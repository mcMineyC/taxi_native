import "package:context_menus/context_menus.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import '../../../../../helpers/widgets/helper_widgets.dart';
import '../../../../../providers/data/fetched_data_provider.dart';
import '../../../../../providers/services/player.dart';

import "../../../../types/song.dart";
enum SongMenuItem {
  play,
  addToQueue,
  addToPlaylist,
  divider,
  delete,
}

List<ContextMenuButtonConfig> buildContextMenuConfig(WidgetRef ref, BuildContext context, Song song){
  List<ContextMenuButtonConfig> list = [
    ContextMenuButtonConfig(
      "Play",
      icon: Icon(Icons.play_arrow_rounded),
      onPressed: (){
        ref.read(playerProvider.notifier).setSong(song.id);
      }
    ),
    ContextMenuButtonConfig(
      "Add to queue",
      icon: Icon(Icons.add_rounded),
      onPressed: (){
        ref.read(playerProvider.notifier).addIdToQueue(song.id);
      }
    ),
    ContextMenuButtonConfig(
      "Add to playlist",
      icon: Icon(Icons.playlist_add_rounded),
      onPressed: () async{
        await playlistLogic(ref, context, song.id, "song");
      }
    ),
    // ContextMenuButtonConfig(
    //   "Play",
    //   icon: Icon(Icons.play_arrow_rounded),
    //   onPressed: (){
    //     ref.read(playerProvider.notifier).setSong(song.id);
    //   }
    // ),
  ];
  return list;
}