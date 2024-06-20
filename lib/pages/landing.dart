import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper_widgets.dart';
import '../types/song.dart';
import '../providers/new_provider.dart';
import '../providers/info_provider.dart';
import '../providers/user_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LandingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Song>> newSongs = ref.watch(fetchNewSongsProvider);
    final AsyncValue<List<Song>> recentlyPlayed = ref.watch(fetchRecentlyPlayedProvider);
    final AsyncValue<String> user = ref.watch(userNameProvider);

    return Container(
      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: ListView(
        children: [
          Text(
            user.when(
              data: (data) => "Hello, $data!",
              loading: () => "Hello, User!",
              error: (err, stack) => "Greetings and salutations!"
            ),
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(" Favorites", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      MediaCard(
                        text: "A great song",
                        thingId: "thisisgreat",
                        thingType: "song",
                        image: "https://placehold.co/512x512.png",
                      ),
                    ],
                  ),
                )
              )
            ]
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(" Recently Played", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: recentlyPlayed.when(
                    data: (data) {
                      return Row(
                        children: data.map((song) => MediaCard(
                          text: song.displayName,
                          image: "https://eatthecow.mooo.com:3030/info/songs/${song.id}/image",
                          thingId: song.id,
                          thingType: "song",
                        )).toList(),
                      );
                    },
                    loading: () => SingleChildScrollView(
                      child: Skeletonizer(
                        enabled: true,
                        child: Row(
                          children: [for (int i = 0; i < 10; i++) MediaCard(text: "meh who cares", thingId: "idklol", thingType: "song", image: "https://placehold.co/512x512.png")]
                        )
                      )
                    ),
                    error: (err, stack) => Text("Error fetching data: $err"),
                )
              ))
            ]
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("  Recommended By Others", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [ 
                      MediaCard(
                        text: "Megalovania",
                        thingId: "idklol",
                        thingType: "song",
                        image: "https://eatthecow.mooo.com:3030/info/songs/de96dae7e8737bc6285b26c6a6ba7978d05d3d6c7739017ba5b930deb018f3ef_3f4bf9ee2fbc96a53a3d70934e11db632d4408ce27effd950d151480884e7b87_3f4bf9ee2fbc96a53a3d70934e11db632d4408ce27effd950d151480884e7b87/image",
                      ),
                    ],
                  ),
                )
              )
            ]
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("  New Playlists", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      MediaCard(
                        text: "HYPE",
                        thingId: "idklol",
                        thingType: "playlist",
                        image: "https://eatthecow.mooo.com:3030/info/songs/3206e87679e8df617737af5d2e3d1cf6529efa339d19347bbbaa30bd9523b2a6_657b7be77e32cc2f9904e1c3a921e195ec15b116d2f3814d8d5d87f8c64c499b_a0b828f8c1b319af5e0e415f7c385c38ce6bd720ae14ef9e3c0da584ea6506f4/image",
                      ),
                    ],
                  ),
                )
              )
            ]
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("  New Songs", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: newSongs.when(
                    data: (data) {
                      return Row(
                        children: data.map((song) => MediaCard(
                          text: song.displayName,
                          image: "https://eatthecow.mooo.com:3030/info/songs/${song.id}/image",
                          thingId: song.id,
                          thingType: "song",
                        )).toList(),
                      );
                    },
                    loading: () => SingleChildScrollView(
                      child: Skeletonizer(
                        enabled: true,
                        child: Row(
                          children: [for (int i = 0; i < 10; i++) MediaCard(text: "meh who cares", thingId: "idklol", thingType: "song", image: "https://placehold.co/512x512.png")]
                        )
                      )
                    ),
                    error: (err, stack) => Text("Error fetching data: $err"),
                )
              ))
            ]
          ),
        ]
      )
    );
  }
}
