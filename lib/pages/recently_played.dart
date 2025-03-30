import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:context_menus/context_menus.dart';

import "../providers/data/info_provider.dart";
import '../providers/data/fetched_data_provider.dart';
import "../providers/services/player.dart";
import '../helpers/utilities.dart';
import "../helpers/widgets/helper_widgets.dart";
import "../helpers/widgets/modern_list_item.dart";
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
            subtitle: Text("Artist name - album"),
            leading: Container(color: Colors.grey),
          ),
          itemBuilder: (context, index) => ContextMenuRegion(
            contextMenu: GenericContextMenu(buttonConfigs: buildContextMenuConfig(context, ref, data[index])),
            child: ModernListItem(
              isEnd: index == data.length - 1,
              isStart: index == 0,
              titleText: data[index].displayName,
              subtitleText: "${data[index].artistDisplayName} - ${data[index].albumDisplayName}",
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: CachedNetworkImage(
                  width: 72,
                  height: 72,
                  imageUrl: data[index].imageUrl,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.more_horiz_rounded),
                onPressed: (){
                  context.contextMenuOverlay.show(GenericContextMenu(
                    buttonConfigs: buildContextMenuConfig(context, ref, data[index]),
                  ));
                },
              )
              // trailing: IconButton(
              //   icon: const Icon(Icons.link_rounded),
              //   onPressed: () {},
              // ),
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