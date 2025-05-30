import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:taxi_native/pages/responsive/library/common.dart';
import 'package:taxi_native/types/generic.dart';

import '../cards.dart';
import '../../providers/data/fetched_data_provider.dart'; 
import '../../providers/error_watcher.dart';
import '../../types/album.dart';
import '../../types/song.dart';

class AlbumsPage extends ConsumerWidget {
  final bool personal;
  ViewType type;
  AlbumsPage({required this.personal, required this.type});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Album>> albums = ref.watch(fetchAlbumsProvider(personal: personal));
    handleError(ref, fetchAlbumsProvider(personal: personal), Beamer.of(context));
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
  final String artistId;
  AlbumsByArtistPage({required this.artistId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FindAlbumsByArtistProvider prov = findAlbumsByArtistProvider(artistId, personal: false);
    final AsyncValue<List<Album>> albums = ref.watch(prov);
    handleError(ref, prov, Beamer.of(context));
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
  final bool personal;
  final String artistId;
  SinglesByArtistPage({required this.personal, required this.artistId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Song>> songs = ref.watch(findSinglesByArtistProvider(artistId, personal: personal));
    handleError(ref, fetchAlbumsProvider(personal: personal), Beamer.of(context));
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
