import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:beamer/beamer.dart';
import 'dart:convert';

import '../helper_widgets.dart';
import '../types/searchresult.dart';
import '../providers/services/adder.dart';
import '../providers/services/player.dart';
import '../providers/data/fetched_data_provider.dart';
import '../tone_extension.dart';
import '../hierarchicalListView.dart';

// NEW ADDER

class AdderPage extends ConsumerStatefulWidget {
  const AdderPage({Key? key}) : super(key: key);

  _AdderPageState createState() => _AdderPageState();
}

class _AdderPageState extends ConsumerState {
  String page = "auth";
  bool nextable = false;
  bool backable = false;
  String query = "";
  TextEditingController queryController = TextEditingController();
  SearchType selectedSearchType = SearchType.track;
  List<SearchResult> searchResults = [];
  bool pulledSearchResults = false;
  List<SearchResult> selectedSearchResults = [];
  bool restoredSelectedSearchResults = false;
  List<FindResult> findResults = [];
  bool findResultsProcessed = false;
  List<HLVArtist> hlvArtists = [];

  @override
  Widget build(BuildContext context) {
    TextEditingController queryController = TextEditingController();
    ref.read(adderProvider.notifier).init();
    final state = ref.watch(adderProvider);
    if (state.state == "authed") {
      backable = true;
      page = "search";
      if(query == ""){
        query = ref.read(adderProvider).query;
        queryController.text = query;
        selectedSearchType = ref.read(adderProvider).searchType;
      }
    } else if (state.state == "findingresults") {
      nextable = false;
      backable = false;
    } else if (state.state == "searchresults") {
      if(!pulledSearchResults) {
        searchResults = state.searchResults.toList();
        pulledSearchResults = true;
      }
      if(!restoredSelectedSearchResults && state.selectedSearchResults.isNotEmpty){
        print("Restoring selected search results");
        selectedSearchResults = state.selectedSearchResults.toList();
        restoredSelectedSearchResults = true;
      }

      page = "searchresults";
      //print(state.searchResults);
      print("Search returned ${searchResults.length} items");
      queryController.text = query;
    } else if(state.state == "findresults"){
      if(!findResultsProcessed){
        findResults = state.findResults.toList();
        print("Find results: ${jsonEncode(findResults)}");
        hlvArtists = findResultsToHLVContent(findResults);
        findResultsProcessed = true;
      }
      page = "findresults";
    }
    print("Adder: query: $query");
    print("Adder: Page $page");
    print("Adder: State ${state.state}");
    return Container(
        margin: EdgeInsets.fromLTRB(14, 10, 14, 10),
        child: Center(
            child: Column(
          children: [
            Expanded(
              child: switch (state.state) {
                "auth" => const Center(
                      child: Column(children: [
                    Text("Logging in...",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18)),
                    CircularProgressIndicator()
                  ])),
                "loading" => const Center(child: CircularProgressIndicator()),
                "loadingfind" => const Center(child: CircularProgressIndicator()),
                "loadingsearch" => searchPage(context, null, true),
                _ => switch (page) {
                    "search" => searchPage(context, null, false),
                    "searchresults" => searchPage(context, searchResults, false),
                    "findresults" => findPage(context, findResults),
                    _ => Center(
                          child: Column(children: [
                        Text("Unknown state: ${state.state}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18)),
                      ])),
                  }
              },
            ),
            // Expanded(child: Container()),
            Row(
              children: [
                FilledButton.tonal(
                  child: Text(page.length >= 6 && page.substring(0,6) == "search" ? "Cancel" : "Back"),
                  onPressed: !backable
                      ? null
                      : () {
                          if (page.length >= 6 && page.substring(0, 6) == "search") cancel();
                          else if(page == "findresults"){
                            page = "searchresults";
                            findResultsProcessed = false;
                            //ref.read(adderProvider.notifier).clearSelectedSearchResults();
                            setState(() => ref.read(adderProvider.notifier).setStep("searchresults"));
                          }
                        },
                ),
                Expanded(child: Container(color: Colors.pink)),
                FilledButton.tonal(
                  child: Text("Next"),
                  onPressed: !nextable ? null : () {
                    if (page == "search") {
                      searchQuerySubmitted(context);
                    }else if(page == "searchresults"){
                      searchPageSubmitted(context);
                    }
                  },
                ),
              ],
            ),
          ],
        )));
  }

