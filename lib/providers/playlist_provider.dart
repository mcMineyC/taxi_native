import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'preferences_provider.dart';
import 'fetched_data_provider.dart';
import '../types/playlist.dart';

part 'playlist_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<Playlist>> fetchPlaylists(FetchPlaylistsRef ref) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${await ref.read(backendUrlProvider.future)}/playlists?sort=none"),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode(<String, String>{
        'authtoken': _sp.getString("token") ?? ""
      })
  );
  var desponse = jsonDecode(response.body);
  if(desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  desponse = desponse["playlists"] ?? [];
  var listThings = <Playlist>[];
  desponse.forEach((element) {
    // print(element);
    var outStr = jsonEncode(element);
    Map<String, dynamic> json = jsonDecode(outStr);
    json["public"] = json["public"] == "true";
    var playlist = Playlist.fromJson(json);
    listThings.add(playlist);
  });
  return listThings;
}

@Riverpod(keepAlive: true)
Future<List<Playlist>> fetchNewPlaylists(FetchNewPlaylistsRef ref) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${await ref.read(backendUrlProvider.future)}/playlists?sort=new"),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode(<String, String>{
        'authtoken': _sp.getString("token") ?? ""
      })
  );
  var desponse = jsonDecode(response.body);
  if(desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  desponse = desponse["playlists"] ?? [];
  var listThings = <Playlist>[];
  desponse.forEach((element) {
    // print(element);
    var outStr = jsonEncode(element);
    Map<String, dynamic> json = jsonDecode(outStr);
    json["public"] = json["public"] == "true";
    var playlist = Playlist.fromJson(json);
    listThings.add(playlist);
  });
  return listThings;
}

@Riverpod(keepAlive: false)
Future<bool> addPlaylist(AddPlaylistRef ref, Playlist playlist) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
    Uri.parse("${await ref.read(backendUrlProvider.future)}/playlists/modify/create"),
    headers: Map<String, String>.from({
      'Content-Type': 'application/json',
    }),
    body: jsonEncode({
      'authtoken': _sp.getString("token") ?? "",
      'name': playlist.displayName,
      'owner': playlist.owner,
      'public': playlist.public.toString(),
      'description': "nall",
      'songs': playlist.songs,
    }),
  );
  var desponse = jsonDecode(response.body);
  if(desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  if(desponse["success"] == true) {
    ref.refresh(fetchPlaylistsProvider);
  }
  return true;
}

@Riverpod(keepAlive: false)
Future<bool> addIdToPlaylist(AddIdToPlaylistRef ref, String playlistId, String id) async {
  final _sp = await SharedPreferences.getInstance();
  Playlist playlist = (await ref.read(findPlaylistProvider(playlistId).future)).toPlaylist();
  List<String> newSongs = [...playlist.songs];
  newSongs.add(id);
  var response = await http.post(
    Uri.parse("${await ref.read(backendUrlProvider.future)}/playlists/modify/$playlistId/"),
    headers: Map<String, String>.from({
      'Content-Type': 'application/json',
    }),
    body: jsonEncode({
      'authtoken': _sp.getString("token") ?? "",
      'name': playlist.displayName,
      'owner': playlist.owner,
      'public': playlist.public.toString(),
      'description': "nall",
      'songs': newSongs,
    }),
  );
  var desponse = jsonDecode(response.body);
  if(desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  if(desponse["success"] == true) {
    ref.refresh(fetchPlaylistsProvider);
  }
  return true;
}

@Riverpod(keepAlive: false)
Future<bool> deletePlaylist(DeletePlaylistRef ref, String playlistId) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
    Uri.parse("${await ref.read(backendUrlProvider.future)}/playlists/remove/$playlistId"),
    headers: Map<String, String>.from({
      'Content-Type': 'application/json',
    }),
    body: jsonEncode({
      'authtoken': _sp.getString("token") ?? "",
    }),
  );
  var desponse = jsonDecode(response.body);
  if(desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  if(desponse["success"] == true) {
    ref.refresh(fetchPlaylistsProvider);
    return true;
  }else{
    return false;
  }
}

@Riverpod(keepAlive: false)
Future<FilledPlaylist> findPlaylist(FindPlaylistRef ref, String id) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
    Uri.parse("${await ref.read(backendUrlProvider.future)}/playlists/$id"),
    headers: Map<String, String>.from({
      'Content-Type': 'application/json',
    }),
    body: jsonEncode({
      'authtoken': _sp.getString("token") ?? "",
    }),
  );
  var desponse = jsonDecode(response.body);
  if(desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  Playlist playlist = Playlist.fromJson(desponse["playlists"][0]);
  var newSongs = await ref.read(findBatchSongsProvider(playlist.songs).future);
  return FilledPlaylist(
    id: playlist.id,
    displayName: playlist.displayName,
    owner: playlist.owner,
    public: playlist.public,
    added: playlist.added,
    songs: newSongs
  );
}
