import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../types/song.dart';
import 'fetched_data_provider.dart';

part 'info_provider.g.dart';

@riverpod
Future<bool> addRecentlyPlayed(AddRecentlyPlayedRef ref, String id) async {
  if(id == null) return false;
  print("Adding recently played: $id");
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("https://eatthecow.mooo.com:3030/recently-played/${(_sp.getString("username") ?? "")}/add"),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode(<String, String>{
        'authtoken': (_sp.getString("token") ?? ""),
        'id': id
      })
  );
  var desponse = jsonDecode(response.body);
  if(desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }else if(desponse["success"] == false) {
    return false;
  }
  return desponse["success"];
}

@Riverpod(keepAlive: true)
Future<List<Song>> fetchRecentlyPlayed(FetchRecentlyPlayedRef ref) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("https://eatthecow.mooo.com:3030/recently-played/"+(_sp.getString("username") ?? "")),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode(<String, String>{
        'authtoken': (_sp.getString("token") ?? "")
      })
  );
  var desponse = jsonDecode(response.body);
  if(desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  List<String> responsible = List<String>.from(desponse["played"]);
  var songs = <Song>[];
  songs = await ref.read(findBatchSongsProvider(responsible).future);
  return songs;
}

@Riverpod(keepAlive: true)
Future<List<Song>> fetchFavorites(FetchFavoritesRef ref) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("https://eatthecow.mooo.com:3030/favorites/"+(_sp.getString("username") ?? "")),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode(<String, String>{
        'authtoken': (_sp.getString("token") ?? "")
      })
  );
  var desponse = jsonDecode(response.body);
  if(desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  List<String> responsible = List<String>.from(desponse["songs"]);
  var songs = <Song>[];
  songs = await ref.read(findBatchSongsProvider(responsible).future);
  return songs;
}

@riverpod
Future<Song> findSong(FindSongRef ref, String id) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
    Uri.parse("https://eatthecow.mooo.com:3030/info/songs/$id"),
    headers: Map<String, String>.from({
      'Content-Type': 'application/json'
    }),
    body: jsonEncode(<String, String>{
      'authtoken': (_sp.getString("token") ?? "")
    })
  );
  var desponse = jsonDecode(response.body);
  if(desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  return Song.fromJson(desponse["song"]);
}
