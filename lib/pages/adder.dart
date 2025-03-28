import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:beamer/beamer.dart';

import '../helpers/widgets/helper_widgets.dart';
import '../types/searchresult.dart';
import '../providers/services/adder.dart';
import '../providers/services/player.dart';
import '../providers/data/fetched_data_provider.dart';
import '../helpers/extensions/tone_extension.dart';
import 'dart:convert';

class AdderPage extends ConsumerStatefulWidget {
  const AdderPage({Key? key}) : super(key: key);

  _AdderPageState createState() => _AdderPageState();
}

class _AdderPageState extends ConsumerState {
  List<String> steps = [
    "authed",
    "searchresults",
    "foundresults",
    "addresult",
  ];
  String query = "";

  int page = 1;
  List<SearchResult> selectedSearchResults = [];
  SearchType selectedSearchType = SearchType.track;
  SearchSource selectedSearchSource = SearchSource.spotify;
  List<GlobalKey<InfoEditorCardState>> stateKeys = [];
  List<FindResult> correctedFindResults = [];

  @override
  Widget build(BuildContext context) {
    TextEditingController queryController = TextEditingController();
    ref.read(adderProvider.notifier).init();
    final state = ref.watch(adderProvider);
    if (state.state == "authed") {
      page = 1;
    } else if (state.state == "foundresults" && page == 3) {
      print("Setting state keys");
      stateKeys = List.generate(state.findResults.length,
          (index) => GlobalKey<InfoEditorCardState>());
    } else if (state.state == "addresult") {
      print("Adder: Done!");
    }
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
                "findingresults" => const Center(
                      child: Column(children: [
                    Text("Searching...",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18)),
                    CircularProgressIndicator()
                  ])),
                "authed" => firstStep(ref, queryController),
                "searchresults" => secondStep(state.searchResults),
                "foundresults" => thirdStep(state.findResults, stateKeys,
                    MediaQuery.of(context).size.width.truncate()),
                "addingresults" => const Center(
                      child: Column(children: [
                    Text("Adding the new songs...",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18)),
                    CircularProgressIndicator()
                  ])),
                "addresult" => fourthStep(state.addResult),
                _ => Text("Unknown state: ${state.state}")
              },
            ),
            // Expanded(child: Container()),
            if (!state.state.contains("ing"))
              Row(
                children: [
                  if (page != 4)
                    FilledButton.tonal(
                      child: Text(page == 1 ? "Cancel" : "Back"),
                      onPressed: () {
                        back();
                      },
                    ),
                  Expanded(child: Container(color: Colors.pink)),
                  FilledButton.tonal(
                    child: Text(page == 4 ? "Done" : "Next"),
                    onPressed: () {
                      switch (page) {
                        case 1:
                          stepOneToTwo(queryController);
                          break;
                        case 2:
                          stepTwoToThree(selectedSearchResults, context);
                          break;
                        case 3:
                          stepThreeToFour(stateKeys);
                          break;
                        case 4:
                          done();
                          break;
                        default:
                          break;
                      }
                    },
                  ),
                ],
              ),
          ],
        )));
  }

  void back() {
    print("Back $page");
    setState(() {
      if (page > 1)
        page--;
      else
        cancel();
      ref.read(adderProvider.notifier).setStep(steps[page - 1]);
    });
  }

  void cancel() {
    page = 1;
    ref.read(adderProvider.notifier).cancel();
    Beamer.of(context).beamBack();
  }

  void done() {
    page = 1;
    ref.read(adderProvider.notifier).cancel();
    Beamer.of(context).beamBack();
  }

  void stepOneToTwo(TextEditingController queryController) {
    page = 2;
    selectedSearchResults = [];
    ref
        .read(adderProvider.notifier)
        .search(queryController.text, selectedSearchType);
  }

  void stepTwoToThree(List<SearchResult> results, BuildContext context) {
    print("Step two to 3");
    if (results.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select at least one song")));
      return;
    }
    setState(() {
      page = 3;
    });
    print("Selected $results");
    ref.read(adderProvider.notifier).findVideosFor(results);
  }

  void stepThreeToFour(List<GlobalKey<InfoEditorCardState>> stateKeys) {
    List<FindResult> results = [];
    stateKeys.forEach((key) {
      if (key.currentState == null) return;
      print("Adding ${key.currentState!.data.name}");
      results.add(key.currentState!.data);
      //print("Adding ${key.currentState!.data}");
    });
    ref.read(adderProvider.notifier).addFindResults(results);
    setState(() {
      page = 4;
    });
  }

  Widget firstStep(WidgetRef ref, TextEditingController queryController) {
    queryController.text = query;
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
              onSubmitted: (text) => stepOneToTwo(queryController),
              onChanged: (text) => query = text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: DropdownMenu<SearchType>(
              initialSelection: selectedSearchType,
              label: const Text('Type'),
              onSelected: (SearchType? value) => setState(
                  () => selectedSearchType = value ?? SearchType.track),
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
        ]),
      ],
    ));
  }

  Widget secondStep(List<SearchResult> results) {
    return Column(children: [
      Text("Step 2: Results",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      Container(
        //margin: EdgeInsets.only(top: 42),
        child: Text("Select the song(s) you want to add"),
      ),
      Expanded(
        //margin: EdgeInsets.only(top: 72, bottom: 16),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: results.length,
          itemBuilder: (context, index) {
            return Container(
              // margin: EdgeInsets.symmetric(horizontal: 8),
              // padding: EdgeInsets.all(8),
              // margin: EdgeInsets.only(bottom: 16),
              decoration: <Decoration>() {
                if (index == 0)
                  return BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      color: Theme.of(context).colorScheme.surfaceContainer);
                else if (index == results.length - 1)
                  return BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Theme.of(context).colorScheme.surfaceContainer);
                else
                  return BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer);
              }(),
              // color: Theme.of(context).colorScheme.surface.tone(20),
              height: 56,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      height: 56 - 16,
                      width: 56 - 16,
                      child: CachedNetworkImage(
                        imageUrl: results[index].imageUrl,
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
                        errorWidget: (context, url, error) => Icon(
                            Icons.error_outline_rounded,
                            color: Colors.pink[700]),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      results[index].cardString,
                      overflow: TextOverflow.ellipsis,
                    )),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: CheckBox(
                          initialValue: false,
                          callback: (value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    '${value ? "Selected" : "Deselected"} ${results[index].cardString}'),
                                duration: Duration(seconds: 1)));
                            if (value)
                              selectedSearchResults.add(results[index]);
                            else
                              selectedSearchResults.remove(results[index]);
                            print("Checkbox $index: $value");
                          }),
                    ),
                  ]),
            );
          },
        ),
      ),
    ]);
  }

  Widget thirdStep(List<FindResult> results,
      List<GlobalKey<InfoEditorCardState>> stateKeys, int viewportWidth) {
    print("\n\n\n");
    print(jsonEncode(results));
    print("\n\n\n");
    return Column(children: [
      Text("Step 3: Check",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      Container(
        //margin: EdgeInsets.only(top: 42),
        child: Text("Check that the info is correct before proceeding"),
      ),
      Expanded(
        child: Container(
          //margin: EdgeInsets.only(top: 72, bottom: 16),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (600 / 552),
              crossAxisCount: (viewportWidth / 600).truncate() == 0
                  ? 1
                  : (viewportWidth / 600).truncate(),
            ),
            shrinkWrap: true,
            itemCount: results.length,
            itemBuilder: (context, index) {
              return InfoEditorCard(
                  key: stateKeys[index], data: results[index], ref: ref);
            },
          ),
        ),
      ),
    ]);
  }

  Widget fourthStep(AddResult data) {
    return Container(
        child: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Successfully added:",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Text("${data.count.artists} artists",
                style: TextStyle(fontSize: 20)),
            Text("${data.count.albums} albums,",
                style: TextStyle(fontSize: 20)),
            Text("and ${data.count.songs} songs,",
                style: TextStyle(fontSize: 20)),
            Text(
              "Click Done to finish",
              style: TextStyle(fontSize: 20),
            ),
          ]),
    ));
  }
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
