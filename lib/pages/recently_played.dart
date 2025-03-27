import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:context_menus/context_menus.dart';

import "../providers/data/info_provider.dart";
import '../providers/data/fetched_data_provider.dart';
import "../providers/services/player.dart";
import '../helpers/utilities.dart';
import "../helpers/widgets/helper_widgets.dart";
import "../helpers/platform_utils.dart";
import "../types/song.dart";

class RecentlyPlayedPage extends ConsumerWidget {
  RecentlyPlayedPage({super.key});
  List<ContextMenuButtonConfig> buildContextMenuConfig(BuildContext context, WidgetRef ref, Song song)  => [
    ContextMenuButtonConfig("Play",
      icon: const Icon(Icons.play_arrow_rounded),
      onPressed: () async {
        if (PlatformUtils.isWeb) {
          return;
        }
        ref.read(playerProvider.notifier).setSong(song.id);
      },
    ),
    ContextMenuButtonConfig("Add to queue",
      icon: const Icon(Icons.queue),
      onPressed: () {
        if (PlatformUtils.isWeb) {
          showWebError(context);
          return;
        }
        ref.read(playerProvider.notifier).addIdToQueue(song.id);
      },
    ),
    ContextMenuButtonConfig(
      "Add to playlist",
      icon: const Icon(Icons.playlist_add),
      onPressed: () async =>
        await playlistLogic(ref, context, song.id, "song"),
    ),
    if (song.isInLibrary) ContextMenuButtonConfig(
      "Remove from library",
      icon: Icon(Icons.bookmark_remove_rounded),
      onPressed: () {
        ref.read(removeFromLibraryProvider(song.id, "song").future).then((value) {
          refreshLibrary(ref);
        });
      },
    ),
    if (!song.isInLibrary) ContextMenuButtonConfig(
      "Add to library",
      icon: Icon(Icons.bookmark_rounded),
      onPressed: () {
        ref.read(addToLibraryProvider(song.id, "song").future).then((value) {
          refreshLibrary(ref);
        });
      },
    ),
    ContextMenuButtonConfig(
      "song" == "playlist" ? "Owner: ${song.addedBy}" : "Added by: ${song.addedBy}",
      onPressed: null,
    )
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Song>> recentlyPlayed = ref.watch(fetchRecentlyPlayedProvider);
    print("Recently played rebuilding");
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: recentlyPlayed.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          prototypeItem: ModernListItem(
            isEnd: false,
            isStart: false,
            title: Text("Song name"),
            subtitle: Text("Album - Artist name"),
            leading: Container(color: Colors.grey),
          ),
          itemBuilder: (context, index) => ContextMenuRegion(
            contextMenu: GenericContextMenu(buttonConfigs: buildContextMenuConfig(context, ref, data[index])),
            child: ModernListItem(
              isEnd: index == data.length - 1,
              isStart: index == 0,
              titleText: data[index].displayName,
              subtitleText: "${data[index].albumDisplayName} - ${data[index].artistDisplayName}",
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  width: 72,
                  height: 72,
                  imageUrl: data[index].imageUrl,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.link_rounded),
                onPressed: () {},
              ),
            ),
          )
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.error),
              SizedBox(height: 8),
              Text("Error loading recently played")
            ]
          ),
        ),
      ),
    );
  }
}

//class ModernListItemData {
//  Widget title;
//  Widget? subtitle;
//  Widget? leading;
//  Widget? trailing;
//}

class ModernListItem extends StatelessWidget {
  final bool isEnd;
  final bool isStart;
  final Widget? child;
  final Widget? trailing;
  final Widget? leading;
  final Widget? title;
  final String? titleText;
  final Widget? subtitle;
  final String? subtitleText;
  final int horizPadding;
  final int interItemSpacing;
  ModernListItem({super.key, required this.isEnd, required this.isStart, this.child, this.trailing, this.leading, this.title, this.subtitle, this.titleText, this.subtitleText, this.horizPadding = 12, this.interItemSpacing = 6}) {
    assert(child != null || (leading != null || title != null || subtitle != null || subtitleText != null || titleText != null), "Either child or layout-specific widget should be defined");
    assert(child == null && (leading != null || title != null || subtitle != null || titleText != null || subtitleText != null), "Both child and layout-specific widget cannot be defined");
    //assert(title != null && titleText != null, "Either titleText or title should be defined");
    //assert(subtitle != null || subtitleText != null, "Either subtitleText or subtitle should be defined");
    assert((title == null) ^ (titleText == null), "Either titleText or title should be defined but not both");
    assert((subtitle == null) ^ (subtitleText == null), "Either subtitleText or subtitle should be defined but not both");
    //assert(child != null && (leading == null && title == null && subtitle == null), "Both child and layout-specific widget cannot be defined");
  }
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      height: 84,
      margin: EdgeInsets.only(
        bottom: isEnd ? 0 : interItemSpacing/2.0,
        top: isStart ? 0 : interItemSpacing/2.0,
        left: horizPadding.toDouble(),
        right: horizPadding.toDouble()
      ),
      //margin: EdgeInsets.only(bottom: isEnd ? 0 : 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: 
          isEnd ? BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)) :
          isStart ? BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)) :
          null,
        color: theme.colorScheme.surfaceContainerHighest,
      ),
      child: child ?? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) leading!,
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title != null ? title! : Text(titleText!, style: Theme.of(context).textTheme.headlineMedium,),
                subtitle != null ? subtitle! : Text(subtitleText!, style: Theme.of(context).textTheme.bodyMedium,)
              ],
            ),
          ),
          if (trailing != null) const Spacer(),
          if (trailing != null) trailing! //trailing!,
        ],
      ),
    );
  }
}

