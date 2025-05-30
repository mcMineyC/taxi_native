import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../cards.dart';
import '../../providers/data/preferences_provider.dart';
import '../../providers/error_watcher.dart';
import '../../providers/data/fetched_data_provider.dart'; 
import '../../types/song.dart'; 
import '../../types/generic.dart';
import "../responsive/library/common.dart";
import 'package:beamer/beamer.dart';

class SongsPage extends ConsumerWidget {
  final bool personal;
  final ViewType type;
  SongsPage({required this.personal, required this.type});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Song>> songs = ref.watch(fetchSongsProvider(personal: personal));
    handleError(ref, fetchSongsProvider(personal: personal), Beamer.of(context));
    return songs.when(
      data: (data) {
        List<GenericItem> cardList = data.map((e) => GenericItem.fromSong(e)).toList();
        return type == ViewType.grid ? CardView(list: cardList) : ItemListView(list: cardList);
      },
      loading: () => LoadingCardView(),
      error: (error, stack) => LoadingCardView(),
    );
  }
}

class SongsByArtistPage extends ConsumerWidget {
  final bool personal;
  final String artistId;
  final ViewType type;
  SongsByArtistPage({required this.personal, required this.artistId, required this.type});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Song>> songs = ref.watch(findSongsByArtistProvider(artistId, personal: personal));
    handleError(ref, findSongsByArtistProvider(artistId, personal: personal), Beamer.of(context));
    return songs.when(
      data: (data) {
        List<GenericItem> cardList = data.map((e) => GenericItem.fromSong(e)).toList();
        return type == ViewType.grid ? CardView(list: cardList) : ItemListView(list: cardList);
      },
      loading: () => LoadingCardView(),
      error: (error, stack) => LoadingCardView(),
    );
  }
}
