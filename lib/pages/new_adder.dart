import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:beamer/beamer.dart';
import 'dart:convert';
import 'package:flutter/scheduler.dart';

import '../utilities.dart';
import '../helper_widgets.dart';
import '../types/searchresult.dart';
import '../types/hierarchicalListView.dart';
import '../providers/services/adder.dart';
import '../providers/services/player.dart';
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
  SearchSource selectedSearchSource = SearchSource.spotify;
  List<SearchResult> searchResults = [];
  bool pulledSearchResults = false;
  List<SearchResult> selectedSearchResults = [];
  bool restoredSelectedSearchResults = false;
  List<FindResult> findResults = [];
  bool findResultsProcessed = false;
  List<HLVArtist> hlvArtists = [];
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
    List<String> searchResultIds = searchResults.map((result) => "${result.type}:${result.id}").toList();
    selectedSearchResults.forEach((result) {
      print("Restoring search result ${result.type}:${result.id}");
      if(!searchResultIds.contains("${result.type}:${result.id}")){
        searchResults = [result, ...searchResults];
      }
    });
    restoredSelectedSearchResults = true;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController queryController = TextEditingController();
    ref.read(adderProvider.notifier).init();
    final state = ref.watch(adderProvider);
    if (state.state == "auth:success") {
      backable = true;
      page = "search";
      if(query == ""){
        query = ref.read(adderProvider).query;
        queryController.text = query;
        selectedSearchType = state.searchType;
        selectedSearchSource = state.searchSource;
      }
    } else if (state.state == "search:results") {
      if(!pulledSearchResults) {
        pullSearchResults(state);
      }
      if(!restoredSelectedSearchResults && state.selectedSearchResults.isNotEmpty){
        restoreSelectedSearchResults(state);
      }

      page = "search:results";
      //print(state.searchResults);
      print("Search returned ${searchResults.length} items");
      queryController.text = query;
    } else if(state.state == "find:results"){
      if(!findResultsProcessed){
        findResults = state.findResults.toList();
        print("Find results: ${jsonEncode(findResults)}");
        hlvArtists = findResultsToHLVContent(findResults);
        findResultsProcessed = true;
      }
      page = "find:results";
    }else if(state.state == "auth:fail"){
      
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Adder login failed!  If this issue, persists, please contact the developer.")));
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
                      const Text(
                        "Login failed",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18)
                      ),
                      Icon(Icons.error, size: 64, color: Colors.red[350]),
                    ],
                  ),
                ),
                "loading" => const Center(child: CircularProgressIndicator()),
                "loading:auth" => const Center(
                  child: Column(
                    children: [
                      Text("Logging in...",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18)
                      ),
                      CircularProgressIndicator()
                    ]
                  )
                ),
                "loading:find" => const Center(child: CircularProgressIndicator()),
                "loading:search" => searchPage(context, null, true),
                "loading:add" => const Center(
                  child: Column(
                    children: [
                      Text("Adding...",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18)
                      ),
                      CircularProgressIndicator()
                    ]
                  )
                ),
                "add:results" => adderResultsPage(context, state.addResult),
                _ => switch (page) {
                    "search" => searchPage(context, null, false),
                    "search:results" => searchPage(context, searchResults, false),
                    "find:results" => findPage(context, findResults),
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
                  onPressed: (){
                    List<String> parts = state.state.split(":");
                    if(parts[0] == "loading" && parts.length > 1 && (parts[1] != "search")){
                      return null;
                    }else{
                      return () {
                        if (parts[0] == "search") cancel();
                        else if(page == "find:results"){
                          page = "search:results";
                          findResultsProcessed = false;
                          //ref.read(adderProvider.notifier).clearSelectedSearchResults();
                          setState(() => ref.read(adderProvider.notifier).setStep("search:results"));
                        }
                      };
                    }
                  }(),
                ),
                Expanded(child: Container(color: Colors.pink)),
                if(state.state != "add:results") FilledButton.tonal(
                  child: Text("Next"),
                  onPressed: (){
                    List<String> parts = state.state.split(":"); 
                    if(parts[0] == "loading" && parts.length > 1 && (parts[1] != "search")){
                      return null;
                    }else if(page == "find:results" && hlvArtists.isEmpty){
                      return null;
                    }else{
                      return () {
                        if (page == "search") {
                          searchQuerySubmitted(context);
                        }else if(page == "search:results"){
                          searchPageSubmitted(context);
                        }else if(page == "find:results"){
                          findPageSubmitted(context);
                        }
                      };
                    }
                  }(),
                ),
                if(state.state == "add:results") OutlinedButton(
                  child: Text("Add more"),
                  onPressed: () {
                    dutiesDone(context);
                  }
                ),
                if(state.state == "add:results") SpacerWidget(width:8),
                if(state.state == "add:results") FilledButton.tonal(
                  child: Text("Done"),
                  onPressed: () {
                    dutiesDone(context);
                    cancel();
                  }
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
    if(selectedSearchType == SearchType.url && spotifyUrlRegex.firstMatch(query) == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Column(children:[Text("Not a valid Spotify URL.  It should be in the format \"https://open.spotify.com/[type]/[id]?si=[shareKey]\""),Text("The share key is optional.")])));
      return;
    }
    pulledSearchResults = false;
    page = "search:results";
    ref.read(adderProvider.notifier).search(query, selectedSearchType, selectedSearchSource);
    //ScaffoldMessenger.of(context).showSnackBar(
    //SnackBar(content: Text("\"$query\" - ${selectedSearchType.label}")));
  }
  void searchPageSubmitted(BuildContext context) {
    page = "loading:find";
    restoredSelectedSearchResults = false;
    ref.read(adderProvider.notifier).findVideosForSelectedSearchResults();
  }
  void findPageSubmitted(BuildContext context) {
    page = "loading:add";
    ref.read(adderProvider.notifier).addHLVResults(hlvArtists);
    print("Find page submitted");
  }
  void dutiesDone(BuildContext context){
    refreshLibrary(ref);
    ref.read(adderProvider.notifier).done();
  }

  Widget findPage(BuildContext context, List<FindResult> findResults) {
    return Container(
      child: HierarchicalListView(data: hlvArtists, onChange: (data) => setState(() => hlvArtists = data)),
    );
  }

  Widget adderResultsPage(BuildContext context, AddResult addResults) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 100, color: Theme.of(context).colorScheme.inversePrimary),
            Text("Done!"),
            Text("Added ${addResults.count.songs} song${(addResults.count.songs > 1) ? "s" : ""} and ${addResults.count.albums} album${(addResults.count.albums > 1) ? "s" : ""} to your library."),
          ],
        ),
      ),
    );
  }

  Widget searchPage(BuildContext context, List<SearchResult>? searchResults, bool? loading) {
    // TODO Deal with responsive layout, eg on a phone
    int cardWidth = 200;
    int cardPadding = 10;
    int crossAxisNum = ((MediaQuery.of(context).size.width - 110) / 200).ceil();
    loading = loading ?? false;
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children:[
            Text("Step 1: Search",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              )
            ),
            Expanded(child: Container()),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: DropdownMenu<SearchSource>(
                initialSelection: selectedSearchSource,
                label: const Text('Source'),
                onSelected: (SearchSource? value) {
                  print("Clearing selected search results");
                  setState(() {
                    ref.read(adderProvider.notifier).clearSelectedSearchResults(); // Make sure that only one source is sent
                    AddState state = ref.read(adderProvider);
                    pullSearchResults(state);
                    restoreSelectedSearchResults(state);
                    selectedSearchSource = value ?? SearchSource.spotify;
                    if(query != "") searchQuerySubmitted(context);
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
          ]
        ),
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
                if (value == null) return;
                restoredSelectedSearchResults = false;
                ref.read(adderProvider.notifier).setSelectedSearchType(value);
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
                          pullSearchResults(ref.read(adderProvider));
                          restoreSelectedSearchResults(ref.read(adderProvider));
                        }
                      ))
                      .toList(),
                ))),
      ],
    ));
  }

  //
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
