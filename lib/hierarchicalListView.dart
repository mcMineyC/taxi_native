import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'types/hierarchicalListView.dart';
import 'helper_widgets.dart';
import 'package:context_menus/context_menus.dart';
import 'package:url_launcher/url_launcher.dart';

class HierarchicalListView extends StatelessWidget {
  List<HLVArtist> data;
  final Function(List<HLVArtist>) onChange;
  HierarchicalListView({required this.data, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return data.isEmpty ?
      Center(
        child: Text(
          "No Results",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        )
      ) : 
      ListView(
        children: data.map((artist) => _buildHLVArtist(artist, 0, context)).toList(),
      );
  }

  // Recursive function to build the hierarchical list view with indentation
  Widget _buildHLVArtist(HLVArtist artist, int level, BuildContext context) {
    double indentation = 24.0 * level; // Increase indentation with each level

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onSecondaryTap: () {
        print("Long press on artist: ${artist.name}");
      },
      child: Padding(
      padding: EdgeInsets.only(left: indentation),
      child: artist.albums.isEmpty ?
        ListTile(
          title: Text(artist.name),
        ) :
        ExpansionTile(
          title: Text(artist.name),
          children: artist.albums
            .map((album) => _buildHLVAlbum(album, artist, level + 1, context))
            .toList(),
        ),
      ),
    );
  }

