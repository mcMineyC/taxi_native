import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'marque.dart';

import 'package:taxi_native/helpers/utilities.dart';
import '../../../../providers/services/player.dart';

class MobileFullscreenPlayerPage extends ConsumerStatefulWidget {
  MobileFullscreenPlayerPage({Key? key}) : super(key: key);
  @override
  _MobileFullscreenPlayerPageState createState() => _MobileFullscreenPlayerPageState();
}

class _MobileFullscreenPlayerPageState extends ConsumerState<MobileFullscreenPlayerPage> {
  bool _showingArt = true;
  @override
  Widget build(BuildContext context) {
    var player = ref.watch(playerProvider);
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;
    double iconSize = 40;
    double horizPadding = 24;
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.all(8),
            child: IconButton(
              icon: Icon(Icons.arrow_downward_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizPadding),
          child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: player.imageUrl,
            ),
          )
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizPadding),
          child: MarqueeTextWidget(
            text: player.displayName,
            fontColor: Theme.of(context).colorScheme.primary,
            fontSize: screenHeight * 0.028,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizPadding),
          child: MarqueeTextWidget(
            text: player.albumDisplayName,
            fontColor: Theme.of(context).colorScheme.secondary,
            fontSize: screenHeight * 0.017,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizPadding-22),
          child: Column(
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(trackHeight: 12, thumbSize: MaterialStateProperty.all<Size>(Size(8,32))),
                child: Slider(
                  value: player.duration == 0 ? 0 : player.position.toDouble(),
                  onChanged: (value) => ref.read(playerProvider.notifier).seek(Duration(milliseconds: value.toInt())),
                  max: player.duration.toDouble(),
                  min: 0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(millisecondsToDurationString(player.position), style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary)),
                    Text(millisecondsToDurationString(player.duration), style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _PlayerControlButton(
                      icon: FluentIcons.arrow_shuffle_24_filled,
                      color: player.shuffle ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                      onPress: () => ref.read(playerProvider.notifier).shuffle(),
                      iconSize: iconSize,
                      iconScaleFactor: 2,
                    ),
                    Row(
                      children: [
                        _PlayerControlButton(
                          icon: FluentIcons.previous_24_filled,
                          color: Theme.of(context).colorScheme.primary,
                          onPress: () => ref.read(playerProvider.notifier).previous(),
                          iconSize: iconSize,
                        ),
                        const SizedBox(width: 10),
                        _PlaybackIconButton(
                          thinking: player.thinking,
                          playing: player.isPlaying,
                          color: Theme.of(context).colorScheme.primary,
                          bgColor: Theme.of(context).colorScheme.primaryContainer,
                          onPress: () => ref.read(playerProvider.notifier).toggle(),
                          iconSize: iconSize,
                        ),
                        const SizedBox(width: 10),
                        _PlayerControlButton(
                          icon: FluentIcons.next_24_filled,
                          color: Theme.of(context).colorScheme.primary,
                          onPress: () => ref.read(playerProvider.notifier).next(),
                          iconSize: iconSize,
                        ),
                      ],
                    ),
                    _PlayerControlButton(
                      icon: FluentIcons.arrow_repeat_all_24_filled,
                      color: player.loop ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                      onPress: () => ref.read(playerProvider.notifier).loop(!player.loop),
                      iconSize: iconSize,
                      iconScaleFactor: 2,
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      ],
    );
  }
  Widget _PlaybackIconButton({double iconSize = 48, required Color color, required Color bgColor, required Function() onPress, required bool thinking, required bool playing}) {
    return RawMaterialButton(
      elevation: 2,
      padding: const EdgeInsets.all(15),
      shape: const CircleBorder(),
      fillColor: bgColor,
      splashColor: Colors.transparent,
      onPressed: onPress,
      child: thinking ? 
        const CircularProgressIndicator() : 
        Icon(
          playing ? FluentIcons.pause_24_filled : FluentIcons.play_24_filled,
          size: iconSize,
          color: color,
        ),
      // child: Icon(
      //   thinking ? FluentIcons.spinner_ios_16_filled : (playing ? FluentIcons.pause_24_filled : FluentIcons.play_24_filled),
      //   size: iconSize,
      //   color: color,
      // ),
    );
  }

  Widget _PlayerControlButton({double iconSize = 48, double iconScaleFactor = 1.7, required Color color, required IconData icon, required Function() onPress}) {
    return IconButton(
      splashColor: Colors.transparent,
      onPressed: onPress,
      icon: Icon(
        //FluentIcons.previous_24_filled,
        icon,
        //color: audioHandler.hasPrevious ? primaryColor : secondaryColor,
        color: color,
      ),
      iconSize: iconSize / 1.7,
    );
  }
}

void showFullscreenPlayer(BuildContext context) {
  showMaterialModalBottomSheet(
    context: context,
    expand: true,
    builder: (context) => MobileFullscreenPlayerPage(),
  );
}
