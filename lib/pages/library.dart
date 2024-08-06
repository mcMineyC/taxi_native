import "package:flutter/material.dart";
import "songs.dart";
import "albums.dart";
import "artists.dart";
import "playlists.dart";

class LibraryPage extends StatefulWidget {
  LibraryPageState createState() => LibraryPageState();
}

class LibraryPageState extends State<LibraryPage> {
  _TabList currentTab = _TabList.songs;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Container(
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
              onSelectionChanged: (Set<_TabList> newSelection) {
                setState(() {
                  currentTab = newSelection.first;
                });
              },
            )
          ),
        ),
        Expanded(
          child: switch(currentTab) {
            _TabList.songs => SongsPage(),
            _TabList.albums => AlbumsPage(),
            _TabList.artists => ArtistsPage(),
            _TabList.playlists => PlaylistsPage(),
          },
        ),
      ],
    );
  }
}
enum _TabList { songs, albums, artists, playlists }
