import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../types/hierarchicalListView.dart';
import 'helper_widgets.dart';
import 'package:context_menus/context_menus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:transparent_image/transparent_image.dart';

class HierarchicalListView extends StatelessWidget {
  final List<HLVArtist> data;
  final Function(List<HLVArtist>) onChange;
  HierarchicalListView({required this.data, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? Center(
            child: Text(
            "No Results",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ))
        : ListView(
            children: data
                .map((artist) => _buildHLVArtist(artist, 0, context))
                .toList(),
            padding: EdgeInsets.zero,
          );
  }
  

  // Recursive function to build the hierarchical list view with indentation
  Widget _buildHLVArtist(HLVArtist artist, int level, BuildContext context) {
    double indentation = 24.0 * level; // Increase indentation with each level

    return ContextMenuRegion(
      contextMenu: GenericContextMenu(
        buttonConfigs: [
          ContextMenuButtonConfig(
            "Edit",
            icon: Icon(Icons.edit_rounded),
            onPressed: () async {
              print("Long press on album: ${artist.name}");
              HLVArtist newArtist =
                  await showHLVArtistEditDialog(context, artist);
              onChange(changeHLVArtist(artist, newArtist, data));
            },
          ),
          ContextMenuButtonConfig(
            "Delete",
            icon: Icon(Icons.delete_rounded),
            onPressed: () {
              onChange(changeHLVArtist(artist, null, data));
            },
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: indentation),
        child: artist.albums.isEmpty
            ? ListTile(
                title: Text(artist.name),
              )
            : ExpansionTile(
                title: Text(artist.name),
                //tilePadding: EdgeInsets.zero,
                children: artist.albums
                    .map((album) =>
                        _buildHLVAlbum(album, artist, level + 1, context))
                    .toList(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(level == 0 ? 8.0 : 0),
                    topRight: Radius.circular(level == 0 ? 8.0 : 0),
                    bottomLeft: Radius.circular(
                        level == artist.albums.length - 1 ? 8.0 : 0),
                    bottomRight: Radius.circular(
                        level == artist.albums.length - 1 ? 8.0 : 0),
                  ),
                ),
                collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
      ),
    );
  }

  // Recursive function to build the album list with indentation
  Widget _buildHLVAlbum(
      HLVAlbum album, HLVArtist artist, int level, BuildContext context) {
    double indentation = 24.0 * level; // Increase indentation with each level

    return ContextMenuRegion(
      contextMenu: GenericContextMenu(
        buttonConfigs: [
          ContextMenuButtonConfig(
            "Edit",
            icon: Icon(Icons.edit_rounded),
            onPressed: () async {
              print("Long press on album: ${album.name}");
              HLVAlbum newAlbum = await showHLVAlbumEditDialog(context, album);
              onChange(changeHLVAlbum(album, artist, newAlbum, data));
            },
          ),
          ContextMenuButtonConfig(
            "Delete",
            icon: Icon(Icons.delete_rounded),
            onPressed: () {
              onChange(changeHLVAlbum(album, artist, null, data));
            },
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: indentation),
        child: album.songs.isEmpty
            ? ListTile(
                title: Text(album.name),
              )
            : ExpansionTile(
                title: Text(album.name),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(level == 0 ? 8.0 : 0),
                    topRight: Radius.circular(level == 0 ? 8.0 : 0),
                    bottomLeft: Radius.circular(
                        level == artist.albums.length - 1 ? 8.0 : 0),
                    bottomRight: Radius.circular(
                        level == artist.albums.length - 1 ? 8.0 : 0),
                  ),
                ),
                collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                children: album.songs
                    .map((song) =>
                        _buildHLVSong(song, album, artist, level + 1, context))
                    .toList(),
              ),
      ),
    );
  }

  // Build a song item with indentation
  Widget _buildHLVSong(HLVSong song, HLVAlbum album, HLVArtist artist,
      int level, BuildContext context) {
    double indentation = 24.0 * level; // Increase indentation for song items

    return ContextMenuRegion(
      contextMenu: GenericContextMenu(buttonConfigs: [
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
          onPressed: () {
            launchUrl(Uri.parse(specialUrlToPlain(song.audioUrl)!));
          },
        ),
        if (song.audioUrl.startsWith("http"))
          ContextMenuButtonConfig(
            "URL: ${song.audioUrl}",
            icon: Icon(Icons.language_rounded),
            onPressed: null,
          ),
      ]),
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

List<HLVArtist> changeHLVSong(HLVSong song, HLVAlbum album, HLVArtist artist,
    HLVSong? newSong, List<HLVArtist> listt) {
  List<HLVArtist> list = listt;
  int artistIndex = list.indexOf(artist);
  HLVArtist foundArtist = list[artistIndex];
  int albumIndex = foundArtist.albums.indexOf(album);
  HLVAlbum foundAlbum = foundArtist.albums[albumIndex];
  int songIndex = foundAlbum.songs.indexOf(song);
  if (newSong != null)
    foundAlbum.songs[songIndex] = newSong;
  else
    foundAlbum.songs.removeAt(songIndex);

  if (foundAlbum.songs.isEmpty)
    foundArtist.albums.removeAt(albumIndex);
  else
    foundArtist.albums[albumIndex] = foundAlbum;

  if (foundArtist.albums.isEmpty)
    list.removeAt(artistIndex);
  else
    list[artistIndex] = foundArtist;
  //printHLVContent(list);
  return list;
}

List<HLVArtist> changeHLVAlbum(HLVAlbum album, HLVArtist artist,
    HLVAlbum? newAlbum, List<HLVArtist> listt) {
  List<HLVArtist> list = listt;
  int artistIndex = list.indexOf(artist);
  HLVArtist foundArtist = list[artistIndex];
  int albumIndex = foundArtist.albums.indexOf(album);
  if (newAlbum != null)
    foundArtist.albums[albumIndex] = newAlbum;
  else
    list.removeAt(artistIndex);

  if (foundArtist.albums.isEmpty)
    list.removeAt(artistIndex);
  else
    list[artistIndex] = foundArtist;

  return list;
}

List<HLVArtist> changeHLVArtist(
    HLVArtist artist, HLVArtist? newArtist, List<HLVArtist> listt) {
  List<HLVArtist> list = listt;
  int artistIndex = list.indexOf(artist);
  if (newArtist != null)
    list[artistIndex] = newArtist;
  else
    list.removeAt(artistIndex);
  return list;
}

String getHLVSongSubtitle(HLVSong s) {
  List<String> urlParts = s.audioUrl.split(":");
  switch (urlParts.first) {
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
    urlController.text = this.song.audioUrl;
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
                    })),
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
                    labelText: "Song name"),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                child: Row(children: [
                  Expanded(
                    child: TextField( // NOTE: change this to a dropdown
                      onChanged: (value) {
                        setState(() => song = song.copyWith(audioUrl: value));
                      },
                      controller: urlController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "URL",
                          labelText: "URL",
                          errorText: kSupportedHLVUrlTypes
                                  .contains(urlController.text.split(":").first)
                              ? null
                              : "Must start with either ${kSupportedHLVUrlTypesString}"),
                    ),
                  ),
                  SpacerWidget(width: 8),
                  FilledButton(
                    onPressed: specialUrlToPlain(song.audioUrl) != null
                        ? () =>
                            launchUrl(Uri.parse(specialUrlToPlain(song.audioUrl)!))
                        : null,
                    child: Row(
                      children: [
                        Icon(Icons.link),
                        SpacerWidget(width: 4),
                        Text("Open"),
                      ],
                    ),
                  )
                ])),
            CustomListTile(
              leading: Text("Visible to"),
              trailing: TextButton(
                  child: Text("Edit..."),
                  onPressed: () async {
                    var result = await getVisibleToFieldDialog(
                        song.visibleTo, "Visible to", context);
                    setState(() => song = song.copyWith(visibleTo: result));
                  }),
            ),
            //Flexible(child: Container()),
            Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                child: Row(children: [
                  Icon(Icons.info_outlined),
                  SpacerWidget(width: 4),
                  Text(
                      "To edit the artist and album names, edit the corresponding entries on the previous page")
                ]))
          ],
        ),
      ),
    );
  }

  void saveChanges() {
    this.song =
        song.copyWith(name: nameController.text, audioUrl: urlController.text);
  }
}

