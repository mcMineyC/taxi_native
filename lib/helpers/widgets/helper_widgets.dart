import 'dart:ui';
import 'dart:convert';
import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:context_menus/context_menus.dart';
import '../../providers/services/player.dart';
import '../../providers/data/playlist_provider.dart';
import '../../providers/data/fetched_data_provider.dart';
import '../service_locator.dart';
import '../../providers/data/preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../types/playlist.dart';
import '../../types/song.dart';
import '../../types/searchresult.dart';
import '../utilities.dart';
import '../platform_utils.dart';

class MediaCard extends ConsumerWidget {
  static const double height = 198;
  static const double width = 168;

  final String text;
  final String thingId;
  final String thingType;
  final String image;
  final String addedBy;
  final bool inLibrary;
  const MediaCard(
      {super.key,
      required this.text,
      required this.thingId,
      required this.thingType,
      required this.image,
      required this.addedBy,
      required this.inLibrary});

  List<ContextMenuButtonConfig> buildMenuButtons(
      BuildContext context, WidgetRef ref) {
    List<ContextMenuButtonConfig> buttons = [];
    switch (thingType) {
      case "song":
        buttons.add(ContextMenuButtonConfig("Play",
            icon: const Icon(Icons.play_arrow_rounded), onPressed: () async {
          if (PlatformUtils.isWeb) {
            showWebError(context);
            return;
          }
          ref.read(playerProvider.notifier).setSong(thingId);
        }));
        buttons.add(ContextMenuButtonConfig("Add to queue",
            icon: const Icon(Icons.queue), onPressed: () {
          if (PlatformUtils.isWeb) {
            showWebError(context);
            return;
          }
          ref.read(playerProvider.notifier).addIdToQueue(thingId);
        }));
        buttons.add(ContextMenuButtonConfig(
          "Add to playlist",
          icon: const Icon(Icons.playlist_add),
          onPressed: () async =>
              await playlistLogic(ref, context, thingId, thingType),
        ));
        break;
      case "album":
        buttons.add(ContextMenuButtonConfig("Play",
            icon: const Icon(Icons.play_arrow_rounded), onPressed: () async {
          if (PlatformUtils.isWeb) {
            showWebError(context);
            return;
          }
          ref.read(playerProvider.notifier).setAlbum(thingId);
        }));
        buttons.add(ContextMenuButtonConfig("Add to queue",
            icon: const Icon(Icons.queue), onPressed: () {
          if (PlatformUtils.isWeb) {
            showWebError(context);
            return;
          }
          ref.read(playerProvider.notifier).addAlbumToQueue(thingId);
        }));
        buttons.add(ContextMenuButtonConfig(
          "Add to playlist",
          icon: const Icon(Icons.playlist_add),
          onPressed: () async =>
              await playlistLogic(ref, context, thingId, thingType),
        ));
        break;
      case "artist":
        buttons.add(ContextMenuButtonConfig("Play",
            icon: const Icon(Icons.play_arrow_rounded), onPressed: () async {
          if (PlatformUtils.isWeb) {
            showWebError(context);
            return;
          }
          ref.read(playerProvider.notifier).setArtist(thingId);
        }));
        buttons.add(ContextMenuButtonConfig("Add to queue",
            icon: const Icon(Icons.queue), onPressed: () {
          if (PlatformUtils.isWeb) {
            showWebError(context);
            return;
          }
          ref.read(playerProvider.notifier).addArtistToQueue(thingId);
        }));
        buttons.add(ContextMenuButtonConfig(
          "Add to playlist",
          icon: const Icon(Icons.playlist_add),
          onPressed: () async =>
              await playlistLogic(ref, context, thingId, thingType),
        ));
        break;
      case "playlist":
        buttons.add(ContextMenuButtonConfig("Play",
            icon: const Icon(Icons.play_arrow_rounded), onPressed: () async {
          if (PlatformUtils.isWeb) {
            showWebError(context);
            return;
          }
          ref.read(playerProvider.notifier).setPlaylist(thingId);
        }));
        buttons.add(ContextMenuButtonConfig("Add to queue",
            icon: const Icon(Icons.queue), onPressed: () {
          if (PlatformUtils.isWeb) {
            showWebError(context);
            return;
          }
          ref.read(playerProvider.notifier).addPlaylistToQueue(thingId);
        }));
        buttons.add(ContextMenuButtonConfig(
          "Add to playlist",
          icon: const Icon(Icons.playlist_add),
          onPressed: () async =>
              await playlistLogic(ref, context, thingId, thingType),
        ));
        break;
      default:
        buttons.add(ContextMenuButtonConfig("Placeholder",
            icon: const Icon(Icons.abc), onPressed: () {}));
        break;
    }
    if (inLibrary) buttons.add(ContextMenuButtonConfig(
      "Remove from library",
      icon: Icon(Icons.bookmark_remove_rounded),
      onPressed: () {
        ref.read(removeFromLibraryProvider(thingId, thingType).future).then((value) {
          refreshLibrary(ref);
        });
      },
    ));
    else buttons.add(ContextMenuButtonConfig(
      "Add to library",
      icon: Icon(Icons.bookmark_rounded),
      onPressed: () {
        ref.read(addToLibraryProvider(thingId, thingType).future).then((value) {
          refreshLibrary(ref);
        });
      },
    ));
    buttons.add(ContextMenuButtonConfig(
      thingType == "playlist" ? "Owner: $addedBy" : "Added by: $addedBy",
      onPressed: null,
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
                child: Text(text,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 14))),
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
                      debugPrint(
                          "Pressed card with id: $thingId and type: $thingType");
                      switch (thingType) {
                        case "song":
                          if (PlatformUtils.isWeb) {
                            showWebError(context);
                            return;
                          }
                          print("Setting song");
                          ref.read(playerProvider.notifier).setSong(thingId);
                          break;
                        case "album":
                          // if (PlatformUtils.isWeb) {
                          //   showWebError(context);
                          //   return;
                          // }
                          print("Setting album");
                          // ref.read(playerProvider.notifier).setAlbum(thingId);
                          Beamer.of(context).beamToNamed("/album/$thingId");
                          break;
                        case "artist":
                          // if (PlatformUtils.isWeb) {
                          //   showWebError(context);
                          //   return;
                          // }
                          print("Setting artist");
                          // ref.read(playerProvider.notifier).setArtist(thingId);
                          Beamer.of(context).beamToNamed("/artist/$thingId");
                          // Beamer.of(context).update(: BeamState.fromUriString('/artist/$thingId'));
                          break;
                        case "playlist":
                          print("Setting playlist");
                          // ref.read(playerProvider.notifier).setPlaylist(thingId);
                          Beamer.of(context).beamToNamed("/playlist/$thingId");
                          break;
                        case "placeholder":
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Hmm, nothing here. The real question is why do you just go around randomly clicking loading things? ><")));
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
                        child: Column(children: [
                      FittedBox(
                        child: Container(
                          margin: EdgeInsets.only(top: 12, left: 12, right: 12),
                          height: 172,
                          width: 172,
                          // decoration: BoxDecoration(
                          //   color: Colors.teal,
                          //   borderRadius: BorderRadius.circular(12),
                          // ),
                          child: thingType == "playlist"
                              ? PlaylistImage(playlistId: thingId)
                              : CachedNetworkImage(
                                  imageUrl: image,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  errorWidget: (context, url, error) => Icon(
                                      Icons.error_outline_rounded,
                                      color: Colors.pink[700]),
                                ),
                        ),
                      ),
                      Container(
                          height: 26,
                          margin:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Text(
                            text,
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ]))))
            // )
            ),
      ),
    );
  }
}

