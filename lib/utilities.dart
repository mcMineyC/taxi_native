import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/data/fetched_data_provider.dart';
import 'providers/data/playlist_provider.dart';
import 'providers/data/new_provider.dart';
import 'providers/services/player.dart';
import 'providers/data/info_provider.dart';

void refreshChanges(WidgetRef ref) {
  ref.read(playerProvider.notifier).clear();
  ref.refresh(fetchSongsProvider(ignore: true));
  ref.refresh(fetchAlbumsProvider(ignore: true));
  ref.refresh(fetchArtistsProvider(ignore: true));
  ref.refresh(fetchSongsProvider(ignore: false));
  ref.refresh(fetchAlbumsProvider(ignore: false));
  ref.refresh(fetchArtistsProvider(ignore: false));
  ref.refresh(fetchPlaylistsProvider(editable: false));
  ref.refresh(fetchPlaylistsProvider(editable: true));
  ref.refresh(fetchPlaylistsProvider(ignore: true));
  ref.refresh(fetchPlaylistsProvider(ignore: false));
  ref.refresh(fetchNewPlaylistsProvider);
  ref.refresh(fetchNewSongsProvider);
  ref.refresh(fetchRecentlyPlayedProvider);
}

void refreshLibrary(WidgetRef ref) {
  ref.refresh(fetchSongsProvider(ignore: true));
  ref.refresh(fetchAlbumsProvider(ignore: true));
  ref.refresh(fetchArtistsProvider(ignore: true));
  ref.refresh(fetchSongsProvider(ignore: false));
  ref.refresh(fetchAlbumsProvider(ignore: false));
  ref.refresh(fetchArtistsProvider(ignore: false));
  ref.refresh(fetchPlaylistsProvider(editable: false));
  ref.refresh(fetchPlaylistsProvider(editable: true));
  ref.refresh(fetchPlaylistsProvider(ignore: true));
  ref.refresh(fetchPlaylistsProvider(ignore: false));
  ref.refresh(fetchNewPlaylistsProvider);
  ref.refresh(fetchNewSongsProvider);
  ref.refresh(fetchRecentlyPlayedProvider);
}

void logout(WidgetRef ref) {
  ref.invalidate(fetchSongsProvider(ignore: true));
  ref.invalidate(fetchAlbumsProvider(ignore: true));
  ref.invalidate(fetchArtistsProvider(ignore: true));
  ref.invalidate(fetchSongsProvider(ignore: false));
  ref.invalidate(fetchAlbumsProvider(ignore: false));
  ref.invalidate(fetchArtistsProvider(ignore: false));
  ref.invalidate(fetchPlaylistsProvider(editable: false));
  ref.invalidate(fetchPlaylistsProvider(editable: true));
  ref.invalidate(fetchPlaylistsProvider(ignore: true));
  ref.invalidate(fetchPlaylistsProvider(ignore: false));
  ref.invalidate(fetchNewPlaylistsProvider);
  ref.invalidate(fetchNewSongsProvider);
  ref.invalidate(fetchRecentlyPlayedProvider);
}