Future<HLVSong> showHLVSongEditDialog(
    BuildContext context, HLVSong song) async {
  HLVSongEditDialog dialog = HLVSongEditDialog(
      song: song, onSaved: (HLVSong s) => Navigator.of(context).pop(s));
  HLVSong result = await showDialog<HLVSong>(
          context: context, builder: (context) => dialog) ??
      song;
  return result;
}

class HLVAlbumEditDialog extends StatefulWidget {
  final HLVAlbum album;
  final Function(HLVAlbum) onSaved;
  const HLVAlbumEditDialog({required this.album, required this.onSaved});
  _HLVAlbumEditDialogState createState() => _HLVAlbumEditDialogState();
}

class _HLVAlbumEditDialogState extends State<HLVAlbumEditDialog> {
  late HLVAlbum album;
  TextEditingController nameController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  @override
  void initState() {
    this.album = widget.album;
    nameController.text = this.album.name;
    imageUrlController.text = this.album.imageUrl;
    print(this.album.imageUrl);
    this.album = this.album.copyWith(visibleTo: ["all"]);
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
                  onTap: () => widget.onSaved(this.album),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Center(child: Icon(Icons.close)),
                  ),
                ),
              ),
            ),
            Text("Edit Album - Adder Step 3",
                style: theme.textTheme.titleMedium),
            Expanded(child: Container()),
            Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: TextButton(
                    child: const Text('Save'),
                    onPressed: () {
                      saveChanges();
                      widget.onSaved(this.album);
                    })),
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
                    hintText: "Album name",
                    labelText: "Album name"),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      controller: imageUrlController,
                      onChanged: (value) {
                        setState(() => album = album.copyWith(imageUrl: value));
                      },
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Image URL",
                          labelText: "Image URL"),
                    ),
                  ),
                  //SpacerWidget(width: 8),
                  //FilledButton(
                  //  onPressed: ,
                  //  child: Row(
                  //    children: [
                  //      Icon(Icons.link),
                  //      SpacerWidget(width: 4),
                  //      Text("Open"),
                  //    ],
                  //  ),
                  //)
                ])),
            CustomListTile(
              leading: Text("Visible to"),
              trailing: TextButton(
                  child: Text("Edit..."),
                  onPressed: () async {
                    var result = await getVisibleToFieldDialog(
                        album.visibleTo, "Visible to", context);
                    setState(() => album = album.copyWith(visibleTo: result));
                  }),
            ),
            //Flexible(child: Container()),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              constraints: BoxConstraints(maxHeight: 512, maxWidth: 512),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: album.imageUrl,
                imageErrorBuilder: (context, error, stackTrace) =>
                    Row(children: [
                  Icon(Icons.error, color: Colors.red[500]),
                  SpacerWidget(width: 8),
                  Text("Failed to load image")
                ]),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(children: [
                    Icon(Icons.info_outlined),
                    SpacerWidget(width: 4),
                    Text(
                        "To edit the artist name, edit the corresponding entry on the previous page",
                        softWrap: true),
                  ])),
            )
          ],
        ),
      ),
    );
  }

  void saveChanges() {
    this.album = album.copyWith(
        name: nameController.text, imageUrl: imageUrlController.text);
  }
}

