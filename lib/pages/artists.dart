import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';

import 'cards.dart';
import '../providers/data/fetched_data_provider.dart'; 
import '../providers/error_watcher.dart';
import '../providers/data/preferences_provider.dart';
import '../types/artists.dart';

class ArtistsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Artist>> artists = ref.watch(fetchArtistsProvider);
    final AsyncValue<String> backendUrl = ref.watch(backendUrlProvider);
    handleError(ref, fetchArtistsProvider, Beamer.of(context));
    return backendUrl.when(
      data: (url) => artists.when(
        data: (data) {
          var cardList = data.map((e) => {
            "text": e.displayName,
            "image": e.imageUrl,
            "id": e.id,
            "type": "artist",
          }).toList();
          return CardView(cardList: cardList);
        },
        loading: () => LoadingCardView(),
        error: (error, stack) => LoadingCardView(),
      ),
      loading: () => LoadingCardView(),
      error: (error, stack) => LoadingCardView(),
    );
  }
}
