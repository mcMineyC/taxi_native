import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';

import 'cards.dart';
import '../providers/data/fetched_data_provider.dart'; 
import '../providers/error_watcher.dart';
import '../types/album.dart';
import '../types/song.dart';

class AlbumsPage extends ConsumerWidget {
  final bool private;
  AlbumsPage({required this.private});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Album>> albums = ref.watch(fetchAlbumsProvider(ignore: private));
    handleError(ref, fetchAlbumsProvider(ignore: private), Beamer.of(context));
    return albums.when(
      data: (data) {
        var cardList = data.map((e) => {
          "text": e.displayName,
          "image": e.imageUrl,
          "id": e.id,
          "type": "album",
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

class AlbumsByArtistPage extends ConsumerWidget {
  final bool private;
  final String artistId;
  AlbumsByArtistPage({required this.private, required this.artistId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Album>> albums = ref.watch(findAlbumsByArtistProvider(artistId, ignore: private));
    handleError(ref, fetchAlbumsProvider(ignore: private), Beamer.of(context));
    return albums.when(
      data: (data) {
        var cardList = data.map((e) => {
          "text": e.displayName,
          "image": e.imageUrl,
          "id": e.id,
          "type": "album",
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

class SinglesByArtistPage extends ConsumerWidget {
  final bool private;
  final String artistId;
  SinglesByArtistPage({required this.private, required this.artistId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Song>> songs = ref.watch(findSinglesByArtistProvider(artistId, ignore: private));
    handleError(ref, fetchAlbumsProvider(ignore: private), Beamer.of(context));
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
