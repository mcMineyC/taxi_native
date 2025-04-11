import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cards.dart';
import '../providers/data/preferences_provider.dart';
import '../providers/error_watcher.dart';
import '../providers/data/fetched_data_provider.dart'; 
import '../types/song.dart';
import 'package:beamer/beamer.dart';

class SongsPage extends ConsumerWidget {
  final bool private;
  SongsPage({required this.private});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Song>> songs = ref.watch(fetchSongsProvider(ignore: private));
    handleError(ref, fetchSongsProvider(ignore: private), Beamer.of(context));
    return songs.when(
      data: (data) {
        var cardList = data.map((e) => {
          "text": e.displayName,
          "image": e.imageUrl,
          "id": e.id,
          "type": "song",
          "addedBy": e.addedBy,
          "inLibrary": e.isInLibrary,
        }).toList();
        return CardView(cardList: cardList);
      },
      loading: () => LoadingCardView(),
      error: (error, stack) => LoadingCardView(),
    );
  }
}

class SongsByArtistPage extends ConsumerWidget {
  final bool private;
  final String artistId;
  SongsByArtistPage({required this.private, required this.artistId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Song>> songs = ref.watch(findSongsByArtistProvider(artistId, ignore: private));
    handleError(ref, findSongsByArtistProvider(artistId, ignore: private), Beamer.of(context));
    return songs.when(
      data: (data) {
        var cardList = data.map((e) => {
          "text": e.displayName,
          "image": e.imageUrl,
          "id": e.id,
          "type": "song",
          "addedBy": e.addedBy,
          "inLibrary": e.isInLibrary,
        }).toList();
        return CardView(cardList: cardList);
      },
      loading: () => LoadingCardView(),
      error: (error, stack) => LoadingCardView(),
    );
  }
}
