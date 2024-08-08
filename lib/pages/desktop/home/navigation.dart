import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';

class DesktopNav extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationRail(
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
                    content: Text("This feature isn't done yet :(${MediaQuery.of(context).size.width}x${MediaQuery.of(context).size.height})"),
                  );
                    ScaffoldMessenger.of(context).showSnackBar(snacky);
                  break;
              }
            },
          );
  }
}
