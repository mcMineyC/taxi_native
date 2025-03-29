// ignore_for_file: implicit_call_tearoffs
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:context_menus/context_menus.dart';
import 'package:provider/provider.dart' as prov;
import 'package:shared_preferences/shared_preferences.dart';
import 'helpers/service_locator.dart';
import 'providers/data/preferences_provider.dart';
import "providers/services/audio_handler.dart";
import "providers/services/player.dart";
import "package:audio_service/audio_service.dart";
import 'providers/theme_provider.dart';
import 'helpers/extensions/uppercase_extension.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'pages/error.dart';
import 'pages/responsive/skeleton/skeleton.dart';
import 'pages/artists.dart';
import 'pages/artist.dart';
import 'pages/albums.dart';
import 'pages/album.dart';
import 'pages/songs.dart';
import 'pages/new_adder.dart';
import 'pages/queue.dart';
import 'pages/landing.dart';
import 'pages/search.dart';
import 'pages/playlists.dart';
import 'pages/responsive/playlist/playlist.dart';
import 'pages/responsive/settings/settings.dart';
import 'pages/checklist.dart';
import 'pages/responsive/library/library.dart';
import 'pages/recently_played.dart';

import 'pages/admin/dashboard.dart';

import 'pages/login.dart';
late MyAudioHandler audioHandler;

void main() async {
  // print("Current commit: ${String.fromEnvironment("GIT_REV")}");
  print("Ensuring widget binding is initialized");
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator()
      .register<SharedPreferences>(await SharedPreferences.getInstance());
  print("Found shared preferences");
  print("Initing audio_service");
  audioHandler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.example.taxi_native.channel.audio',
      androidNotificationChannelName: 'Taxi Audio Playback',
      androidNotificationIcon: "drawable/ic_stat_local_taxi",
      notificationColor: Colors.blue,
      androidStopForegroundOnPause: false,
      //androidNotificationOngoing: true,
    ),
  );
  ServiceLocator().register<MyAudioHandler>(audioHandler);
  print("audio_service init done");
  PreferencesProvider prefsProvider = PreferencesProvider();
  await prefsProvider.init();
  ServiceLocator().register<PreferencesProvider>(prefsProvider);
  ThemeChanger themeProvider = ThemeChanger();
  await themeProvider.init();
  var scheme = ColorScheme.fromSeed(
    seedColor: HexColor.fromHex(themeProvider.seedColor),
    brightness: themeProvider.dark ? Brightness.dark : Brightness.light,
  );
  print("Starting app");
  runApp(prov.MultiProvider(
    providers: [
      prov.ChangeNotifierProvider(create: (_) => themeProvider),
      prov.ChangeNotifierProvider(create: (_) => prefsProvider),
    ],
    child: ProviderScope(
        child: ContextMenuOverlay(
      cardBuilder: (context, children) => Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(children: children)),
      buttonBuilder: (context, config, [__]) => TextButton(
        onPressed: config.onPressed,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              IconTheme(
                data: IconThemeData(color: scheme.onSurface),
                child: config.icon ?? Container(),
              ),
              const SizedBox(width: 8),
              Expanded(
                  child: Text(
                config.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins().apply(
                  color: scheme.onSurface,
                ),
              )),
            ],
          ),
        ),
      ),
      child: App(),
    )),
  ));
}

