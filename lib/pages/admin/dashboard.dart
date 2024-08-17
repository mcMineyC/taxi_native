import "package:flutter/material.dart";
import "package:beamer/beamer.dart";

import '../desktop/home/appbar.dart';

import "../../types/song.dart";
import "../../types/album.dart";
import "../../types/artists.dart";
import "../../types/playlist.dart";

import "songs.dart";

class AdminDashboardPage extends StatefulWidget {
  String selected = "";
  AdminDashboardPage(this.selected);

  @override
  AdminDashboardPageState createState() => AdminDashboardPageState();
}

class AdminDashboardPageState extends State<AdminDashboardPage> {
  String selected = "";
  dynamic selectedObject;

  @override
  Widget build(BuildContext context) {
    selected = widget.selected;
    List<(String name, IconData icon, String route, int numPanes)> navigationItems = [
      ("Overview", Icons.home_rounded, "", 1),
      ("Songs", Icons.music_note_rounded, "songs", 2),
      ("Albums", Icons.album_rounded, "albums", 2),
      ("Artists", Icons.person_rounded, "artists", 2),
      ("Playlists", Icons.playlist_play_rounded, "playlists", 2),
      ("Users", Icons.people_rounded, "users", 2),
    ];
    int selectedPage = navigationItems.indexWhere((element) => element.$3 == selected);
    (String name, IconData icon, String route, int numPanes) item = navigationItems[selectedPage];

    bool mobile = MediaQuery.of(context).size.width < 840;
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
                    constraints: const BoxConstraints(maxWidth: 200),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      borderRadius: const BorderRadius.all(Radius.circular(24)).copyWith(topLeft: Radius.zero, bottomLeft: Radius.zero),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 18),
                    padding: const EdgeInsets.only(top: 12),
                    child: NavigationDrawer(
                      selectedIndex: selectedPage,
                      onDestinationSelected: (int index) {
                        Beamer.of(context).beamToNamed("/admin${index != 0 ? "/" : ""}" + navigationItems[index].$3);
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
                        borderRadius: const BorderRadius.all(Radius.circular(24)),
                        color: Theme.of(context).colorScheme.surfaceContainer,
                      ),
                      child: switch(selectedPage) {
                        0 => Text("Overview"),
                        1 => SongsPane1(callback: songPageSwitched),
                        _ => Text(item.$1),
                      },
                    ),
                  ),
                ],
              ),
            ),
            if(selectedObject != null) Expanded(
              child: Container(
                margin: const EdgeInsets.all(18).copyWith(left: 12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                child: switch(selectedPage) {
                  0 => Text("Overview pane2"),
                  1 => SongsPane2(selected: selectedObject),
                  _ => Text(item.$1 + " pane2"),
                },
              ),
            ),
          ],
        ),
      )
    );
  }

  void songPageSwitched(Song s){
    setState(() {
      selectedObject = s;
    });
  }
}
