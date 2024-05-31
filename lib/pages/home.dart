import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taxi_native_test/locations.dart';

import '../helper_widgets.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key, required this.homeJunk});
  final Widget homeJunk;
  bool _isPlaying = false;
  double position = 0;


  void _update(callback) {
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                        case ValueKey(value: 'queue'):
                          return 2;
                        case ValueKey(value: 'playlists'):
                          return 3;
                        case ValueKey(value: 'downloader'):
                          return 4;
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
                        case 4:
                          Beamer.of(context).beamToNamed('/downloader');
                          break;
                        default:
                          const snacky = SnackBar(
                            content: Text("This feature isn't done yet"),
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
                                    child: (_isPlaying == false) ? const Icon(Icons.play_circle_outline_rounded, size: 28) : const Icon(Icons.pause_circle_outline_rounded, size: 28),
    
                                  ),
                                  onPressed: () {
                                    _update((){
                                      _isPlaying = _isPlaying ? false : true;
                                    });
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
                  )]
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
              ))
            )
      );
  }
}
