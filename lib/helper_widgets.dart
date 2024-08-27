import 'dart:ui';
import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:context_menus/context_menus.dart';
import 'providers/services/player.dart';
import 'providers/data/playlist_provider.dart';
import 'providers/data/fetched_data_provider.dart';
import 'types/playlist.dart';
import 'types/song.dart';

class MediaCard extends ConsumerWidget{
  static const double height = 198;
  static const double width = 168;

  final String text;
  final String thingId;
  final String thingType;
  final String image;
  final String addedBy;
  const MediaCard({
    super.key, 
    required this.text, 
    required this.thingId, 
    required this.thingType, 
    required this.image,
    required this.addedBy
  });
  
  List<ContextMenuButtonConfig> buildMenuButtons(BuildContext context, WidgetRef ref){
    List<ContextMenuButtonConfig> buttons = [];
    switch (thingType) {
      case "song":
        buttons.add(ContextMenuButtonConfig(
          "Play",
          icon: const Icon(Icons.play_arrow_rounded),
          onPressed: () async {
            ref.read(playerProvider.notifier).setSong(thingId);
          }
        ));
        buttons.add(ContextMenuButtonConfig(
          "Add to queue",
          icon: const Icon(Icons.queue),
          onPressed: () {
            ref.read(playerProvider.notifier).addIdToQueue(thingId);
          }
        ));
        buttons.add(ContextMenuButtonConfig(
          "Add to playlist",
          icon: const Icon(Icons.playlist_add),
          onPressed: () async => await playlistLogic(ref, context, thingId, thingType),
        ));
        break;
      case "album":
        buttons.add(ContextMenuButtonConfig(
          "Play",
          icon: const Icon(Icons.play_arrow_rounded),
          onPressed: () async {
            ref.read(playerProvider.notifier).setAlbum(thingId);
          }
        ));
        buttons.add(ContextMenuButtonConfig(
          "Add to queue",
          icon: const Icon(Icons.queue),
          onPressed: () {
            ref.read(playerProvider.notifier).addAlbumToQueue(thingId);
          }
        ));
        buttons.add(ContextMenuButtonConfig(
          "Add to playlist",
          icon: const Icon(Icons.playlist_add),
          onPressed: () async => await playlistLogic(ref, context, thingId, thingType),
        ));
        break;
      case "artist":
        buttons.add(ContextMenuButtonConfig(
          "Play",
          icon: const Icon(Icons.play_arrow_rounded),
          onPressed: () async {
            ref.read(playerProvider.notifier).setArtist(thingId);
          }
        ));
        buttons.add(ContextMenuButtonConfig(
          "Add to queue",
          icon: const Icon(Icons.queue),
          onPressed: () {
            ref.read(playerProvider.notifier).addArtistToQueue(thingId);
          }
        ));
        buttons.add(ContextMenuButtonConfig(
          "Add to playlist",
          icon: const Icon(Icons.playlist_add),
          onPressed: () async => await playlistLogic(ref, context, thingId, thingType),
        ));
        break;
      default:
        buttons.add(ContextMenuButtonConfig("Placeholder", icon: const Icon(Icons.abc), onPressed: (){}));
        break;
    }
    buttons.add(ContextMenuButtonConfig(
      "Added by: $addedBy",
      onPressed: (){},
    ));
    return buttons;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      richMessage: WidgetSpan(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                text,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 14)
              )
            ),
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          ),
        ),
      ),
      child: ContextMenuRegion(
        contextMenu: GenericContextMenu(
          buttonConfigs: buildMenuButtons(context, ref),
        ),
        child: Container(
          width: width,
          height: height,
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  debugPrint("Pressed card with id: $thingId and type: $thingType");
                  switch (thingType) {
                    case "song":
                      print("Setting song");
                      ref.read(playerProvider.notifier).setSong(thingId);
                      break;
                    case "album":
                      print("Setting album");
                      // ref.read(playerProvider.notifier).setAlbum(thingId);
                      Beamer.of(context).beamToNamed("/album/$thingId");
                      break;
                    case "artist":
                      print("Setting artist");
                      // ref.read(playerProvider.notifier).setArtist(thingId);
                      Beamer.of(context).beamToNamed("/artist/$thingId");
                      // Beamer.of(context).update(: BeamState.fromUriString('/artist/$thingId'));
                      break;
                    case "placeholder":
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Hmm, nothing here. The real question is why do you just go around randomly clicking loading things? ><")));
                    default:
                      debugPrint("No implementation for $thingType");
                  }
                },
                // onSecondaryTap: () {
                //   print("Secondary tapped");
                // },
                // onLongPress: () {
                //   print("Long press");
                // },
              child: Container(
                child: Column(
                  children: [
                      FittedBox(
                        child: Container(
                        margin: EdgeInsets.only(top: 12, left: 12, right: 12),
                        height: 172,
                        width: 172,
                        // decoration: BoxDecoration(
                        //   color: Colors.teal,
                        //   borderRadius: BorderRadius.circular(12),
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12))),
                          errorWidget: (context, url, error) => Icon(Icons.error_outline_rounded,color:Colors.pink[700]),
                        ),
                      ),
                    ),
                    Container(
                      height: 26,
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ),
                  ]
                )
              
            )
          )
        )
        // )
        ),
      ),
    );
  }
}

