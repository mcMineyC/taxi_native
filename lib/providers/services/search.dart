import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_debounce/easy_debounce.dart';

import '../data/preferences_provider.dart';
import '../../helpers/service_locator.dart';
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
    required List<Album> albums,
    required List<Artist> artists,
    required List<Song> songs,
    required List<String> order,
  }) = _SearchInfo;
}

@Riverpod(keepAlive: true)
class Search extends _$Search {
  get text => state.query;
  get songs => state.songs;
  get albums => state.albums;
  get artists => state.artists;
  get hasText => state.hasText;
  get isLoading => state.isLoading;
  get hasResults => state.hasResults;
  get query => state.query;

  @override
  SearchInfo build() {
    print("SearchProvider build");
    bouncedSearch("all"); 
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

  void bouncedSearch(String type, {bool ignore = false}) {
    EasyDebounce.debounce(
      'dbounce',                 // <-- An ID for this particular debouncer
      Duration(milliseconds: 200),    // <-- The debounce duration
      () => searchAction(type, ignore)              // <-- The target method
    );
  }

  void search(String q, String type, {bool ignore = false}) {
    state = state.copyWith(query: q, hasText: q.isNotEmpty, isLoading: state.isLoading || q.isNotEmpty);
    bouncedSearch(type, ignore: ignore);
  }

  void searchAction(String type, bool ignore) async {
    var query = state.query;
    if(query.isNotEmpty) {
      state = state.copyWith(isLoading: true, hasResults: false);
      if(type == "song") {
        List<Song> ss = await _searchSongs(query, ignore: ignore);
        state = state.copyWith(query: query, songs: ss, hasResults: true, isLoading: false);
      }else if(type == "album") {
        List<Album> ss = await _searchAlbums(query, ignore: ignore);
        state = state.copyWith(query: query, albums: ss, hasResults: true, isLoading: false);
      }else if(type == "artist") {
        List<Artist> ss = await _searchArtists(query, ignore: ignore);
        state = state.copyWith(query: query, artists: ss, hasResults: true, isLoading: false);
      }else{
        SearchResponse sr = await searchAll(query, ignore: ignore);
        state = state.copyWith(query: query, songs: sr.songs, albums: sr.albums, artists: sr.artists, order: sr.relevancy, hasResults: true, isLoading: false);
      }
    }else{
      state = state.copyWith(hasResults: false, isLoading: false);
    }
  }

  Future<SearchResponse> searchAll(String query, {bool ignore = false}) async {
    final _sp = await SharedPreferences.getInstance();
    var response = await http.post(
        Uri.parse("${p.backendUrl}/searchAll${ignore ? "?ignore=true" : ""}"),
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

  Future<List<Song>> _searchSongs(String query, {bool ignore = false}) async {
    final _sp = await SharedPreferences.getInstance();
    var response = await http.post(
        Uri.parse("${p.backendUrl}/search${ignore ? "?ignore=true" : ""}"),
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

  Future<List<Album>> _searchAlbums(String query, {bool ignore = false}) async {
    final _sp = await SharedPreferences.getInstance();
    var response = await http.post(
        Uri.parse("${p.backendUrl}/search${ignore ? "?ignore=true" : ""}"),
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

  Future<List<Artist>> _searchArtists(String query, {bool ignore = false}) async {
    final _sp = await SharedPreferences.getInstance();
    var response = await http.post(
        Uri.parse("${p.backendUrl}/search${ignore ? "?ignore=true" : ""}"),
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
