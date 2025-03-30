import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../types/song.dart';
//import '../types/queueitem.dart';
import '../../../../providers/services/player.dart';

class DesktopQueuePage extends ConsumerWidget {
  //List<QueueItem> _queue = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final queue = ref.watch(playerProvider.select((value) => value.queue));
    final int playingIndex =
        ref.watch(playerProvider.select((value) => value.currentIndex));
    return Container(
      child: Material(
          child: ReorderableListView.builder(
        buildDefaultDragHandles: false,
        itemCount: queue.length + 1,
        itemBuilder: (context, index) => index == 0
            ? ListTile(
                key: Key('$index'),
                title: Row(// Action chips
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
                    onPressed: () {},
                  ),
                ]))
            : ListTile(
                key: Key('$index'),
                tileColor: index - 1 == playingIndex
                    ? colorScheme.onSurface
                    : colorScheme.surface,
                title: Text(queue[index - 1].displayName),
                trailing: ReorderableDragStartListener(
                  index: index,
                  child: const Icon(Icons.drag_handle),
                ),
              ),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex == 0) return;
          ref.read(playerProvider.notifier).moveQueueItem(oldIndex, newIndex);
        },
      )),
    );
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
