import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:taxi_native/helpers/utilities.dart';
import '../../helpers/service_locator.dart';
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
  List<Map<String, dynamic>> responsible = List<Map<String, dynamic>>.from(desponse["played"]);
  //var songs = <Song>[];
  //songs = await ref.read(findBatchSongsProvider(responsible).future);
  List<Song> songs = responsible.map<Song>((e) => Song.fromJson(e)).toList();
  return songs;
}

@Riverpod(keepAlive: true)
Future<List<Song>> fetchLandingRecentlyPlayed(FetchLandingRecentlyPlayedRef ref) async {
  var _sp = await SharedPreferences.getInstance();
  var response = await http.post(
      Uri.parse("${p.backendUrl}/recently-played/"+(_sp.getString("username") ?? "")+"?limit=10"),
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
    return Future.error({"code": 401, "name": "recently-played-get-landing", "error": "Not authenticated"});
  }
  List<Map<String, dynamic>> responsible = List<Map<String, dynamic>>.from(desponse["played"]);
  //var songs = <Song>[];
  //songs = await ref.read(findBatchSongsProvider(responsible).future);
  List<Song> songs = responsible.map<Song>((e) => Song.fromJson(e)).toList();
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

@riverpod
Future<String> latestVersion(LatestVersionRef ref) async {
  
  var response = await http.get(
    Uri.parse("https://api.github.com/repos/mcmineyc/taxi_native/tags"),
    headers: {
      "Authorization": "Bearer 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",
    },
  );
  if(response.statusCode != 200){
    print(response.body);
    return Future.error("Failed to get version information. Status code: ${response.statusCode}");
  }
  var desponse = jsonDecode(response.body);
  RegExp version_exp = RegExp(r'^v([0-9]+.+)*');
  List versions = desponse.map((v) => (v["name"] ?? "") as String).where((v) => version_exp.hasMatch(v)).where((v) => v != "").toList();
  // List<String> versions = [];
  // for(int i = 1; i <= 10; i++){
  //   for(int ii = 1; ii <= 10; ii++){
  //     for(int iii = 1; iii <= 10; iii++){
  //       for(int iiii = 1; iiii <= 10; iiii++){
  //         versions.add("v${i}.${ii}.${iii}.${iiii}");
  //       }
  //     }
  //   }
  // }
  // versions.sort((_, __) => Random().nextBool() ? 1 : -1); // scramble for testing
  versions.sort((a, b) => compareSemver(a, b));
  // print("Hello from latestVersionPrvider");
  return versions[0];
  // return "v" + Random().nextInt(10).toString();
}