class App extends ConsumerStatefulWidget{
  App();
  @override
  _AppState createState() => _AppState();
}
class _AppState extends ConsumerState<App> {
  final routerDelegate = BeamerDelegate(
    initialPath: '/login',
    locationBuilder: RoutesLocationBuilder(routes: {
      '/*': (context, state, data) => BeamPage(
            key: ValueKey('how'),
            title: 'Error',
            popToNamed: '/home',
            child: HomePage(homeJunk: ErrorPage()), //ErrorPage(),
          ),
      '/': (context, state, data) => BeamPage(
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
            // popToNamed: '/home',
            child: HomePage(homeJunk: LibraryPage()),
          ),
      '/library/:initialRoute': (context, state, data) {
        final route = state.uri
            .toString()
            .split("/library/")
            .last
            .split("/")
            .first
            .split("?")
            .first;
        print("Route: $route");
        return BeamPage(
          key: ValueKey("library$route"),
          title: "Library",
          // popToNamed: '/home',
          child: HomePage(homeJunk: LibraryPage(initialPage: route)),
        );
      },
      '/artist/:artistId': (context, state, data) {
        print("Artist ID: ${state.pathParameters["artistId"] ?? "not here :("}");
        final artistId = state.uri
            .toString()
            .split("/artist/")
            .last
            .split("/")
            .first
            .split("?")
            .first;
        return BeamPage(
          key: ValueKey("artist-view-$artistId"),
          title: "Artist",
          // popToNamed: '/home',
          child: HomePage(homeJunk: ArtistPage(id: artistId)),
        );
      },
      '/album/:albumId': (context, state, data) {
        final albumId = state.uri
            .toString()
            .split("/album/")
            .last
            .split("/")
            .first
            .split("?")
            .first;
        return BeamPage(
          key: ValueKey("album-view-$albumId"),
          title: "Album",
          // popToNamed: '/home',
          child: HomePage(homeJunk: AlbumPage(id: albumId)),
        );
      },
      '/artists': (context, state, data) => BeamPage(
            key: const ValueKey('artists'),
            title: 'Artists',
            // popToNamed: '/home',
            child: HomePage(homeJunk: ArtistsPage(private: true)),
          ),
      '/albums': (context, state, data) => BeamPage(
            key: const ValueKey('albums'),
            title: 'Albums',
            // popToNamed: '/home',
            child: HomePage(homeJunk: AlbumsPage(private: true)),
          ),
      '/songs': (context, state, data) => BeamPage(
            key: const ValueKey('songs'),
            title: 'Songs',
            // popToNamed: '/home',
            child: HomePage(homeJunk: SongsPage(private: true)),
          ),
      '/queue': (context, state, data) => BeamPage(
            key: const ValueKey('queue'),
            title: 'Queue',
            // popToNamed: '/home',
            child: HomePage(homeJunk: QueuePage()),
          ),
      '/adder': (context, state, data) => BeamPage(
            key: const ValueKey('adder'),
            title: 'Adder',
            // popToNamed: '/home',
            child: HomePage(homeJunk: AdderPage()),
          ),
      '/search': (context, state, data) => BeamPage(
            key: const ValueKey('search'),
            title: 'Search',
            // popToNamed: '/home',
            child: HomePage(homeJunk: SearchPage()),
          ),
      '/playlists': (context, state, data) => BeamPage(
            key: const ValueKey('playlists'),
            title: 'Playlists',
            // popToNamed: '/home',
            child: HomePage(homeJunk: PlaylistsPage(private: true)),
          ),
      '/playlist/:playlistId': (context, state, data) {
        final playlistId = state.uri
            .toString()
            .split("/playlist/")
            .last
            .split("/")
            .first
            .split("?")
            .first;
        return BeamPage(
          key: ValueKey("playlist-view-$playlistId"),
          title: "Playlist",
          // popToNamed: '/home',
          child: HomePage(homeJunk: PlaylistPage(id: playlistId)),
        );
      },
      '/settings': (context, state, data) => BeamPage(
            key: const ValueKey('settings'),
            title: 'Settings',
            // popToNamed: '/home',
            child: HomePage(homeJunk: SettingsPage()),
          ),
      '/checklist': (context, state, data) => BeamPage(
            key: const ValueKey('checklist'),
            title: 'Roadmap',
            // popToNamed: '/home',
            child: HomePage(homeJunk: ChecklistPage()),
          ),
      '/admin': (context, state, data) => BeamPage(
            key: const ValueKey('admin'),
            title: 'Admin Dashboard',
            child: AdminDashboardPage(""),
          ),
      '/admin/:route': (context, state, data) {
        final route = state.uri
            .toString()
            .split("/admin/")
            .last
            .split("/")
            .first
            .split("?")
            .first;
        //print("Admin route: $route");
        return BeamPage(
          key: ValueKey("admin-$route"),
          title: "Admin: ${route.capitalize()}",
          popToNamed: '/admin',
          child: AdminDashboardPage(route),
        );
      },
      '/recentlyPlayed': (context, state, data) => BeamPage(
        key: const ValueKey('played-me'),
        title: 'Recently Played',
        child: HomePage(homeJunk: RecentlyPlayedPage()),
      ),
      '/recentlyPlayed/:user': (context, state, data) {
        final user = state.uri
          .toString()
          .split("/recentlyPlayed/")
          .last
          .split("/")
          .first
          .split("?")
          .first;
        return BeamPage(
          key: ValueKey('played-${user}'),
          title: 'Recently Played',
          // popToNamed: '/home',
          child: HomePage(homeJunk: RecentlyPlayedPage()),
        );
      },
    }),
    // buildListener: (p0, p1) {
    //   print("BeamerDelegate buildListener");
    //   p1.currentPages.forEach((element) {
    //     print("Current page: ${element.title} ${element.key.toString()}");
    //   });
    // },
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = prov.Provider.of<ThemeChanger>(context);
    var scheme = ColorScheme.fromSeed(
      seedColor: HexColor.fromHex(theme.seedColor),
      brightness: theme.dark ? Brightness.dark : Brightness.light,
    );
    theme.textTheme = GoogleFonts.poppinsTextTheme()
        .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);
    theme.colorScheme = scheme;
    return DynamicColorBuilder(
        builder: (ColorScheme? light, ColorScheme? dark) {
      if (theme.auto) {
        print("main.dart@310: Using dynamic colors");
        if (theme.isDark) {
          scheme = dark ?? scheme;
          theme.textTheme = GoogleFonts.poppinsTextTheme().apply(
              bodyColor: scheme.onSurface, displayColor: scheme.onSurface);
          print("main.dart@315: Using dark dynamic colors");
        } else {
          scheme = light ?? scheme;
          theme.textTheme = GoogleFonts.poppinsTextTheme().apply(
              bodyColor: scheme.onSurface, displayColor: scheme.onSurface);
          print("main.dart@320: Using light dynamic colors");
        }
      }
      return MaterialApp.router(
        // debugShowCheckedModeBanner: false,
        title: 'Taxi',
        theme: ThemeData(
          colorScheme: scheme,
          textTheme: theme.textTheme,
          useMaterial3: true,
          sliderTheme: const SliderThemeData(year2023: false),
        ),
        routerDelegate: routerDelegate,
        routeInformationParser: BeamerParser(),
        backButtonDispatcher: BeamerBackButtonDispatcher(delegate: routerDelegate, alwaysBeamBack: true),
      );
    });
  }
  @override
  void initState() {
    super.initState();

    // Listen for app lifecycle changes
    SystemChannels.lifecycle.setMessageHandler((msg) {
      print('App lifecycle change: $msg');
      if (msg == AppLifecycleState.paused.toString() ||
          msg == AppLifecycleState.inactive.toString() ||
          msg == AppLifecycleState.detached.toString()) {
        // App going to background, save state
        final playerRef = ref.read(playerProvider.notifier);
        playerRef.persistPlayerState();
      }
      return Future.value(msg);
    });
  }
}
