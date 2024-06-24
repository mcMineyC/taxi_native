// ignore_for_file: implicit_call_tearoffs

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:context_menus/context_menus.dart';
import 'package:audio_service/audio_service.dart';
import 'service_locator.dart';
import 'providers/playing_provider.dart';


import 'pages/error.dart';
import 'pages/home.dart';
import 'pages/artists.dart';
import 'pages/artist.dart';
import 'pages/albums.dart';
import 'pages/songs.dart';
import 'pages/downloader.dart';
import 'pages/landing.dart';
import 'login.dart';

late AudioHandler audioHandler;

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
  WidgetsFlutterBinding.ensureInitialized();
  var handy = AudioServiceHandler();
  handy.init();
  audioHandler = await AudioService.init(
    builder: () => handy,
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.forkleserver.taxi-native',
      androidNotificationChannelName: 'Media Player',
      androidNotificationOngoing: true,
    )
  );
  // await audioHandler.playMediaItem(MediaItem(id: 'https://download.samplelib.com/mp3/sample-3s.mp3', title: 'Music', album: 'Album', artist: 'Artist', duration: const Duration(milliseconds: 20000)));
  ServiceLocator().register<AudioHandler>(audioHandler);

  runApp(
    ProviderScope(
      child: ContextMenuOverlay(
        child: App(),
      ),
    )
  );
}

class App extends ConsumerWidget {
  final routerDelegate = BeamerDelegate(
    initialPath: '/login',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/*':  (context, state, data) => BeamPage(
          key: ValueKey('how'),
          title: 'Error',
          popToNamed: '/home',
          child: HomePage(homeJunk: ErrorPage()), //ErrorPage(),
        ),
        '/':   (context, state, data) => BeamPage(
          key: const ValueKey('slash'),
          title: 'Slash (The Root)',
          popToNamed: '/home',
          child: HomePage(homeJunk: ErrorPage()),
        ),
        '/how': (context, state, data) => BeamPage(
          key: const ValueKey('how'),
          title: 'How. Just How?',
          child: HomePage(homeJunk: ErrorPage()),
        ),
        '/login': (context, state, data) => BeamPage(
          key: const ValueKey('login'),
          title: 'Login',
          child: LoginPage(),
        ),
        '/home': (context, state, data) => BeamPage(
          key: const ValueKey('home'),
          title: 'Home',
          child: HomePage(homeJunk: LandingPage()),
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
        '/albums': (context, state, data) => BeamPage(
          key: const ValueKey('albums'),
          title: 'Albums',
          popToNamed: '/home',
          child: HomePage(homeJunk: AlbumsPage()),
        ),
        '/songs': (context, state, data) => BeamPage(
          key: const ValueKey('songs'),
          title: 'Songs',
          popToNamed: '/home',
          child: HomePage(homeJunk: SongsPage()),
        ),
        '/downloader': (context, state, data) => BeamPage(
          key: const ValueKey('downloader'),
          title: 'Downloader',
          popToNamed: '/home',
          child: HomePage(homeJunk: DownloaderPage()),
        ),
      }
    ),
    // buildListener: (p0, p1) {
    //   print("BeamerDelegate buildListener");
    //   p1.currentPages.forEach((element) {
    //     print("Current page: ${element.title} ${element.key.toString()}");
    //   });
    // },
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Taxi - Native',
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
