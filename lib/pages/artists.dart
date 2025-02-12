import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';

import 'cards.dart';
import '../providers/data/fetched_data_provider.dart'; 
import '../providers/error_watcher.dart';
import '../types/artists.dart';

class ArtistsPage extends ConsumerWidget {
  final bool private;
  ArtistsPage({required this.private});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Artist>> artists = ref.watch(fetchArtistsProvider(ignore: private));
    handleError(ref, fetchArtistsProvider(ignore: private), Beamer.of(context));
    return artists.when(
      data: (data) {
        var cardList = data.map((e) => {
          "text": e.displayName,
          "image": e.imageUrl,
          "id": e.id,
          "type": "artist",
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
