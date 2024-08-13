import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../service_locator.dart';
import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'preferences_provider.dart';

part 'user_provider.g.dart';
PreferencesProvider p = ServiceLocator().get<PreferencesProvider>();

@riverpod
Future<int> loginPassword(LoginPasswordRef ref, String username, String password) async {
  SharedPreferences _sp = await SharedPreferences.getInstance();
  try{
    var response = await http.post(
      Uri.parse("${p.backendUrl}/auth"),
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
      Uri.parse("${p.backendUrl}/authtoken"),
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
