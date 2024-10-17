import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cards.dart';
import '../providers/data/preferences_provider.dart';
import '../providers/error_watcher.dart';
import '../providers/data/fetched_data_provider.dart'; 
import '../types/song.dart';
import 'package:beamer/beamer.dart';

class SongsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Song>> songs = ref.watch(fetchSongsProvider(ignore: false));
    handleError(ref, fetchSongsProvider(ignore: false), Beamer.of(context));
    return songs.when(
      data: (data) {
        var cardList = data.map((e) => {
          "text": e.displayName,
          "image": e.imageUrl,
          "id": e.id,
          "addedBy": e.addedBy,
          "type": "song"
        }).toList();
        return CardView(cardList: cardList);
      },
      loading: () => LoadingCardView(),
      error: (error, stack) => LoadingCardView(),
    );
  }
}
