import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_native_test/pages/cards.dart';

import '../providers/fetched_data_provider.dart';
import '../types/song.dart';

class DownloaderPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Song>> str = ref.watch(fetchSongsProvider);

    return Scaffold(
      body: Container(child: str.when(
        data: (data) {
          var cardList = data.map((e) => {
            "text": e.displayName,
            "image": "https://forkleserver.mooo.com:3030/info/songs/${e.id}/image",
            "id": e.id,
            "type": "song"
          }).toList();
          return CardView(cardList: cardList);
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
      ))
    );
  }
}