class SpacerWidget extends StatelessWidget {
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

Widget EmptyCardRow() {
  return Row(children: [
    for (int i = 0; i < 10; i++)
      MediaCard(
        text: "meh who cares",
        thingId: "idklol",
        thingType: "placeholder",
        image: "https://placehold.co/512x512.png",
        addedBy: "jedi",
        inLibrary: true,
      ),
  ]);
}

class CheckBox extends StatefulWidget {
  final Function(bool) callback;
  final bool initialValue;
  bool _checkbox = false;
  bool get value => _checkbox;
  set value(bool value) => _checkbox = value;

  CheckBox({Key? key, required this.callback, required this.initialValue})
      : super(key: key);

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
        });
  }
}

class FancyImage extends StatelessWidget {
  final String url;
  final int width;
  final int height;
  final double radius;
  const FancyImage(
      {Key? key,
      required this.url,
      required this.width,
      required this.height,
      this.radius = 12})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.fromLTRB(24, 20, 24, 0),
      height: height.toDouble(),
      width: width.toDouble(),
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
        placeholder: (context, url) => Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12))),
        errorWidget: (context, url, error) =>
            Icon(Icons.error_outline_rounded, color: Colors.pink[700]),
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
  Playlist selected = Playlist.empty(); // also not used
  String currentUser = "";
  PreferencesProvider p = ServiceLocator().get<PreferencesProvider>();
  @override
  void initState() {
    currentUser = p.loginName;
    print("current user is $currentUser");
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
                    selected = Playlist.empty().copyWith(id: "create"); // this basically only uses the "create" id
                    Navigator.of(context)
                        .pop({"selected": true, "value": selected});
                  });
                },
              ),
              ...(List<Widget>.generate(
                widget.playlists.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = widget.playlists[index];
                      Navigator.of(context)
                          .pop({"selected": true, "value": selected});
                    });
                  },
                  child: ListTile(
                    title: Text(widget.playlists[index].displayName),
                  ),
                ),
              )),
            ]),
      ),
      actions: <Widget>[
        TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop({"selected": false, "value": selected});
            }),
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

