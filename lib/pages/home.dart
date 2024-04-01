import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../helper_widgets.dart';
import 'cards.dart';
import '../main.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

final cards = [
  {
    "displayName": "Card 1",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 2",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Lorem Ipsum Dolor Sit Amet",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 1",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 2",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Lorem Ipsum Dolor Sit Amet",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 1",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 2",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Lorem Ipsum Dolor Sit Amet",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 1",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 2",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Lorem Ipsum Dolor Sit Amet",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 1",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 2",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Lorem Ipsum Dolor Sit Amet",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 1",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 2",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Lorem Ipsum Dolor Sit Amet",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 1",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 2",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Lorem Ipsum Dolor Sit Amet",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 1",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 2",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Lorem Ipsum Dolor Sit Amet",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 1",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Card 2",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
  {
    "displayName": "Lorem Ipsum Dolor Sit Amet",
    "image": "https://picsum.photos/200",
    "id": "1",
    "type": "card",
  },
];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    // debugPrint((MediaQuery.of(context).size.width / 220).truncate().toString());

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        scrolledUnderElevation: 0.0,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Just Some Random Cards", style: GoogleFonts.poppins()),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              const snacky = SnackBar(
                // width: 10,
                content: Text("Settings isn't done yet"),
              );
              ScaffoldMessenger.of(context).showSnackBar(snacky);
            },
            tooltip: "Settings",
          )
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  NavigationRail(
                    backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                    indicatorColor: Theme.of(context).colorScheme.inversePrimary,
                    labelType: NavigationRailLabelType.selected,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text("Home"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.queue_music),
                        label: Text("Queue"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.playlist_add),
                        label: Text("Playlists"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.download_rounded),
                        label: Text("Downloader"),
                      ),
                    ],
                    selectedIndex: 0,
                    onDestinationSelected: (int index) {
                      // TODO
                    },
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 6, 0, 6),
                        child: CardView(cardList: cards,),
                      )
                    ),
                  ),
                ]
              )
            ),
            Container( // Bottom bar
              constraints: const BoxConstraints(
                minHeight: 96,
                maxHeight: 96
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin:EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: Row(
                        children: [
                          Text("Left", style: GoogleFonts.poppins()),
                          const Spacer(),
                          Container(  // Button group
                            child: Row(
                              children: [
                                FilledButton(
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 48,
                                      maxHeight: 48
                                    ),
                                    child: const Icon(Icons.skip_previous_rounded, size: 28),
    
                                  ),
                                  onPressed: () {          
                                }
                                ),
                                const SpacerWidget(width: 8),
                                FilledButton(
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 48,
                                      maxHeight: 48
                                    ),
                                    child: Icon(Icons.play_circle_outline_rounded, size: 28),
    
                                  ),
                                  onPressed: () {
                                    
                                  }
                                ),
                                const SpacerWidget(width: 8),
                                FilledButton(
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 48,
                                      maxHeight: 48
                                    ),
                                    child: const Icon(Icons.skip_next_rounded, size: 28),
    
                                  ),
                                  onPressed: () {
                                    
                                  }
                                ),
                              ]
                            )
                          ),
                          const Spacer(),
                          Text("Right", style: GoogleFonts.poppins()),
                        ]
                      )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 0, 12, 16),
                    child: LinearProgressIndicator(
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(9999),
                      value: 0.42,
                      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    )
                  ),
                ]
              )
            )
          ]
        )
      ),
    );
  }
}
