import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../types/song.dart';

part 'fetched_data_provider.g.dart';

@riverpod
Future<List<Song>> fetchData(FetchDataRef ref) async {
  var response = await http.post(
      Uri.parse("https://forkleserver.mooo.com:3030/info/songs"),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode(<String, String>{
        'authtoken': '1234567890'
      })
  );
  var desponse = jsonDecode(response.body);
  print(desponse);
  desponse = desponse["songs"];
  var listThings = <Song>[];
  desponse.forEach((element) {
    print(element);
    var outStr = jsonEncode(element);
    var song = Song.fromJson(jsonDecode(outStr));
    listThings.add(song);
  });
  return listThings;
}