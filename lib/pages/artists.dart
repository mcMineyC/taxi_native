import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:taxi_native/pages/responsive/library/common.dart';
import 'package:taxi_native/types/generic.dart';

import 'cards.dart';
import '../providers/data/fetched_data_provider.dart'; 
import '../providers/error_watcher.dart';
import '../types/artists.dart';

class ArtistsPage extends ConsumerWidget {
  final bool private;
  final ViewType type;
  ArtistsPage({required this.private, required this.type});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Artist>> artists = ref.watch(fetchArtistsProvider(ignore: private));
    handleError(ref, fetchArtistsProvider(ignore: private), Beamer.of(context));
    return artists.when(
      data: (data) {
        var cardList = data.map((e) => GenericItem.fromArtist(e))
        .toList();
        return type == ViewType.grid ? CardView(list: cardList) : ItemListView(list: cardList);
      },
      loading: () => LoadingCardView(),
      error: (error, stack) => LoadingCardView(),
    );
  }
}
