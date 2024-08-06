import 'package:beamer/beamer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:provider/provider.dart' as prov;

import '../helper_widgets.dart';
import '../providers/playing_provider.dart';
import '../providers/search_provider.dart';
import '../providers/theme_provider.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key, required this.homeJunk});
  final Widget homeJunk;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(playerProvider.notifier).init();
    final player = ref.watch(playerProvider);
    // _searchController.text = ref.read(searchProvider.notifier).text;
    // ref.watch(searchProvider);
    var qText = ref.watch(searchProvider.notifier).text;
    if(Beamer.of(context).currentPages.last.key == ValueKey("search") && qText.isNotEmpty && _searchController.text == "") {
      print("Restoring text: $qText");
      _searchController.text = qText;
    }else if(Beamer.of(context).currentPages.last.key == ValueKey("search") && qText == "") {
      _searchController.clear();
    }
    if(Beamer.of(context).currentPages.last.key == ValueKey("search")) {
      ref.watch(searchProvider.select((value) => value.query));
    }
    return Scaffold(
      // extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Beamer.of(context).beamToNamed('/search'),
        tooltip: "Search",
        child: const Icon(Icons.search_rounded),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(58),
        child: Container(
          color: Theme.of(context).colorScheme.surfaceContainer,
          height: 58,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Beamer.of(context).beamBack(),
                ),
              ),
              Text(
                Beamer.of(context).currentPages.last.title ?? "Home",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Expanded(
                child: Container(),
              ),
              Beamer.of(context).currentPages.last.key == ValueKey("search") ? 
                Container(
                  constraints: BoxConstraints(maxWidth: 512),
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    onChanged: (value) async {
                      ref.read(searchProvider.notifier).search(value);
                    },
                    decoration: ref.read(searchProvider.notifier).text.isNotEmpty ? InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9999)),
                      ),
                      hintText: "Search",
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear), 
                        onPressed: () {
                          _searchController.clear();
                          ref.read(searchProvider.notifier).search("");
                        },
                      )
                    ) :
                    InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9999)),
                      ),
                      hintText: "Search",
                      prefixIcon: const Icon(Icons.search_rounded),
                    )
                  ),
                ) :
                Container(),
                Container(
                  width: 96,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () => Beamer.of(context).beamToNamed('/settings'),
                    // onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Settings not done yet :("))),
                    ),
                  ),
                ),
            ]
          )
        ),
      ),
      body: BodyWithSideSheet(
        show: true,
        sheetWidth: 96,
        sheetBody: NavigationRail(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          // indicatorColor: Theme.of(context).colorScheme.inversePrimary,
          labelType: NavigationRailLabelType.selected,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.home),
              label: Text("Home"),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.library_music_rounded),
              label: Text("Library"),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.queue_music),
              label: Text("Queue"),
            ),
            // NavigationRailDestination(
            //   icon: Icon(Icons.playlist_add),
            //   label: Text("Playlists"),
            // ),
            NavigationRailDestination(
              icon: Icon(Icons.download_rounded),
              label: Text("Adder"),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.checklist_rounded),
              label: Text("Roadmap"),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.bug_report_rounded),
              label: Text("Report an issue"),
            ),
          ],
          selectedIndex: () {
            switch (Beamer.of(context).currentPages.last.key) {
              case ValueKey(value: 'home'):
                return 0;
              case ValueKey(value: 'library'):
                return 1;
              case ValueKey(value: 'queue'):
                return 2;
              // case ValueKey(value: 'playlists'):
              //   return 3;
              case ValueKey(value: 'adder'):
                return 3;
              case ValueKey(value: 'roadmap'):
                return 4;
              case ValueKey(value: 'issues'):
                return 5;
              default:
                return null;
          }}(),
          onDestinationSelected: (int index) {
            switch (index) {
              case 0:
                Beamer.of(context).beamToNamed('/home');
                break;
              case 1:
                Beamer.of(context).beamToNamed('/library');
                break;
              case 2:
                Beamer.of(context).beamToNamed('/queue');
                break;
              // case 3:
              //   Beamer.of(context).beamToNamed('/playlists');
              //   break;
              case 3:
                Beamer.of(context).beamToNamed('/adder');
                break;
              case 4:
                Beamer.of(context).beamToNamed('/checklist');
                break;
              default:
                var snacky = SnackBar(
                  content: Text("This feature isn't done yet :("),
                );
                ScaffoldMessenger.of(context).showSnackBar(snacky);
                break;
            }
          },
        ),
        body: Container(
          color: Theme.of(context).colorScheme.surfaceContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    // color: Colors.teal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    // color: Colors.green,
                    margin: EdgeInsets.fromLTRB(0, 6, 0, 6),
                    child: homeJunk,
                  )
                )
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
                      margin: EdgeInsets.fromLTRB(16, 12, 12, 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  player.displayName,
                                  style: GoogleFonts.poppins().copyWith(color: Theme.of(context).colorScheme.onSurface),
                                  overflow: TextOverflow.ellipsis
                                ),
                                Text(
                                  player.albumDisplayName.isNotEmpty && player.artistDisplayName.isNotEmpty ? "${player.albumDisplayName} - ${player.artistDisplayName}" : "",
                                  style: GoogleFonts.poppins().copyWith(color: Theme.of(context).colorScheme.onSurface),
                                  overflow: TextOverflow.ellipsis
                                ),
                              ],
                            ),
                          ),


                          Container(  // Button group
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    ref.read(playerProvider.notifier).shuffle(!player.shuffle);
                                  },
                                  icon: const Icon(Icons.shuffle_rounded),
                                  color: player.shuffle ? Theme.of(context).colorScheme.primary : null,
                                ),
                                const SpacerWidget(width: 8),
                                FilledButton.tonal(
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 48,
                                      maxHeight: 48
                                    ),
                                    child: const Icon(Icons.skip_previous_rounded, size: 28),
                                  ),
                                  onPressed: () {
                                    ref.read(playerProvider.notifier).previous();
                                  }
                                ),
                                const SpacerWidget(width: 8),
                                FilledButton.tonal(
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
                                FilledButton.tonal(
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 48,
                                      maxHeight: 48
                                    ),
                                    child: const Icon(Icons.skip_next_rounded, size: 28),
    
                                  ),
                                  onPressed: () {
                                    ref.read(playerProvider.notifier).next();
                                  }
                                ),
                                const SpacerWidget(width: 8),
                                IconButton(
                                  onPressed: () {
                                    ref.read(playerProvider.notifier).loop(!player.loop);
                                  },
                                  icon: const Icon(Icons.loop_rounded),
                                  color: player.loop ? Theme.of(context).colorScheme.primary : null,
                                ),
                              ]
                            )
                          ),
                          Expanded(
                            child: Text(
                              "",
                              style: GoogleFonts.poppins().copyWith(color: Theme.of(context).colorScheme.onSurface),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis
                            )
                          ),
                        ]
                      )
                  )]
                    ),
                  ),
                  Listener(
                    onPointerSignal: (event) {
                      if(event is PointerScrollEvent) {
                        print("${event.scrollDelta.dy<0 ? "Scrolling up" : "Scrolling down"}");
                        if(event.scrollDelta.dy < 0) {
                          ref.read(playerProvider.notifier).seekForward(3000);
                          print("Seeking forward");
                        }else{
                          ref.read(playerProvider.notifier).seekBackward(3000);
                          print("Seeking backward");
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 12, 16),
                      child: LinearProgressIndicator(
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(9999),
                        value: player.duration == 0 ? 0 : player.position / player.duration,
                      )
                    ),
                  ),
                ]
              ))
            )
      );
  }
}
