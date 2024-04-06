import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


import 'helper_widgets.dart';
import 'locations.dart';
import 'login.dart';

part "main.g.dart";


@riverpod
Future<SharedPreferences> sp(Ref ref) async {
  return await SharedPreferences.getInstance();
}

class PlatformUtils {
  static bool get isMobile {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isIOS || Platform.isAndroid;
    }
  }

  static bool get isDesktop {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isLinux || Platform.isFuchsia || Platform.isWindows || Platform.isMacOS;
    }
  }
}

Future main() async{
  if(PlatformUtils.isDesktop){
    print("Using FFI");
  }
// Initialize FFI
  runApp(
    ProviderScope(
      child: App(),
    )
  );
}

class App extends ConsumerWidget {
  final routerDelegate = BeamerDelegate(
    initialPath: '/login',
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        LoginLocation(),
        HomeLocation(),
      ],
    ),
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Taxi Native',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue[600]!,
          brightness: Brightness.dark
        ),
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
    );
  }
}