import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../types/song.dart';

part 'info_provider.g.dart';

@riverpod
Future<List<String>> fetchRecentlyPlayed(FetchRecentlyPlayedRef ref) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("https://forkleserver.mooo.com:3030/recently-played/${_sp.getString("loginName")}"),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode(<String, String>{
        'authtoken': (_sp.getString("token") ?? "")
      })
  );
  var desponse = jsonDecode(response.body);
  if(desponse is List) {
      return [];
  }else{
      return desponse;
  }
}
