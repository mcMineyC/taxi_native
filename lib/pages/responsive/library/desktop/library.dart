import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../common/common.dart";
import "../../../../helpers/service_locator.dart";
import "../../../../helpers/widgets/helper_widgets.dart";
import "../../../songs.dart";
import "../../../albums.dart";
import "../../../artists.dart";
import "../../../playlists.dart";
class DesktopLibraryPage extends StatefulWidget {
  final String? initialPage;
  DesktopLibraryPage({Key? key, this.initialPage}) : super(key: key);
  @override
  DesktopLibraryPageState createState() => DesktopLibraryPageState();
}

class DesktopLibraryPageState extends State<DesktopLibraryPage> {
  bool private = true;
  @override
  initState() {
    super.initState();
    SharedPreferences prefs = ServiceLocator().get<SharedPreferences>();
    private = prefs.getBool('privateLibrary') ?? true;
    String tabString = widget.initialPage ?? prefs.getString('libraryTab') ?? "songs";
    currentTab = switch(tabString) {
      "songs" => TabList.songs,
      "albums" => TabList.albums,
      "artists" => TabList.artists,
      "playlists" => TabList.playlists,
      _ => TabList.songs,
    };
  }

  TabList currentTab = TabList.songs;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SegmentedButton<TabList>(
                segments: const <ButtonSegment<TabList>>[
                  ButtonSegment<TabList>(
                      value: TabList.songs,
                      label: Text('Songs'),
                      icon: Icon(Icons.music_note_rounded)),
                  ButtonSegment<TabList>(
                      value: TabList.albums,
                      label: Text('Albums'),
                      icon: Icon(Icons.library_music_rounded)),
                  ButtonSegment<TabList>(
                      value: TabList.artists,
                      label: Text('Artists'),
                      icon: Icon(Icons.person_rounded)),
                  ButtonSegment<TabList>(
                      value: TabList.playlists,
                      label: Text('Playlists'),
                      icon: Icon(Icons.playlist_add_rounded)),
                ],
                selectedIcon: const Icon(Icons.check_rounded),
                selected: <TabList>{currentTab},
                onSelectionChanged: (Set<TabList> newSelection) async {
                  setState(() {
                    currentTab = newSelection.first;
                  });
                  (await SharedPreferences.getInstance()).setString('libraryTab',
                    switch(currentTab){
                      TabList.songs => 'songs',
                      TabList.albums => 'albums',
                      TabList.artists => 'artists',
                      TabList.playlists => 'playlists',
                    }
                  );
                },
              )
            ),
            Expanded(child: Container()),
            Text(
              "My Library",
            ),
            SpacerWidget(width: 8),
            Switch(
              value: private,
              onChanged: (v) async {
                (await SharedPreferences.getInstance()).setBool('privateLibrary', v);
                setState(() => private = v);
              }
            ),
          ],
        ),
        Expanded(
          child: switch(currentTab) {
            TabList.songs => SongsPage(private: private),
            TabList.albums => AlbumsPage(private: private),
            TabList.artists => ArtistsPage(private: private),
            TabList.playlists => PlaylistsPage(private: private),
          },
        ),
      ],
    );
  }
}