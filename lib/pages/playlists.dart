import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../providers/data/playlist_provider.dart'; 
import '../providers/error_watcher.dart';
import '../types/playlist.dart';
import 'cards.dart';
import "responsive/library/common.dart";

class PlaylistsPage extends ConsumerWidget {
  final bool private;
  final ViewType type;
  PlaylistsPage({required this.private, required this.type});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Playlist>> songs = ref.watch(fetchPlaylistsProvider(ignore: private));
    handleError(ref, fetchPlaylistsProvider(ignore: private), Beamer.of(context));
    return songs.when(
      data: (data) {
        List<Map<String, dynamic>> cardList = data.map((e) => {
          "text": "${e.displayName}\n${e.owner}\n${e.description}",
          "image": "nada",
          "id": e.id,
          "type": "playlist",
          "addedBy": e.owner,
          "inLibrary": e.isInLibrary,
        }).toList();
        return type == ViewType.grid ? CardView(cardList: cardList) : ItemListView(list: cardList);
      },
      loading: () => LoadingCardView(),
      error: (error, stack) => LoadingCardView(),
    );
  }
}