class EditPlaylistDialog extends StatefulWidget {
  @override
  _EditPlaylistDialogState createState() => _EditPlaylistDialogState();

  FilledPlaylist starter;
  EditPlaylistDialog({required this.starter});
}

class _EditPlaylistDialogState extends State<EditPlaylistDialog> {
  FilledPlaylist current = FilledPlaylist.empty(); // this gets replaced by the starter (passed in by the caller)
  late ThemeData theme;
  List<Song> songs = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    current = widget.starter;
    nameController.text = widget.starter.displayName;
    descriptionController.text = widget.starter.description;
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
                      onTap: () => Navigator.of(context)
                          .pop({"created": false, "value": current}),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Center(child: Icon(Icons.close)),
                      ),
                    ),
                  ),
                ),
                Text("Create a new playlist",
                    style: theme.textTheme.titleMedium),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: TextButton(
                      child: const Text('Create'),
                      onPressed: () {
                        current = current.copyWith(description: descriptionController.text, displayName: nameController.text);
                        print(current);
                        Navigator.of(context)
                          .pop({"created": true, "value": current});
                      },
                  )
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
                    controller: nameController,
                    // onChanged: (value) => setState(
                    //     () => current = current.copyWith(displayName: value)),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Playlist name',
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    // onChanged: (value) => setState(
                    //     () => current = current.copyWith(description: value)),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                    ),
                  ),
                  //SpacerWidget(height: 10, width: 0),
                  //Row(
                  //  children: [
                  //    Expanded(
                  //      child: TextField(
                  //        controller: imageController,
                  //        decoration: const InputDecoration(
                  //          border: OutlineInputBorder(),
                  //          labelText: 'Image URL',
                  //        ),
                  //      ),
                  //    ),
                  //    Container(
                  //      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  //      child: FilledButton(
                  //        child: Row(mainAxisSize: MainAxisSize.min, children: [
                  //          Icon(Icons.auto_fix_high),
                  //          Container(width: 6),
                  //          Text("Autogenerate"),
                  //        ]),
                  //        onPressed: () {},
                  //      ),
                  //    ),
                  //  ],
                  //),
                  // Playlist image support not done yet, currently just tiles first four songs
                  SpacerWidget(height: 8, width: 0),
                  Row(
                    children: [
                      Text("Visible to"),
                      Expanded(child: Container()),
                      TextButton(
                        child: Text("Edit..."),
                        onPressed: () async {
                          var result = await getVisibleToFieldDialog(current.visibleTo, "Visible to", context);
                          setState(() {
                            current = current.copyWith(visibleTo: result);
                          });
                        },
                      ),
                      //Switch(
                      //    value: current.visible,
                      //    onChanged: (value) {
                      //      setState(() {
                      //        current = current.copyWith(public: value);
                      //      });
                      //    }),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Allowed collaborators"),
                      Expanded(child: Container()),
                      TextButton(
                        child: Text("Edit..."),
                        onPressed: () async {
                          var result = await getVisibleToFieldDialog(current.allowedCollaborators, "Allowed collaborators", context);
                          setState(() {
                            current = current.copyWith(allowedCollaborators: result);
                            result.forEach((c) {
                              if (!current.visibleTo.contains(c) && current.visibleTo != ["all"]) {
                                current = current.copyWith(visibleTo: [...current.visibleTo, c]);
                              }
                            });
                          });
                        },
                      ),
                      //Switch(
                      //    value: current.visible,
                      //    onChanged: (value) {
                      //      setState(() {
                      //        current = current.copyWith(public: value);
                      //      });
                      //    }),
                    ],
                  ),
                  Text("${current.songs.length} songs",
                      style: theme.textTheme.bodyLarge),
                  Container(height: 16),
                  Divider(),
                  ...(current.songs.map(
                    (s) => ListTile(
                      title: Text(s.displayName),
                      subtitle: Text(
                          "${s.artistDisplayName} - ${s.albumDisplayName}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => setState(() {
                          songs.remove(s);
                          current = current.copyWith(songs: songs);
                        }),
                      ),
                    ),
                  )),
                ]),
          ),
        ),
      ),
    );
  }
}

