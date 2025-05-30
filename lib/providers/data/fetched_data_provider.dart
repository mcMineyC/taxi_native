import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../helpers/service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'preferences_provider.dart';
import '../../helpers/service_locator.dart';
import '../../types/song.dart';
import '../../types/album.dart';
import '../../types/artists.dart';

part 'fetched_data_provider.g.dart';

PreferencesProvider _p = ServiceLocator().get<PreferencesProvider>();

@Riverpod(keepAlive: true)
Future<List<Song>> fetchSongs(FetchSongsRef ref, {bool? ignore = false}) async {
  final _sp = await SharedPreferences.getInstance();
  print("IGNORING: $ignore");
  var response = await http.post(
      Uri.parse("${_p.backendUrl}/info/songs${ignore ?? false ? "?mine=true" : ""}"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(
          <String, String>{'authtoken': _sp.getString("token") ?? ""}));
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  print("fetchSongs: ${desponse["songs"].length}, $ignore");
  // print(desponse);
  desponse = desponse["songs"];
  var listThings = <Song>[];
  desponse.forEach((element) {
    // print(element);
    var outStr = jsonEncode(element);
    var song = Song.fromJson(jsonDecode(outStr));
    if (song.artistDisplayName == "Megadeth") {
      print("Well, has megadeth: ${song.displayName} ignoring = $ignore");
    }
    listThings.add(song);
  });
  return listThings;
}

@Riverpod(keepAlive: true)
Future<List<Album>> fetchAlbums(FetchAlbumsRef ref,
    {bool ignore = false}) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${_p.backendUrl}/info/albums${ignore ? "?mine=true" : ""}"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(
          <String, String>{'authtoken': _sp.getString("token") ?? ""}));
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  desponse = desponse["albums"];
  var listThings = <Album>[];
  desponse.forEach((element) {
    var outStr = jsonEncode(element);
    var song = Album.fromJson(jsonDecode(outStr));
    listThings.add(song);
  });
  return listThings;
}