Future<HLVAlbum> showHLVAlbumEditDialog(
    BuildContext context, HLVAlbum album) async {
  HLVAlbumEditDialog dialog = HLVAlbumEditDialog(
      album: album, onSaved: (HLVAlbum s) => Navigator.of(context).pop(s));
  HLVAlbum result = await showDialog<HLVAlbum>(
          context: context, builder: (context) => dialog) ??
      album;
  return result;
}

class HLVArtistEditDialog extends StatefulWidget {
  final HLVArtist artist;
  final Function(HLVArtist) onSaved;
  const HLVArtistEditDialog({required this.artist, required this.onSaved});
  _HLVArtistEditDialogState createState() => _HLVArtistEditDialogState();
}

class _HLVArtistEditDialogState extends State<HLVArtistEditDialog> {
  late HLVArtist artist;
  TextEditingController nameController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  @override
  void initState() {
    this.artist = widget.artist;
    nameController.text = this.artist.name;
    imageUrlController.text = this.artist.imageUrl;
    print(this.artist.imageUrl);
    this.artist = this.artist.copyWith(visibleTo: ["all"]);
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
                  onTap: () => widget.onSaved(this.artist),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Center(child: Icon(Icons.close)),
                  ),
                ),
              ),
            ),
            Text("Edit Artist - Adder Step 3",
                style: theme.textTheme.titleMedium),
            Expanded(child: Container()),
            Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: TextButton(
                    child: const Text('Save'),
                    onPressed: () {
                      saveChanges();
                      widget.onSaved(this.artist);
                    })),
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
                    hintText: "Artist name",
                    labelText: "Artist name"),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      controller: imageUrlController,
                      onChanged: (value) {
                        setState(
                            () => artist = artist.copyWith(imageUrl: value));
                      },
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Image URL",
                          labelText: "Image URL"),
                    ),
                  ),
                  //SpacerWidget(width: 8),
                  //FilledButton(
                  //  onPressed: ,
                  //  child: Row(
                  //    children: [
                  //      Icon(Icons.link),
                  //      SpacerWidget(width: 4),
                  //      Text("Open"),
                  //    ],
                  //  ),
                  //)
                ])),
            CustomListTile(
              leading: Text("Visible to"),
              trailing: TextButton(
                  child: Text("Edit..."),
                  onPressed: () async {
                    var result = await getVisibleToFieldDialog(
                        artist.visibleTo, "Visible to", context);
                    setState(() => artist = artist.copyWith(visibleTo: result));
                  }),
            ),
            //Flexible(child: Container()),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              constraints: BoxConstraints(maxHeight: 512, maxWidth: 512),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: artist.imageUrl,
                imageErrorBuilder: (context, error, stackTrace) =>
                    Row(children: [
                  Icon(Icons.error, color: Colors.red[500]),
                  SpacerWidget(width: 8),
                  Text("Failed to load image")
                ]),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(children: [
                    Icon(Icons.info_outlined),
                    SpacerWidget(width: 4),
                    Text(
                        "To edit the artist name, edit the corresponding entry on the previous page",
                        softWrap: true),
                  ])),
            )
          ],
        ),
      ),
    );
  }

  void saveChanges() {
    this.artist = artist.copyWith(
        name: nameController.text, imageUrl: imageUrlController.text);
  }
}

Future<HLVArtist> showHLVArtistEditDialog(
    BuildContext context, HLVArtist artist) async {
  HLVArtistEditDialog dialog = HLVArtistEditDialog(
      artist: artist, onSaved: (HLVArtist s) => Navigator.of(context).pop(s));
  HLVArtist result = await showDialog<HLVArtist>(
          context: context, builder: (context) => dialog) ??
      artist;
  return result;
}

Widget ConstrainedTextField(
    {TextEditingController? controller,
    Function(String)? onChanged,
    int maxLines = 1,
    InputDecoration? decoration,
    required int maxWidth}) {
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

Widget CustomListTile(
    {required Widget leading, required Widget trailing, int spacing = 8}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: spacing.toDouble(), horizontal: 24),
    child: Row(
      children: [leading, Expanded(child: Container()), trailing],
    ),
  );
}

Future<String> showTextInputDialog(
    BuildContext context, String initialText, String title) async {
  final TextEditingController controller =
      TextEditingController(text: initialText);
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
      ) ??
      initialText;
}