Future<void> playlistLogic(WidgetRef ref, BuildContext context, String thingId,
    String thingType) async {
  //Okay, so first we show a choose dialog.
  var dialog = AddPlaylistDialog(
      playlists: await ref.read(fetchPlaylistsProvider(editable: true).future));
  var result = await showDialog<Map<String, dynamic>>(
      context: context, builder: (context) => dialog);
  // print("Dialog result: $result");
  //Then, we check if the id is create or not
  // If/else used for checking if user cancelled
  if (result != null &&
      result["selected"] &&
      (result["value"] as Playlist).id != "create") { // they chose an existing playlist
    // print("Adding song to playlist");
    // print("SID $thingId, PID ${result["value"].id}");
    List<String> oldSongs = [];
    switch (thingType) {
      case "song":
        oldSongs = [thingId];
        break;
      case "album":
        oldSongs = (await ref.read(findSongsByAlbumProvider(thingId).future))
            .map((s) => s.id)
            .toList();
        print("Adding ${oldSongs.length} songs from album");
        break;
      case "artist":
        oldSongs = (await ref.read(findSongsByArtistProvider(thingId).future))
            .map((s) => s.id)
            .toList();
        print("Adding ${oldSongs.length} songs from artist");
        break;
      case "songids":
        oldSongs = thingId.split(",");
        break;
    }
    await ref
        .read(addIdsToPlaylistProvider(result["value"].id, oldSongs).future);
  } else if (result != null &&
      result["selected"] &&
      (result["value"] as Playlist).id == "create") {  // okay, awesome, we're creating a playlist
    // fetch the songs ids!
    List<Song> newSongs = [];
    switch (thingType) {
      case "song":
        newSongs = [await ref.read(findSongProvider(thingId).future)];
        break;
      case "album":
        newSongs = (await ref.read(findSongsByAlbumProvider(thingId).future))
            .toList();
        print("Adding ${newSongs.length} songs from album");
        break;
      case "artist":
        newSongs = (await ref.read(findSongsByArtistProvider(thingId).future))
            .toList();
        print("Adding ${newSongs.length} songs from artist");
        break;
      case "playlist":
        newSongs = (await ref.read(findSongsByPlaylistProvider(thingId).future)).toList();
        print("Adding ${newSongs.length} songs from playlist");
        break;
      case "songids":
        newSongs = (await ref.read(findBatchSongsProvider(thingId.split(",")).future)).toList();
        break;
    }
    var p = result["value"] as Playlist;
    print("Found ${newSongs.length} songs to add to playlist");
    var currentUser = (await SharedPreferences.getInstance()).getString("username")!;
    var fp = FilledPlaylist(
        id: p.id,
        displayName: "",
        description: "",
        visibleTo: ["all"],
        inLibrary: [currentUser],
        allowedCollaborators: [currentUser],
        songs: newSongs,
        added: DateTime.now().millisecondsSinceEpoch,
        owner: currentUser
    );  // okay, this is the magic
    var createDialog = EditPlaylistDialog(starter: fp); // then we pass the started playlist to the edit dialog
    var result2 = await showDialog<Map<String, dynamic>>(
        context: context, builder: (_) => createDialog);
    if (result2 != null && result2["created"]) {
      Playlist p = (result2["value"] as FilledPlaylist).toPlaylist(); // shenanagins because of type safety
      print("AddPlaylistFlow: Creating playlist with name ${p.displayName} and description ${p.description}");
      print(p);
      await ref.read(addPlaylistProvider(p).future);
      print("AddPlaylistFlow: Playlist created");
    } else if (result2 != null && !result2["created"]) {
      print("AddPlaylistFlow: User cancelled, dialog2");
    }

  } else if (result != null && !result["selected"]) {
    print("AddPlaylistFlow: User cancelled, dialog1");
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
Future<List<String>> getVisibleToFieldDialog(List<String> value, String title, BuildContext context) async {
  var result = await showDialog<List<String>>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Container(
        child: VisibleToField(
          shouldRefresh: false,
          id: "visibleToFieldDialog",
          value: value,
          onChanged: (v) => {},
          onSaved: (v) async {Navigator.pop(context, v.toList());},
        ),
      ),
    ),
  );
  print("Result ${jsonEncode(result)}");
  return result != null ? result : value;
}





