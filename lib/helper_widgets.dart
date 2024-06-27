import 'package:beamer/beamer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:context_menus/context_menus.dart';
import 'providers/playing_provider.dart';

class MediaCard extends ConsumerWidget{
  final String text;
  final String thingId;
  final String thingType;
  final String image;
  const MediaCard({
    super.key, 
    required this.text, 
    required this.thingId, 
    required this.thingType, 
    required this.image
  });
  
  List<ContextMenuButtonConfig> buildMenuButtons(WidgetRef ref){
    List<ContextMenuButtonConfig> buttons = [];
    switch (thingType) {
      case "song":
        buttons.add(ContextMenuButtonConfig(
          "Play",
          icon: const Icon(Icons.play_arrow_rounded),
          onPressed: () async {
            ref.read(playerProvider.notifier).setSong(thingId);
          }
        ));
        buttons.add(ContextMenuButtonConfig(
          "Add to queue",
          icon: const Icon(Icons.queue),
          onPressed: () {
            ref.read(playerProvider.notifier).addIdToQueue(thingId);
          }
        ));
        break;
      case "album":
        buttons.add(ContextMenuButtonConfig(
          "Play",
          icon: const Icon(Icons.play_arrow_rounded),
          onPressed: () async {
            ref.read(playerProvider.notifier).setAlbum(thingId);
          }
        ));
        buttons.add(ContextMenuButtonConfig(
          "Add to queue",
          icon: const Icon(Icons.queue),
          onPressed: () {
            ref.read(playerProvider.notifier).addAlbumToQueue(thingId);
          }
        ));
        break;
      case "artist":
        buttons.add(ContextMenuButtonConfig(
          "Play",
          icon: const Icon(Icons.play_arrow_rounded),
          onPressed: () async {
            ref.read(playerProvider.notifier).setArtist(thingId);
          }
        ));
        buttons.add(ContextMenuButtonConfig(
          "Add to queue",
          icon: const Icon(Icons.queue),
          onPressed: () {
            ref.read(playerProvider.notifier).addArtistToQueue(thingId);
          }
        ));
        break;
      default:
        buttons.add(ContextMenuButtonConfig("Placeholder", icon: const Icon(Icons.abc), onPressed: (){}));
        break;
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ContextMenuRegion(
      contextMenu: GenericContextMenu(
        buttonConfigs: buildMenuButtons(ref),
      ),
        child: FittedBox(
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                debugPrint("Pressed card with id: $thingId and type: $thingType");
                switch (thingType) {
                  case "song":
                    print("Setting song");
                    ref.read(playerProvider.notifier).setSong(thingId);
                    break;
                  case "album":
                    print("Setting album");
                    ref.read(playerProvider.notifier).setAlbum(thingId);
                    break;
                  case "artist":
                    print("Setting artist");
                    ref.read(playerProvider.notifier).setArtist(thingId);
                    break;
                  case "placeholder":
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Hmm, nothing here. The real question is why do you just go around randomly clicking loading things? ><")));
                  default:
                    debugPrint("No implementation for $thingType");
                }
              },
              // onSecondaryTap: () {
              //   print("Secondary tapped");
              // },
              // onLongPress: () {
              //   print("Long press");
              // },
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 220.0, 
                minHeight: 230.0, 
                maxWidth: 220.0, 
                // maxHeight: 350.0,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 20, 24, 0),
                    height: 175,
                    width: 200,
                    child: CachedNetworkImage(
                      imageUrl: image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12))),
                      errorWidget: (context, url, error) => Icon(Icons.error_outline_rounded,color:Colors.pink[700]),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: 172,
                    height: 28,
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ),
                ]
              )
            
          )
        )
      )
    )
    );
  }
}

class SpacerWidget extends StatelessWidget{
  final double height;
  final double width;
  const SpacerWidget({this.height = 0, this.width = 0});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}

Widget EmptyCardRow(){
  return Row(
    children: [
      for (int i = 0; i < 10; i++) MediaCard(
        text: "meh who cares",
        thingId: "idklol",
        thingType: "placeholder",
        image: "https://placehold.co/512x512.png")
    ]
  );
}