@Riverpod(keepAlive: true)
Future<List<Artist>> fetchArtists(FetchArtistsRef ref,
    {bool ignore = false}) async {
  final _sp = await SharedPreferences.getInstance();
  print("TOKEN:\n\t" + (_sp.getString("token") ?? ""));
  print("IGNORING: $ignore");
  var response = await http.post(
      Uri.parse("${_p.backendUrl}/info/artists${ignore ? "?mine=true" : ""}"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(
          <String, String>{'authtoken': _sp.getString("token") ?? ""}));
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  desponse = desponse["artists"];
  var listThings = <Artist>[];
  desponse.forEach((element) {
    // print(element);
    var outStr = jsonEncode(element);
    var artist = Artist.fromJson(jsonDecode(outStr));
    listThings.add(artist);
  });
  return listThings;
}

@Riverpod(keepAlive: false)
Future<List<Song>> findBatchSongs(FindBatchSongsRef ref, List<String> ids,
    {bool ignore = false}) async {
  final _sp = await SharedPreferences.getInstance();
  //print("REQUESTING: ${ids.map((e) => e.substring(e.length - 8))}");
  var response = await http.post(
      Uri.parse(
          "${_p.backendUrl}/info/songs/batch${ignore ? "?mine=true" : ""}"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(
          {'authtoken': (_sp.getString("token") ?? ""), 'ids': ids}));
  var desponse = jsonDecode(response.body);
  //print("Response: $desponse");
  if (desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  desponse = desponse["results"];
  List<Song> returning = [];
  for (var i = ids.length - 1; i >= 0; i--) {
    if (desponse.containsKey(ids[i])) {
      if (desponse[ids[i]] == null) {
        continue;
      }
      returning.add(Song.fromJson(desponse[ids[i]]));
    } else {
      continue;
    }
  }
  //print("Returning: ${returning.map((e) => e.id.substring(e.id.length - 8))}");
  //print("Got ${returning.length} out of ${ids.length}");
  return returning;
}

@Riverpod(keepAlive: false)
Future<List<String>> externalIdsToInternal(ExternalIdsToInternalRef ref, List<String> externalIds) async {
  final _sp = await SharedPreferences.getInstance();
  //print("REQUESTING: ${ids.map((e) => e.substring(e.length - 8))}");
  var response = await http.post(
      Uri.parse(
          "${_p.backendUrl}/info/songs/batch"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(
          {'authtoken': (_sp.getString("token") ?? ""), 'externalIds': externalIds}));
  var desponse = jsonDecode(response.body);
  print("Response: $desponse");
  if (desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  desponse = desponse["results"];
  List<String> returning = [];
  for (var i = 0; i < externalIds.length - 1; i++) {
    if (desponse.containsKey(externalIds[i])) {
      if (desponse[externalIds[i]] == null) {
        continue;
      }
      returning.add(desponse[externalIds[i]]);
    } else {
      continue;
    }
  }
  //print("Returning: ${returning.map((e) => e.id.substring(e.id.length - 8))}");
  //print("Got ${returning.length} out of ${ids.length}");
  return returning;
}

@riverpod
Future<Song> findSong(FindSongRef ref, String id, {bool ignore = false}) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse(
          "${_p.backendUrl}/info/songs/$id${ignore ? "?mine=true" : ""}"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(
          <String, String>{'authtoken': (_sp.getString("token") ?? "")}));
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  return Song.fromJson(desponse["song"]);
}

@riverpod
Future<List<Song>> findSongsByAlbum(FindSongsByAlbumRef ref, String id,
    {bool ignore = false}) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse(
          "${_p.backendUrl}/info/songs/by/album/$id${ignore ? "?mine=true" : ""}"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(
          <String, String>{'authtoken': (_sp.getString("token") ?? "")}));
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  List<Song> songs =
      desponse["songs"].map<Song>((e) => Song.fromJson(e)).toList();
  return songs;
}

@riverpod
Future<List<Song>> findSongsByArtist(FindSongsByArtistRef ref, String id,
    {bool ignore = false}) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse(
          "${_p.backendUrl}/info/songs/by/artist/$id${ignore ? "?mine=true" : ""}"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(
          <String, String>{'authtoken': (_sp.getString("token") ?? "")}));
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  List<Song> songs =
      desponse["songs"].map<Song>((e) => Song.fromJson(e)).toList();
  return songs;
}

@riverpod
Future<List<Album>> findAlbumsByArtist(FindAlbumsByArtistRef ref, String id,
    {bool personal = false}) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse(
          "${_p.backendUrl}/info/albums/by/artist/$id${personal ? "?mine=true" : ""}"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(
          <String, String>{'authtoken': _sp.getString("token") ?? ""}));
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  desponse = desponse["albums"];
  var listThings = <Album>[];
  desponse.forEach((element) {
    var outStr = jsonEncode(element);
    var song = Album.fromJson(jsonDecode(outStr));
    listThings.add(song);
  });
  return listThings;
}

@riverpod
Future<List<Album>> findNoSinglesByArtist(
    FindNoSinglesByArtistRef ref, String id,
    {bool ignore = false}) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse(
          "${_p.backendUrl}/info/albums/by/artist/$id?excludeSingles=true${ignore ? "&mine=true" : ""}"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(
          <String, String>{'authtoken': _sp.getString("token") ?? ""}));
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  desponse = desponse["albums"];
  var listThings = <Album>[];
  desponse.forEach((element) {
    var outStr = jsonEncode(element);
    var song = Album.fromJson(jsonDecode(outStr));
    listThings.add(song);
  });
  return listThings;
}

@riverpod
Future<List<Song>> findSinglesByArtist(FindSinglesByArtistRef ref, String id,
    {bool ignore = false}) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse(
          "${_p.backendUrl}/info/singles/by/artist/$id${ignore ? "?mine=true" : ""}"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(
          <String, String>{'authtoken': _sp.getString("token") ?? ""}));
  var desponse = jsonDecode(response.body);
  if (desponse["songs"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  desponse = desponse["songs"];
  var listThings = <Song>[];
  desponse.forEach((element) {
    var outStr = jsonEncode(element);
    var song = Song.fromJson(jsonDecode(outStr));
    listThings.add(song);
  });
  return listThings;
}

@riverpod
Future<Album> findAlbum(FindAlbumRef ref, String id,
    {bool ignore = false}) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse(
          "${_p.backendUrl}/info/album/$id${ignore ? "?mine=true" : ""}"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(
          <String, String>{'authtoken': _sp.getString("token") ?? ""}));
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  print(desponse["album"]);
  return Album.fromJson(desponse["album"]);
}

@riverpod
Future<Artist> findArtist(FindArtistRef ref, String id,
    {bool ignore = false}) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse(
          "${_p.backendUrl}/info/artist/$id${ignore ? "?mine=true" : ""}"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(
          <String, String>{'authtoken': _sp.getString("token") ?? ""}));
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  return Artist.fromJson(desponse["artist"]);
}

@Riverpod(keepAlive: false)
Future<bool> updateSong(UpdateSongRef ref, Song s) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${_p.backendUrl}/edit/song/${s.id}"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(<String, String>{
        'authtoken': _sp.getString("token") ?? "",
        'displayName': s.displayName,
        'albumDisplayName': s.albumDisplayName,
        'artistDisplayName': s.artistDisplayName,
        'audioUrl': s.audioUrl,
        'imageUrl': s.imageUrl,
      }));
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    print("Not authenticated");
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  print((desponse?["success"] ? "succeded" : "failed") +
      " to update song ${s.displayName}");
  return desponse?["success"] ?? false;
}

