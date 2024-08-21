import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:cached_network_image/cached_network_image.dart';

import "../../providers/data/fetched_data_provider.dart";
import "../../providers/data/info_provider.dart";
import "../../providers/data/playlist_provider.dart";
import "../../providers/services/search.dart";
import "../../providers/services/player.dart";
import "../../types/artists.dart";
import "../../helper_widgets.dart";
import "../../info_card.dart";
import "generics.dart";

class ArtistsPane1 extends ConsumerStatefulWidget {
  int selectedIndex = 0;
  void Function(Artist) callback;
  ArtistsPane1({required this.callback, selectedIndex});
  @override
  _ArtistPane1State createState() => _ArtistPane1State();
}

class _ArtistPane1State extends ConsumerState<ArtistsPane1> {
  @override
  Widget build(BuildContext context){
    return SearchableTypedView(callback: widget.callback as void Function(dynamic), type: "artists", selectedIndex: widget.selectedIndex);
  }
}


class ArtistsPane2 extends ConsumerStatefulWidget {
  final Artist selected;
  ArtistsPane2({required this.selected});
  get mutated => _sp2state?.mutated ?? false;
  _ArtistPane2State? _sp2state;
  @override
  _ArtistPane2State createState() {
    print("Creating _SongPane2State");
    _sp2state = _ArtistPane2State();
    return _sp2state!;
  }
}

class _ArtistPane2State extends ConsumerState<ArtistsPane2> {
  Artist selected = Artist.empty();
  Artist currentSong = Artist.empty();
  bool mutated = false;

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
      showDialog<bool>(context: context, builder: discardDialog).then((bool? save) {
        if(save != null && !save) {
          setState(() {
            print("Discarding changes");
            mutated = false;
          });
        }
      });
      }
    );
    if(!mutated){
      currentSong = widget.selected;
      selected = widget.selected;
      nameController.text = currentSong.displayName;
      imageUrlController.text = currentSong.imageUrl;
    }
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
          if(mutated) Row(
            children: [
              OutlinedButton(
                child: Text("Discard changes", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red)),
                onPressed: () => setState(() => mutated = false),
              ),
              Expanded(child: Container()),
              FilledButton.tonal(
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
                  //bool success = await ref.read(updateSongProvider(currentSong).future);
                  bool success = false;
                  if(success){
                    ref.read(playerProvider.notifier).clear();
                    ref.refresh(fetchSongsProvider);
                    ref.refresh(fetchAlbumsProvider);
                    ref.refresh(fetchArtistsProvider);
                    ref.refresh(fetchPlaylistsProvider);
                    ref.refresh(fetchRecentlyPlayedProvider);
                  }
                }
              )
            ],
          )
        ]
      )
    );
  }

  AlertDialog discardDialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Save changes?"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("You have made changes to the current song. Do you want to save them?"),
          const Text("The new info is as follows:"),
          Text("Name: ${nameController.text}"),
          Expanded(
            child: FittedBox(
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