import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileNav extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int width = MediaQuery.of(context).size.width.toInt();
    int numThings = 1;
    if(width >= 225){
      numThings++;
    }
    if(width >= 450){
      numThings++;
    }
    if(width >= 700){
      numThings++;
    }
    //if(width >= 800){
    //  numThings++;
    //}
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      height: 58,
      child: NavigationBar(
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          const NavigationDestination(
            icon: Icon(Icons.library_music_rounded),
            label: "Library",
          ),
          if(width >= 225) const NavigationDestination(
            icon: Icon(Icons.queue_music),
            label: "Queue",
          ),
          if(width >= 450) const NavigationDestination(
            icon: Icon(Icons.download_rounded),
            label: "Adder",
          ),
          if(width >= 700) const NavigationDestination(
               icon: Icon(Icons.checklist_rounded),
                label: "Roadmap",
            ),
           //if(width >= 800) const NavigationDestination(
           //  icon: Icon(Icons.bug_report_rounded),
           //  label: "Report an issue",
           //),
        ],
        selectedIndex: (){
          int index = () {
            switch (Beamer.of(context).currentPages.last.key) {
              case ValueKey(value: 'home'):
                return 0;
              case ValueKey(value: 'library'):
                return 1;
              case ValueKey(value: 'queue'):
                return 2;
              case ValueKey(value: 'playlists'):
                return 3;
              case ValueKey(value: 'adder'):
                return 3;
              case ValueKey(value: 'roadmap'):
                return 4;
              case ValueKey(value: 'issues'):
                return 5;
              default:
                return 0;
          }}();
          if(index > numThings) {
            return 0;
          }else{
            return index;
          }
        }(),
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
            case 3:
              Beamer.of(context).beamToNamed('/adder');
              break;
            case 4:
              Beamer.of(context).beamToNamed('/checklist');
              break;
            //case 5:
            //  Beamer.of(context).beamToNamed('/admin');
            //  break;
            default:
              var snacky = SnackBar(
                content: Text("This feature isn't done yet :("),
              );
              ScaffoldMessenger.of(context).showSnackBar(snacky);
              break;
          }
        },
      ),
    );
  }
}
