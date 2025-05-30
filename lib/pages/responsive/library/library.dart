import 'package:flutter/material.dart';
import "package:taxi_native/helpers/constants.dart";
import "package:shared_preferences/shared_preferences.dart";
import "common.dart";
import "../../../helpers/service_locator.dart";
import "../../../helpers/widgets/helper_widgets.dart";
import "../../lists/songs.dart";
import "../../lists/albums.dart";
import "../../lists/artists.dart";
import "../../lists/playlists.dart";
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
    int width = MediaQuery.of(context).size.width.toInt();
    ScreenBreakpoint bp = ScreenBreakpoint.determine(width);
    // print("${width}: ${bp}");
    bool showPersonalToggle = width >= 630;
    bool showViewTypeSelector = (width < 630 && width >= 594) || width >= 690;
    return Column(
      crossAxisAlignment: width < 500 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        if (width < 500) Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: PillOptions(
            showTab: true,
            showPersonalToggle: true,
            showViewType: true,
            selectedTab: currentTab,
            myLibrary: private,
            viewType: viewType,
            callback: this.callback,
          ),
        ),
        if(width >= 500) Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SegmentedTypeButton(
                  currentTab: currentTab,
                  callback: callback,
                ),
              ),
            ),
            if(showPersonalToggle) ...PersonalToggle(callback: callback, myLibrary: private),
            if(showViewTypeSelector) ...ViewTypeSelector(callback: callback, viewType: viewType, context: context, iconSize: 12),
            if(width >= 490 && width < 690) PillOptions(
              showTab: false,
              showViewType: !showViewTypeSelector,
              showPersonalToggle: !showPersonalToggle,
              selectedTab: currentTab,
              myLibrary: private,
              viewType: viewType,
              callback: this.callback,
            ),
            SpacerWidget(width: 12),
          ],
        ),
        if (bp >= ScreenBreakpoint.medium) ...[
        ],
        
        Expanded(
          child: switch(currentTab) {
            TabList.songs => SongsPage(personal: private, type: viewType),
            TabList.albums => AlbumsPage(personal: private, type: viewType),
            TabList.artists => ArtistsPage(personal: private, type: viewType),
            TabList.playlists => PlaylistsPage(personal: private, type: viewType),
          },
        ),
      ],
    );
  }
}