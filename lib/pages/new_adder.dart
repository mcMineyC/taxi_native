import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:beamer/beamer.dart';
import 'dart:convert';
//import 'package:collection/collection.dart';
import 'package:flutter/scheduler.dart';

import '../helpers/utilities.dart';
import '../helpers/widgets/helper_widgets.dart';
import '../types/searchresult.dart';
import '../types/hierarchicalListView.dart';
import '../providers/services/adder.dart';
import '../providers/services/player.dart';
import '../helpers/widgets/hierarchicalListView.dart';

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
  SearchSource selectedSearchSource = SearchSource.spotify;
  List<SearchResult> searchResults = [];
  bool pulledSearchResults = false;
  List<SearchResult> selectedSearchResults = [];
  bool restoredSelectedSearchResults = false;
  List<FindResult> findResults = [];
  bool findResultsProcessed = false;
  List<HLVArtist> hlvArtists = [];
  FoundPlaylist? foundPlaylist;
  TextEditingController foundPlaylistNameController = TextEditingController();
  TextEditingController foundPlaylistDescriptionController = TextEditingController();
  ///////////////////////
  //////// State resuming
  void pullSearchResults(state) {
    print("Pulling search results");
    restoredSelectedSearchResults = false;
    searchResults = state.searchResults.toList();
    pulledSearchResults = true;
  }

  void restoreSelectedSearchResults(state) {
    print("Restoring selected search results");
    selectedSearchResults = state.selectedSearchResults.toList();
    print("Restoring search results: ${selectedSearchResults.length}");
    List<String> searchResultIds =
        searchResults.map((result) => "${result.type}:${result.externalId}").toList();
    selectedSearchResults.forEach((result) {
      print("Restoring search result ${result.type}:${result.externalId}");
      if (!searchResultIds.contains("${result.type}:${result.externalId}")) {
        searchResults = [result, ...searchResults];
      }
    });
    restoredSelectedSearchResults = true;
  }


//////////////////////////////////////////////////////////////////////////////////
///               PAGE SELECTION                     /////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    TextEditingController queryController = TextEditingController();
    ref.read(adderProvider.notifier).init();
    final state = ref.watch(adderProvider);
    if (state.state == "auth:success") {
      backable = true;
      page = "search";
      if (query == "") {
        query = ref.read(adderProvider).query;
        queryController.text = query;
        selectedSearchType = state.searchType;
        selectedSearchSource = state.searchSource;
      }
    } else if (state.state == "search:results") {
      if (!pulledSearchResults) {
        pullSearchResults(state);
      }
      if (!restoredSelectedSearchResults &&
          state.selectedSearchResults.isNotEmpty) {
        restoreSelectedSearchResults(state);
      }

      page = "search:results";
      //print(state.searchResults);
      print("Search returned ${searchResults.length} items");
      queryController.text = query;
    } else if (state.state == "find:results") {
      if (!findResultsProcessed) {
        findResults = state.findResults.toList();
        print("Find results: ${jsonEncode(findResults)}");
        hlvArtists = findResultsToHLVContent(findResults);
        findResultsProcessed = true;
      }
      page = "find:results";
    } else if (state.state == "find:results:playlist") {
      if (!findResultsProcessed) {
        foundPlaylist = state.foundPlaylist;
        foundPlaylistNameController.text = foundPlaylist!.name;
        foundPlaylistDescriptionController.text = foundPlaylist!.description;
        findResultsProcessed = true;
      }
      page = "find:results:playlist";
    } else if (state.state == "auth:fail") {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Adder login failed!  If this issue persists, please contact the developer.")));
        Beamer.of(context).beamToNamed("/login");
      });
      return Container();
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
                "auth:failed" => Center(
                    child: Column(
                      children: [
                        const Text("Login failed",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18)),
                        Icon(Icons.error, size: 64, color: Colors.red[350]),
                      ],
                    ),
                  ),
                "loading" => const Center(child: CircularProgressIndicator()),
                "loading:auth" => const Center(
                      child: Column(children: [
                    Text("Logging in...",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18)),
                    CircularProgressIndicator()
                  ])),
                "loading:find" =>
                  loadingFindPage(state.totalResults, state.completedResults),
                "loading:search" => searchPage(context, null, true),
                "loading:add" => const Center(
                      child: Column(children: [
                    Text("Adding...",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18)),
                    CircularProgressIndicator()
                  ])),
                "add:results" => adderResultsPage(context, state.addResult),
                _ => switch (page) {
                    "search" => searchPage(context, null, false),
                    "search:results" =>
                      searchPage(context, searchResults, false),
                    "find:results" => findPage(context, findResults),
                    //"find:results:playlist" => Center(child: Text("Congratulations, you found an unfinished page!\nThis will be the third step for adding a playlist.")),
                    "find:results:playlist" =>
                      findResultsPlaylistPage(context, foundPlaylist!),
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
                  child: Text(
                      page.length >= 6 && page.substring(0, 6) == "search"
                          ? "Cancel"
                          : "Back"),
                  onPressed: () {
                    List<String> parts = state.state.split(":");
                    if (parts[0] == "loading" &&
                        parts.length > 1 &&
                        (parts[1] != "search")) {
                      return null;
                    } else {
                      return () {
                        if (parts[0] == "search")
                          cancel();
                        else if (page.startsWith("find:results")) {
                          page = "search:results";
                          findResultsProcessed = false;
                          //ref.read(adderProvider.notifier).clearSelectedSearchResults();
                          setState(() => ref
                              .read(adderProvider.notifier)
                              .setStep("search:results"));
                        }
                      };
                    }
                  }(),
                ),
                Expanded(child: Container(color: Colors.pink)),
                if (state.state != "add:results")
                  FilledButton.tonal(
                    child: Text("Next"),
                    onPressed: () {
                      List<String> parts = state.state.split(":");
                      if (parts[0] == "loading" &&
                          parts.length > 1 &&
                          (parts[1] != "search")) {
                        return null;
                      } else if (page == "find:results" && hlvArtists.isEmpty) {
                        return null;
                      } else {
                        return () {
                          if (page == "search") {
                            searchQuerySubmitted(context);
                          } else if (page == "search:results") {
                            searchPageSubmitted(context);
                          } else if (page == "find:results") {
                            findPageSubmitted(context, "");
                          } else if (page == "find:results:playlist") {
                            findPageSubmitted(context, "playlist");
                          }
                        };
                      }
                    }(),
                  ),
                if (state.state == "add:results")
                  OutlinedButton(
                      child: Text("Add more"),
                      onPressed: () {
                        dutiesDone(context);
                      }),
                if (state.state == "add:results") SpacerWidget(width: 8),
                if (state.state == "add:results")
                  FilledButton.tonal(
                      child: Text("Done"),
                      onPressed: () {
                        dutiesDone(context);
                        cancel();
                      }),
              ],
            ),
          ],
        )));
  }

