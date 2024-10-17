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
    required String state,
    required List<SearchResult> searchResults,
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
      state: "loading",
      searchResults: [],
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
      state = state.copyWith(state: "auth");
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
        state = state.copyWith(state: "authfail", authed: false);
        return;
      }
      state = state.copyWith(state: "authed", authed: true);
    });
    socket.on('searchresults', (data) {
      print("Adder: Search results");
      List<SearchResult> results = [];
      results = data["results"].whereType<Map<String, dynamic>>().toList().map<SearchResult>((element) => SearchResult.fromJson(element)).toList();
      state = state.copyWith(state: "searchresults", searchResults: results);
      print("Adder: Search results: ${results.length}");
    });

    socket.on('findresults', (data) {
      print("Adder: Find results");
      print(data["results"][0].toString());
      var found = List<FindResult>.empty(growable: true);
      data["results"].forEach((element) {
        found.add(FindResult.fromJson(element));
      });
      state = state.copyWith(state: "foundresults", findResults: found);
    });

    socket.on('addresult', (data) {
      var result = AddResult.fromJson(data);
      state = state.copyWith(state: "addresult", addResult: result);
      print("Got success message!!");
      ref.refresh(fetchSongsProvider(ignore: false));
      ref.refresh(fetchAlbumsProvider(ignore: false));
      ref.refresh(fetchArtistsProvider(ignore: false));
      
    });
    _isInit = true;

    print("Adder: Init");
  }

  void search(String query, SearchType type) async {
    print("Searcher: Searching ${query}");
    state = state.copyWith(state: "loading");
    socket.emit('search', {"query": query, "source": "spotify", "mediaType": type.type});
  }

  void findVideosFor(List<SearchResult> results) async {
    print("Adder: Find videos for ${results.length} results");
    socket.emit('find', {'selected': results, 'source': "spotify"});
    state = state.copyWith(state: "findingresults");
  }

  void addFindResults(List<FindResult> results) async {
    print("Adder: Add ${results.length} results");
    socket.emit('add', {"items": results});
    state = state.copyWith(state: "addingresults");
  }

  void setStep(String step) async {
    state = state.copyWith(state: step);
  }
  
  void cancel() async {
    state = state.copyWith(state: "authed");
  }
}
