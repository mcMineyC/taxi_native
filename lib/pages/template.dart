import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';

import '../providers/playlist_provider.dart'; 
import '../providers/error_watcher.dart';
import '../types/playlist.dart';

class PlaylistsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Playlist>> playlists = ref.watch(fetchPlaylistsProvider);
    handleError(ref, fetchPlaylistsProvider, Beamer.of(context));
    return Container();
  }
}
