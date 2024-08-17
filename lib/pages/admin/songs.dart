import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:cached_network_image/cached_network_image.dart';

import "../../providers/data/fetched_data_provider.dart";
import "../../providers/services/search.dart";
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
  @override
  Widget build(BuildContext context) {
    if(!mutated){
      currentSong = widget.selected;
    }
    return Container(child: Text("TODO: Pane 2 ${currentSong.displayName}"));
  }
}