class SpacerWidget extends StatelessWidget{
  final double height;
  final double width;
  const SpacerWidget({this.height = 0, this.width = 0});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}

Widget EmptyCardRow(){
  return Row(
    children: [
      for (int i = 0; i < 10; i++) MediaCard(
        text: "meh who cares",
        thingId: "idklol",
        thingType: "placeholder",
        image: "https://placehold.co/512x512.png",
        addedBy: "jedi",
      ),
    ]
  );
}

class CheckBox extends StatefulWidget {
  final Function(bool) callback;
  final bool initialValue;
  bool _checkbox = false;
  bool get value => _checkbox;
  set value(bool value) => _checkbox = value;

  CheckBox({Key? key, required this.callback, required this.initialValue}) : super(key: key);
  
  @override
  _CheckBoxState createState() => _CheckBoxState(initalValue: initialValue);
}

class _CheckBoxState extends State<CheckBox> {
  bool _checkbox = false;
  bool clicked = false;
  bool initalValue;

  _CheckBoxState({required this.initalValue});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: (clicked ? _checkbox : initalValue),
      onChanged: (value) {
        setState(() {
          clicked = true;
          _checkbox = value!;
          widget.callback(value);
          widget.value = value;
        });
      }
    );
  }
}

class FancyImage extends StatelessWidget {
  final String url;
  final int width;
  final int height;
  final double radius;
  const FancyImage({Key? key, required this.url, required this.width, required this.height, this.radius = 12}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 20, 24, 0),
      height: height.toDouble(),
      width:  width.toDouble(),
      child: CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.contain,
            ),
          ),
        ),
        placeholder: (context, url) => Container(decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12))),
        errorWidget: (context, url, error) => Icon(Icons.error_outline_rounded,color:Colors.pink[700]),
      ),
    );
  }
}


class AddPlaylistDialog extends StatefulWidget {
  @override
  _AddPlaylistDialogState createState() => _AddPlaylistDialogState();

  List<Playlist> playlists = [];
  AddPlaylistDialog({required this.playlists});
}

class _AddPlaylistDialogState extends State<AddPlaylistDialog> {
  Playlist selected = Playlist(id: "create", displayName: "Common", songs: [], public: true, added: 0, owner: "testguy");
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add to playlist"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Text("Choose a playlist"),
            ),
            FilledButton.tonal(
              child: Text("Create new playlist"),
              onPressed: () {
                setState(() {
                  selected = Playlist(id: "create", displayName: "Common", songs: [], public: true, added: 0, owner: "testguy");
                  Navigator.of(context).pop({"selected": true, "value": selected});
                });
              },
            ),
            ...(List<Widget>.generate(
              widget.playlists.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selected = widget.playlists[index];
                    Navigator.of(context).pop({"selected": true, "value": selected});
                  });
                },
                child: ListTile(
                  title: Text(widget.playlists[index].displayName),
                ),
              ),
            )),
          ]
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop({"selected": false, "value": selected});
          }
        ),
        // TextButton(
        //   child: const Text('Add'),
        //   onPressed: () {
        //     Navigator.of(context).pop({"selected": true, "value": selected});
        //   },
        // ),
      ],
    );
  }
}
class CreatePlaylistDialog extends StatefulWidget {
  @override
  _CreatePlaylistDialogState createState() => _CreatePlaylistDialogState();

