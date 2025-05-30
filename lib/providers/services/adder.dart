import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import "package:shared_preferences/shared_preferences.dart";
import 'package:taxi_native/providers/data/playlist_provider.dart';
import 'dart:convert';
import "../../helpers/utilities.dart";
import '../../helpers/platform_utils.dart';
import '../../helpers/service_locator.dart';

import '../data/user_provider.dart';
import '../data/preferences_provider.dart';
import '../data/fetched_data_provider.dart';

import '../../types/searchresult.dart';
import '../../types/hierarchicalListView.dart';
import "../../types/song.dart";
import "../../types/playlist.dart";

part 'adder.g.dart';
part 'adder.freezed.dart';

@freezed
class AddState with _$AddState {
  AddState._();

  factory AddState({
    required String id,
    required String query,
    required SearchType searchType,
    required SearchSource searchSource,
    required String state,
    required List<SearchResult> searchResults,
    required List<SearchResult> selectedSearchResults,
    required List<String> selectedSearchResultIds,
    required List<FindResult> findResults,
    FoundPlaylist? foundPlaylist,
    //required bool
    required AddResult addResult,
    required bool done,
    required bool authed,
    required int totalResults,
    required int completedResults,
  }) = _AddState;
}

@Riverpod(keepAlive: true)
class Adder extends _$Adder {
  late final IO.Socket socket;
  PreferencesProvider p = ServiceLocator().get<PreferencesProvider>();
  bool _isInit = false;
  bool authed = false;

  @override
  AddState build() {
    print("Adder: Build");
    return AddState(
        id: "",
        query: "",
        searchType: SearchType.track,
        searchSource: SearchSource.spotify,
        state: "loading",
        searchResults: [],
        selectedSearchResults: [],
        selectedSearchResultIds: [],
        findResults: [],
        addResult: AddResult(
            success: false,
            count: AddResultCount(artists: 0, albums: 0, songs: 0)),
        done: false,
        authed: false,
        totalResults: 0,
        completedResults: 0);
  }

  void init() async {
    if (_isInit) return;
    String backendUrl = p.backendUrl;
    var optionBuilder = IO.OptionBuilder();
    if (!PlatformUtils.isWeb) optionBuilder.setTransports(['websocket']);
    var options = optionBuilder.build();
    socket = IO.io(backendUrl, options);
    socket.onConnect((_) {
      print("Adder: Connected to backend");
      state = state.copyWith(state: "loading:auth");
    });
    socket.onDisconnect((_) {
      print("Adder: Disconnected from backend");
    });
    socket.on('authprompt', (_) async {
      socket.emit(
          'auth', {"authtoken": await ref.read(authtokenProvider.future)});
    });
    socket.on('authresult', (data) async {
      print("Adder: Authresult ${data["success"]}");
      authed = data["success"];
      if (!authed) {
        print("Adder: Auth failed: ${data["error"]}");
        state = state.copyWith(state: "auth:fail", authed: false);
        return;
      }
      state = state.copyWith(state: "auth:success", authed: true);
    });
    socket.on('searchresults', (data) {
      print("Adder: Search results");
      List<SearchResult> results = [];
      results = data["results"]
          .whereType<Map<String, dynamic>>()
          .toList()
          .map<SearchResult>((element) => SearchResult.fromJson(element))
          .toList();
      state = state.copyWith(state: "search:results", searchResults: results);
      print("Adder: Search results: ${results.length}");
    });

    socket.on('findprogress', (data) {
      state = state.copyWith(
          totalResults: data["total"], completedResults: data["completed"]);
    });

    socket.on('findresults', (data) {
      print("Adder: Find results");
      print("Adder: Do we have a playlist? ${data["isPlaylist"]}");
      if ((data["isPlaylist"] ?? false) == true) {
        print("Adder: We have a playlist!!! Party town");
        FoundPlaylist playlist = FoundPlaylist.fromJson(data["results"][0]);
        print(playlist.toJson());
        state = state.copyWith(
            state: "find:results:playlist", foundPlaylist: playlist);
      } else {
        print("We do not have a playlist");
        //print(data["results"][0].toString());
        var found = List<FindResult>.empty(growable: true);
        data["results"].forEach((element) {
          found.add(FindResult.fromJson(element));
        });
        state = state.copyWith(state: "find:results", findResults: found);
      }
    });

    socket.on('addresult', (data) async {
      var result = AddResult.fromJson(data);
      if(state.foundPlaylist != null){
        FoundPlaylist found = state.foundPlaylist!;
        List<String> internalIds = await ref.read(externalIdsToInternalProvider(state.foundPlaylist!.songs.map((song) => song.externalId).toList()).future);
        // var currentUser = (await SharedPreferences.getInstance()).getString("username")!;
        print("Adder: addresult:playlist ${found.visibleTo}");
        var accompanying = Playlist(
          id: "create",
          displayName: found.name,
          description: found.description,
          visibleTo: found.visibleTo,
          inLibrary: found.inLibrary,
          allowedCollaborators: found.allowedCollaborators,
          songs: internalIds,
          added: DateTime.now().millisecondsSinceEpoch,
          owner: found.owner
        );  // okay, this is the magic
        await ref.read(addPlaylistProvider(accompanying).future);
      }
      state = state.copyWith(state: "add:results", addResult: result);
      print("Got success message!!");
      refreshLibrary(ref);
    });
    _isInit = true;

    print("Adder: Init");
  }

