// ignore_for_file: implicit_call_tearoffs
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:context_menus/context_menus.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:provider/provider.dart' as prov;
import 'package:shared_preferences/shared_preferences.dart';
import 'service_locator.dart';
// import 'package:just_audio_handlers/just_audio_handlers.dart';
// import 'providers/services/better_handler.dart';
import 'providers/services/player.dart';
import 'providers/data/preferences_provider.dart';
import 'platform_utils.dart';
import 'providers/theme_provider.dart';

import 'pages/error.dart';
import 'pages/home.dart';
import 'pages/artists.dart';
import 'pages/artist.dart';
import 'pages/albums.dart';
import 'pages/album.dart';
import 'pages/songs.dart';
import 'pages/adder.dart';
import 'pages/queue.dart';
import 'pages/landing.dart';
import 'pages/search.dart';
import 'pages/playlists.dart';
import 'pages/playlist.dart';
import 'pages/settings.dart';
import 'pages/checklist.dart';
import 'pages/library.dart';
import 'login.dart';

late AudioHandler audioHandler;

void main() async{
  if(PlatformUtils.isDesktop){
    print("Using FFI");
  }
  // print("Current commit: ${String.fromEnvironment("GIT_REV")}");
  // Initialize FFI
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().register<SharedPreferences>(await SharedPreferences.getInstance());
  // var handy = AudioHandlerJustAudio(player: AudioPlayer());
  var handy = AudioServiceHandler();
  await handy.init();
  var audioHandler = await AudioService.init(
    builder: () => handy,
  );
  ServiceLocator().register<AudioHandler>(audioHandler);
  final session = await AudioSession.instance;
  await session.configure(AudioSessionConfiguration.music());
  await session.setActive(true);
  var p = Prefs(backendUrl: "https://eatthecow.mooo.com:3030", authToken: "", username: "");
  await p.load();
  ServiceLocator().register<Prefs>(p);
  ThemeChanger themeProvider = ThemeChanger();
  await themeProvider.init();
  var scheme = ColorScheme.fromSeed(
    seedColor: HexColor.fromHex(themeProvider.seedColor),
    brightness: themeProvider.dark ? Brightness.dark : Brightness.light, 
  );
  print("Starting app");
  runApp(
    prov.MultiProvider(
      providers: [
        prov.ChangeNotifierProvider(create: (_) => themeProvider),
      ],
      child: ProviderScope(
        child: ContextMenuOverlay(
          cardBuilder: (context, children) => Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHigh,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(children: children)
          ),
          buttonBuilder: (context, config, [__]) => TextButton(
            onPressed: config.onPressed,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  IconTheme(
                    data: IconThemeData(color: scheme.onSurface),
                    child: config.icon ?? Container(),
                  ) ,
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      config.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins().apply(
                        color: scheme.onSurface,
                      ),
                    )
                  ),
                ],
              ),
            ) ,
          ),
          child: App(),
        ),
      )
    ),
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
        '/library': (context, state, data) => BeamPage(
          key: const ValueKey('library'),
          title: 'Library',
          popToNamed: '/home',
          child: HomePage(homeJunk: LibraryPage()),
        ),
        '/artist/:artistId': (context, state, data) {
          final artistId = state.uri.toString().split("/artist/").last.split("/").first.split("?").first;
          return BeamPage(
            key: ValueKey("artist-view-$artistId"),
            title: "Artist",
            popToNamed: '/home',
            child: HomePage(homeJunk: ArtistPage(id: artistId)),
          );
        },
        '/album/:albumId': (context, state, data) {
          final albumId = state.uri.toString().split("/album/").last.split("/").first.split("?").first;
          return BeamPage(
            key: ValueKey("album-view-$albumId"),
            title: "Album",
            popToNamed: '/home',
            child: HomePage(homeJunk: AlbumPage(id: albumId)),
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
        '/queue': (context, state, data) => BeamPage(
          key: const ValueKey('queue'),
          title: 'Queue',
          popToNamed: '/home',
          child: HomePage(homeJunk: QueuePage()),
        ),
        '/adder': (context, state, data) => BeamPage(
          key: const ValueKey('adder'),
          title: 'Adder',
          popToNamed: '/home',
          child: HomePage(homeJunk: AdderPage()),
        ),
        '/search': (context, state, data) => BeamPage(
          key: const ValueKey('search'),
          title: 'Search',
          popToNamed: '/home',
          child: HomePage(homeJunk: SearchPage()),
        ),
        '/playlists': (context, state, data) => BeamPage(
          key: const ValueKey('playlists'),
          title: 'Playlists',
          popToNamed: '/home',
          child: HomePage(homeJunk: PlaylistsPage()),
        ),
        '/playlist/:playlistId': (context, state, data) {
          final playlistId = state.uri.toString().split("/playlist/").last.split("/").first.split("?").first;
          return BeamPage(
            key: ValueKey("playlist-view-$playlistId"),
            title: "Playlist",
            popToNamed: '/home',
            child: HomePage(homeJunk: PlaylistPage(id: playlistId)),
          );
        },
        '/settings': (context, state, data) => BeamPage(
          key: const ValueKey('settings'),
          title: 'Settings',
          popToNamed: '/home',
          child: HomePage(homeJunk: SettingsPage()),
        ),
        '/checklist': (context, state, data) => BeamPage(
          key: const ValueKey('checklist'),
          title: 'Roadmap',
          popToNamed: '/home',
          child: HomePage(homeJunk: ChecklistPage()),
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
    final theme = prov.Provider.of<ThemeChanger>(context);
    var scheme = ColorScheme.fromSeed(
      seedColor: HexColor.fromHex(theme.seedColor),
      brightness: theme.dark ? Brightness.dark : Brightness.light, 
    );
    return MaterialApp.router(
      // debugShowCheckedModeBanner: false,
      title: 'Taxi - Native',
      theme: ThemeData(
        colorScheme: scheme, 
        textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface),
        useMaterial3: true,
      ),
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
    );
  }
}

