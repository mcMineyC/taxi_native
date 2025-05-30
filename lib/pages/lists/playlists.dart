import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taxi_native/types/generic.dart';

import '../../providers/data/playlist_provider.dart'; 
import '../../providers/error_watcher.dart';
import '../../types/playlist.dart';
import '../cards.dart';
import "../responsive/library/common.dart";

class PlaylistsPage extends ConsumerWidget {
  final bool personal;
  final ViewType type;
  PlaylistsPage({required this.personal, required this.type});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Playlist>> songs = ref.watch(fetchPlaylistsProvider(ignore: personal));
    handleError(ref, fetchPlaylistsProvider(ignore: personal), Beamer.of(context));
    return songs.when(
      data: (data) {
        List<GenericItem> cardList = data.map((e) => GenericItem.fromPlaylist(e)).toList();
        return type == ViewType.grid ? CardView(list: cardList) : ItemListView(list: cardList);
      },
      loading: () => LoadingCardView(),
      error: (error, stack) => LoadingCardView(),
    );
  }
}