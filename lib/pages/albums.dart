import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:taxi_native/pages/responsive/library/common.dart';
import 'package:taxi_native/types/generic.dart';

import 'cards.dart';
import '../providers/data/fetched_data_provider.dart'; 
import '../providers/error_watcher.dart';
import '../types/album.dart';
import '../types/song.dart';

class AlbumsPage extends ConsumerWidget {
  final bool private;
  ViewType type;
  AlbumsPage({required this.private, required this.type});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Album>> albums = ref.watch(fetchAlbumsProvider(ignore: private));
    handleError(ref, fetchAlbumsProvider(ignore: private), Beamer.of(context));
    return albums.when(
      data: (data) {
        var cardList = data.map((e) => GenericItem.fromAlbum(e)).toList();
        return type == ViewType.grid ? CardView(list: cardList) : ItemListView(list: cardList);
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
        var cardList = data.map((e) => GenericItem.fromAlbum(e)).toList();
        return CardView(list: cardList);
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
        var cardList = data.map((e) => GenericItem.fromSong(e)).toList();
        return CardView(list: cardList);
      },
      loading: () => LoadingCardView(),
      error: (error, stack) => LoadingCardView(),
    );
  }
}
