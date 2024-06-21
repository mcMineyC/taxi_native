import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';

import 'cards.dart';
import '../providers/fetched_data_provider.dart'; 
import '../providers/error_watcher.dart';
import '../types/album.dart';

class AlbumsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Album>> albums = ref.watch(fetchAlbumsProvider);
    handleError(ref, fetchAlbumsProvider, Beamer.of(context));

    return albums.when(
        data: (data) {
          var cardList = data.map((e) => {
            "text": e.displayName,
            "image": "https://forkleserver.mooo.com:3030/info/albums/${e.id}/image",
            "id": e.id,
            "type": "album"
          }).toList();
          return CardView(cardList: cardList);
        },
        loading: () => LoadingCardView(),
        error: (error, stack) => LoadingCardView(),
      );
  }
}
