import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/data/fetched_data_provider.dart';
import 'providers/data/playlist_provider.dart';
import 'providers/services/player.dart';
import 'providers/data/info_provider.dart';

void refreshChanges(WidgetRef ref) {
  ref.read(playerProvider.notifier).clear();
  ref.refresh(fetchSongsProvider(ignore: true));
  ref.refresh(fetchAlbumsProvider(ignore: true));
  ref.refresh(fetchAlbumsProvider(ignore: true));
  ref.refresh(fetchSongsProvider(ignore: false));
  ref.refresh(fetchAlbumsProvider(ignore: false));
  ref.refresh(fetchAlbumsProvider(ignore: false));
  ref.refresh(fetchPlaylistsProvider(editable: false));
  ref.refresh(fetchPlaylistsProvider(editable: true));
  ref.refresh(fetchRecentlyPlayedProvider);
}
