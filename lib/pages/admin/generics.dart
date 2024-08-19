import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import "../../providers/data/fetched_data_provider.dart";
import "../../providers/data/playlist_provider.dart";
import "../../providers/services/search.dart";

class SearchableTypedView extends ConsumerStatefulWidget {
  int selectedIndex = -1;
  void Function(dynamic) callback;
  String type;
  SearchableTypedView({required this.callback, required this.type, selectedIndex, super.key});
  @override
  _SearchableTypedViewState createState() => _SearchableTypedViewState();
}

class _SearchableTypedViewState extends ConsumerState<SearchableTypedView> {
  int selectedIndex = 0;
  int numPanes = 1;
  bool searching = false;
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SearchInfo searchInfo = ref.watch(searchProvider);
    AsyncValue<List<dynamic>> datas = ref.watch(
      switch(widget.type) {
        "songs" => fetchSongsProvider,
        "albums" => fetchAlbumsProvider,
        "artists" => fetchArtistsProvider,
        "playlists" => fetchPlaylistsProvider,
        _ => fetchSongsProvider,
      }
    );
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
      child: datas.when(
        data: (data) => Column(
          children: [
            TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: (value) async {
                ref.read(searchProvider.notifier).search(value, widget.type);
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
                      ref.read(searchProvider.notifier).search("", widget.type);
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
                List<dynamic> datum = data;
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
