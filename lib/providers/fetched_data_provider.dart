import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../types/song.dart';
import '../types/artists.dart';

part 'fetched_data_provider.g.dart';

@riverpod
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
  print(desponse);
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

@riverpod
Future<List<Artist>> fetchArtists(FetchArtistsref) async {
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
  // print(desponse);
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
