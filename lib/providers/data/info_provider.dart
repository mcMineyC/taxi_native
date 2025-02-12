import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../types/song.dart';
import 'fetched_data_provider.dart';
import 'preferences_provider.dart';

part 'info_provider.g.dart';
PreferencesProvider p = ServiceLocator().get<PreferencesProvider>();

@riverpod
Future<bool> addRecentlyPlayed(AddRecentlyPlayedRef ref, String id) async {
  if(id == null) return false;
  //print("Adding recently played: $id");
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${p.backendUrl}/recently-played/${(_sp.getString("username") ?? "")}/add"),
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
    return Future.error({"code": 401, "name": "recently-played-add", "error": "Not authenticated"});
  }else if(desponse["success"] == false) {
    return false;
  }
  return desponse["success"];
}

@Riverpod(keepAlive: true)
Future<List<Song>> fetchRecentlyPlayed(FetchRecentlyPlayedRef ref) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${p.backendUrl}/recently-played/"+(_sp.getString("username") ?? "")),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode(<String, String>{
        'authtoken': (_sp.getString("token") ?? "")
      })
  );
  var desponse = jsonDecode(response.body);
  // print("Response: $desponse");
  if(desponse["authed"] == false) {
    return Future.error({"code": 401, "name": "recently-played-get", "error": "Not authenticated"});
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
      Uri.parse("${p.backendUrl}/favorites/"+(_sp.getString("username") ?? "")),
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

