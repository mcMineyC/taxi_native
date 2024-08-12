import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/services/player.dart';

class MobilePlayerControls extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int width = MediaQuery.of(context).size.width.toInt();
    int height = MediaQuery.of(context).size.height.toInt();
    final player = ref.watch(playerProvider);
    return Container(
                padding: EdgeInsets.only(top: (height >= 560 ? 16 : 0)),
                height: (height >= 560 ? 100 : 84),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
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
                                    overflow: TextOverflow.ellipsis
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(  // Button group
                            margin: EdgeInsets.only(right: 84),
                            child: Row(
                              children: [
                                if(width >= 296 && width <= 525) IconButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fullscreen player view not done")));
                                  },
                                  icon: const Icon(Icons.keyboard_arrow_up_rounded),
                                ),
                                if(width >= 324) IconButton(
                                  onPressed: () {
                                    ref.read(playerProvider.notifier).shuffle(!player.shuffle);
                                  },
                                  icon: const Icon(Icons.shuffle_rounded),
                                  color: player.shuffle ? Theme.of(context).colorScheme.primary : null,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.skip_previous_rounded),
                                  onPressed: () {
                                    ref.read(playerProvider.notifier).previous();
                                  }
                                ),
                                IconButton(
                                  icon: (player.isPlaying == false) ? const Icon(Icons.play_circle_outline_rounded) : const Icon(Icons.pause_circle_outline_rounded),
                                 onPressed: () {
                                    ref.read(playerProvider.notifier).toggle(); 
                                  }
                                ),
                                IconButton(
                                  icon: const Icon(Icons.skip_next_rounded),
                                  onPressed: () {
                                    ref.read(playerProvider.notifier).next();
                                  }
                                ),
                                if(width >= 352) IconButton(
                                  onPressed: () {
                                    ref.read(playerProvider.notifier).loop(!player.loop);
                                  },
                                  icon: const Icon(Icons.loop_rounded),
                                  color: player.loop ? Theme.of(context).colorScheme.primary : null,
                                ),
                              ],
                            ),
                          ),
                        ]
                      ),
                    ),
                    if(height >= 560) Listener(
                      onPointerSignal: (event) {
                        if(event is PointerScrollEvent) {
                          if(event.scrollDelta.dy < 0) {
                            ref.read(playerProvider.notifier).seekForward(3000);
                          }else{
                            ref.read(playerProvider.notifier).seekBackward(3000);
                          }
                        }
                      },
                      child: Container(
                        height: 16,
                        // color: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        margin: const EdgeInsets.only(top: 16),
                        child: Column(
                          children: [
                            LinearProgressIndicator(
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(9999),
                              value: player.duration == 0 ? 0 : player.position / player.duration,
                            ),
                            Expanded(child: Container()),
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              );
  }
}
