import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'preferences_provider.dart';
import '../../service_locator.dart';
import '../../types/song.dart';
import '../../types/album.dart';
import '../../types/artists.dart';

part 'fetched_data_provider.g.dart';
PreferencesProvider p = ServiceLocator().get<PreferencesProvider>();

@Riverpod(keepAlive: true)
Future<List<Song>> fetchSongs(FetchSongsRef ref) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${p.backendUrl}/info/songs"),
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
  // print(desponse);
  desponse = desponse["songs"];
  var listThings = <Song>[];
  desponse.forEach((element) {
    // print(element);
    var outStr = jsonEncode(element);
    var song = Song.fromJson(jsonDecode(outStr));
    listThings.add(song);
  });
  return listThings;
}

@Riverpod(keepAlive: true)
Future<List<Album>> fetchAlbums(FetchAlbumsRef ref) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${p.backendUrl}/info/albums"),
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
Future<List<Artist>> fetchArtists(FetchArtistsRef ref) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${p.backendUrl}/info/artists"),
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
Future<List<Song>> findBatchSongs(FindBatchSongsRef ref, List<String> ids) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${p.backendUrl}/info/songs/batch"),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode({
        'authtoken': (_sp.getString("token") ?? ""),
        'ids': ids
      })
  );
  var desponse = jsonDecode(response.body);
  // print("Response: $desponse");
  if(desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  desponse = desponse["results"];
  List<Song> returning = [];
  for(var i = ids.length - 1; i >= 0; i--) {
    if(desponse.containsKey(ids[i])) {
      if(desponse[ids[i]] == null) {
        continue;
      }
      returning.add(Song.fromJson(desponse[ids[i]]));
    }else{
      returning.add(EmptySong());
    }
  }
  return returning;
}
@riverpod

Future<Song> findSong(FindSongRef ref, String id) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
    Uri.parse("${p.backendUrl}/info/songs/$id"),
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

@riverpod
Future<List<Song>> findSongsByAlbum(FindSongsByAlbumRef ref, String id) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
    Uri.parse("${p.backendUrl}/info/songs/by/album/$id"),
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
  List<Song> songs = desponse["songs"].map<Song>((e) => Song.fromJson(e)).toList();
  return songs;
}

@riverpod
Future<List<Song>> findSongsByArtist(FindSongsByArtistRef ref, String id) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
    Uri.parse("${p.backendUrl}/info/songs/by/artist/$id"),
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
  List<Song> songs = desponse["songs"].map<Song>((e) => Song.fromJson(e)).toList();
  return songs;
}

@riverpod
Future<List<Album>> findAlbumsByArtist(FetchAlbumsRef ref, String id) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${p.backendUrl}/info/albums/by/artist/$id"),
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
Future<List<Album>> findNoSinglesByArtist(FindNoSinglesByArtistRef ref, String id) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${p.backendUrl}/info/albums/by/artist/$id?excludeSingles=true"),
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
Future<List<Song>> findSinglesByArtist(FindSinglesByArtistRef ref, String id) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${p.backendUrl}/info/singles/by/artist/$id"),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode(<String, String>{
        'authtoken': _sp.getString("token") ?? ""
      })
  );
  var desponse = jsonDecode(response.body);
  if(desponse["songs"] == false) {
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
Future<Album> findAlbum(FindAlbumRef ref, String id) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
    Uri.parse("${p.backendUrl}/info/album/$id"),
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
  print(desponse["album"]);
  return Album.fromJson(desponse["album"]);
}

@riverpod
Future<Artist> findArtist(FindArtistRef ref, String id) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
    Uri.parse("${p.backendUrl}/info/artist/$id"),
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
  return Artist.fromJson(desponse["artist"]);
}
