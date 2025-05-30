import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:taxi_native/helpers/extensions/uppercase_extension.dart";
import "package:taxi_native/helpers/widgets/helper_widgets.dart";
enum TabList { songs, albums, artists, playlists }
enum ViewType { list, grid }
class PillOptions extends StatelessWidget {
  TabList selectedTab;
  bool myLibrary;
  ViewType viewType;
  bool showTab;
  bool showViewType;
  bool showPersonalToggle;
  Function(String whatChanged, dynamic value) callback;
  PillOptions({required this.callback, required this.myLibrary, required this.selectedTab, required this.viewType, required this.showViewType, required this.showPersonalToggle, required this.showTab});
  @override
  Widget build(BuildContext context){
    return MenuAnchor(
      menuChildren: [
        SpacerWidget(height: 8),
        if(showPersonalToggle) ListTile(
          title: Text("My Library"),
          leading: Switch(
            value: myLibrary,
            onChanged: (val) => callback("mylibrary", val),
          ),
        ),
        if(showTab) ...TabList.values.map((v) => 
          ListTile(
            title: Text(v.toString().split(".")[1].capitalize()),
            leading: Radio(
              value: v,
              // toggleable: false,
              groupValue: selectedTab,
              onChanged: (val) => callback("tab", val)
            ),
          )
        ),
        if(showViewType) Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ViewTypeSelector(callback: callback, viewType: viewType, context: context, iconSize: 32),
        ),
        SpacerWidget(height: 8),
      ],
      builder: (BuildContext context, MenuController controller, _) => IconButton(
        icon: Icon(Icons.more_vert_rounded),
        onPressed: () {
          if(controller.isOpen)
            controller.close();
          else
            controller.open();
        },
      ),
    );
  }
}

Widget SegmentedTypeButton({required TabList currentTab, required Function(String whatChanged, dynamic value) callback}) => 
Container(
  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
    onSelectionChanged: (Set<TabList> newSelection) {
      callback("tab", newSelection.first);
    },
  )
);

List<Widget> PersonalToggle({required Function(String whatChanged, dynamic value) callback, required bool myLibrary}) =>
[
  Text(
    "Personal",
  ),
  SpacerWidget(width: 8),
  Switch(
    value: myLibrary,
    onChanged: (val) => callback("mylibrary", val),
  ),
];

List<Widget> ViewTypeSelector({required Function(String whatChanged, dynamic value) callback, required ViewType viewType, required BuildContext context, required int iconSize}) =>
[
  IconButton(
    icon: Icon(Icons.grid_view_rounded, color: viewType == ViewType.grid ? Theme.of(context).colorScheme.primary : null),
    iconSize: 32,
    onPressed: () => callback("viewtype", ViewType.grid),
  ),
  IconButton(
    icon: Icon(Icons.list_rounded, color: viewType == ViewType.list ? Theme.of(context).colorScheme.primary : null),
    iconSize: 32,
    onPressed: () => callback("viewtype", ViewType.list),
  )
];