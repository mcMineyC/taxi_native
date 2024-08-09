import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'preferences_provider.dart';

part 'user_provider.g.dart';

@riverpod
Future<String> userName(UserNameRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  String? user = prefs.getString('username') ?? "user";
  return user.substring(0, 1).toUpperCase() + user.substring(1);
}

@riverpod
Future<int> loginPassword(LoginPasswordRef ref, String username, String password) async {
  SharedPreferences _sp = await SharedPreferences.getInstance();
  try{
    var response = await http.post(
      Uri.parse("${await ref.read(backendUrlProvider.future)}/auth"),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      })
    );
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if(data["authorized"] == false) {
        return 0;
      }else{
        await _sp.setString("token", data["authtoken"]);
        await _sp.setString("username", data["username"]);
        return 1;
      }
    }else{
      return -1;
    }
  }catch(e) {
    return -1;
  }
}

@riverpod
Future<int> loginToken(LoginTokenRef ref, String token) async {
  SharedPreferences _sp = await SharedPreferences.getInstance();
  try{
    var response = await http.post(
      Uri.parse("${await ref.read(backendUrlProvider.future)}/authtoken"),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json'
      }),
      body: jsonEncode(<String, String>{
        'authtoken': token,
      })
    );
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if(data["authorized"] == false) {
        return 0;
      }else{
        await _sp.setString("token", data["authtoken"]);
        await _sp.setString("username", data["username"]);
        return 1;
      }
    }else{
      return -1;
    }
  }catch(e) {
    return -1;
  }
}

@riverpod
Future<String> authtoken(AuthtokenRef ref) async {
  SharedPreferences _sp = await SharedPreferences.getInstance();
  return _sp.getString("token") ?? "";
}
