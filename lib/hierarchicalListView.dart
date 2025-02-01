import 'package:flutter/material.dart';
import 'types/hierarchicalListView.dart';
import 'package:context_menus/context_menus.dart';

class HierarchicalListView extends StatelessWidget {
  List<HLVArtist> data;
  final Function(List<HLVArtist>) onChange;
  HierarchicalListView({required this.data, required this.onChange});
  // Example data structure for multiple artists and their albums
  //final List<HLVArtist> artists = searchResultsToHLVContent(listResults);
  //final List<HLVArtist> artists = [
  //  HLVArtist('C418', [
  //    HLVAlbum('Minecraft - Volume Beta', "", [
  //      HLVSong("", 'Sweden'),
  //      HLVSong("", 'Cat'),
  //      HLVSong("", 'Dog'),
  //      HLVSong("", 'Mice on Venus'),
  //    ]),
  //    HLVAlbum('Minecraft - Volume Alpha', "", [
  //      HLVSong("", 'Minecraft'),
  //      HLVSong("", 'The End'),
  //      HLVSong("", 'Haggstrom'),
  //      HLVSong("", 'Alpha'),
  //    ]),
  //    HLVAlbum("", 'Dief', [
  //      HLVSong("", 'Dief'),
  //      HLVSong("", 'Notch'),
  //      HLVSong("", 'Sunrise'),
  //    ]),
  //  ]),
  //  HLVArtist('TheFatRat', [
  //    HLVAlbum('The Remixes', "", [
  //      HLVSong("", 'Unity'),
  //      HLVSong("", 'Monody'),
  //      HLVSong("", 'Fly Away'),
  //      HLVSong("", 'The Calling'),
  //    ]),
  //    HLVAlbum('Paralyzed', "", [
  //      HLVSong("", 'The Calling'),
  //      HLVSong("", 'Fly Away'),
  //      HLVSong("", 'Waves'),
  //    ]),
  //  ]),
  //  HLVArtist('Virtual Riot', [
  //    HLVAlbum('The Classics', "", [
  //      HLVSong("", 'Energy Drink'),
  //      HLVSong("", 'Hyperion'),
  //      HLVSong("", 'Primal'),
  //      HLVSong("", 'Machine'),
  //    ]),
  //  ]),
  //];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: data.map((artist) => _buildHLVArtist(artist, 0, context)).toList(),
    );
  }

  // Recursive function to build the hierarchical list view with indentation
  Widget _buildHLVArtist(HLVArtist artist, int level, BuildContext context) {
    double indentation = 24.0 * level; // Increase indentation with each level

    return Padding(
      padding: EdgeInsets.only(left: indentation),
      child: artist.albums.isEmpty
          ? ListTile(
              title: Text(artist.name),
            )
          : ExpansionTile(
              title: Text(artist.name),
              children: artist.albums
                  .map((album) => _buildHLVAlbum(album, level + 1, context))
                  .toList(),
            ),
    );
  }

  // Recursive function to build the album list with indentation
  Widget _buildHLVAlbum(HLVAlbum album, int level, BuildContext context) {
    double indentation = 24.0 * level; // Increase indentation with each level

    return Padding(
      padding: EdgeInsets.only(left: indentation),
      child: album.songs.isEmpty
          ? ListTile(
              title: Text(album.name),
            )
          : ExpansionTile(
              title: Text(album.name),
              children: album.songs
                  .map((song) => _buildHLVSong(song, level + 1, context))
                  .toList(),
            ),
    );
  }

  // Build a song item with indentation
  Widget _buildHLVSong(HLVSong song, int level, BuildContext context) {
    double indentation = 24.0 * level; // Increase indentation for song items

    return ContextMenuRegion(
      contextMenu: GenericContextMenu(
        buttonConfigs: [
          ContextMenuButtonConfig(
            "Edit",
            icon: Icon(Icons.edit_rounded),
            onPressed: () async {
              var text = await showTextInputDialog(context, song.name, "Edit song name");
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("I haven't fully finished this yet :)")));
            },
          ),
          ContextMenuButtonConfig(
            "Delete",
            icon: Icon(Icons.delete_rounded),
            onPressed: () {

            },
          ),
          ContextMenuButtonConfig(
            "Open in browser",
            icon: Icon(Icons.link_rounded),
            onPressed: () {},
          ),
          if (song.url.startsWith("http"))
            ContextMenuButtonConfig(
              "URL: ${song.url}",
              icon: Icon(Icons.language_rounded),
              onPressed: null,
            ),
        ]
      ),
      child: Padding(
        padding: EdgeInsets.only(left: indentation),
        child: ListTile(
          title: Text(song.name),
          subtitle: Text(getHLVSongSubtitle(song)),
        ),
      ),
    );
  }
}

String getHLVSongSubtitle(HLVSong s){
  List<String> urlParts = s.url.split(":");
  switch(urlParts.first){
    case "youtube":
      return "Youtube - ${urlParts[1]}";
    case "http":
    case "https":
      return "URL (right click to see)";
    case "scratch":
      return "Scratch - ${urlParts[1]}";
    case "custom":
      return "Custom (right click to see)";
    default:
      return "";
  }
}

Future<String> showTextInputDialog(BuildContext context, String initialText, String title) async {
  final TextEditingController controller = TextEditingController(text: initialText);
  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () => Navigator.pop(context, controller.text),
          ),
        ],
      );
    },
  ) ?? initialText;
}
