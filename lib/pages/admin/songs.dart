import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:cached_network_image/cached_network_image.dart';

import "../../providers/data/fetched_data_provider.dart";
import "../../providers/data/info_provider.dart";
import "../../providers/data/playlist_provider.dart";
import "../../providers/services/search.dart";
import "../../providers/services/player.dart";
import "../../types/song.dart";
import "../../info_card.dart";
import "generics.dart";

class SongsPane2 extends ConsumerStatefulWidget {
  final Song selected;
  SongsPane2({required this.selected});
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
  bool mutated = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController artistController = TextEditingController();
  TextEditingController albumController = TextEditingController();
  TextEditingController youtubeIdController = TextEditingController();
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
      artistController.text = currentSong.artistDisplayName;
      albumController.text = currentSong.albumDisplayName;
      youtubeIdController.text = currentSong.youtubeId;
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
              controller: youtubeIdController,
              decoration: const InputDecoration(
                labelText: "Video ID",
                filled: true
              ),
              onChanged: (value) {
                setState(() => mutated = true);
                currentSong = currentSong.copyWith(youtubeId: value);
              }
            ),
            trailing: IconButton(
              icon: const Icon(Icons.play_arrow_rounded),
              onPressed: () => ref.read(playerProvider.notifier).playYoutubeId(youtubeIdController.text),
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
                  if(await saveChanges()) refreshChanges();
                }
              )
            ],
          )
        ]
      )
    );
  }
  
  Future<bool> saveChanges() async {
    //return await ref.read(updateSongProvider(currentSong).future);
    return false;
  }

  void refreshChanges() {
    ref.read(playerProvider.notifier).clear();
    ref.refresh(fetchSongsProvider);
    ref.refresh(fetchAlbumsProvider);
    ref.refresh(fetchArtistsProvider);
    ref.refresh(fetchPlaylistsProvider);
    ref.refresh(fetchRecentlyPlayedProvider);
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
          Text("Album: ${albumController.text}"),
          Text("Artist: ${artistController.text}"),
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