  // Recursive function to build the album list with indentation
  Widget _buildHLVAlbum(HLVAlbum album, HLVArtist artist, int level, BuildContext context) {
    double indentation = 24.0 * level; // Increase indentation with each level

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onSecondaryTap: () {
        print("Long press on album: ${album.name}");
      },
      child: Padding(
      padding: EdgeInsets.only(left: indentation),
      child: album.songs.isEmpty ?
        ListTile(
          title: Text(album.name),
        ) :
        ExpansionTile(
          title: Text(album.name),
          children: album.songs
            .map((song) => _buildHLVSong(song, album, artist, level + 1, context))
            .toList(),
        ),
      ),
    );
  }

  // Build a song item with indentation
  Widget _buildHLVSong(HLVSong song, HLVAlbum album, HLVArtist artist, int level, BuildContext context) {
    double indentation = 24.0 * level; // Increase indentation for song items

    return ContextMenuRegion(
      contextMenu: GenericContextMenu(
        buttonConfigs: [
          ContextMenuButtonConfig(
            "Edit",
            icon: Icon(Icons.edit_rounded),
            onPressed: () async {
              //var text = await showTextInputDialog(context, song.name, "Edit song name");
              //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("I haven't fully finished this yet :)")));
              HLVSong newSong = await showHLVSongEditDialog(context, song);
              onChange(changeHLVSong(song, album, artist, newSong, data));
            },
          ),
          ContextMenuButtonConfig(
            "Delete",
            icon: Icon(Icons.delete_rounded),
            onPressed: () {
              onChange(changeHLVSong(song, album, artist, null, data));
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

List<HLVArtist> changeHLVSong(HLVSong song, HLVAlbum album, HLVArtist artist, HLVSong? newSong, List<HLVArtist> listt){
  List<HLVArtist> list = listt;
  int artistIndex = list.indexOf(artist);
  HLVArtist foundArtist = list[artistIndex];
  int albumIndex = foundArtist.albums.indexOf(album);
  HLVAlbum foundAlbum = foundArtist.albums[albumIndex];
  int songIndex = foundAlbum.songs.indexOf(song);
  if(newSong != null)
    foundAlbum.songs[songIndex] = newSong;
  else 
    foundAlbum.songs.removeAt(songIndex);
  
  if(foundAlbum.songs.isEmpty)
    foundArtist.albums.removeAt(albumIndex);
  else
    foundArtist.albums[albumIndex] = foundAlbum;

  if(foundArtist.albums.isEmpty)
    list.removeAt(artistIndex);
  else
    list[artistIndex] = foundArtist;
  //printHLVContent(list);
  return list;
}

List<HLVArtist> changeHLVAlbum(HLVAlbum album, HLVArtist artist, HLVAlbum? newAlbum, List<HLVArtist> listt){
  List<HLVArtist> list = listt;
  int artistIndex = list.indexOf(artist);
  HLVArtist foundArtist = list[artistIndex];
  int albumIndex = foundArtist.albums.indexOf(album);
  if(newAlbum != null)
    foundArtist.albums[albumIndex] = newAlbum;
  else
    list.removeAt(artistIndex);

  if(foundArtist.albums.isEmpty)
    list.removeAt(artistIndex);
  else
    list[artistIndex] = foundArtist;

  return list;
}

List<HLVArtist> changeHLVArtist(HLVArtist artist, HLVArtist? newArtist, List<HLVArtist> listt){
  List<HLVArtist> list = listt;
  int artistIndex = list.indexOf(artist);
  if(newArtist != null)
    list[artistIndex] = newArtist;
  else
    list.removeAt(artistIndex);
  return list;
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

class HLVSongEditDialog extends StatefulWidget {
  final HLVSong song;
  final Function(HLVSong) onSaved;
  const HLVSongEditDialog({required this.song, required this.onSaved});
  _HLVSongEditDialogState createState() => _HLVSongEditDialogState();
}

class _HLVSongEditDialogState extends State<HLVSongEditDialog> {
  late HLVSong song;
  TextEditingController nameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  @override
  void initState() {
    this.song = widget.song;
    nameController.text = this.song.name;
    urlController.text = this.song.url;
    this.song = this.song.copyWith(visibleTo: ["all"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: GestureDetector(
                  onTap: () => widget.onSaved(this.song),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Center(child: Icon(Icons.close)),
                  ),
                ),
              ),
            ),
            Text("Edit Song - Adder Step 3",
                style: theme.textTheme.titleMedium),
            Expanded(child: Container()),
            Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TextButton(
                child: const Text('Save'),
                onPressed: () {
                  saveChanges();
                  widget.onSaved(this.song);
                }
              )
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Song name",
                  labelText: "Song name"
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        if(specialUrlToPlain(value) == null) 
                          setState(() => song = song.copyWith(url: value));
                        else
                          setState(() => song = song.copyWith(url: value));
                      },
                      controller: urlController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "URL",
                        labelText: "URL"
                      ),
                    ),
                  ),
                  SpacerWidget(width: 8),
                  FilledButton(
                    onPressed: specialUrlToPlain(song.url) != null ? () => launchUrl(Uri.parse(specialUrlToPlain(song.url)!)) : null,
                    child: Row(
                      children: [
                        Icon(Icons.link),
                        SpacerWidget(width: 4),
                        Text("Open"),
                      ],
                    ),
                  )
                ]
              )
            ),
            CustomListTile(
              leading: Text("Visible to"),
              trailing: TextButton(
                child: Text("Edit..."),
                onPressed: () async {
                  var result = await getVisibleToFieldDialog(song.visibleTo, "Visible to", context);
                  setState(() => song = song.copyWith(visibleTo: result));
                }
              ),
            ),
            //Flexible(child: Container()),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Row(
                children: [
                  Icon(Icons.info_outlined),
                  SpacerWidget(width: 4),
                  Text("To edit the artist and album names, edit the corresponding entries on the previous page")
                ]
              )
            )
          ],
        ),
      ),
    );
  }
  void saveChanges(){
    this.song = song.copyWith(name: nameController.text, url: urlController.text);
  }
}

Future<HLVSong> showHLVSongEditDialog(BuildContext context, HLVSong song) async {
  HLVSongEditDialog dialog = HLVSongEditDialog(song: song, onSaved: (HLVSong s) => Navigator.of(context).pop(s));
  HLVSong result = await showDialog<HLVSong>(context: context, builder: (context) => dialog) ?? song;
  return result;
}

Widget ConstrainedTextField({TextEditingController? controller, Function(String)? onChanged, int maxLines = 1, InputDecoration? decoration, required int maxWidth}){
  return ConstrainedBox(
    constraints: BoxConstraints(maxWidth: maxWidth.toDouble()),
    child: TextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: decoration,
    ),
  );
}
Widget CustomListTile({required Widget leading, required Widget trailing, int spacing = 8}){
  return Container(
    margin: EdgeInsets.symmetric(vertical: spacing.toDouble(), horizontal: 24),
    child: Row(
      children: [
        leading,
        Expanded(child: Container()),
        trailing
      ],
    ),
  );
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
