import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../../../service_locator.dart";
import "../../../helper_widgets.dart";
import "../../songs.dart";
import "../../albums.dart";
import "../../artists.dart";
import "../../playlists.dart";
class DesktopLibraryPage extends StatefulWidget {
  DesktopLibraryPageState createState() => DesktopLibraryPageState();
}

class DesktopLibraryPageState extends State<DesktopLibraryPage> {
  bool private = true;
  @override
  initState() {
    super.initState();
    SharedPreferences prefs = ServiceLocator().get<SharedPreferences>();
    private = prefs.getBool('privateLibrary') ?? true;
    currentTab = switch(prefs.getString('libraryTab')) {
      "songs" => _TabList.songs,
      "albums" => _TabList.albums,
      "artists" => _TabList.artists,
      "playlists" => _TabList.playlists,
      _ => _TabList.songs,
    };
  }

  _TabList currentTab = _TabList.songs;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SegmentedButton<_TabList>(
                segments: const <ButtonSegment<_TabList>>[
                  ButtonSegment<_TabList>(
                      value: _TabList.songs,
                      label: Text('Songs'),
                      icon: Icon(Icons.music_note_rounded)),
                  ButtonSegment<_TabList>(
                      value: _TabList.albums,
                      label: Text('Albums'),
                      icon: Icon(Icons.library_music_rounded)),
                  ButtonSegment<_TabList>(
                      value: _TabList.artists,
                      label: Text('Artists'),
                      icon: Icon(Icons.person_rounded)),
                  ButtonSegment<_TabList>(
                      value: _TabList.playlists,
                      label: Text('Playlists'),
                      icon: Icon(Icons.playlist_add_rounded)),
                ],
                selectedIcon: const Icon(Icons.check_rounded),
                selected: <_TabList>{currentTab},
                onSelectionChanged: (Set<_TabList> newSelection) async {
                  setState(() {
                    currentTab = newSelection.first;
                  });
                  (await SharedPreferences.getInstance()).setString('libraryTab',
                    switch(currentTab){
                      _TabList.songs => 'songs',
                      _TabList.albums => 'albums',
                      _TabList.artists => 'artists',
                      _TabList.playlists => 'playlists',
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
            _TabList.songs => SongsPage(private: private),
            _TabList.albums => AlbumsPage(private: private),
            _TabList.artists => ArtistsPage(private: private),
            _TabList.playlists => PlaylistsPage(private: private),
          },
        ),
      ],
    );
  }
}
enum _TabList { songs, albums, artists, playlists }
