import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'cards.dart';
import '../providers/fetched_data_provider.dart'; 
import '../types/artists.dart';
import '../helper_widgets.dart';

class ArtistsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Artist>> artists = ref.watch(fetchArtistsProvider);

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
        loading: () => Skeletonizer(
          enabled: true,
          child: CardView(cardList: [for (int i = 0; i < 32; i++) {"text": "meh who cares", "id": "idklol", "type": "placeholder", "image": "https://placehold.co/512x512.png"}]),
        ),
        error: (error, stack) => Text('Error: $error'),
      );
  }
}
