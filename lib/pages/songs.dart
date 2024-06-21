import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cards.dart';
import '../providers/error_watcher.dart';
import '../providers/fetched_data_provider.dart'; 
import '../types/song.dart';
import 'package:beamer/beamer.dart';

class SongsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Song>> songs = ref.watch(fetchSongsProvider);
    handleError(ref, fetchSongsProvider, Beamer.of(context));
    return songs.when(
        data: (data) {
          var cardList = data.map((e) => {
            "text": e.displayName,
            "image": "https://forkleserver.mooo.com:3030/info/songs/${e.id}/image",
            "id": e.id,
            "type": "song"
          }).toList();
          return CardView(cardList: cardList);
        },
        loading: () => LoadingCardView(),
        error: (error, stack) => LoadingCardView(),
      );
  }
}
