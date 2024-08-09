import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../providers/data/playlist_provider.dart'; 
import '../providers/error_watcher.dart';
import '../types/playlist.dart';

class PlaylistsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Playlist>> playlists = ref.watch(fetchPlaylistsProvider);
    handleError(ref, fetchPlaylistsProvider, Beamer.of(context));
    return Container(
      margin: EdgeInsets.all(24),
      child: playlists.when(
        data: (data) => ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: data.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => Beamer.of(context).beamToNamed('/playlist/${data[index].id}'),
            child: ListTile(
              title: Text(data[index].displayName),
              subtitle: Text(data[index].owner),
            ),
          ),
        ),
        loading: () => ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: 20,
          itemBuilder: (context, index) => Skeletonizer(
            enabled: true,
            child: const ListTile(
              title: const Text('Loading...'),
              subtitle: const Text('Loading...'),
            ),
          )
        ),
        error: (_, __) => ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: 20,
          itemBuilder: (context, index) => Skeletonizer(
            enabled: true,
            child: ListTile(
              title: Text('Loading...'),
              subtitle: Text('Loading...'),
            ),
          ),
        ),
      ),
    );
  }
}
