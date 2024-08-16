import "package:flutter/material.dart";
import "package:beamer/beamer.dart";

import '../desktop/home/appbar.dart';

class AdminDashboardPage extends StatefulWidget {
  String selected = "";
  AdminDashboardPage(this.selected);

  @override
  AdminDashboardPageState createState() => AdminDashboardPageState();
}

class AdminDashboardPageState extends State<AdminDashboardPage> {
  String selected = "";
  @override
  Widget build(BuildContext context) {
    selected = widget.selected;
    List<(String name, IconData icon, String route)> navigationItems = [
      ("Songs", Icons.music_note_rounded, "songs"),
      ("Albums", Icons.album_rounded, "albums"),
      ("Artists", Icons.person_rounded, "artists"),
      ("Playlists", Icons.playlist_play_rounded, "playlists"),
      ("Users", Icons.people_rounded, "users"),
    ];

    bool mobile = MediaQuery.of(context).size.width < 840;
    int numPanes = 1;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(58),
        child: DesktopAppBar(),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 18),
                    padding: EdgeInsets.only(top: 12),
                    child: NavigationDrawer(
                      onDestinationSelected: (int index) {
                        switch(index){
                          case 0:
                            Beamer.of(context).beamToReplacementNamed("/admin/songs");
                            break;
                          case 1:
                            Beamer.of(context).beamToReplacementNamed("/admin/albums");
                            break;
                          case 2:
                            Beamer.of(context).beamToReplacementNamed("/admin/artists");
                            break;
                          case 3:
                            Beamer.of(context).beamToReplacementNamed("/admin/playlists");
                            break;
                          case 4:
                            Beamer.of(context).beamToReplacementNamed("/admin/users");
                        }
                      },
                      children: navigationItems.map<Widget>((item) => NavigationDrawerDestination(
                        label: Text(item.$1),
                        icon: Icon(item.$2),
                      )).toList(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(18).copyWith(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        color: Theme.of(context).colorScheme.surfaceContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(18).copyWith(left: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
