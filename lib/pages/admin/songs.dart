import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:cached_network_image/cached_network_image.dart';

import "../../providers/data/fetched_data_provider.dart";
import "../../providers/data/info_provider.dart";
import "../../providers/data/playlist_provider.dart";
import "../../providers/services/player.dart";
import "../../providers/services/search.dart";
import "../../types/song.dart";
import "../../info_card.dart";
import "generics.dart";
import "../../helper_widgets.dart";
import '../../utilities.dart';

class SongsPane2 extends ConsumerStatefulWidget {
  final Song selected;
  final Function(dynamic) deselect;
  SongsPane2({required this.selected, required this.deselect});
  get mutated => _sp2state?.mutated ?? false;
  _SongPane2State? _sp2state;
  @override
  _SongPane2State createState() {
    print("Creating _SongPane2State");
    _sp2state = _SongPane2State();
    return _sp2state!;
  }
}

class _SongPane2State extends ConsumerState<SongsPane2> {
  Song selected = Song.empty();
  Song currentSong = Song.empty();
  Song previous = Song.empty();
  bool mutated = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController artistController = TextEditingController();
  TextEditingController albumController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("Init state: ${widget.selected.displayName}");
  }

  @override
  Widget build(BuildContext context) {
    if(mutated && selected != widget.selected) WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog<bool>(context: context, builder: (context) => discardDialog(context, previous)).then((bool? save) {
        if(save != null && !save) {
          setState(() {
            mutated = false;
          });
        }
      });
      }
    );
    if(mutated && selected.id != widget.selected.id) previous = currentSong;
    if(selected == Song.empty() || selected.id != widget.selected.id) {
      currentSong = widget.selected;
      selected = widget.selected;
      nameController.text = currentSong.displayName;
      artistController.text = currentSong.artistDisplayName;
      albumController.text = currentSong.albumDisplayName;
      urlController.text = currentSong.audioUrl;
      imageUrlController.text = currentSong.imageUrl;
    }
    print("Current song: ${currentSong.displayName}");
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              height: 128,
              width: 128,
              child: CachedNetworkImage(
                imageUrl: currentSong.imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4))),
                errorWidget: (context, url, error) => Icon(Icons.error_outline_rounded,color:Colors.pink[700]),
              ),
            ),
            ListTile(
              title: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  filled: true
                ),
                onChanged: (value) {
                  setState(() => mutated = true);
                  currentSong = currentSong.copyWith(displayName: value);
                },
              ),
            ),
            ListTile(
              title: TextField(
                controller: albumController,
                decoration: const InputDecoration(
                  labelText: "Album",
                  filled: true
                ),
                onChanged: (value) {
                  setState(() => mutated = true);
                  currentSong = currentSong.copyWith(albumDisplayName: value);
                },
              ),
            ),
            ListTile(
              title: TextField(
                controller: artistController,
                decoration: const InputDecoration(
                  labelText: "Artist",
                  filled: true
                ),
                onChanged: (value) {
                  setState(() => mutated = true);
                  currentSong = currentSong.copyWith(artistDisplayName: value);
                },
              ),
            ),
            ListTile(
              title: TextField(
                controller: urlController,
                decoration: const InputDecoration(
                  labelText: "Video ID",
                  filled: true
                ),
                onChanged: (value) {
                  setState(() => mutated = true);
                  currentSong = currentSong.copyWith(audioUrl: value);
                }
              ),
              trailing: IconButton(
                icon: const Icon(Icons.play_arrow_rounded),
                onPressed: () => ref.read(playerProvider.notifier).playYoutubeId(urlController.text),
              ),
            ),
            ListTile(
              title: TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(
                  labelText: "Image URL",
                  filled: true
                ),
                onChanged: (value) {
                  setState(() => mutated = true);
                  currentSong = currentSong.copyWith(imageUrl: value);
                }
              ),
              trailing: IconButton(
                icon: const Icon(Icons.link_rounded),
                onPressed: () => showImage(context, imageUrlController.text),
              ),
            ),
            VisibleToField(
              shouldRefresh: true,
              value: currentSong.visibleTo.toList(),
              onChanged: (value) => currentSong = currentSong.copyWith(visibleTo: value),
              onSaved: (v) async => await ref.read(editItemVisibilityProvider("song", currentSong.id, v).future),
              id: currentSong.id,
            ),
            //Expanded(child:Container()),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
              children: [
                FilledButton(
                  child: Row(children: [const Icon(Icons.delete_rounded), Container(width: 6), const Text("Delete")]),
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red), foregroundColor: WidgetStateProperty.all(Colors.white)),
                  onPressed: () => showDialog<bool>(context: context, builder: (context) => deleteDialog(context, "song", null)).then((bool? delete) async {
                    if(delete != null && delete) {
                      bool deleted = await ref.read(deleteItemProvider("song", currentSong.id, "").future);
                      if(deleted) {
                        print("Song deleted");
                        widget.deselect(null);
                        _refreshChanges();
                      }
                    }
                  }),
                ),
                Expanded(child: Container()),
                if(mutated) Container(
                  padding: const EdgeInsets.only(right: 8),
                  child: OutlinedButton(
                    child: Text("Discard changes", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red)),
                    onPressed: () => setState(() => mutated = false),
                  )
                ),
                if(mutated) FilledButton.tonal(
                  child: Row(
                    children: [
                      const Icon(Icons.save_rounded),
                      Container(width: 6),
                      const Text("Save changes")
                    ],
                  ),
                  onPressed: () async {
                    bool confirm = await showDialog<bool>(context: context, builder: (context) => AlertDialog(
                      title: const Text("Save changes? page"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("You have made changes to the current song. Do you want to save them?"),
                          const Text("The new info is as follows:"),
                          Text("Name: ${nameController.text}"),
                          Text("Album: ${albumController.text}"),
                          Text("Artist: ${artistController.text}"),
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              height: 512,
                              width: 512,
                              child: CachedNetworkImage(
                                imageUrl: currentSong.imageUrl,
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Container(decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4))),
                                errorWidget: (context, url, error) => Icon(Icons.error_outline_rounded,color:Colors.pink[700]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text("No")),
                        TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text("Yes")),
                      ],
                    )) ?? false;
                    if(!confirm) return;
                    if(await saveChanges()) _refreshChanges();
                  }
                )
              ],
            ))
          ]
        )
      )
    );
  }
  
  Future<bool> saveChanges() async {
    return await ref.read(updateSongProvider(currentSong).future);
  }

  void _refreshChanges() {
    refreshChanges(ref);
    setState(() => mutated = false);
  }

  AlertDialog discardDialog(BuildContext context, Song current) {
    return AlertDialog(
      title: const Text("Save changes?"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("You have made changes to the current song. Do you want to save them?"),
          const Text("The new info is as follows:"),
          Text("Name: ${current.displayName}"),
          Text("Album: ${current.albumDisplayName}"),
          Text("Artist: ${current.artistDisplayName}"),
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                height: 512,
                width: 512,
                child: CachedNetworkImage(
                  imageUrl: current.imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4))),
                  errorWidget: (context, url, error) => Icon(Icons.error_outline_rounded,color:Colors.pink[700]),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text("No")),
        TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text("Yes")),
      ],
    );
  }
}
