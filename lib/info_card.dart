import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import "types/searchresult.dart";
import "providers/services/player.dart";

class InfoEditorCard extends StatefulWidget{
  final FindResult data;
  final WidgetRef ref;
  const InfoEditorCard(
    {
    super.key,
    required this.data,
    required this.ref
    }
  );
  InfoEditorCardState createState() => InfoEditorCardState();
}

class InfoEditorCardState extends State<InfoEditorCard>{
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
    if(!modified) {
      var other = widget.data;
      other.songs.forEach((element) {
        songs.add(element);
      });
      modifiedData = widget.data;
    }
    modified = true;

    nameController.text = (modifiedData.type == "song") ? modifiedData.songs[0].title : modifiedData.name;
    albumController.text = (modifiedData.type == "song" || modifiedData.type == "album") ? modifiedData.album : "This isn't going to actually be used";
    artistController.text = modifiedData.artist;
    videoIdController.text = modifiedData.songs[0].id;
    imageUrlController.text = modifiedData.imageUrl;

    return Card(
      child: Column(
        children: [
          Row(
            children: [
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
                  placeholder: (context, url) => Container(decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4))),
                  errorWidget: (context, url, error) => Icon(Icons.error_outline_rounded,color:Colors.pink[700]),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text("Type: ${modifiedData.type}", textAlign: TextAlign.left),
                  ),
                  if(modifiedData.type != "song")
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text("Number of songs: ${modifiedData.songs.length}", textAlign: TextAlign.left),
                    ),
                  if(modifiedData.type != "song")
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: FilledButton.tonal(
                        child: Text("View songs"),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            showDragHandle: true,
                            builder: (BuildContext context) =>
                              Container(
                                child: ReorderableListView.builder(
                                  itemCount: modifiedData.songs.length,
                                  itemBuilder: (context, index) =>
                                    ListTile(
                                      key: Key('$index'),
                                      title: Text(modifiedData.songs[index].title),
                                    ),
                                  onReorder: (oldIndex, newIndex) {
                                    var song = songs.removeAt(oldIndex);
                                    song = song.copyWith(trackNumber: newIndex);
                                    songs.insert(newIndex, song);
                                    modifiedData = modifiedData.copyWith(songs: songs);
                                  },
                                )
                              ),
                          );
                        },
                      )
                    ),
                ]
              ),
            ]
          ),
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
            )
          ),
          (modifiedData.type == "song") ? 
          ListTile(
            title: TextField(
              controller: albumController,
              decoration: InputDecoration(
                labelText: 'Album',
                filled: true,
              ),
              onChanged: (_) {
                modifiedData = modifiedData.copyWith(name: albumController.text);
              },
            ),
          ) :
          Container(),
          (modifiedData.type == "song" || modifiedData.type == "album") ? ListTile(
            title: TextField(
               controller: artistController,
               decoration: InputDecoration(
                 labelText: 'Artist',
                 filled: true,
               ),
              onChanged: (_) {
                modifiedData = modifiedData.copyWith(artist: artistController.text);
              },
              )
            ) : Container(),
          ListTile(
            trailing: IconButton(
              icon: Icon(Icons.play_arrow_rounded),
              onPressed: () {
                widget.ref.read(playerProvider.notifier).playFindResult(modifiedData);
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
            )
          ),
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
                modifiedData = modifiedData.copyWith(imageUrl: imageUrlController.text);
              },
            ), 
          ),
        ]
      )
    );
  }
}

void showImage(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) =>
      AlertDialog(
        title: Text('Image Preview'),
        content: Container(
          child: Image.network(imageUrl),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge
            ),
            child: const Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      )
  );
}
