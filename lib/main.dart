// ignore_for_file: implicit_call_tearoffs

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taxi_native_test/pages/error.dart';


import 'pages/home.dart';
import 'pages/artists.dart';
import 'pages/artist.dart';
import 'pages/downloader.dart';
import 'login.dart';


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

void main() async{
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
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/':   (context, state, data) => BeamPage(
          key: const ValueKey('slash'),
          title: 'Slash (The Root)',
          popToNamed: '/home',
          child: ErrorPage(),
        ),
        '/how': (context, state, data) => BeamPage(
          key: const ValueKey('how'),
          title: 'How',
          child: ErrorPage(),
        ),
        '/login': (context, state, data) => const LoginPage(),
        '/home': (context, state, data) => BeamPage(
          key: const ValueKey('home'),
          title: 'Home',
          child: HomePage(homeJunk: Text("This is /home")),
        ),
        '/artist/:artistId': (context, state, data) {
          final artistId = state.pathParameters['artistId']!;
          return BeamPage(
            key: ValueKey("artist-view"),
            title: artistId,
            popToNamed: '/home',
            child: ArtistPage(id: artistId),
          );
        },
        '/artists': (context, state, data) => BeamPage(
          key: const ValueKey('artists'),
          title: 'Artists',
          popToNamed: '/home',
          child: HomePage(homeJunk: ArtistsPage()),
        ),
        '/downloader': (context, state, data) => BeamPage(
          key: const ValueKey('downloader'),
          title: 'Downloader',
          popToNamed: '/home',
          child: DownloaderPage(),
        ),
      }
    ),
    buildListener: (p0, p1) {
      print("BeamerDelegate buildListener");
      p1.currentPages.forEach((element) {
        print("Current page: ${element.title} ${element.key.toString()}");
      });
    },
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
        // dividerColor: Color.fromARGB(255, 67, 71, 78)
        dividerColor: Colors.pink[600]
      ),
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
    );
  }
}