  void cancel() {
    //restoredSelectedSearchResults = false;
    pulledSearchResults = false;
    ref.read(adderProvider.notifier).cancel();
    Beamer.of(context).beamBack();
  }

  void searchQuerySubmitted(BuildContext context) {
    pulledSearchResults = false;
    page = "searchresults";
    ref.read(adderProvider.notifier).search(query, selectedSearchType);
    //ScaffoldMessenger.of(context).showSnackBar(
    //SnackBar(content: Text("\"$query\" - ${selectedSearchType.label}")));
  }
  void searchPageSubmitted(BuildContext context) {
    page = "loadingfind";
    restoredSelectedSearchResults = false;
    ref.read(adderProvider.notifier).findVideosForSelectedSearchResults();
  }

  Widget findPage(BuildContext context, List<FindResult> findResults) {
    return Container(
      child: HierarchicalListView(data:hlvArtists),
    );
  }

  Widget searchPage(BuildContext context, List<SearchResult>? searchResults, bool? loading) {
    int cardWidth = 200;
    int cardPadding = 10;
    int crossAxisNum = ((MediaQuery.of(context).size.width - 110) / 200).ceil();
    loading = loading ?? false;
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Step 1: Search",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        Container(height: 10),
        Row(children: [
          Expanded(
            child: TextField(
              controller: queryController,
              onSubmitted: (_) {
                if (query == "") return;
                searchQuerySubmitted(context);
              },
              onChanged: (text) {
                setState(() {
                  query = text;
                  if (query != "" && !nextable) {
                    nextable = true;
                  }
                  if (query == "" && nextable) {
                    nextable = false;
                  }
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: DropdownMenu<SearchType>(
              initialSelection: selectedSearchType,
              label: const Text('Type'),
              onSelected: (SearchType? value) {
                setState(() => selectedSearchType = value ?? SearchType.track);
                if(query != "") searchQuerySubmitted(context);
              },
              dropdownMenuEntries: SearchType.values
                  .map((SearchType value) => DropdownMenuEntry<SearchType>(
                        value: value,
                        label: value.label,
                      ))
                  .toList(),
              hintText: 'Select a type',
              enableSearch: false,
              requestFocusOnTap: false,
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          FilledButton(
              child:
                  Row(children: [Icon(Icons.search_rounded), Text("Search")]),
              onPressed: query == ""
                  ? null
                  : () {
                      searchQuerySubmitted(context);
                    })
        ]),
        Expanded(
            child: Container(
                //color: Colors.teal,
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 10)
                    .copyWith(right: 20),
                child: loading == true ? const Center(child: CircularProgressIndicator(value: null)) : GridView.count(
                  crossAxisCount: crossAxisNum,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 200 / (200 + (cardPadding * 2) + 28),
                  children: (searchResults ?? [])
                      .map((e) => AdderCard(
                        selected: selectedSearchResults.contains(e),
                        searchResult: e,
                        selectedCallback: (bool selected, SearchResult _) {
                          if (selected)
                            ref.read(adderProvider.notifier).selectSearchResult(e);
                          else
                            ref.read(adderProvider.notifier).deselectSearchResult(e);
                          print((selected ? "Selected" : "Deselected")+" "+e.name);
                        }
                      ))
                      .toList(),
                ))),
      ],
    ));
  }

  //
}

class InfoEditorCard extends StatefulWidget {
  final FindResult data;
  final WidgetRef ref;
  const InfoEditorCard({super.key, required this.data, required this.ref});
  InfoEditorCardState createState() => InfoEditorCardState();
}

class InfoEditorCardState extends State<InfoEditorCard> {
  bool nameCorrect = true;
  TextEditingController nameController = TextEditingController();
  bool albumCorrect = true;
  TextEditingController albumController = TextEditingController();
  bool artistCorrect = true;
  TextEditingController artistController = TextEditingController();
  bool videoIdCorrect = true;
  TextEditingController videoIdController = TextEditingController();
  bool imageUrlCorrect = true;
  TextEditingController imageUrlController = TextEditingController();
  late FindResult modifiedData;
  bool modified = false;

  get data => (modified) ? modifiedData : widget.data;
  List<FindResultSong> songs = [];

  @override
  Widget build(BuildContext context) {
    if (!modified) {
      var other = widget.data;
      other.songs.forEach((element) {
        songs.add(element);
      });
      modifiedData = widget.data;
    }
    modified = true;

    nameController.text = (modifiedData.type == "song")
        ? modifiedData.songs[0].title
        : modifiedData.name;
    albumController.text =
        (modifiedData.type == "song" || modifiedData.type == "album")
            ? modifiedData.album
            : "This isn't going to actually be used";
    artistController.text = modifiedData.artist;
    videoIdController.text = modifiedData.songs[0].id;
    imageUrlController.text = modifiedData.imageUrl;

    return Card(
        child: Column(children: [
      Row(children: [
        Container(
          margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
          height: 128,
          width: 128,
          child: CachedNetworkImage(
            imageUrl: widget.data.imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4))),
            errorWidget: (context, url, error) =>
                Icon(Icons.error_outline_rounded, color: Colors.pink[700]),
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.only(top: 8),
            child:
                Text("Type: ${modifiedData.type}", textAlign: TextAlign.left),
          ),
          if (modifiedData.type != "song")
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Text("Number of songs: ${modifiedData.songs.length}",
                  textAlign: TextAlign.left),
            ),
          if (modifiedData.type != "song")
            Container(
                margin: EdgeInsets.only(top: 8),
                child: FilledButton.tonal(
                  child: Text("View songs"),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      showDragHandle: true,
                      builder: (BuildContext context) => Container(
                          child: ReorderableListView.builder(
                        itemCount: modifiedData.songs.length,
                        itemBuilder: (context, index) => ListTile(
                          key: Key('$index'),
                          title: Text(modifiedData.songs[index].title),
                        ),
                        onReorder: (oldIndex, newIndex) {
                          var song = songs.removeAt(oldIndex);
                          song = song.copyWith(trackNumber: newIndex);
                          songs.insert(newIndex, song);
                          modifiedData = modifiedData.copyWith(songs: songs);
                        },
                      )),
                    );
                  },
                )),
        ]),
      ]),
      ListTile(
          title: TextField(
        controller: nameController,
        decoration: InputDecoration(
          labelText: 'Name',
          filled: true,
        ),
        onChanged: (_) {
          var song = modifiedData.songs.toList();
          song[0] = song[0].copyWith(title: nameController.text);
          modifiedData = modifiedData.copyWith(songs: song);
          print(modifiedData.songs[0].title);
        },
      )),
      (modifiedData.type == "song")
          ? ListTile(
              title: TextField(
                controller: albumController,
                decoration: InputDecoration(
                  labelText: 'Album',
                  filled: true,
                ),
                onChanged: (_) {
                  modifiedData =
                      modifiedData.copyWith(name: albumController.text);
                },
              ),
            )
          : Container(),
      (modifiedData.type == "song" || modifiedData.type == "album")
          ? ListTile(
              title: TextField(
              controller: artistController,
              decoration: InputDecoration(
                labelText: 'Artist',
                filled: true,
              ),
              onChanged: (_) {
                modifiedData =
                    modifiedData.copyWith(artist: artistController.text);
              },
            ))
          : Container(),
      ListTile(
          trailing: IconButton(
            icon: Icon(Icons.play_arrow_rounded),
            onPressed: () {
              widget.ref
                  .read(playerProvider.notifier)
                  .playFindResult(modifiedData);
            },
          ),
          title: TextField(
            controller: videoIdController,
            decoration: InputDecoration(
              labelText: 'Video ID',
              filled: true,
            ),
            onChanged: (_) {
              var song = modifiedData.songs.toList();
              song[0] = song[0].copyWith(id: videoIdController.text);
              modifiedData = modifiedData.copyWith(songs: song);
            },
          )),
      ListTile(
        trailing: IconButton(
          icon: Icon(Icons.link_rounded),
          onPressed: () {
            showImage(context, modifiedData.imageUrl);
          },
        ),
        title: TextField(
          controller: imageUrlController,
          decoration: InputDecoration(
            labelText: 'Image URL',
            filled: true,
          ),
          onChanged: (_) {
            modifiedData =
                modifiedData.copyWith(imageUrl: imageUrlController.text);
          },
        ),
      ),
    ]));
  }
}

void showImage(BuildContext context, String imageUrl) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text('Image Preview'),
            content: Container(
              child: Image.network(imageUrl),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge),
                child: const Text('Close'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ));
}
