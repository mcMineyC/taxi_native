import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';

import 'cards.dart';
import '../providers/fetched_data_provider.dart'; 
import '../providers/error_watcher.dart';
import '../types/artists.dart';

class ArtistsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Artist>> artists = ref.watch(fetchArtistsProvider);
    handleError(ref, fetchArtistsProvider, Beamer.of(context));

    return artists.when(
        data: (data) {
          var cardList = data.map((e) => {
            "text": e.displayName,
            "image": "https://forkleserver.mooo.com:3030/info/artists/${e.id}/image",
            "id": e.id,
            "type": "artist"
          }).toList();
          return CardView(cardList: cardList);
        },
        loading: () => LoadingCardView(),
        error: (error, stack) => LoadingCardView(),
      );
  }
}
