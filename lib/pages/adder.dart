import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cards.dart';

import '../providers/fetched_data_provider.dart';
import '../providers/playing_provider.dart';
import '../types/song.dart';

class AdderPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text('This will be the music adder page,\nIn time.', style: TextStyle(fontSize: 20)),
            OutlinedButton(
              child: Text('Play Video'),
              onPressed: () async {
                ref.read(playerProvider.notifier).playYoutubeId("aH5duyhfSHE");
              }
            ),
          ]
        ),
      )
    );
  }
}
