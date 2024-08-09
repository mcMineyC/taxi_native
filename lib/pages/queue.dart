import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../types/song.dart';
import '../providers/services/player.dart';

class QueuePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    final queue = ref.watch(playerProvider.select((value) => value.queue));
    final int playingIndex = ref.watch(playerProvider.select((value) => value.currentIndex));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(24, 12, 24, 12),
          child: Row(    // Action chips
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
            ]
          ),
        ),
          Expanded(
            child: SingleChildScrollView(
              child: Material(
                child: ReorderableListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  children: <Widget>[
                    for (int index = 0; index < queue.length; index += 1)
                      ListTile(
                        key: Key('$index'),
                        tileColor: index == playingIndex ? colorScheme.primary : ((((index+1)%2)>0) ? oddItemColor : evenItemColor),
                        title: Text(queue[index].displayName),
                      ),
                  ],
                  onReorder: (int oldIndex, int newIndex) {
                    ref.read(playerProvider.notifier).moveQueueItem(oldIndex, newIndex);
                  },
                ),
              )
            ),
          ),
        ]
    );
  }
}
