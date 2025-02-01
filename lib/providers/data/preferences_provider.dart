import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import "dart:convert";

part "preferences_provider.freezed.dart";
part "preferences_provider.g.dart";

class PreferencesProvider extends ChangeNotifier {
  PreferencesProvider();
  late SharedPreferences sp;
  bool spInit = false;
  PersistenceOptions _persistence = PersistenceOptions.defaults();
  StorablePrefs _prefs = StorablePrefs.defaults();

  PersistenceOptions get persistence => _persistence;
  StorablePrefs get prefs => _prefs;

  set prefs(StorablePrefs p) {
    _prefs = p;
    notifyListeners();
    sp.setString("storedPrefs", jsonEncode(p.toJson()));
  }
  set persistence(PersistenceOptions p) {
    _persistence = p;
    notifyListeners();
    sp.setString("persistenceOptions", jsonEncode(p.toJson()));
  }

  bool get debugMode => prefs.debugMode;
  String get backendUrl => prefs.backendUrl;
  String get username => prefs.username.substring(0, 1).toUpperCase() + prefs.username.substring(1);
  String get loginName => prefs.username;
  bool get shuffleOnLoop => prefs.shuffleOnLoop;
  bool get shuffleDefault => prefs.shuffleDefault;
  bool get autoResume => _persistence.autoplaySong;
  bool get persistInfo => _persistence.persistInfo;
  bool get saveLibraryTab => _persistence.saveLibraryTab;

  set debugMode(bool d)      => prefs = prefs.copyWith(debugMode: d);
  set backendUrl(String u)   => prefs = prefs.copyWith(backendUrl: u);
  set username(String u)     => prefs = prefs.copyWith(username: u);
  set shuffleOnLoop(bool s)  => prefs = prefs.copyWith(shuffleOnLoop: s);
  set shuffleDefault(bool s) => prefs = prefs.copyWith(shuffleDefault: s);
  set autoResume(bool a)     => persistence = persistence.copyWith(autoplaySong: a);
  set persistInfo(bool p)    => persistence = persistence.copyWith(persistInfo: p);
  set saveLibraryTab(bool s) => persistence = persistence.copyWith(saveLibraryTab: s);

  Future<void> logout() async {
    sp.remove("username");
    sp.remove("token");
  }

  Future<void> reset() async {
    if (!spInit) return;
    sp.remove("storedPrefs");
    sp.remove("persistenceOptions");
    persistence = PersistenceOptions.defaults();
  }

  Future<void> init() async {
    if (spInit) return;
    sp = await SharedPreferences.getInstance();
    try{
      _persistence = sp.containsKey("persistenceOptions") ? PersistenceOptions.fromJson(jsonDecode(sp.getString("persistenceOptions")!)) : _persistence;
    }catch(e){
      _persistence = PersistenceOptions.defaults();
    }
    try{
      _prefs = sp.containsKey("storedPrefs") ? StorablePrefs.fromJson(jsonDecode(sp.getString("storedPrefs")!)) : _prefs;
    }catch(e){
      _prefs = StorablePrefs.defaults();
    }
    if(prefs.username == "nobody" || prefs.username == "someone") username = sp.getString("username") ?? "user";
    print("Loaded preferences");
    spInit = true;
  }
}

@freezed
class PersistenceOptions with _$PersistenceOptions {
  factory PersistenceOptions({
    required bool autoplaySong,
    required bool persistInfo,
    required bool saveLibraryTab,
  }) = _PersistenceOptions;
  
  factory PersistenceOptions.fromJson(Map<String, dynamic> json) => _$PersistenceOptionsFromJson(json);
  factory PersistenceOptions.defaults() => PersistenceOptions(autoplaySong: false, persistInfo: true, saveLibraryTab: true);
}

@freezed
class StorablePrefs with _$StorablePrefs {
  factory StorablePrefs({
    required bool shuffleOnLoop,
    required bool shuffleDefault,
    required String username,
    required String backendUrl,
    //required String
    required bool debugMode,
  }) = _StorablePrefs;

  factory StorablePrefs.defaults() => StorablePrefs(shuffleOnLoop: true, shuffleDefault: false, username: "nobody", backendUrl: "https://eatthecow.mooo.com:3030", debugMode: false);
  factory StorablePrefs.fromJson(Map<String, dynamic> json) => _$StorablePrefsFromJson(json);
}
