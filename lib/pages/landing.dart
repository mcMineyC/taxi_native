import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:provider/provider.dart" as prov;
import '../helper_widgets.dart';
import '../types/song.dart';
import '../types/playlist.dart';
import '../providers/error_watcher.dart';
import '../providers/data/playlist_provider.dart';
import '../providers/data/new_provider.dart';
import '../providers/data/info_provider.dart';
import '../providers/data/preferences_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:beamer/beamer.dart';

class LandingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PreferencesProvider p = prov.Provider.of<PreferencesProvider>(context);
    final AsyncValue<List<Song>> newSongs = ref.watch(fetchNewSongsProvider);
    final AsyncValue<List<Song>> recentlyPlayed = ref.watch(fetchRecentlyPlayedProvider);
    final AsyncValue<List<Playlist>> newPlaylists = ref.watch(fetchNewPlaylistsProvider);
    // Handle unauth errors
    BeamerDelegate bd = Beamer.of(context);
    handleError(ref, fetchNewSongsProvider, bd);
    handleError(ref, fetchRecentlyPlayedProvider, bd);

    // ref.read(playerProvider.notifier).setArtist("d37ebd110ec1813f206f2f339c3c077e77ddbac3ae981174df651ebc1fd56f9b");

    //print("Rebuilding containing page");
    return Container(
      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: ListView(
        children: [
          Text(
            "Hello, ${p.username}!",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.left,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                " Favorites", 
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Container(
                height: MediaCard.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      //MediaCard(
                      //  text: "A great song",
                      //  thingId: "thisisgreat",
                      //  thingType: "placeholder",
                      //  image: "https://placehold.co/512x512.png",
                      //  addedBy: "jedi",
                      //  inLibrary: true,
                      //),
                    ],
                  ),
                )
              )
            ]
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                " Recently Played",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Container(
                height: MediaCard.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: recentlyPlayed.when(
                    data: (data) {
                      return Row(
                        children: data.map((song) => MediaCard(
                          text: song.displayName,
                          image: song.imageUrl,
                          thingId: song.id,
                          thingType: "song",
                          addedBy: song.addedBy,
                          inLibrary: song.isInLibrary,
                        )).toList(),
                      );
                    },
                    loading: () => SingleChildScrollView(
                      child: Skeletonizer(
                        enabled: true,
                        child: EmptyCardRow()
                      )
                    ),
                    error: (err, stack) => SingleChildScrollView(
                      child: Skeletonizer(
                        enabled: true,
                        child: EmptyCardRow()
                      ),
                    ),
                  ),
                )
              )
            ]
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                " Recommended By Others",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Container(
                height: MediaCard.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [ 
                      //MediaCard(
                      //  text: "Megalovania",
                      //  thingId: "idklol",
                      //  thingType: "placeholder",
                      //  image: "https://placehold.co/512x512.png",
                      //  addedBy: "jedi",
                      //),
                    ],
                  ),
                )
              )
            ]
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "  New Playlists",
                style: TextStyle(
                  fontSize: 26, 
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Container(
                height: MediaCard.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: newPlaylists.when(
                    data: (data) {
                      return Row(
                        children: data.take(10).map((playlist) => MediaCard(
                          text: playlist.displayName,
                          image: "https://placehold.co/512x512.png",
                          thingId: playlist.id,
                          thingType: "playlist",
                          addedBy: playlist.owner,
                          inLibrary: playlist.isInLibrary,
                        )).toList(),
                      );
                    },
                    loading: () => SingleChildScrollView(
                      child: Skeletonizer(
                        enabled: true,
                        child: EmptyCardRow()
                      )
                    ),
                    error: (err, stack) => SingleChildScrollView(
                      child: Skeletonizer(
                        enabled: true,
                        child: EmptyCardRow()
                      ),
                    ),
                  )
                ),
              )
            ]
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "  New Songs",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Container(
                height: MediaCard.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: newSongs.when(
                    data: (data) {
                      return Row(
                        children: data.map((song) => MediaCard(
                          text: song.displayName,
                          image: song.imageUrl,
                          thingId: song.id,
                          thingType: "song",
                          addedBy: song.addedBy,
                          inLibrary: song.isInLibrary,
                        )).toList(),
                      );
                    },
                    loading: () => SingleChildScrollView(
                      child: Skeletonizer(
                        enabled: true,
                        child: EmptyCardRow()
                      )
                    ),
                    error: (err, stack) => SingleChildScrollView(
                      child: Skeletonizer(
                        enabled: true,
                        child: EmptyCardRow()
                      ),
                    ),
                  )
                )
              )
            ]
          ),
        ]
      )
    );
  }
}
