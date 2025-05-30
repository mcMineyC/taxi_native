import 'package:beamer/beamer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../helpers/widgets/helper_widgets.dart';
import "package:context_menus/context_menus.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class CardView extends StatelessWidget {
  final List cardList;

  const CardView({super.key, required this.cardList});
  @override
  Widget build(BuildContext context) {
    double count = (MediaQuery.of(context).size.width / (MediaCard.width+32));
    return GridView.count(
        crossAxisCount: count.ceil(),
        scrollDirection: Axis.vertical,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: MediaCard.width / (MediaCard.height+6),
        children: cardList.map(
          (card) => MediaCard(
            text: card["text"].split("\n")[0],
            image: card["image"],
            thingId: card["id"],
            thingType: card["type"],
            addedBy: card["addedBy"] ?? "no data",
            inLibrary: card["inLibrary"]
          ),
        ).toList(),
    );
  }
}

class ItemListView extends ConsumerWidget {
  final List<Map<String, dynamic>> list;

  const ItemListView({super.key, required this.list});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: list.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          List<String> textPieces = list[index]["text"]!.split("\n"); 
          return ContextMenuRegion(
            contextMenu: GenericContextMenu(
              buttonConfigs: MediaCard.buildMenuButtons(context, ref, 
                list[index]["type"],
                list[index]["id"],
                list[index]["addedBy"] ?? "no data",
                list[index]["inLibrary"]
              ),
            ),
            child: ListTile(
              onTap: () => Beamer.of(context).beamToNamed("/${list[index]["type"]}/${list[index]["id"]}"),
              enableFeedback: true,
              // dense: true,
              // minVerticalPadding: 2,
              minTileHeight: 68,
              visualDensity: VisualDensity(vertical: 3, horizontal:0),
              contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              leading: Container(
                constraints: BoxConstraints(maxWidth: 56, maxHeight: 56),
                child: list[index]["type"] == "playlist" ?
                  PlaylistImage(playlistId: list[index]["id"]) :
                  CachedNetworkImage(
                    imageUrl: list[index]["image"],
                    imageBuilder: (context, imageProvider) =>
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.circular(12))),
                    errorWidget: (context, url, error) => Icon(
                        Icons.error_outline_rounded,
                        color: Colors.pink[700]),
                  )
                ),
                title: Text(
                  textPieces[0],
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  )
                ),
                subtitle: Text(
                  textPieces.length > 1 ? textPieces[1] : textPieces[0],
                  // list[index]["text"].split("\n").last,
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  )
                ),

                // subtitle: Row(
                //   children: [
                //     Text(
                //       textPieces.length > 1 ? textPieces[1] : textPieces[0],
                //       // list[index]["text"].split("\n").last,
                //       overflow: TextOverflow.ellipsis,
                //       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                //         fontWeight: FontWeight.w600,
                //         color: Theme.of(context).colorScheme.onSurface,
                //       )
                //     ),
                //     if(list[index]["type"] == "playlist") ...[
                //       SpacerWidget(width: 6),
                //       Icon(Icons.circle, size: 8),
                //       SpacerWidget(width: 6),
                //       Text(
                //         textPieces.length > 2 ? textPieces.last : textPieces[0],
                //         overflow: TextOverflow.ellipsis,
                //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                //           fontWeight: FontWeight.w600,
                //           color: Theme.of(context).colorScheme.onSurface,
                //         )
                //       ),
                //     ]
                //   ]
                // ),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert_rounded),
                  onPressed: () => context.contextMenuOverlay.show(
                    GenericContextMenu(
                      buttonConfigs: MediaCard.buildMenuButtons(context, ref, 
                        list[index]["type"],
                        list[index]["id"],
                        list[index]["addedBy"] ?? "no data",
                        list[index]["inLibrary"]
                      )
                    )
                  ),
                ),
            ),
          );
        },
        separatorBuilder: (context, _) => Divider(),
        // children: cardList.map(
        //   (card) => MediaCard(
        //     text: card["text"],
        //     image: card["image"],
        //     thingId: card["id"],
        //     thingType: card["type"],
        //     addedBy: card["addedBy"] ?? "no data",
        //     inLibrary: card["inLibrary"]
        //   ),
        // ).toList(),
    );
  }
}

Skeletonizer LoadingCardView(){
  return Skeletonizer(
          enabled: true,
          child: CardView(cardList: [for (int i = 0; i < 32; i++) {
            "text": "meh who cares",
            "id": "idklol",
            "type": "placeholder",
            "image": "https://placehold.co/512x512.png",
            "addedBy": "a banana",
            "inLibrary": true
          }]),
        );
}