//////////////////////////////////////////////////////////////////////////////////
///               FUNCTIONS                          /////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

  void cancel() {
    //restoredSelectedSearchResults = false;
    pulledSearchResults = false;
    ref.read(adderProvider.notifier).cancel();
    Beamer.of(context).beamBack();
  }

  void searchQuerySubmitted(BuildContext context) {
    if (selectedSearchType == SearchType.url &&
        spotifyUrlRegex.firstMatch(query) == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Column(children: [
        Text(
            "Not a valid Spotify URL.  It should be in the format \"https://open.spotify.com/[type]/[id]?si=[shareKey]\""),
        Text("The share key is optional.")
      ])));
      return;
    }
    pulledSearchResults = false;
    page = "search:results";
    ref
        .read(adderProvider.notifier)
        .search(query, selectedSearchType, selectedSearchSource);
    //ScaffoldMessenger.of(context).showSnackBar(
    //SnackBar(content: Text("\"$query\" - ${selectedSearchType.label}")));
  }

  void searchPageSubmitted(BuildContext context) {
    page = "loading:find";
    restoredSelectedSearchResults = false;
    ref.read(adderProvider.notifier).findVideosForSelectedSearchResults();
  }

  void findPageSubmitted(BuildContext context, String extension) {
    if (extension == "playlist") {
      // print("Can't submit yet");
      // print(foundPlaylistNameController.value.text);
      // Reconstruct playlist
      
      foundPlaylist = foundPlaylist!.copyWith(name: foundPlaylistNameController.value.text);
      // First send the songs to server to be hydrated and put into hierarchy
      // ref.read(adderProvider.notifier).setPlaylist(foundPlaylist!);
      // ref.read(adderProvider.notifier).selectSearchResults(foundPlaylist!.songs.map((fps) => fps.toSearchResult()).toList());
      // ref.read(adderProvider.notifier).findVideosForSelectedSearchResults();
       ref
           .read(adderProvider.notifier)
           .addPlaylist(foundPlaylist!); // YOU LEFT OFF HERE
      findResultsProcessed = false; // Otherwise the hierarchy won't be pulled
    } else if (extension == "") {
      ref.read(adderProvider.notifier).addHLVResults(hlvArtists);
    }
    page = "loading:add";
    print("Find page submitted");
  }

  void dutiesDone(BuildContext context) {
    refreshLibrary(ref);
    ref.read(adderProvider.notifier).done();
  }

