import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cards.dart';

import '../providers/fetched_data_provider.dart';
import '../types/song.dart';

class DownloaderPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Center(
        child: Text('This will be the downloader page,\nin time.', style: TextStyle(fontSize: 20)),
      )
    );
  }
}
