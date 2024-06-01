import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../types/song.dart';

part 'info_provider.g.dart';

@riverpod
Future<List<Song>> fetchRecentlyPlayed(FetchRecentlyPlayedRef ref) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("https://forkleserver.mooo.com:3030/recently-played/"+(_sp.getString("username") ?? "")),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode(<String, String>{
        'authtoken': (_sp.getString("token") ?? "")
      })
  );
  var desponse = jsonDecode(response.body);
  desponse = desponse["played"];
  var songs = <Song>[];
  if(desponse is List) {
      for(var x = desponse.length - 1; x > 0; x--) {
          var repsonse = await http.post(
              Uri.parse("https://forkleserver.mooo.com:3030/info/songs/${desponse[x]}"),
              headers: Map<String, String>.from({
                'Content-Type': 'application/json'
              }),
              body: jsonEncode(<String, String>{
                'authtoken': (_sp.getString("token") ?? "")
             })
          );
          var ds = jsonDecode(repsonse.body);
          var songy = Song.fromJson(ds);
          songs.add(songy);
      };
      return songs;
  }else{
      return [];
  }
}
