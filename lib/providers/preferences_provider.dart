import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'info_provider.dart';

part 'preferences_provider.g.dart';
part 'preferences_provider.freezed.dart';

@freezed
class Prefs with _$Prefs {
  factory Prefs({
    required String backendUrl,
    required String authToken,
    required String username,
  }) = _Prefs;
}

var prefs = Prefs(backendUrl: 'https://eatthecow.mooo.com:3030', authToken: '', username: 'jedi');

@riverpod
Future<String> backendUrl(BackendUrlRef ref) async {
  return prefs.backendUrl;
}
