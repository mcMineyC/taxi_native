import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import "package:context_menus/context_menus.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../types/song.dart';
//import '../types/queueitem.dart';
import '../../../../providers/services/player.dart';
import "../../../../helpers/widgets/modern_list_item.dart";
import "../../../../helpers/widgets/helper_widgets.dart";
import "../common.dart";

class MobileQueuePage extends ConsumerWidget {
  //List<QueueItem> _queue = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final queue = ref.watch(playerProvider.select((value) => value.queue));
    final int playingIndex =
        ref.watch(playerProvider.select((value) => value.currentIndex));
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 12)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 12, left: 12),
            child: Row(
              children: [
                FilledButton(
                  child: Text('Clear Queue'),
                  onPressed: () {
                    ref.read(playerProvider.notifier).clearQueue();
                  },
                ),
                Expanded(child: Container()),
                OutlinedButton(
                  child: Text("Add to playlist"),
                  onPressed: () {
                    playlistLogic(
                      ref, context,
                      queue
                        .where((e) => e.type == "song")
                        .map((e) => e.id)
                        .toList()
                        .join(","), 
                      "songids",
                    );
                  },
                ),
              ]
            ),
          ),
        ),
        SliverReorderableList(
          itemCount: queue.length,
          itemBuilder: (context, index) => ReorderableDelayedDragStartListener(
            key: ValueKey(queue[index]),
            index: index,
            child: ModernListItem(
              isEnd: index == queue.length - 1,
              isStart: index == 0,
              horizPadding: 12,
              color: playingIndex == index ? colorScheme.primary : null,
              textColor: playingIndex == index ? colorScheme.onPrimary : null,
              titleText: queue[index].displayName,
              subtitleText: "${queue[index].artistName} - ${queue[index].albumName}",
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: CachedNetworkImage(
                  width: 72,
                  height: 72,
                  imageUrl: queue[index].imageUrl,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.more_horiz_rounded),
                onPressed: (){
                  context.contextMenuOverlay.show(GenericContextMenu(
                    buttonConfigs: buildContextMenuConfig(context, ref, queue[index].toSong(), index),
                  ));
                },
              )
              // trailing: Text(index.toString()),
              // trailing: IconButton(
              //   icon: const Icon(Icons.link_rounded),
              //   onPressed: () {},
              // ),
            ),
          ),
          onReorder: (int oldIndex, int newIndex) {
            // BELOW IS FROM FLUTTER DOCS
            // https://api.flutter.dev/flutter/widgets/ReorderCallback.html
            if (oldIndex < newIndex) {
              // removing the item at oldIndex will shorten the list by 1.
              newIndex -= 1;
            }
            ref.read(playerProvider.notifier).moveQueueItem(oldIndex, newIndex);
          },
        ),
        SliverToBoxAdapter(child: SizedBox(height: 12)),
      ],
    );
    // return Container(
    //   child: Material(
    //       child: ReorderableListView.builder(
    //     buildDefaultDragHandles: false,
    //     itemCount: queue.length + 1,
    //     itemBuilder: (context, index) => index == 0
    //         ? ListTile(
    //             key: Key('$index'),
    //             title: Row(// Action chips
    //                 children: [
    //               FilledButton(
    //                 child: Text('Clear Queue'),
    //                 onPressed: () {
    //                   ref.read(playerProvider.notifier).clearQueue();
    //                 },
    //               ),
    //               Expanded(child: Container()),
    //               OutlinedButton(
    //                 child: Text("Add to playlist"),
    //                 onPressed: () {},
    //               ),
    //             ]))
    //         : ListTile(
    //             key: Key('$index'),
    //             tileColor: index - 1 == playingIndex
    //                 ? colorScheme.primary
    //                 : colorScheme.surface,
    //             title: Text(queue[index - 1].displayName),
    //             trailing: ReorderableDragStartListener(
    //               index: index,
    //               child: const Icon(Icons.drag_handle),
    //             ),
    //           ),
    //     shrinkWrap: true,
    //     padding: const EdgeInsets.symmetric(horizontal: 40),
    //     onReorder: (int oldIndex, int newIndex) {
    //       if (oldIndex == 0) return;
    //       ref.read(playerProvider.notifier).moveQueueItem(oldIndex-1, newIndex-2);
    //     },
    //   )),
    // );
    /*
    return CustomScrollView(
      slivers: [
        // Example SliverAppBar or sticky header
        //SliverAppBar(
        //  pinned: true,
        //  expandedHeight: 200.0,
        //  flexibleSpace: FlexibleSpaceBar(
        //    title: Text('Reorderable List Example'),
        //    background: Container(
        //      color: Colors.blueAccent,
        //      child: Center(
        //        child: Text(
        //          'Reorder the List',
        //          style: TextStyle(color: Colors.white, fontSize: 24),
        //        ),
        //      ),
        //    ),
        //  ),
        //),

        // SliverList to hold the reorderable items
        SliverToBoxAdapter(
            child: ReorderableListView(
          shrinkWrap: true, // Makes the list take the exact space needed
          onReorder: (int oldIndex, int newIndex) {
            ref.read(playerProvider.notifier).moveQueueItem(oldIndex, newIndex);
          },
          children: List.generate(
            queue.length,
            (index) => ListTile(
              key: ValueKey(queue[index].id),
              title: Text(queue[index].displayName),
            ),
          ),
        )),
      ],
    );*/
  }
}
