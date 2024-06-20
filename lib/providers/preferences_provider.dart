import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:audioplayers/audioplayers.dart';

import 'info_provider.dart';

// part 'preferences_provider.g.dart';
part 'preferences_provider.freezed.dart';

@freezed
class Prefs with _$Prefs {
  factory Prefs({
    required String backendUrl,
    required String authToken,
    required String username,
  }) = _Prefs;
}
