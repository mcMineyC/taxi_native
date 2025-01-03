import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../platform_utils.dart';
import '../../service_locator.dart';

import '../data/user_provider.dart';
import '../data/preferences_provider.dart';
import '../data/fetched_data_provider.dart';

import '../../types/searchresult.dart';

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
    required AddResult addResult,
    required bool done,
    required bool authed,
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
      addResult: AddResult(success: false, count: AddResultCount(artists: 0, albums: 0, songs: 0)),
      done: false,
      authed: false,
    ); 
  }

  void init() async {
    if(_isInit) return;
    String backendUrl = p.backendUrl;
    var optionBuilder = IO.OptionBuilder();
    if(!PlatformUtils.isWeb) optionBuilder.setTransports(['websocket']);
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
      socket.emit('auth', {"authtoken": await ref.read(authtokenProvider.future)});
    });
    socket.on('authresult', (data) async {
      print("Adder: Authresult ${data["success"]}");
      authed = data["success"];
      if(!authed){
        print("Adder: Auth failed: ${data["error"]}");
        state = state.copyWith(state: "auth:fail", authed: false);
        return;
      }
      state = state.copyWith(state: "auth:success", authed: true);
    });
    socket.on('searchresults', (data) {
      print("Adder: Search results");
      List<SearchResult> results = [];
      results = data["results"].whereType<Map<String, dynamic>>().toList().map<SearchResult>((element) => SearchResult.fromJson(element)).toList();
      state = state.copyWith(state: "search:results", searchResults: results);
      print("Adder: Search results: ${results.length}");
    });

    socket.on('findresults', (data) {
      print("Adder: Find results");
      print(data["results"][0].toString());
      var found = List<FindResult>.empty(growable: true);
      data["results"].forEach((element) {
        found.add(FindResult.fromJson(element));
      });
      state = state.copyWith(state: "find:results", findResults: found);
    });

    socket.on('addresult', (data) {
      var result = AddResult.fromJson(data);
      state = state.copyWith(state: "add:results", addResult: result);
      print("Got success message!!");
      ref.refresh(fetchSongsProvider(ignore: false));
      ref.refresh(fetchAlbumsProvider(ignore: false));
      ref.refresh(fetchArtistsProvider(ignore: false));
    });
    _isInit = true;

    print("Adder: Init");
  }

  void search(String query, SearchType type, SearchSource source) {
    print("Searcher: Searching ${query}");
    state = state.copyWith(state: "loading:search", query: query, searchType: type);
    socket.emit('search', {"query": query, "source": source.type, "mediaType": type.type});
  }

  void findVideosFor(List<SearchResult> results, SearchSource source) {
    state = state.copyWith(state: "loading:find");
    print("Adder: Find videos for ${results.length} results");
    socket.emit('find', {'selected': results, 'source': source.type});
  }

  void addFindResults(List<FindResult> results) {
    state = state.copyWith(state: "loading:add");
    print("Adder: Add ${results.length} results");
    socket.emit('add', {"items": results});
  }

  void setStep(String step) {
    state = state.copyWith(state: step);
  }
  
  void cancel() {
    state = state.copyWith(state: "authed", searchResults: [], selectedSearchResults: [], findResults: []);
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
  void deselectSearchResult(SearchResult result) {
    state = state.copyWith(
      selectedSearchResults: state.selectedSearchResults.where(
        (element) => element != result
      ).toList(),
    );
  }
  void clearSelectedSearchResults(){
    state = state.copyWith(selectedSearchResults: [], selectedSearchResultIds: []);
  }


  void findVideosForSelectedSearchResults() {
    findVideosFor(state.selectedSearchResults, state.searchSource);
  }
}
