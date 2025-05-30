import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:cached_network_image/cached_network_image.dart';
import "package:taxi_native/helpers/utilities.dart";

import "../../providers/data/fetched_data_provider.dart";
import "../../providers/data/info_provider.dart";
import "../../providers/data/playlist_provider.dart";
import "../../providers/services/search.dart";
import "../../providers/services/player.dart";
import "../../types/album.dart";
import "../../types/song.dart";
import "../../helpers/widgets/helper_widgets.dart";
import "../../helpers/widgets/info_card.dart";
import "generics.dart";

class AlbumsPane1 extends ConsumerStatefulWidget {
  int selectedIndex = 0;
  void Function(Album) callback;
  AlbumsPane1({required this.callback, selectedIndex});
  @override
  _AlbumPane1State createState() => _AlbumPane1State();
}

class _AlbumPane1State extends ConsumerState<AlbumsPane1> {
  @override
  Widget build(BuildContext context){
    return SearchableTypedView(callback: widget.callback as void Function(dynamic), type: "albums", selectedIndex: widget.selectedIndex);
  }
}


class AlbumsPane2 extends ConsumerStatefulWidget {
  final Album selected;
  final Function(dynamic) deselect;
  AlbumsPane2({required this.selected, required this.deselect});
  get mutated => _sp2state?.mutated ?? false;
  _AlbumPane2State? _sp2state;
  @override
  _AlbumPane2State createState() {
    print("Creating _SongPane2State");
    _sp2state = _AlbumPane2State();
    return _sp2state!;
  }
}

class _AlbumPane2State extends ConsumerState<AlbumsPane2> {
  Album selected = Album.empty();
  Album currentSong = Album.empty();
  Album previous = Album.empty();
  List<Song> currentSongs = [];
  bool mutated = false;
  bool dataLoaded = false;

  TextEditingController nameController = TextEditingController();
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
            print("Discarding changes");
            mutated = false;
          });
        }
      });
      }
    );
    if(mutated && widget.selected != selected) {
      previous = currentSong;
    }
    if(selected == Album.empty() || selected.id != widget.selected.id) {
      currentSong = widget.selected;
      selected = widget.selected;
      nameController.text = currentSong.displayName;
      imageUrlController.text = currentSong.imageUrl;
    }
    AsyncValue<List<Song>> songs = ref.watch(findSongsByAlbumProvider(selected.id));
    songs.when(
      data: (data) {
        if(mutated) return;
        setState(() {
          dataLoaded = true;
          currentSongs = data;
        });
      },
      loading: () => setState(() => dataLoaded = false),
      error: (err, stack) {
        print("Error: $err");
        print(stack);
        dataLoaded = false;
      }
    );
    print("Current song: ${currentSong.displayName}");
    return Container(
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
            onSaved: (v) async => await ref.read(editItemVisibilityProvider("album", currentSong.id, v).future),
            id: currentSong.id,
          ),
          Expanded(
            child: dataLoaded ? ListView.separated(
              itemCount: currentSongs.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) => ListTile(
                title: Text(currentSongs[index].displayName),
                subtitle: Text(currentSongs[index].artistDisplayName),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_rounded),
                  color: Colors.red,
                  onPressed: () =>
                    setState(() {
                      currentSongs.removeAt(index);
                      mutated = true;
                    })
                ),
              )
            )
            : const Center(child: CircularProgressIndicator()),
            //error: (error, stackTrace) => Center(child: Text("Error: $error, stackTrace: $stackTrace")),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
            children: [
              FilledButton(
                child: Row(children: [const Icon(Icons.delete_rounded), Container(width: 6), const Text("Delete")]),
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red), foregroundColor: WidgetStateProperty.all(Colors.white)),
                onPressed: () {
                  CheckBox deleteSongsCheck = CheckBox(initialValue: false, callback: (b){});
                  showDialog<bool>(
                    context: context,
                    builder: (context) => deleteDialog(
                      context,
                      "album", 
                      [
                        Row(children: [deleteSongsCheck, Container(width: 6), const Text("Delete contained songs")]),
                      ]
                    )
                  ).then((bool? delete) async {
                    if(delete != null && delete) {
                      bool deleted = await ref.read(deleteItemProvider("album", currentSong.id, "?deleteSongs=${deleteSongsCheck.value}").future);
                      if(deleted){
                        refreshChanges();
                        widget.deselect(null);
                      }
                    }
                  });
                }
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
                    title: const Text("Save changes?"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("You have made changes to the current song. Do you want to save them?"),
                        const Text("The new info is as follows:"),
                        Text("Name: ${nameController.text}"),
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
                  if(await saveChanges()) refreshChanges();
                }
              )
            ],
          ))
        ]
      )
    );
  }

  Future<bool> saveChanges() async {
    return await ref.read(updateAlbumProvider(currentSong, currentSongs).future);
  }

  void refreshChanges() {
    refreshLibrary(ref);
    ref.read(searchProvider.notifier).search(ref.read(searchProvider.notifier).query, "album", ignore: true);
    ref.refresh(fetchRecentlyPlayedProvider);
    setState(() {
      selected = currentSong;
      mutated = false;
    });
  }

  AlertDialog discardDialog(BuildContext context, Album current) {
    return AlertDialog(
      title: const Text("Save changes?"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("You have made changes to the current song. Do you want to save them?"),
          const Text("The new info is as follows:"),
          Text("Name: ${current.displayName}"),
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
