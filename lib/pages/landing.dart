import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper_widgets.dart';
import '../types/song.dart';
import '../providers/new_provider.dart';
import '../providers/info_provider.dart';

class LandingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Song>> newSongs = ref.watch(fetchNewSongsProvider);
    final AsyncValue<List<Song>> recentlyPlayed = ref.watch(fetchRecentlyPlayedProvider);

    return Container(
      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: ListView(
        children: [
          Text(
            "Hello, User!",
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
                  child: Row(
                    children: 
                      recentlyPlayed.when(
                        data: (data) => data.map((song) => MediaCard(
                          text: song.displayName,
                          image: "https://eatthecow.mooo.com:3030/info/songs/${song.id}/image",
                          thingId: song.id,
                          thingType: "song",
                        )).toList(),
                        loading: () => [Center(child: CircularProgressIndicator())],
                        error: (err, stack) => [Text("Error fetching data: $err")],
                      )
                      // MediaCard(
                      //   text: "Sevcon",
                      //   thingId: "idklol",
                      //   thingType: "song",
                      //   image: "https://eatthecow.mooo.com:3030/info/songs/94c2eddf97b4e8e1d2d2142030ddd50a73ce6bbd9e639498fa9780e04897e331_b8205db61d821c68c7371dc8aae446d48d3801b3ed1eef863fe838a001b30a50_ac74ddee7ade1c36f46baaea6f3a7890375a81629a426ed253eee1ab80e5a33d/image",
                      // ),
                  ),
                )
              )
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
                    loading: () => Center(child: CircularProgressIndicator()),
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
