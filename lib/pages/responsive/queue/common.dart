import "package:context_menus/context_menus.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../helpers/widgets/helper_widgets.dart";
import "../../../helpers/utilities.dart";
import "../../../helpers/platform_utils.dart";
import "../../../providers/services/player.dart";
import "../../../providers/data/fetched_data_provider.dart";
import "../../../types/song.dart";

  List<ContextMenuButtonConfig> buildContextMenuConfig(BuildContext context, WidgetRef ref, Song song, int index)  => [
    ContextMenuButtonConfig("Skip here",
      icon: const Icon(Icons.play_arrow_rounded),
      onPressed: () async {
        if (PlatformUtils.isWeb) {
          return;
        }
        ref.read(playerProvider.notifier).skipToItem(index);
      },
    ),
    // ContextMenuButtonConfig("Add to queue",
    //   icon: const Icon(Icons.queue),
    //   onPressed: () {
    //     if (PlatformUtils.isWeb) {
    //       showWebError(context);
    //       return;
    //     }
    //     ref.read(playerProvider.notifier).addIdToQueue(song.id);
    //   },
    // ),
    ContextMenuButtonConfig(
      "Add to playlist",
      icon: const Icon(Icons.playlist_add),
      onPressed: () async =>
        await playlistLogic(ref, context, song.id, "song"),
    ),
    ContextMenuButtonConfig(
      "Remove from queue",
      icon: Icon(Icons.delete_rounded),
      onPressed: () async {
        Player p = ref.read(playerProvider.notifier);
        bool skip = false;
        if(ref.read(playerProvider).currentIndex == index){
          skip = (await showDialog<bool>(context: context, builder: (context) => 
            AlertDialog(
              title: Text(
                "Move on?",
                style: Theme.of(context).textTheme.displayMedium
              ),
              content: Text("Would you like to move on to the next song in the queue?"), 
              actions: [
                TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text("No")),
                TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text("Yes")),
              ],
          ))) ?? false;
        }
        p.removeQueueItem(index, skip: skip);
      }
    ),
    // if (song.isInLibrary) ContextMenuButtonConfig(
    //   "Remove from library",
    //   icon: Icon(Icons.bookmark_remove_rounded),
    //   onPressed: () {
    //     ref.read(removeFromLibraryProvider(song.id, "song").future).then((value) {
    //       refreshLibrary(ref);
    //     });
    //   },
    // ),
    // if (!song.isInLibrary) ContextMenuButtonConfig(
    //   "Add to library",
    //   icon: Icon(Icons.bookmark_rounded),
    //   onPressed: () {
    //     ref.read(addToLibraryProvider(song.id, "song").future).then((value) {
    //       refreshLibrary(ref);
    //     });
    //   },
    // ),
    ContextMenuButtonConfig(
      "song" == "playlist" ? "Owner: ${song.addedBy}" : "Added by: ${song.addedBy}",
      onPressed: null,
    )
  ];