import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_debounce/easy_debounce.dart';

import 'preferences_provider.dart';
import '../types/song.dart';
import '../types/album.dart';
import '../types/artists.dart';

part 'search_provider.g.dart';
part 'search_provider.freezed.dart';

@freezed
class SearchInfo with _$SearchInfo {
  factory SearchInfo({
    required String query,
    required bool hasText,
    required bool isLoading,
    required bool hasResults,
    required List<Album> albums,
    required List<Artist> artists,
    required List<Song> songs
  }) = _SearchInfo;
}

@Riverpod(keepAlive: true)
class Search extends _$Search {
  String query = "";

  get text => state.query;

  @override
  SearchInfo build() {
    print("SearchProvider build");
    EasyDebounce.debounce(
      'dbounce',                 // <-- An ID for this particular debouncer
      Duration(milliseconds: 500),    // <-- The debounce duration
      () => searchAction()              // <-- The target method
    );
    return SearchInfo(
      query: "",
      albums: [],
      artists: [],
      songs: [],
      hasText: false,
      isLoading: false,
      hasResults: false
    );
  }

  void search(String q){
    print("Search: $q");
    state = state.copyWith(query: query, hasText: q.isNotEmpty, isLoading: false);
    query = q;
    EasyDebounce.fire('dbounce');
  }

  void searchAction() async {
    print("SearchAction");
    if(query.isNotEmpty) {
      state = state.copyWith(isLoading: true);
      List<Album> albums = await searchAlbums(query);
      List<Artist> artists = await searchArtists(query);
      List<Song> songs = await searchSongs(query);
      state = state.copyWith(albums: albums, artists: artists, songs: songs, hasResults: true, isLoading: false);
    }
  }

  Future<List<Song>> searchSongs(String query) async {
    final _sp = await SharedPreferences.getInstance();
    var response = await http.post(
        Uri.parse("${await ref.read(backendUrlProvider.future)}/search"),
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
        Uri.parse("${await ref.read(backendUrlProvider.future)}/search"),
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
        Uri.parse("${await ref.read(backendUrlProvider.future)}/search"),
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