  FilledPlaylist starter;
  CreatePlaylistDialog({required this.starter});
}

class _CreatePlaylistDialogState extends State<CreatePlaylistDialog> {
  FilledPlaylist current = FilledPlaylist(id: "create", displayName: "Common", songs: [], public: true, added: 0, owner: "testguy");
  late ThemeData theme;
  List<Song> songs = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    current = widget.starter;
    songs = [...current.songs];
  }
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Container(
            child: Row(
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop({"created": false, "value": current}),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Center(child: Icon(Icons.close)),
                      ),
                    ),
                  ),
                ),
                Text("Create a new playlist", style: theme.textTheme.titleMedium),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: TextButton(
                    child: const Text('Create'),
                    onPressed: () => Navigator.of(context).pop({"created": true, "value": current})
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(24, 20, 24, 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  onChanged: (value) => setState(() => current = current.copyWith(displayName: value)),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Playlist name',
                  ),
                ),
                SpacerWidget(height: 10, width: 0),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: imageController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Image URL',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: FilledButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.auto_fix_high),
                            Container(width: 6),
                            Text("Autogenerate"),
                          ]
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SpacerWidget(height: 8, width: 0),
                Row(
                  children: [
                    Text("Public"),
                    Expanded(child: Container()),
                    Switch(value: current.public, onChanged: (value) {setState(() {current = current.copyWith(public: value);});}),
                  ],
                ),
                Text("${current.songs.length} songs", style: theme.textTheme.bodyLarge),
                Container(height: 16),
                Divider(),
                ...(current.songs.map((s) => 
                  ListTile(
                    title: Text(s.displayName),
                    subtitle: Text("${s.artistDisplayName} - ${s.albumDisplayName}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => setState(() {
                        songs.remove(s);
                        current = current.copyWith(songs: songs);
                      }),
                    ),
                  ),
                )),
              ]
            ),
          ),
        ),
      ),
    );
  }
}

Future playlistLogic(WidgetRef ref, BuildContext context, String thingId, String thingType) async {
  var dialog = AddPlaylistDialog(playlists: await ref.read(fetchPlaylistsProvider.future));
  var result = await showDialog<Map<String, dynamic>>(context: context, builder: (context) => dialog);
  // print("Dialog result: $result");
  if(result != null && result["selected"] && (result["value"] as Playlist).id != "create") {
    // print("Adding song to playlist");
    // print("SID $thingId, PID ${result["value"].id}");
    List<String> oldSongs = [];
    switch(thingType){
      case "song":
        oldSongs = [thingId];
        break;
      case "album":
        oldSongs = (await ref.read(findSongsByAlbumProvider(thingId).future)).map((s) => s.id).toList();
        print("Adding ${oldSongs.length} songs from album");
        break;
      case "artist":
        oldSongs = (await ref.read(findSongsByArtistProvider(thingId).future)).map((s) => s.id).toList();
        print("Adding ${oldSongs.length} songs from artist");
        break;
    }
    await ref.read(addIdsToPlaylistProvider(result["value"].id, oldSongs).future);
  }else if(result != null && result["selected"] && (result["value"] as Playlist).id == "create"){
    List<String> oldSongs = [];
    switch(thingType){
      case "song":
        oldSongs = [thingId];
        break;
      case "album":
        oldSongs = (await ref.read(findSongsByAlbumProvider(thingId).future)).map((s) => s.id).toList();
        print("Adding ${oldSongs.length} songs from album");
        break;
      case "artist":
        oldSongs = (await ref.read(findSongsByArtistProvider(thingId).future)).map((s) => s.id).toList();
        print("Adding ${oldSongs.length} songs from artist");
        break;
    }
    var p = result["value"] as Playlist;
    List<Song> newSongs = [];
    newSongs = await ref.read(findBatchSongsProvider(oldSongs).future);
    print("Found ${newSongs.length} songs to add to playlist");
    var fp = FilledPlaylist(
      id: p.id,
      displayName: p.displayName,
      public: p.public,
      songs: newSongs,
      added: p.added,
      owner: p.owner
    );
    var createDialog = CreatePlaylistDialog(starter: (fp as FilledPlaylist));
    var result2 = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => createDialog
    );
    if(result2 != null && result2["created"]){
      Playlist p = (result2["value"] as FilledPlaylist).toPlaylist();
      // print("Creating playlist with name ${p.displayName}");
      await ref.read(addPlaylistProvider(p).future);
      print("Playlist created");
    }else if(result2 != null && !result2["created"]){
      print("User cancelled");
    }
  }else if(result != null && !result["selected"]){
    print("User cancelled");
  }
}




