import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_debounce/easy_debounce.dart';

import '../data/preferences_provider.dart';
import '../../service_locator.dart';
import '../../types/song.dart';
import '../../types/album.dart';
import '../../types/artists.dart';
import '../../types/searchresult.dart';

part 'search.g.dart';
part 'search.freezed.dart';

PreferencesProvider p = ServiceLocator().get<PreferencesProvider>();

@freezed
class SearchInfo with _$SearchInfo {
  factory SearchInfo({
    required String query,
    required bool hasText,
    required bool isLoading,
    required bool hasResults,
    required List<LocalSearchResult> albums,
    required List<LocalSearchResult> artists,
    required List<LocalSearchResult> songs,
    required List<String> order,
  }) = _SearchInfo;
}

@Riverpod(keepAlive: true)
class Search extends _$Search {
  get text => state.query;

  @override
  SearchInfo build() {
    print("SearchProvider build");
    bouncedSearch(); 
    return SearchInfo(
      query: "",
      albums: [],
      artists: [],
      songs: [],
      order: [],
      hasText: false,
      isLoading: false,
      hasResults: false
    );
  }

  void bouncedSearch(){
    EasyDebounce.debounce(
      'dbounce',                 // <-- An ID for this particular debouncer
      Duration(milliseconds: 200),    // <-- The debounce duration
      () => searchAction()              // <-- The target method
    );
  }

  void search(String q){
    state = state.copyWith(query: q, hasText: q.isNotEmpty, isLoading: state.isLoading || q.isNotEmpty);
    bouncedSearch();
  }

  void searchAction() async {
    print("SearchAction");
    var query = state.query;
    if(query.isNotEmpty) {
      state = state.copyWith(isLoading: true);
      SearchResponse sr = await searchAll(query);
      state = state.copyWith(query: query, albums: sr.albums, artists: sr.artists, songs: sr.songs, order: sr.relevancy, hasResults: true, isLoading: false);
    }else{
      state = state.copyWith(hasResults: false, isLoading: false);
    }
  }

  Future<SearchResponse> searchAll(String query) async {
    final _sp = await SharedPreferences.getInstance();
    var response = await http.post(
        Uri.parse("${p.backendUrl}/searchAll"),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json'
        }),
        body: jsonEncode(<String, String>{
          'authtoken': _sp.getString("token") ?? "",
          'type': "song",
          'query': query
        })
    );
    var desponse = jsonDecode(response.body);
    if(desponse["authed"] == false) {
      return Future.error({"code": 401, "error": "Not authenticated"});
    }
    SearchResponse sr = SearchResponse.fromJson(desponse);
    return sr;
  }

  Future<List<Song>> searchSongs(String query) async {
    final _sp = await SharedPreferences.getInstance();
    var response = await http.post(
        Uri.parse("${p.backendUrl}/search"),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json'
        }),
        body: jsonEncode(<String, String>{
          'authtoken': _sp.getString("token") ?? "",
          'type': "song",
          'query': query
        })
    );
    var desponse = jsonDecode(response.body);
    if(desponse["authed"] == false) {
      return Future.error({"code": 401, "error": "Not authenticated"});
    }
    List<Song> songs = [];
    for(var e in desponse["results"]) {
      songs.add(Song.fromJson(e));
    }
    return songs;
  }

  Future<List<Album>> searchAlbums(String query) async {
    final _sp = await SharedPreferences.getInstance();
    var response = await http.post(
        Uri.parse("${p.backendUrl}/search"),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json'
        }),
        body: jsonEncode(<String, String>{
          'authtoken': _sp.getString("token") ?? "",
          'type': "album",
          'query': query
        })
    );
    var desponse = jsonDecode(response.body);
    if(desponse["authed"] == false) {
      return Future.error({"code": 401, "error": "Not authenticated"});
    }
    List<Album> albums = [];
    for(var e in desponse["results"]) {
      albums.add(Album.fromJson(e));
    }
    return albums;
  }

  Future<List<Artist>> searchArtists(String query) async {
    final _sp = await SharedPreferences.getInstance();
    var response = await http.post(
        Uri.parse("${p.backendUrl}/search"),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json'
        }),
        body: jsonEncode(<String, String>{
          'authtoken': _sp.getString("token") ?? "",
          'type': "artist",
          'query': query
        })
    );
    var desponse = jsonDecode(response.body);
    if(desponse["authed"] == false) {
      return Future.error({"code": 401, "error": "Not authenticated"});
    }
    List<Artist> artists = [];
    for(var e in desponse["results"]) {
      artists.add(Artist.fromJson(e));
    }
    return artists;
  }
}