class VisibleToField extends ConsumerStatefulWidget {
  VisibleToField(
      {super.key,
      required this.onChanged,
      required this.value,
      required this.onSaved,
      required this.id,
      required this.shouldRefresh
      });
  Function(List<String> data) onChanged;
  Future<void> Function(List<String> data) onSaved;
  String id;
  List<String> value = [];
  _VisibleToFieldState? state;
  bool shouldRefresh;

  @override
  _VisibleToFieldState createState() {
    state = _VisibleToFieldState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => state!.initalValue = value);
    return state!;
  }
}

class _VisibleToFieldState extends ConsumerState<VisibleToField> {
  List<String> _value = [];
  List<String> _userList = [];
  List<String> get value => _value;
  String id = "";
  set initalValue(List<String> v) => setState(() {
        _value = v.toList();
        id = widget.id;
      });
  set value(List<String> v) => setState(() => _value = v.toList());
  bool _loading = true;
  @override
  Widget build(BuildContext context) {
    if (widget.id != id) initalValue = widget.value;
    AsyncValue<List<String>> users = ref.watch(fetchUsernamesProvider);
    users.when(
      data: (d) => setState(() {
        _userList = d.where((element) => element != "testguy").toList();
        _loading = false;
        if (_value.contains("all")) setState(() => _value = _userList.toList());
      }),
      loading: () => setState(() => _loading = true),
      error: (e, stack) => setState(() {
        _loading = true;
        print("Error: $e");
        print("Stack: $stack");
      }),
    );
    print("Value: $value, initial: ${widget.value}");
    return Container(
        child: _loading
            ? CircularProgressIndicator()
            : Wrap(spacing: 8, runSpacing: 8, children: [
                ..._userList.map(
                  (e) => InputChip(
                      label: Text(
                          e.substring(0, 1).toUpperCase() + e.substring(1)),
                      selected: _value.contains(e),
                      onSelected: (t) {
                        if (_value.contains(e)) {
                          _value.remove(e);
                        } else {
                          _value.add(e);
                        }
                        setValue(_value);
                      }),
                ),
                FilledButton(
                  child: const Text("Save"),
                  onPressed: () => widget.onSaved(_value).then((_) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("Saved")));
                    if (!widget.shouldRefresh) return;
                    ref.refresh(fetchSongsProvider(ignore: true));
                    ref.refresh(fetchAlbumsProvider(ignore: true));
                    ref.refresh(fetchArtistsProvider(ignore: true));
                  }),
                ),
              ]));
  }

  void setValue(List<String> v) {
    if (v.isEmpty && _userList.isNotEmpty)
      v = _userList;
    else if (v.isEmpty && _userList.isEmpty) return;
    setState(() => _value = v);
    //print("\t$value\n\t${widget.value}");
    widget.onChanged(v);
  }
}