//const List<String> _users = <String>[
//  'Jedi',
//  'Abby',
//  'Connor',
//  'Braden',
//  'Eli',
//  'Colt',
//  'Najayah',
//  'Luke',
//  'James',
//];

class VisibleToField extends ConsumerStatefulWidget {
  VisibleToField({super.key, required this.onChanged, required this.value, required this.onSaved, required this.id});
  Function(List<String> data) onChanged;
  Future<void> Function(List<String> data) onSaved;
  String id;
  List<String> value = [];
  _VisibleToFieldState? state;

  @override
  _VisibleToFieldState createState() {
    state = _VisibleToFieldState();
    WidgetsBinding.instance.addPostFrameCallback((_) => state!.initalValue = value);
    return state!;
  }
}

class _VisibleToFieldState extends ConsumerState<VisibleToField> {
  List<String> _value = [];
  List<String> _userList = [];
  List<String> get value => _value;
  String id = "";
  set initalValue(List<String> v) => setState(() {_value = v; id = widget.id;});
  set value(List<String> v) => setState(() => _value = v);
  bool _loading = true;
  @override
  Widget build(BuildContext context) {
    if(widget.id != id) initalValue = widget.value;
    AsyncValue<List<String>> users = ref.watch(fetchUsernamesProvider);
    users.when(
      data: (d) => setState(() {
        _userList = d;
        _loading = false;
        if(_value.contains("all")) setState(() => _value = _userList.toList());
      }),
      loading: () => setState(() => _loading = true),
      error: (e, stack) => setState(() {_loading = true; print("Error: $e");print("Stack: $stack");}),
    );
    print("Value: $value, initial: ${widget.value}");
    return Container(
      child: _loading ? 
        Center(
          child: CircularProgressIndicator()
        ) : Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [..._userList.map((e) => 
            InputChip(
              label: Text(e.substring(0, 1).toUpperCase() + e.substring(1)),
              selected: _value.contains(e),
              onSelected: (t) {
                if(_value.contains(e)){
                  _value.remove(e);
                }else{
                  _value.add(e);
                }
                setValue(_value);
              }
            ),
          ),
            FilledButton(
              child: const Text("Save"),
              onPressed: () => widget.onSaved(_value).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Saved")));
                ref.refresh(fetchSongsProvider(ignore: true));
                ref.refresh(fetchAlbumsProvider(ignore: true));
                ref.refresh(fetchArtistsProvider(ignore: true));
              }),
            ),
          ]
        )
    );
  }

  void setValue(List<String> v){
    if(v.isEmpty && _userList.isNotEmpty) v = _userList;
    else if(v.isEmpty && _userList.isEmpty) return;
    setState(() => _value = v);
    //print("\t$value\n\t${widget.value}");
    widget.onChanged(v);
  }
}
