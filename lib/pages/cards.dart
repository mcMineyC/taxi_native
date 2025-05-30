import 'package:beamer/beamer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taxi_native/types/generic.dart';
import '../helpers/widgets/helper_widgets.dart';
import "package:context_menus/context_menus.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class CardView extends StatelessWidget {
  final List<GenericItem> list;

  const CardView({super.key, required this.list});
  @override
  Widget build(BuildContext context) {
    double count = (MediaQuery.of(context).size.width / (MediaCard.width+32));
    return GridView.count(
        crossAxisCount: count.ceil(),
        scrollDirection: Axis.vertical,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: MediaCard.width / (MediaCard.height+6),
        children: list.map(
          (card) => MediaCard(
            text: card.texts[0],
            image: card.imageUrl,
            thingId: card.thingId,
            thingType: card.thingType,
            addedBy: card.addedBy ?? "no data",
            inLibrary: card.isInLibrary,
          ),
        ).toList(),
    );
  }
}

class ItemListView extends ConsumerWidget {
  final List<GenericItem> list;

  const ItemListView({super.key, required this.list});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: list.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          GenericItem working = list[index];
          return ContextMenuRegion(
            contextMenu: GenericContextMenu(
              buttonConfigs: MediaCard.buildMenuButtons(context, ref, 
                working.thingType,
                working.thingId,
                working.addedBy ?? "no data",
                working.isInLibrary,
              ),
            ),
            child: ListTile(
              onTap: () => MediaCard.itemClickBehaviour(thingType: working.thingType, thingId: working.thingId, context: context, ref: ref),
              enableFeedback: true,
              // dense: true,
              // minVerticalPadding: 2,
              minTileHeight: 68,
              visualDensity: VisualDensity(vertical: 3, horizontal:0),
              contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              leading: Container(
                constraints: BoxConstraints(maxWidth: 56, maxHeight: 56),
                child: working.thingType == "playlist" ?
                  PlaylistImage(playlistId: working.thingId) :
                  CachedNetworkImage(
                    imageUrl: working.imageUrl,
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
                  working.texts[0],
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  )
                ),
                subtitle: working.texts.length > 1 ? Text(
                  working.texts[1],
                  // working["text"].split("\n").last,
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  )
                ) : null,

                // subtitle: Row(
                //   children: [
                //     Text(
                //       textPieces.length > 1 ? textPieces[1] : textPieces[0],
                //       // working["text"].split("\n").last,
                //       overflow: TextOverflow.ellipsis,
                //       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                //         fontWeight: FontWeight.w600,
                //         color: Theme.of(context).colorScheme.onSurface,
                //       )
                //     ),
                //     if(working["type"] == "playlist") ...[
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
                        working.thingType,
                        working.thingId,
                        working.addedBy ?? "no data",
                        working.isInLibrary,
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
          child: CardView(list: [for (int i = 0; i < 32; i++) GenericItem.placeholder()]),
        );
}
