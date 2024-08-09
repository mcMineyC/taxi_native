import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'preferences_provider.dart';
import '../../types/song.dart';

part 'new_provider.g.dart';

@riverpod
Future<List<Song>> fetchNewSongs(FetchNewSongsRef ref) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${await ref.read(backendUrlProvider.future)}/info/songs?limit=10"),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode(<String, String>{
        'authtoken': (_sp.getString("token") ?? "")
      })
  );
  var desponse = jsonDecode(response.body);
  // print(desponse);
  desponse = desponse["songs"];
  var listThings = <Song>[];
  // desponse.forEach((element) {
  //   // print(element);
  //   var outStr = jsonEncode(element);
  //   var song = Song.fromJson(jsonDecode(outStr));
  //   listThings.add(song);
  // });
  for(var x = 0; x < (desponse.length >= 10 ? 10 : desponse.length); x++){
    var song = Song.fromJson(desponse[x]);
    listThings.add(song);
  }
  return listThings;
}