//////////////////////////////////////////////////////////////////////////////////
///               PAGES                          /////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

  Widget findPage(BuildContext context, List<FindResult> findResults) {
    return Container(
      child: HierarchicalListView(
          data: hlvArtists,
          onChange: (data) => setState(() => hlvArtists = data)),
    );
  }

  Widget adderResultsPage(BuildContext context, AddResult addResults) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle,
                size: 100, color: Theme.of(context).colorScheme.inversePrimary),
            Text("Done!"),
            Text(
                "Added ${addResults.count.songs} song${(addResults.count.songs > 1) ? "s" : ""} and ${addResults.count.albums} album${(addResults.count.albums > 1) ? "s" : ""} to your library."),
          ],
        ),
      ),
    );
  }

  Widget searchPage(
      BuildContext context, List<SearchResult>? searchResults, bool? loading) {
    // TODO Deal with responsive layout, eg on a phone
    int cardWidth = 200;
    int cardPadding = 10;
    int crossAxisNum = ((MediaQuery.of(context).size.width - 110) / 200).ceil();
    loading = loading ?? false;
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Text("Step 1: Search",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Expanded(child: Container()),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: DropdownMenu<SearchSource>(
              initialSelection: selectedSearchSource,
              label: const Text('Source'),
              onSelected: (SearchSource? value) {
                print("Clearing selected search results");
                setState(() {
                  ref
                      .read(adderProvider.notifier)
                      .clearSelectedSearchResults(); // Make sure that only one source is sent
                  AddState state = ref.read(adderProvider);
                  pullSearchResults(state);
                  restoreSelectedSearchResults(state);
                  selectedSearchSource = value ?? SearchSource.spotify;
                  if (query != "") searchQuerySubmitted(context);
                });
              },
              dropdownMenuEntries: SearchSource.values
                  .map((SearchSource value) => DropdownMenuEntry<SearchSource>(
                        value: value,
                        label: value.label,
                      ))
                  .toList(),
              hintText: 'Select a source',
              enableSearch: false,
              requestFocusOnTap: false,
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ]),
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
          TextButton( // debug quick testing
            child: Text("Example"),
            onPressed: () {queryController.text = "https://open.spotify.com/playlist/1szfdkjp18T3lMhS0xABrJ?si=0e8820b5c9f84e40";setState((){selectedSearchType=SearchType.url;nextable=true;query=queryController.text;});},
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: DropdownMenu<SearchType>(
              initialSelection: selectedSearchType,
              label: const Text('Type'),
              onSelected: (SearchType? value) {
                if (value == null) return;
                restoredSelectedSearchResults = false;
                ref.read(adderProvider.notifier).setSelectedSearchType(value);
                setState(() => selectedSearchType = value ?? SearchType.track);
                if (query != "") searchQuerySubmitted(context);
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
                child: loading == true
                    ? const Center(
                        child: CircularProgressIndicator(value: null))
                    : GridView.count(
                        crossAxisCount: crossAxisNum,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        childAspectRatio: 200 / (200 + (cardPadding * 2) + 28),
                        children: (searchResults ?? [])
                            .map((e) => AdderCard(
                                selected: selectedSearchResults.contains(e),
                                searchResult: e,
                                selectedCallback:
                                    (bool selected, SearchResult _) {
                                  if (selected) {
                                    if (selectedSearchResults.firstWhereOrNull(
                                            (element) =>
                                                element.type == "playlist") !=
                                        null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "You can only select one playlist at a time.\nWhen one is selected, it's the only item that can be added.")));
                                      return;
                                    }
                                    ref
                                        .read(adderProvider.notifier)
                                        .selectSearchResult(e);
                                  } else
                                    ref
                                        .read(adderProvider.notifier)
                                        .deselectSearchResult(e);
                                  print((selected ? "Selected" : "Deselected") +
                                      " " +
                                      e.name);
                                  pullSearchResults(ref.read(adderProvider));
                                  restoreSelectedSearchResults(
                                      ref.read(adderProvider));
                                }))
                            .toList(),
                      ))),
      ],
    ));
  }

  Widget loadingFindPage(int total, int completed) {
    return Center(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              value:
                  total != 0 ? completed.toDouble() / total.toDouble() : null,
            ),
            SpacerWidget(height: 10),
            Text("Finding videos..."),
            if (total != 0) Text("${completed}/${total}"),
          ]),
    );
  }

  Widget findResultsPlaylistPage(BuildContext context, FoundPlaylist playlist) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 0, bottom: 16),
                child: Text("Step 3: Verify Info - Playlist",
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
              ),
              TextField(
                controller: foundPlaylistNameController,
                decoration: InputDecoration(
                  labelText: 'Playlist Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                 playlist = playlist.copyWith(name: text);
                },
              ),
              SpacerWidget(height: 10),
              TextField(
                controller: foundPlaylistDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Playlist Description',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                 playlist = playlist.copyWith(description: text);
                },
              ),
              SpacerWidget(height: 10),
              Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Visible To:"),
                  SpacerWidget(height: 5),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Icon(Icons.info_outline,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                    SpacerWidget(width: 5),
                    Text("Also changes visbility of contained songs",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant)),
                  ])
                ]),
                Expanded(child: Container()),
                // TextButton( // for testing 
                //   child: Text("Print"),
                //   onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${playlist.visibleTo} --- ${playlist.songs.fold([], (a, b) => [...a, ...b.visibleTo]).toSet().toList()}"))),
                // ),
                TextButton(
                  child: Text("Edit..."),
                  onPressed: () async {
                    var result = await getVisibleToFieldDialog(
                        playlist.visibleTo, "Visible to", context);
                    setState(() {
                      foundPlaylist = playlist.copyWith(
                        visibleTo: result,
                        songs: foundPlaylist!.songs.map((s) => s.copyWith(visibleTo: result)).toList());
                    });
                  },
                ),
                //VisibleToField(
                //  value: playlist.visibleTo,
                //  id: playlist.id,
                //  shouldRefresh: false,
                //  onSaved: (List<String> v) async {
                //    setState(() {
                //      foundPlaylist = foundPlaylist!.copyWith(visibleTo: v);
                //    });
                //    print("Saved ${v}");
                //    return null;
                //  },
                //  onChanged: (v) => print("Changed ${v}"),
                //),
              ]),
              SpacerWidget(height: 10),
              Row(
                children: [
                  Text("Allowed collaborators"),
                  Expanded(child: Container()),
                  TextButton(
                    child: Text("Edit..."),
                    onPressed: () async {
                      var result = await getVisibleToFieldDialog(
                          playlist.allowedCollaborators,
                          "Allowed collaborators",
                          context);
                      List<String> toAdd = [];
                      result.forEach((c) {
                        if (!playlist.visibleTo.contains(c) &&
                            playlist.visibleTo != ["all"]) {
                            toAdd.add(c);
                        }
                      });
                      print("We need to update visibleto bc colab: "+toAdd.toString());
                      foundPlaylist = playlist.copyWith(
                        allowedCollaborators: result,
                        visibleTo: [...playlist.visibleTo, ...toAdd],
                        songs: foundPlaylist!.songs.map((s) => s.copyWith(visibleTo: [...playlist.visibleTo, ...toAdd])).toList()
                      );
                      print("vibisle to: ${foundPlaylist!.songs[0].visibleTo}");
                      setState(() {});
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
            ],
          ),
        ),
        SliverList.builder(
          itemCount: playlist.songs.length,
          itemBuilder: (context, index) {
            FoundPlaylistSong song = playlist.songs[index];
            return ListTile(
              title: Text(song.title),
              subtitle: Text(song.artist),
              trailing: PopupMenuButton<void Function()>(
                itemBuilder: (context) {
                  return [
                    // PopupMenuItem(
                    //   value: () {
                    //     print("Edit playlist song ${song.title}");
                    //   },
                    //   child: Row(children: [
                    //     Icon(Icons.edit),
                    //     SpacerWidget(width: 4),
                    //     Text("Edit")
                    //   ]),
                    // ),
                    PopupMenuItem(
                      value: () {
                        print("Delete playlist song ${song.title}");
                      },
                      child: Row(children: [
                        Icon(Icons.delete),
                        SpacerWidget(width: 4),
                        Text("Delete")
                      ]),
                    ),
                  ];
                },
                onSelected: (_) {
                  setState(() => playlist.songs.removeAt(index));
                },
              ),
            );
        }
      )
      ],
    );
  }
}

/////    OTHER JUNK

enum FoundPlaylistSongPopupMenuItems { edit, delete }

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
