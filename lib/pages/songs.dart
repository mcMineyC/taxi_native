import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cards.dart';
import '../providers/preferences_provider.dart';
import '../providers/error_watcher.dart';
import '../providers/fetched_data_provider.dart'; 
import '../types/song.dart';
import 'package:beamer/beamer.dart';

class SongsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Song>> songs = ref.watch(fetchSongsProvider);
    final AsyncValue<String> backendUrl = ref.watch(backendUrlProvider);
    handleError(ref, fetchSongsProvider, Beamer.of(context));
    return backendUrl.when(
      data: (url) => songs.when(
        data: (data) {
          var cardList = data.map((e) => {
            "text": e.displayName,
            "image": e.imageUrl,
            "id": e.id,
            "type": "song"
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