void showWebError(context) {
  showDialog(
      context: context,
      builder: (context) => const AlertDialog(
            title: Text("Not supported"),
            content: Text(
                "Video playback is not supported on web, due to workarounds.  It used to be, but I had to shut the proxy down because it was sending too many requests to YouTube.  Now only the native apps are supported.  Sorry :("),
          ));
}


class PlaylistImage extends ConsumerWidget {
  final String playlistId;
  PlaylistImage({required this.playlistId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = 200;
    final height = 200;
    final int radius = 8;
    final playlistAsyncValue = ref.watch(findPlaylistProvider(playlistId));

    return playlistAsyncValue.when(
      data: (playlist) {
        final songs = playlist.songs.take(4).toList();
        if (songs.length == 0) {
          return Container(
              width: 200,
              height: 200,
              child: Center(
                  child: Text("¯\\_(ツ)_/¯",
                      style: Theme.of(context).textTheme.headlineMedium)));
        } else if (songs.length < 4) {
          Song song = songs[0];
          return CachedNetworkImage(
            imageUrl: song.imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              width: width.toDouble(),
              height: height.toDouble(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              width: width.toDouble(),
              height: height.toDouble(),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            errorWidget: (context, url, error) => Icon(
              Icons.error_outline_rounded,
              color: Colors.pink[700],
            ),
          );
        }
        return GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          primary: false,
          children: songs.asMap().entries
              .map(
                (entry) => CachedNetworkImage(
                  imageUrl: entry.value.imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: width / 4,
                    height: width / 4,
                    decoration: BoxDecoration(
                      borderRadius: deriveFromIndex(entry.key, radius),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    width: width / 4,
                    height: width / 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: deriveFromIndex(entry.key, radius),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error_outline_rounded,
                    color: Colors.pink[700],
                  ),
                ),
              )
              .toList(),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
  BorderRadius deriveFromIndex(int index, int radius) {
    return BorderRadius.only(
      topLeft: index == 0 ? Radius.circular(8) : Radius.zero,
      topRight: index == 1 ? Radius.circular(8) : Radius.zero,
      bottomLeft: index == 2 ? Radius.circular(8) : Radius.zero,
      bottomRight: index == 3 ? Radius.circular(8) : Radius.zero,
    );
  }
}

class AdderCard extends StatefulWidget {
  Function(bool selected, SearchResult searchResult) selectedCallback;
  SearchResult searchResult;
  bool selected;
  AdderCard({required this.selectedCallback, required this.searchResult, required this.selected});
  @override
  _AdderCardState createState() => _AdderCardState(searchResult: searchResult, selected: selected);
}

class _AdderCardState extends State<AdderCard> {
  SearchResult searchResult;
  bool selected = false;
  int cardWidth = 200;
  int cardPadding = 10;
  _AdderCardState({required this.searchResult, required this.selected});
  Widget build(BuildContext context) {

    int crossAxisNum = ((MediaQuery.of(context).size.width - 110) / 200).ceil();
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            ContextMenuRegion(
              contextMenu: GenericContextMenu(
                buttonConfigs: buildMenuButtons(searchResult),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Card(
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                        onTap: () {
                          setState((){selected = !selected;});
                          widget.selectedCallback(selected, searchResult);
                          //print(searchResult.name);
                        },
                        onLongPress: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("\"${searchResult.name}\" - \"${searchResult.artist}\"")));
                        },
                        child: Container(
                          //color: Colors.pink,
                          child: Tooltip(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            richMessage: WidgetSpan(
                                child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: BackdropFilter(
                                  child: Container(
                                    //margin: EdgeInsets.symmetric(
                                    //    horizontal: 12, vertical: 6),
                                    child: Text(searchResult.name,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                          fontSize: 14)
                                    )
                                  ),
                                  filter: ImageFilter.blur(
                                    sigmaX: 8, sigmaY: 8),
                                  ),
                                ),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  if(!selected) cardBody(constraints),
                                  if(selected) ColorFiltered(
                                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                                    child: cardBody(constraints),
                                  ), 
                                  if(selected) Center(
                                    child: Container(
                                      width: 52,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        //color: Theme.of(context).colorScheme.brightness == Brightness.dark ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.primary,
                                        color: Theme.of(context).colorScheme.inversePrimary
                                      ),
                                      child: Icon(Icons.check_rounded, color: Theme.of(context).colorScheme.primary, size: 30),
                                    ),
                                  ),
                                ]
                              )
                            )
                          )
                        )
                    )
                )
              ),
            );
 }
 List<ContextMenuButtonConfig> buildMenuButtons(SearchResult searchResult) {
   List<ContextMenuButtonConfig> buttons = [];
   if(searchResult.type == "song"){
     buttons = [
       unclickableTextButton(text: "Type: song"),
       unclickableTextButton(text: "Artist: ${searchResult.artist}", icon: const Icon(Icons.person)),
       unclickableTextButton(text: "Album: ${searchResult.album}", icon: const Icon(Icons.album)),
       unclickableTextButton(text: "Name: \"${searchResult.name}\"", icon: const Icon(Icons.music_note)),
     ];
   }else if(searchResult.type == "album"){
     buttons = [
       unclickableTextButton(text: "Type: album"),
       unclickableTextButton(text: "Artist: ${searchResult.artist}", icon: const Icon(Icons.person)),
       unclickableTextButton(text: "Name: \"${searchResult.name}\"", icon: const Icon(Icons.music_note)),
     ];
   }else if(searchResult.type == "artist"){
     buttons = [
       unclickableTextButton(text: "Type: artist"),
       unclickableTextButton(text: "Name: \"${searchResult.name}\"", icon: const Icon(Icons.music_note)),
     ];
   }

   return buttons;
  }
  ContextMenuButtonConfig unclickableTextButton({String text = "", Widget? icon}){
    return ContextMenuButtonConfig(text, icon: icon, onPressed: null);
  }
 Widget cardBody(BoxConstraints constraints) {
   // TODO BUG: Some cards (1st and 3rd) have no left padding
   return Column(
     mainAxisSize: MainAxisSize.min,
     crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Container(
         //color: Colors.red,
           margin: EdgeInsets.only(top: cardPadding.toDouble() / 2),
           //color: Colors.yellow,
           child: FancyImage(
             url: searchResult.imageUrl,
             height: constraints.maxWidth.floor() - (cardPadding * 2),
             width: constraints.maxWidth.floor() - (cardPadding * 2),
           )
         ),
         Container(
           margin: EdgeInsets.symmetric(horizontal: cardPadding.toDouble()),
           child: Text(
             searchResult.name,
             textAlign: TextAlign.center,
             maxLines: 1,
             overflow: TextOverflow.ellipsis,
         )
       ),
       Container(
        margin: EdgeInsets.only(bottom: cardPadding.toDouble() / 2),
         child: Text(searchResult.type),
       ),
     ]
   );
 }
}

String? specialUrlToPlain(String url){
  List<String> parts = url.split(":");
  switch(parts.first){
    case "http":
    case "https":
      return url;
    case "youtube":
      return "https://www.youtube.com/watch?v=${parts[1]}";
    default:
      return null;
  }
}

