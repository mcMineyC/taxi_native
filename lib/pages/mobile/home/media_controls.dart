import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/services/player.dart';

class MobilePlayerControls extends ConsumerWidget {
  MobilePlayerControls({required this.persistenceFunction});
  final Function(PlayerInfo) persistenceFunction;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int width = MediaQuery.of(context).size.width.toInt();
    int height = MediaQuery.of(context).size.height.toInt();
    final player = ref.watch(playerProvider);
    persistenceFunction(player);
    return Container(
      //padding: EdgeInsets.only(top: (height >= 560 ? 16 : 0)),
      height: 64,
      child: Column(
        children: [
          Expanded(
            child: Row(
            mainAxisAlignment: width >= 616 ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              if(width >= 616) Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        player.displayName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                          player.albumDisplayName.isNotEmpty &&
                                  player.artistDisplayName.isNotEmpty
                              ? "${player.albumDisplayName} - ${player.artistDisplayName}"
                              : "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ),
              Container(
              //color: Colors.green[500],
                // Button group
                margin: width >= 616 ? EdgeInsets.only(right: 84) : EdgeInsets.only(right: 36),
                child: Row(
                  children: [
                    if (width < 616)
                      IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Fullscreen player view not done")));
                        },
                        icon: const Icon(Icons.keyboard_arrow_up_rounded),
                      ),
                    if (width >= 324)
                      IconButton(
                        onPressed: () {
                          if (player.thinking) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Currently thinking...")));
                            return;
                          }
                          ref.read(playerProvider.notifier).shuffle();
                        },
                        icon: const Icon(Icons.shuffle_rounded),
                        color: player.shuffle
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                    IconButton(
                        icon: const Icon(Icons.skip_previous_rounded),
                        onPressed: () {
                          if (player.thinking) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Currently thinking...")));
                            return;
                          }
                          ref.read(playerProvider.notifier).previous();
                        }),
                    (player.thinking)
                        ? CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                            value: null)
                        : IconButton(
                            icon: (player.isPlaying == false)
                                ? const Icon(Icons.play_circle_outline_rounded)
                                : const Icon(
                                    Icons.pause_circle_outline_rounded),
                            onPressed: () {
                              if (player.thinking) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Currently thinking...")));
                                return;
                              }
                              ref.read(playerProvider.notifier).toggle();
                            }),
                    IconButton(
                        icon: const Icon(Icons.skip_next_rounded),
                        onPressed: () {
                          if (player.thinking) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Currently thinking...")));
                            return;
                          }
                          ref.read(playerProvider.notifier).next();
                        }),
                    if (width >= 352)
                      IconButton(
                        onPressed: () {
                          if (player.thinking) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Currently thinking...")));
                            return;
                          }
                          ref.read(playerProvider.notifier).loop(!player.loop);
                        },
                        icon: const Icon(Icons.loop_rounded),
                        color: player.loop
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                  ],
                ),
              ),
            ]),
          ),
          // No mobile seekbar
          //if (height >= 560)
          //  Container(
          //    padding: const EdgeInsets.symmetric(horizontal: 16),
          //    margin: const EdgeInsets.only(top: 16),
          //    child: Slider(
          //      value: player.position.toDouble(),
          //      max: player.duration.toDouble(),
          //      min: 0,
          //      onChanged: (_){},
          //      onChangeEnd: (value) {
          //        ref.read(playerProvider.notifier).seek(Duration(milliseconds: value.toInt()));
          //      },
          //    ),
          //  ),
            //Listener(
            //  onPointerSignal: (event) {
            //    if (player.thinking) {
            //      ScaffoldMessenger.of(context).showSnackBar(
            //          const SnackBar(content: Text("Currently thinking...")));
            //      return;
            //    }
            //    if (event is PointerScrollEvent) {
            //      if (event.scrollDelta.dy < 0) {
            //        ref.read(playerProvider.notifier).seekForward(3000);
            //      } else {
            //        ref.read(playerProvider.notifier).seekBackward(3000);
            //      }
            //    }
            //  },
            //  child: Container(
            //      height: 16,
            //      // color: Colors.green,
            //      padding: const EdgeInsets.symmetric(horizontal: 16),
            //      margin: const EdgeInsets.only(top: 16),
            //      child: Column(
            //        children: [
            //          LinearProgressIndicator(
            //            minHeight: 8,
            //            borderRadius: BorderRadius.circular(9999),
            //            value: player.duration == 0
            //                ? 0
            //                : player.position / player.duration,
            //          ),
            //          Expanded(child: Container()),
            //        ],
            //      )),
            //),
        ],
      ),
    );
  }
}
