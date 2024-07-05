import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_provider.g.dart';
part 'preferences_provider.freezed.dart';

@freezed
class Prefs with _$Prefs {
  const Prefs._();
  factory Prefs({
    required String backendUrl,
    required String authToken,
    required String username,
  }) = _Prefs;
  Future persist() async {
    var sp = await SharedPreferences.getInstance();
    sp.setString('backendUrl', this.backendUrl);
  }
  Future load() async {
    var sp = await SharedPreferences.getInstance();
    this.copyWith(backendUrl: sp.getString('backendUrl') ?? this.backendUrl, authToken: sp.getString('authToken') ?? this.authToken, username: sp.getString('username') ?? this.username);
  }
}

var prefs = Prefs(backendUrl: 'https://eatthecow.mooo.com:3030', authToken: '', username: 'jedi');

@riverpod
Future<String> backendUrl(BackendUrlRef ref) async {
  var sp = await SharedPreferences.getInstance();
  if(sp.getString('backendUrl') == null || sp.getString('backendUrl') == '' || sp.getString('backendUrl') != prefs.backendUrl) {
    sp.setString('backendUrl', prefs.backendUrl);
  }
  return prefs.backendUrl;
}
