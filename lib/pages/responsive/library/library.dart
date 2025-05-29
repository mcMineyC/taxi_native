import 'package:flutter/material.dart';
import "package:taxi_native/helpers/constants.dart";
import "package:shared_preferences/shared_preferences.dart";
import "common.dart";
import "../../../helpers/service_locator.dart";
import "../../../helpers/widgets/helper_widgets.dart";
import "../../songs.dart";
import "../../albums.dart";
import "../../artists.dart";
import "../../playlists.dart";
import "package:taxi_native/helpers/constants.dart";

class LibraryPage extends StatefulWidget {
  final String? initialPage;
  LibraryPage({this.initialPage});
  @override
  State<StatefulWidget> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  late final String? initialPage;
  // _LibraryPage({Key? key, this.initialPage}) : super(key: key);
  @override
  initState() {
    super.initState();
    initialPage = widget.initialPage;
    SharedPreferences prefs = ServiceLocator().get<SharedPreferences>();
    private = prefs.getBool('privateLibrary') ?? true;
    viewType = (prefs.getBool("libraryUsingGridView") ?? true) ? ViewType.grid : ViewType.list;
    String tabString = widget.initialPage ?? prefs.getString('libraryTab') ?? "songs";
    currentTab = switch(tabString) {
      "songs" => TabList.songs,
      "albums" => TabList.albums,
      "artists" => TabList.artists,
      "playlists" => TabList.playlists,
      _ => TabList.songs,
    };
  }

  bool private = true;
  TabList currentTab = TabList.songs;
  ViewType viewType = ViewType.grid; // todo persist this

  callback(String whatChanged, dynamic value) async {
    switch(whatChanged){
      case "tab":
        setState(() {
          currentTab = value;
        });
        (await SharedPreferences.getInstance()).setString('libraryTab',
          switch(currentTab){
            TabList.songs => 'songs',
            TabList.albums => 'albums',
            TabList.artists => 'artists',
            TabList.playlists => 'playlists',
          }
        );
        break;
      case "mylibrary":
        (await SharedPreferences.getInstance()).setBool('privateLibrary', value);
        setState(() => private = value);
        break;
      case "viewtype":
        setState(() => viewType = value);
        (await SharedPreferences.getInstance()).setBool('libraryUsingGridView', value == ViewType.grid);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenBreakpoint bp = ScreenBreakpoint.determine(MediaQuery.of(context).size.width.toInt());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        if (bp <= ScreenBreakpoint.medium) PillOptions(
          selectedTab: currentTab,
          myLibrary: private,
          viewType: viewType,
          callback: this.callback,
        ),
        if (bp > ScreenBreakpoint.medium) StandardOptions(
          currentTab: currentTab,
          private: private,
          callback: this.callback,
        ),
        Expanded(
          child: switch(currentTab) {
            TabList.songs => SongsPage(private: private, type: viewType),
            TabList.albums => AlbumsPage(private: private, type: viewType),
            TabList.artists => ArtistsPage(private: private, type: viewType),
            TabList.playlists => PlaylistsPage(private: private, type: viewType),
          },
        ),
      ],
    );
  }
}