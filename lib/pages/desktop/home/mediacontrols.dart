import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../providers/services/player.dart';
import '../../../helper_widgets.dart';

class DesktopBottomBar extends ConsumerWidget {
  DesktopBottomBar({required this.persistenceFunction});
  final Function(PlayerInfo) persistenceFunction;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerProvider);
    persistenceFunction(player);
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
                    height: 96,
                    child: Column(  // Player controls
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(16, 12, 12, 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      player.displayName,
                                      style: GoogleFonts.poppins().copyWith(color: Theme.of(context).colorScheme.onSurface),
                                      overflow: TextOverflow.ellipsis
                                    ),
                                    Text(
                                      player.albumDisplayName.isNotEmpty && player.artistDisplayName.isNotEmpty ? "${player.albumDisplayName} - ${player.artistDisplayName}" : "",
                                      style: GoogleFonts.poppins().copyWith(color: Theme.of(context).colorScheme.onSurface),
                                      overflow: TextOverflow.ellipsis
                                    ),
                                  ],
                                ),
                              ),
                              Container(  // Button group
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        ref.read(playerProvider.notifier).shuffle(!player.shuffle);
                                      },
                                      icon: const Icon(Icons.shuffle_rounded),
                                      color: player.shuffle ? Theme.of(context).colorScheme.primary : null,
                                    ),
                                    const SpacerWidget(width: 8),
                                    FilledButton.tonal(
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 48,
                                          maxHeight: 48
                                        ),
                                        child: const Icon(Icons.skip_previous_rounded, size: 28),
                                      ),
                                      onPressed: () {
                                        ref.read(playerProvider.notifier).previous();
                                      }
                                    ),
                                    const SpacerWidget(width: 8),
                                    FilledButton.tonal(
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 48,
                                          maxHeight: 48
                                        ),
                                        //*PLAY_BUTTON
                                        child: (player.isPlaying == false) ? const Icon(Icons.play_circle_outline_rounded, size: 28) : const Icon(Icons.pause_circle_outline_rounded, size: 28),
        
                                      ),
                                      onPressed: () {
                                        ref.read(playerProvider.notifier).toggle(); 
                                      }
                                    ),
                                    const SpacerWidget(width: 8),
                                    FilledButton.tonal(
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 48,
                                          maxHeight: 48
                                        ),
                                        child: const Icon(Icons.skip_next_rounded, size: 28),
                                      ),
                                      onPressed: () {
                                        ref.read(playerProvider.notifier).next();
                                      }
                                    ),
                                    const SpacerWidget(width: 8),
                                    IconButton(
                                      onPressed: () {
                                        ref.read(playerProvider.notifier).loop(!player.loop);
                                      },
                                      icon: const Icon(Icons.loop_rounded),
                                      color: player.loop ? Theme.of(context).colorScheme.primary : null,
                                    ),
                                  ]
                                )
                              ),
                              Expanded(
                                child: Text(
                                  "",
                                  style: GoogleFonts.poppins().copyWith(color: Theme.of(context).colorScheme.onSurface),
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis
                                )
                              ),
                            ],
                          ),
                        ),
                        Listener(
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
                            margin: EdgeInsets.fromLTRB(16, 0, 12, 16),
                            child: LinearProgressIndicator(
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(9999),
                              value: player.duration == 0 ? 0 : player.position / player.duration,
                            )
                          ),
                        ),
                      ]
                    )
                  );
  }
}
