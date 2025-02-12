import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import "../../providers/data/fetched_data_provider.dart";
import "../../providers/data/playlist_provider.dart";
import "../../providers/services/search.dart";
import "../../types/album.dart";

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
    //AsyncValue<List<dynamic>> datas = ref.watch(
    //  switch(widget.type) {
    //    "songs" => fetchSongsProvider(ignore: true),
    //    "albums" => fetchAlbumsProvider(ignore: true),
    //    "artists" => fetchArtistsProvider(ignore: true),
    //    //"playlists" => fetchPlaylistsProvider,
    //    _ => fetchSongsProvider(ignore: true),
    //  }
    //);
    print("Rebuilding SearchableTypedView");
    AsyncValue<List<dynamic>> datas;
    switch(widget.type) {
      case "songs":
        datas = ref.watch(fetchSongsProvider(ignore: true));
        break;
      case "albums":
        datas = ref.watch(fetchAlbumsProvider(ignore: true));
        break;
      case "artists":
        datas = ref.watch(fetchArtistsProvider(ignore: true));
        break;
      case "playlists":
        datas = ref.watch(fetchPlaylistsProvider(editable: false));
        break;
      default: 
        datas = AsyncValue.data([Album.empty()]);
        break;
    }
    var qText = ref.watch(searchProvider.notifier).text;
    if(qText.isNotEmpty && _searchController.text == "") {
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
                ref.read(searchProvider.notifier).search(value, widget.type.substring(0, widget.type.length - 1), ignore: true);
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
                      ref.read(searchProvider.notifier).search("", widget.type.substring(0, widget.type.length - 1), ignore: true);
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
                  if(widget.type == "songs") datum = searchInfo.songs;
                  if(widget.type == "albums") datum = searchInfo.albums;
                  if(widget.type == "artists") datum = searchInfo.artists;
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
AlertDialog deleteDialog(BuildContext context, String type, List<Widget>? extraBody) {
  return AlertDialog(
    title: const Text("Delete?"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Do you want to delete this $type?"),
        const Text("This action is irreversible."),
        if(extraBody != null) ...extraBody,
      ],
    ),
    actions: [
      TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text("No")),
      TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text("Yes")),
    ],
  );
}