  Future<void> retryAuth() async {
    socket
        .emit('auth', {"authtoken": await ref.read(authtokenProvider.future)});
  }

  void search(String query, SearchType type, SearchSource source) {
    print("Searcher: Searching ${query}");
    state =
        state.copyWith(state: "loading:search", query: query, searchType: type);
    socket.emit('search',
        {"query": query, "source": source.type, "mediaType": type.type});
  }

  void findVideosFor(List<SearchResult> results, SearchSource source) {
    state = state.copyWith(
        state: "loading:find", totalResults: 0, completedResults: 0);
    print("Adder: Find videos for ${results.length} results");
    socket.emit('find', {'selected': results, 'source': source.type});
  }

  void addHLVResults(List<HLVArtist> results) {
    state = state.copyWith(state: "loading:add");
    print("Adder: Add ${results.length} results");
    print(jsonEncode(results));
    socket.emit('add', {"hierarchy": results});
  }

  void addPlaylist(FoundPlaylist list) {
    state = state.copyWith(state: "loading:add", foundPlaylist: list);
    print("Adder: Add playlist ${list.name}");
    socket.emit('playlist', list);
  }

  void setStep(String step) {
    state = state.copyWith(state: step);
  }

  void cancel() {
    state = state.copyWith(
        state: "auth:success",
        searchResults: [],
        selectedSearchResults: [],
        findResults: [],
        foundPlaylist: null);
  }

  void done() {
    state = state.copyWith(
        state: "auth:success",
        searchResults: [],
        selectedSearchResults: [],
        findResults: [],
        foundPlaylist: null);
  }

  void setSelectedSearchType(SearchType type) {
    state = state.copyWith(searchType: type);
  }

  void setSelectedSearchSource(SearchSource source) {
    state = state.copyWith(searchSource: source);
  }

  void selectSearchResult(SearchResult result) {
    state = state.copyWith(
      selectedSearchResults: [...state.selectedSearchResults, result],
    );
  }

  void selectSearchResults(List<SearchResult> results) {
    state = state.copyWith(
      selectedSearchResults: [...state.selectedSearchResults, ...results],
    );
  }

  void deselectSearchResult(SearchResult result) {
    print("Deselecting search type ${result.type}");
    state = state.copyWith(
      selectedSearchResults: state.selectedSearchResults
          .where((element) => element != result)
          .toList(),
      foundPlaylist: result.type == "playlist" ? state.foundPlaylist : null,
    );
  }

  void clearSelectedSearchResults() {
    state =
        state.copyWith(selectedSearchResults: [], selectedSearchResultIds: []);
  }

  void findVideosForSelectedSearchResults() {
    findVideosFor(state.selectedSearchResults, state.searchSource);
  }
}