@Riverpod(keepAlive: false)
Future<bool> updateAlbum(UpdateAlbumRef ref, Album a, List<Song> songs) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${_p.backendUrl}/edit/album/${a.id}"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode({
        'authtoken': _sp.getString("token") ?? "",
        'displayName': a.displayName,
        'artistDisplayName': a.artistDisplayName,
        'imageUrl': a.imageUrl,
        'songs': songs.map((e) => e.id).toList(),
      }));
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    print("Not authenticated");
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  return desponse?["success"] ?? false;
}

@Riverpod(keepAlive: false)
Future<bool> updateArtist(UpdateArtistRef ref, Artist a) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${_p.backendUrl}/edit/artist/${a.id}"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(<String, String>{
        'authtoken': _sp.getString("token") ?? "",
        'displayName': a.displayName,
        'imageUrl': a.imageUrl
      }));
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    print("Not authenticated");
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  return desponse?["success"] ?? false;
}

@Riverpod(keepAlive: false)
Future<bool> deleteItem(
    DeleteItemRef ref, String type, String id, String extraParams) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${_p.backendUrl}/edit/$type/$id/delete$extraParams"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(
          <String, String>{'authtoken': _sp.getString("token") ?? ""}));
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    print("Not authenticated");
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  return desponse?["success"] ?? false;
}

@Riverpod(keepAlive: true)
Future<List<String>> fetchUsernames(FetchUsernamesRef ref) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(Uri.parse("${_p.backendUrl}/info/users"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(
          <String, String>{'authtoken': _sp.getString("token") ?? ""}));
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  List<String> listThings = [];
  desponse["users"]
      .forEach((element) => listThings.add(element["loginName"].toString()));
  return listThings;
}

@Riverpod(keepAlive: false)
Future<bool> editItemVisibility(EditItemVisibilityRef ref, String type,
    String id, List<String> users) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${_p.backendUrl}/edit/$type/$id/visibility"),
      headers: Map<String, String>.from({'Content-Type': 'application/json'}),
      body: jsonEncode(
          {'authtoken': _sp.getString("token") ?? "", 'visibleTo': users}));
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    //print("Not authenticated");
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  bool clearCondition =
      (desponse["success"] ?? false) && desponse["data"]["visibleTo"] == users;
  if (clearCondition) {
    if (type == "song" || type == "album" || type == "artist")
      ref.refresh(fetchSongsProvider(ignore: false));
    if (type == "album" || type == "artist")
      ref.refresh(fetchAlbumsProvider(ignore: false));
    if (type == "artist") ref.refresh(fetchArtistsProvider(ignore: false));
  }
  return clearCondition;
}

@Riverpod(keepAlive: false)
Future<bool> addToLibrary(AddToLibraryRef ref, String id, String type) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
    Uri.parse("${_p.backendUrl}/addToLibrary"),
    headers: Map<String, String>.from({
      'Content-Type': 'application/json',
    }),
    body: jsonEncode(<String, String>{
      'authtoken': _sp.getString("token") ?? "",
      'id': id,
      'type': type,
    }),
  );
  if (response.statusCode != 200) {
    return false;
  }
  Map<String, dynamic> data = jsonDecode(response.body);
  return data["success"] ?? false;
}


@Riverpod(keepAlive: false)
Future<bool> removeFromLibrary(RemoveFromLibraryRef ref, String id, String type) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
    Uri.parse("${_p.backendUrl}/removeFromLibrary"),
    headers: Map<String, String>.from({
      'Content-Type': 'application/json',
    }),
    body: jsonEncode(<String, String>{
      'authtoken': _sp.getString("token") ?? "",
      'id': id,
      'type': type,
    }),
  );
  if (response.statusCode != 200) {
    return false;
  }
  Map<String, dynamic> data = jsonDecode(response.body);
  return data["success"] ?? false;
}



@riverpod
Future<String> getArtistImageUrlFromName(Ref ref, String query) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
    Uri.parse(
      "${_p.backendUrl}/utils/getArtistImageFromName"),
    headers: Map<String, String>.from({'Content-Type': 'application/json'}),
    body: jsonEncode(<String, String>
      {
        'authtoken': (_sp.getString("token") ?? ""),
        'query': query,
      }
    )
  );
  var desponse = jsonDecode(response.body);
  if (desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  return desponse["url"];
}