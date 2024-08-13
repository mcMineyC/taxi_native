import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ThemeChanger extends ChangeNotifier {
  ThemeChanger();
  late SharedPreferences sp;

  static String defaultSeed = "#1E88E5";
  static bool   defaultDark = false;
  static bool   defaultAuto = false;

  bool spInit = false;
  String seedHex = "";
  bool dark = false;
  bool auto = true;
  TextTheme textTheme = TextTheme();
  ColorScheme? colorScheme;
  bool get isDark => dark;
  String get seedColor => seedHex;
  final platformDark = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;

  set isDark(bool val) {dark = val; notifyListeners(); persist().then((_) {print("Persisted theme data");});}
  set seedColor(String val) {seedHex = val; notifyListeners(); persist().then((_) {print("Persisted theme data");});}
  set useAuto(bool val) {auto = val; if(platformDark) dark = true; notifyListeners(); persist().then((_) {print("Persisted theme data");});}

  void toggleTheme(){
    isDark = !isDark;
  }

  Future<void> reset() async {
    if(!spInit) return;
    sp.remove("seed");
    seedColor = defaultSeed;
    sp.remove("dark");
    isDark = defaultDark;
    sp.remove("auto");
    auto = defaultAuto;
  }

  Future<void> persist() async {
    if (!spInit) return;
    sp.setString("seed", seedHex);
    sp.setBool("dark", dark);
    sp.setBool("auto", auto);
  }

  Future<void> init() async {
    if (spInit) return;
    sp = await SharedPreferences.getInstance();
    seedHex = sp.getString("seed") ?? defaultSeed;
    dark = sp.getBool("dark") ?? defaultDark;
    auto = sp.getBool("auto") ?? defaultAuto;
    notifyListeners();
    print("Loaded theme data");
    spInit = true;
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
