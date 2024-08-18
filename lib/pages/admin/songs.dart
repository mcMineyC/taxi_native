import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:cached_network_image/cached_network_image.dart';

import "../../providers/data/fetched_data_provider.dart";
import "../../providers/data/info_provider.dart";
import "../../providers/data/playlist_provider.dart";
import "../../providers/services/search.dart";
import "../../providers/services/player.dart";
import "../../types/song.dart";
import "../../types/searchresult.dart";
import "../../info_card.dart";

class SongsPane1 extends ConsumerStatefulWidget {
  int selectedIndex = 0;
  void Function(Song) callback;
  SongsPane1({required this.callback, selectedIndex});
  @override
  _SongPane1State createState() => _SongPane1State();
}

class _SongPane1State extends ConsumerState<SongsPane1> {
  int selectedIndex = 0;
  int numPanes = 1;
  bool searching = false;
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SearchInfo searchInfo = ref.watch(searchProvider);
    AsyncValue<List<Song>> songs = ref.watch(fetchSongsProvider);
    var qText = ref.watch(searchProvider.notifier).text;
    if(qText.isNotEmpty && _searchController.text == "") {
      //print("Restoring text: $qText");
      _searchController.text = qText;
    }else if(qText == "") {
      _searchController.clear();
    }
    searching = qText.isNotEmpty;
    return Container(
      margin: const EdgeInsets.all(12),
      child: songs.when(
        data: (data) => Column(
          children: [
            TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: (value) async {
                ref.read(searchProvider.notifier).search(value, "songs");
              },
              decoration: ref.read(searchProvider.notifier).text.isNotEmpty ? InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9999)),
                ),
                hintText: "Search",
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear), 
                    onPressed: () {
                      _searchController.clear();
                      ref.read(searchProvider.notifier).search("", "songs");
                    },
                  )
                ) :
                InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9999)),
                  ),
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search_rounded),
                )
            ),
            Expanded(
              child: () {
                List<Song> datum = data;
                if(searching && searchInfo.hasResults){
                  //print("Showing search results");
                  datum = searchInfo.songs;
                }else if(searching && searchInfo.isLoading) {
                  //print("Loading search results");
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: datum.length,
                  itemBuilder: (context, index) =>
                    InkWell(
                      onTap: () => widget.callback(datum[index]),
                      child: ListTile(
                        title: Text(datum[index].displayName),
                      )
                    ),
                );
              }(),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Text(error.toString()),
      ),
    );
  }
}


class SongsPane2 extends ConsumerStatefulWidget {
  final Song selected;
  SongsPane2({required this.selected});
  @override
  _SongPane2State createState() => _SongPane2State();
}

class _SongPane2State extends ConsumerState<SongsPane2> {
  Song currentSong = Song.empty();
  bool mutated = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController artistController = TextEditingController();
  TextEditingController albumController = TextEditingController();
  TextEditingController youtubeIdController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(!mutated){
      currentSong = widget.selected;
      nameController.text = currentSong.displayName;
      artistController.text = currentSong.artistDisplayName;
      albumController.text = currentSong.albumDisplayName;
      youtubeIdController.text = currentSong.youtubeId;
      imageUrlController.text = currentSong.imageUrl;
    }
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
}
