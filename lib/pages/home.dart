import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../helper_widgets.dart';
import '../providers/playing_provider.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key, required this.homeJunk});
  final Widget homeJunk;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(playerProvider.notifier).init();
    final player = ref.watch(playerProvider);
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 96,
        leading: Center(
          child: IconButton (
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Beamer.of(context).beamBack(),
          )
        ),
        title: Text(Beamer.of(context).currentPages.last.title ?? "Home"),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        scrolledUnderElevation: 0.0,
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
      body: BodyWithSideSheet(
        show: true,
        sheetWidth: 96,
        sheetBody: NavigationRail(
                    backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                    indicatorColor: Theme.of(context).colorScheme.inversePrimary,
                    labelType: NavigationRailLabelType.selected,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text("Home"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.person),
                        label: Text("Artists"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.library_music_rounded),
                        label: Text("Albums"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.music_note_rounded),
                        label: Text("Songs"),
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
                    selectedIndex: () {
                      switch (Beamer.of(context).currentPages.last.key) {
                        case ValueKey(value: 'home'):
                          return 0;
                        case ValueKey(value: 'artists'):
                          return 1;
                        case ValueKey(value: 'albums'):
                          return 2;
                        case ValueKey(value: 'songs'):
                          return 3;
                        case ValueKey(value: 'queue'):
                          return 4;
                        case ValueKey(value: 'playlists'):
                          return 5;
                        case ValueKey(value: 'downloader'):
                          return 6;
                        default:
                          return 0;
                    }}(),
                    onDestinationSelected: (int index) {
                      switch (index) {
                        case 0:
                          Beamer.of(context).beamToNamed('/home');
                          break;
                        case 1:
                          Beamer.of(context).beamToNamed('/artists');
                          break;
                        case 2:
                          Beamer.of(context).beamToNamed('/albums');
                          break;
                        case 3:
                          Beamer.of(context).beamToNamed('/songs');
                          break;
                        default:
                          const snacky = SnackBar(
                            content: Text("This feature isn't done yet :("),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snacky);
                          break;
                      }
                    },
                  ),
        body: Container(
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child:Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        // color: Colors.teal,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        // color: Colors.green,
                        margin: EdgeInsets.fromLTRB(0, 6, 0, 6),
                        child: homeJunk,
                      ))
                    ),
              //Controls
              Container(
                constraints: BoxConstraints(
                  minHeight: 72,
                  maxHeight: 72
                ),
                child: Column(  // Player controls
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              player.displayName,
                              style: GoogleFonts.poppins()
                            )
                          ),
                          

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
                                    //*PLAY_BUTTON
                                    child: (player.isPlaying == false) ? const Icon(Icons.play_circle_outline_rounded, size: 28) : const Icon(Icons.pause_circle_outline_rounded, size: 28),
    
                                  ),
                                  onPressed: () {
                                    ref.read(playerProvider.notifier).toggle(); 
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


                          Expanded(
                            child: Text(
                              "Right",
                              style: GoogleFonts.poppins(),
                              textAlign: TextAlign.end
                            )
                          ),
                        ]
                      )
                  )]
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 0, 12, 16),
                    child: LinearProgressIndicator(
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(9999),
                      value: player.duration == 0 ? 0 : player.position / player.duration,
                      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    )
                  ),
                ]
              ))
            )
      );
  }
}
