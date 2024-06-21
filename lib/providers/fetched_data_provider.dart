import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../types/song.dart';
import '../types/album.dart';
import '../types/artists.dart';

part 'fetched_data_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<Song>> fetchSongs(FetchSongsRef ref) async {
  final _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("https://forkleserver.mooo.com:3030/info/songs"),
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
      Uri.parse("https://forkleserver.mooo.com:3030/info/albums"),
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
      Uri.parse("https://forkleserver.mooo.com:3030/info/artists"),
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
      Uri.parse("https://forkleserver.mooo.com:3030/info/songs/batch"),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode({
        'authtoken': (_sp.getString("token") ?? ""),
        'ids': ids
      })
  );
  var desponse = jsonDecode(response.body);
  if(desponse["authed"] == false) {
    return Future.error({"code": 401, "error": "Not authenticated"});
  }
  desponse = desponse["results"];
  List<Song> returning = [];
  for(var i = ids.length - 1; i >= 0; i--) {
    if(desponse.containsKey(ids[i])) {
      returning.add(Song.fromJson(desponse[ids[i]]));
    }else{
      returning.add(EmptySong());
    }
  }
  return returning;
}
