import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'audio_handler.dart';
import "package:youtube_explode_dart/youtube_explode_dart.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../helpers/platform_utils.dart';
import '../../helpers/service_locator.dart';

import '../data/fetched_data_provider.dart';
import '../data/info_provider.dart';
import '../data/playlist_provider.dart';
import '../data/preferences_provider.dart';

import '../../types/song.dart';
import '../../types/searchresult.dart';
import '../../types/queueitem.dart';
import '../../helpers/miller_shuffle.dart';

part 'player.g.dart';
part 'player.freezed.dart';

class _CachedYoutubeUrl {
  final String url;
  final DateTime timestamp;
  final DateTime lastAccessed;

  _CachedYoutubeUrl({
    required this.url,
    required this.timestamp,
    DateTime? lastAccessed,
  }) : lastAccessed = lastAccessed ?? DateTime.now();

  bool get isValid {
    final now = DateTime.now();
    return now.difference(timestamp) < const Duration(hours: 1);
  }

  Map<String, dynamic> toJson() => {
        'url': url,
        'timestamp': timestamp.toIso8601String(),
        'lastAccessed': lastAccessed.toIso8601String(),
      };

  factory _CachedYoutubeUrl.fromJson(Map<String, dynamic> json) {
    return _CachedYoutubeUrl(
      url: json['url'],
      timestamp: DateTime.parse(json['timestamp']),
      lastAccessed: DateTime.parse(json['lastAccessed']),
    );
  }
}

@freezed
class PlayerInfo with _$PlayerInfo {
  factory PlayerInfo({
    required String id,
    required String artistId,
    required String albumId,
    required String displayName,
    required String artistDisplayName,
    required String albumDisplayName,
    required String imageUrl,
    required int duration,
    required int position,
    required bool isPlaying,
    required List<QueueItem> queue,
    required int currentIndex,
    required bool shuffle,
    required bool loop,
    required bool thinking,
    required double volume,
  }) = _PlayerInfo;

  factory PlayerInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayerInfoFromJson(json);
}

@riverpod
class Player extends _$Player {
  static final Map<String, _CachedYoutubeUrl> _youtubeCache = {};
  static const int _maxCacheSize = 100;
  static const Duration _cacheDuration = Duration(hours: 1);

  late MyAudioHandler _audioHandler;
  YoutubeExplode yt = YoutubeExplode();
  PreferencesProvider p = ServiceLocator().get<PreferencesProvider>();
  late final SharedPreferences _sp;
  bool _isInit = false;
  List<QueueItem> _queue = [];
  List<QueueItem> queue = [];
  final String backendUrl = "https://eatthecow.mooo.com:3030";
  bool paused = false;
  bool needInteraction = false;
  int needSeekTo = 0;

  String? lastSavedSongId;
  String? _lastPlayedSongId;
  int _lastKnownDuration = 0;

  static const String _globalVolumeKey = 'global_player_volume';
  static const String _songVolumesKey = 'song_volume_settings';
  Map<String, double> _songVolumes = {};
  double _globalVolume = 1.0;
  bool _isRestoringVolume = false;

  Future<void> _loadYoutubeCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheString = prefs.getString('youtube_cache');
    if (cacheString != null) {
      final cacheData = jsonDecode(cacheString) as Map<String, dynamic>;
      cacheData.forEach((key, value) {
        _youtubeCache[key] = _CachedYoutubeUrl.fromJson(value);
      });
    }
  }

  Future<void> _persistYoutubeCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheData =
        _youtubeCache.map((key, value) => MapEntry(key, value.toJson()));
    await prefs.setString('youtube_cache', jsonEncode(cacheData));
  }

  void _cleanYoutubeCache() {
    _youtubeCache.removeWhere((key, value) => !value.isValid);
  }

  void _removeLeastRecentlyUsedYoutubeUrl() {
    if (_youtubeCache.isEmpty) return;

    var oldestKey = _youtubeCache.entries.reduce((a, b) {
      return a.value.lastAccessed.isBefore(b.value.lastAccessed) ? a : b;
    }).key;

    _youtubeCache.remove(oldestKey);
  }

  @override
  PlayerInfo build() {
    print("Playerinfo: New playerinfo");
    ServiceLocator().register<Player>(this);
    return PlayerInfo(
        id: 'empty',
        artistId: 'empty',
        albumId: 'empty',
        displayName: '',
        artistDisplayName: '',
        albumDisplayName: '',
        imageUrl: '',
        duration: 0,
        position: 0,
        isPlaying: false,
        queue: [],
        currentIndex: -1,
        loop: true,
        shuffle: false,
        thinking: false,
        volume: 1.0);
  }


  Future<void> init() async {
    if (_isInit) return;
    _isInit = true;
    _sp = await SharedPreferences.getInstance();
    await _loadYoutubeCache();
    await _loadVolumeSettings();
    print("Playerinfo: init");

    // Initialize audio service
    _audioHandler = ServiceLocator().get<MyAudioHandler>();

    // Set up position tracking
    _audioHandler.positionNotifier.addListener(() {
      final d = _audioHandler.positionNotifier.value;
      state = state.copyWith(position: d.inMilliseconds);
    });

    // Set up duration tracking
    _audioHandler.durationNotifier.addListener(() {
      final duration = _audioHandler.durationNotifier.value;
      state = state.copyWith(
          duration: duration.inMilliseconds ~/
              (!PlatformUtils.isWeb &&
                      (PlatformUtils.isIOS || PlatformUtils.isMacOS) &&
                      false
                  ? 2
                  : 1));
    });

    // REMOVE the playbackState listener that handles completion
    // and ADD this new completion handler
    _audioHandler.completedNotifier.addListener(() {
      if (_audioHandler.completedNotifier.value && !state.thinking) {
        _handleTrackCompletion();
      }
    });

    // Use playbackState for state updates (not for completion)
    _audioHandler.playbackState.listen((PlaybackState playbackState) {
      // Update thinking state based on processing state
      if (playbackState.processingState == AudioProcessingState.buffering) {
        if (!state.thinking) {
          state = state.copyWith(thinking: true);
        }
      } else if (playbackState.processingState == AudioProcessingState.ready) {
        if (state.thinking) {
          state = state.copyWith(thinking: false);
        }
      }
      // Note: completion is now handled by completedNotifier
    });

    _audioHandler.loadingNotifier.addListener(() {
      state = state.copyWith(thinking: _audioHandler.loadingNotifier.value);
    });

    // Make sure we update the playing state from the audio handler
    _audioHandler.playingNotifier.addListener(() {
      state = state.copyWith(isPlaying: _audioHandler.playingNotifier.value);
    });

    if (_sp.containsKey("playerinfo")) {
      try {
        var i = PlayerInfo.fromJson(jsonDecode(_sp.getString("playerinfo")!));
        print("Loading persisted playerinfo for song: ${i.displayName}");

        // Verify we have a valid queue and current index
        if (i.queue.isEmpty ||
            i.currentIndex < 0 ||
            i.currentIndex >= i.queue.length) {
          print("Persisted state has invalid queue or index - resetting");
          state = state.copyWith(
              queue: i.queue, currentIndex: i.queue.isEmpty ? -1 : 0);
        } else {
          // Save the position we need to restore
          needSeekTo = i.position;
          lastSavedSongId = i.id;

          // Update state with persisted info
          state = i;

          // Setup for autoplay if needed
          needInteraction = true;

          if (!PlatformUtils.isWeb && p.autoResume) {
            // Give a slight delay to ensure initialization is complete
            Future.delayed(Duration(milliseconds: 800), () async {
              print(
                  "Auto-resuming playback of: ${i.queue[i.currentIndex].displayName}");
              print("Audio URL: ${i.queue[i.currentIndex].audioUrl}");
              await playQueueItem(i.queue[i.currentIndex]);
            });
          } else {
            print("Auto-resume disabled");
          }
        }
      } catch (e) {
        print("Error restoring player state: $e");
        // If there's an error, use the default state
      }
    }
  }
  void _handleTrackCompletion() {
    // Save the current duration for potential looping
    if (state.duration > 0) {
      _lastKnownDuration = state.duration;
    }

    _reportSongAsRecentlyPlayed(state.id);

    print("Player: Handling track completion");

    // Use a microtask to avoid immediate execution during state transition
    Future.microtask(() async {
      // This logic was previously in the playbackState listener
      if (canNext) {
        print("Moving to next track in queue");
        paused = false;
        await next();
      } else if (state.loop && state.queue.isNotEmpty) {
        print("Looping back to first track");
        // Save the current song ID before looping
        _lastPlayedSongId = state.id;
        await skipToItem(0);

        // After skipping, if we have a known duration and the current one is zero,
        // restore it (this handles the single-track loop case)
        if (_lastPlayedSongId == state.id &&
            _lastKnownDuration > 0 &&
            state.duration == 0) {

          print("Post-loop duration restoration: $_lastKnownDuration ms");
          state = state.copyWith(duration: _lastKnownDuration);
        }
      }
    });
  }

  void _reportSongAsRecentlyPlayed(String songId) {
    // Skip if this is the same song we just reported or if ID is invalid
    if (songId == 'empty' ||
        songId.isEmpty) {
      // print("PlayerProvider@_report...RecentlyPlayed:308 - songId is not worth saving: $songId");
      return;
    }

    // Report the song as recently played
    print("Reporting song as recently played: $songId");
    ref.read(addRecentlyPlayedProvider(songId).future).then((success) {
      if (success) {
        // print("PlayerProvider@_report...RecentlyPlayed:316 - Successfully added to recently played: $songId");
        ref.refresh(fetchRecentlyPlayedProvider);
        ref.refresh(fetchLandingRecentlyPlayedProvider);
        // print("PlayerProvider@_report...RecentlyPlayed:319 - Refreshed recentlyPlayed providers");
      } else {
        // print("PlayerProvider@_report...RecentlyPlayed:321 - Failed to add to recently played: $songId");
      }
    }).catchError((error) {
      // print("PlayerProvider@_report...RecentlyPlayed:324 - Error adding to recently played: $error");
    });
  }

  Future<void> _loadVolumeSettings() async {
    // Load global volume
    _globalVolume = _sp.getDouble(_globalVolumeKey) ?? 1.0;

    // Load per-song volumes
    final songVolumesJson = _sp.getString(_songVolumesKey);
    if (songVolumesJson != null) {
      try {
        final Map<String, dynamic> volumesMap = jsonDecode(songVolumesJson);
        _songVolumes = volumesMap
            .map((key, value) => MapEntry(key, (value as num).toDouble()));
      } catch (e) {
        print("Error loading song volumes: $e");
        _songVolumes = {};
      }
    }

    print(
        "Loaded global volume: $_globalVolume and ${_songVolumes.length} song-specific volumes");
  }

  // Save all volume settings
  Future<void> _saveVolumeSettings() async {
    // Save global volume
    await _sp.setDouble(_globalVolumeKey, _globalVolume);

    // Save per-song volumes (limit to most recent 100 songs)
    if (_songVolumes.length > 100) {
      // Sort by keys and keep only the most recent 100
      final sortedKeys = _songVolumes.keys.toList()
        ..sort((a, b) => b.compareTo(a)); // Assuming newer IDs are "greater"

      final keysToRemove = sortedKeys.sublist(100);
      for (final key in keysToRemove) {
        _songVolumes.remove(key);
      }
    }

    await _sp.setString(_songVolumesKey, jsonEncode(_songVolumes));
    print(
        "Saved volume settings: global=$_globalVolume, song-specific=${_songVolumes.length}");
  }

  // Get the appropriate volume for the current song
  double _getCurrentSongVolume() {
    if (state.id == 'empty' || state.id.isEmpty) {
      return _globalVolume;
    }

    return _songVolumes[state.id] ?? _globalVolume;
  }

  // Apply the current volume to the audio player
  Future<void> _applyCurrentVolume() async {
    final volume = _getCurrentSongVolume();
    await _audioHandler.setVolume(volume);

    // Only update state if we're not in the middle of a restore operation
    if (!_isRestoringVolume) {
      state = state.copyWith(volume: volume);
    }
  }

  // Public volume control methods
  Future<void> setVolume(double volume) async {
    volume = volume.clamp(0.0, 1.0);

    // If we have a valid song ID, save as song-specific volume
    if (state.id != 'empty' && state.id.isNotEmpty) {
      _songVolumes[state.id] = volume;
    }

    // Also update the global volume
    _globalVolume = volume;

    // Apply to audio player
    await _audioHandler.setVolume(volume);
    state = state.copyWith(volume: volume);

    // Save settings
    await _saveVolumeSettings();
  }

  Future<void> increaseVolume([double step = 0.1]) async {
    final newVolume = (state.volume + step).clamp(0.0, 1.0);
    await setVolume(newVolume);
  }

  Future<void> decreaseVolume([double step = 0.1]) async {
    final newVolume = (state.volume - step).clamp(0.0, 1.0);
    await setVolume(newVolume);
  }

  Future<void> toggleMute() async {
    if (state.volume > 0) {
      // Store current volume in a preference so we can restore it
      final currentVolume = state.volume;
      await _sp.setDouble('last_volume_before_mute', currentVolume);
      await setVolume(0);
    } else {
      // Restore previous volume, or use global volume as a default
      final previousVolume =
          _sp.getDouble('last_volume_before_mute') ?? _globalVolume;
      await setVolume(previousVolume);
    }
  }

  // Update the state when song changes
  Future<void> _updateSongStateWithVolume() async {
    _isRestoringVolume = true;
    final songVolume = _getCurrentSongVolume();

    // Apply volume to audio player
    await _audioHandler.setVolume(songVolume);

    // Update state
    state = state.copyWith(volume: songVolume);
    _isRestoringVolume = false;

    print("Set volume to $songVolume for song: ${state.id}");
  }

  Future<void> seek(Duration d) async {
    await _audioHandler.seek(d);
  }

  Future<void> seekForward(int milliseconds) async {
    await _audioHandler.seek(Duration(milliseconds: state.position) +
        Duration(milliseconds: milliseconds));
  }

  Future<void> seekBackward(int milliseconds) async {
    Duration computed = Duration(milliseconds: state.position) -
        Duration(milliseconds: milliseconds);
    await _audioHandler.seek(computed.isNegative ? Duration.zero : computed);
  }

  Future<void> stop() async {
    await _audioHandler.stop();
    state = state.copyWith(isPlaying: false);
    await setQueue([]);
  }

  Future<void> play() async {
    if (needInteraction) {
      print("Play called, but need interaction");
      await playQueueItem(state.queue[state.currentIndex]);
      await _audioHandler.play();
      state = state.copyWith(isPlaying: true);
      return;
    }
    await _audioHandler.play();
    state = state.copyWith(isPlaying: true);
  }

  Future<void> pause() async {
    await _audioHandler.pause();
    state = state.copyWith(isPlaying: false);
  }

  Future<void> toggle() async {
    if (state.isPlaying) {
      await pause();
    } else {
      await play();
    }
    setPlaying(state.isPlaying);
  }

  Future<void> next() async {
    // Save the current song ID and duration before skipping
    _lastPlayedSongId = state.id;
    if (state.duration > 0) {
      _lastKnownDuration = state.duration;
    }

    await skip(1);

    // If we just looped back to the first song in a single-song queue,
    // make sure the duration is preserved
    if (state.queue.length == 1 &&
        state.loop &&
        _lastPlayedSongId == state.id &&
        _lastKnownDuration > 0 &&
        state.duration == 0) {
      print(
          "Preserving duration for repeated single track: $_lastKnownDuration ms");
      state = state.copyWith(duration: _lastKnownDuration);
    }
  }

  Future<void> previous() async {
    await skip(-1);
  }

  void setPlaying(bool playing) async {
    state = state.copyWith(isPlaying: playing);
    paused = !playing;
  }

  Future<void> setQueue(List<QueueItem> q) async {
    // Ensure all queue items have properly formatted URLs
    var validatedQueue = q.map((item) {
      if (item.audioUrl.isNotEmpty && !item.audioUrl.contains(':')) {
        // Add the not_fetched prefix if URL doesn't have a scheme
        print("setQueue: aUrl \"${item.audioUrl}l\"");
        return item.copyWith(audioUrl: "not_fetched:${item.audioUrl}");
      }
      return item;
    }).toList();

    state = state.copyWith(queue: validatedQueue);

    // Update audio service queue
    await _audioHandler.updateQueue(validatedQueue
        .map((item) => MediaItem(
              id: item.id,
              title: item.displayName,
              album: item.albumName,
              artist: item.artistName,
              artUri: Uri.parse(item.imageUrl),
            ))
        .toList());
  }

  Future<void> skip(int num) async {
    // Save current song info for potential loop detection
    _lastPlayedSongId = state.id;
    if (state.duration > 0) {
      _lastKnownDuration = state.duration;
    }

    int newIndex = skipDex(num);
    print("Skipping to index $newIndex (from ${state.currentIndex})");
    await skipToItem(newIndex);

    // Check if we've looped a single song
    if (state.queue.length == 1 &&
        _lastPlayedSongId == state.id &&
        _lastKnownDuration > 0 &&
        state.duration == 0) {
      print(
          "Preserving duration after single-track loop: $_lastKnownDuration ms");
      state = state.copyWith(duration: _lastKnownDuration);
    }
  }

  int skipDex(int num) {
    int newIndex = state.currentIndex + num;
    print("Index would be $newIndex (from ${state.currentIndex})");

    // Handle looping around the queue
    if (newIndex < 0) {
      print("Index would be < 0, looping");
      return state.loop ? state.queue.length - 1 : 0;
    } else if (newIndex >= state.queue.length) {
      print("Index would be >= queue length, looping");
      return state.loop ? 0 : state.queue.length - 1;
    } else {
      print("this index is fine ( code 218 )");
      return newIndex;
    }
  }

  Future<void> skipToItem(int i) async {
    if (i >= 0 && i < state.queue.length) {
      print("Skipping to index $i");
      state = state.copyWith(
        currentIndex: i,
        displayName: state.queue[i].displayName,
        artistDisplayName: state.queue[i].artistName,
        albumDisplayName: state.queue[i].albumName,
        id: state.queue[i].id,
        artistId: state.queue[i].artistId,
        albumId: state.queue[i].albumId,
        imageUrl: state.queue[i].imageUrl,
        isPlaying: false,
        duration: 0,
        position: 0,
      );
      _reportSongAsRecentlyPlayed(state.queue[i].id);
      await _updateSongStateWithVolume();
      await playQueueItem(state.queue[i]);

      // Update current media item in audio service
      await _audioHandler.skipToQueueItem(i);
      print("Audio service now at index $i");
    } else {
      print(
          "Skipping to $i, but queue has max index of ${state.queue.length - 1}");
    }
  }

  Future<void> setSong(String id) async {
    ref.read(findSongProvider(id).future).then((songObject) async {
      await setQueue([songObject.toQueueItem()]);
      state = state.copyWith(shuffle: false);
      await skipToItem(0);
    });
  }

  Future<void> setItem(QueueItem i) async {
    state = state.copyWith(
      id: i.id,
      artistId: i.artistId,
      albumId: i.albumId,
      displayName: i.displayName,
      albumDisplayName: i.albumName,
      artistDisplayName: i.artistName,
      imageUrl: i.imageUrl,
      queue: [i],
      isPlaying: true,
    );
    await _updateSongStateWithVolume();
    await setQueue([i]);
    state = state.copyWith(shuffle: false);
    await skipToItem(0);
  }

  Future<void> setAlbum(String id) async {
    ref.read(findSongsByAlbumProvider(id).future).then((songs) async {
      List<QueueItem> newQueue = songs.map((s) => s.toQueueItem()).toList();
      await setQueue(newQueue);
      state = state.copyWith(shuffle: false);
      await skipToItem(0);
    });
  }

  Future<void> addAlbumToQueue(String id) async {
    ref.read(findSongsByAlbumProvider(id).future).then((songs) async {
      var newQueue = [...state.queue, ...songs.map((s) => s.toQueueItem())];
      await setQueue(newQueue);
    });
  }

  Future<void> setArtist(String id) async {
    ref.read(findSongsByArtistProvider(id).future).then((songs) async {
      var newQueue = songs.map((s) => s.toQueueItem()).toList();
      await setQueue(newQueue);
      state = state.copyWith(shuffle: false);
      await skipToItem(0);
    });
  }

  Future<void> addArtistToQueue(String id) async {
    ref.read(findSongsByArtistProvider(id).future).then((songs) async {
      var newQueue = [...state.queue, ...songs.map((s) => s.toQueueItem())];
      await setQueue(newQueue);
    });
  }

  Future<void> setPlaylist(String id) async {
    ref.read(findSongsByPlaylistProvider(id).future).then((songs) async {
      var newQueue = songs.map((s) => s.toQueueItem()).toList();
      await setQueue(newQueue);
      state = state.copyWith(shuffle: false);
      await skipToItem(0);
    });
  }

  Future<void> addPlaylistToQueue(String id) async {
    ref.read(findSongsByPlaylistProvider(id).future).then((songs) async {
      var newQueue = [...state.queue, ...songs.map((s) => s.toQueueItem())];
      await setQueue(newQueue);
    });
  }

  Future<void> addToQueue(Song song) async {
    var newQueue = [...state.queue, song.toQueueItem()];
    await setQueue(newQueue);
  }

  Future<void> addIdToQueue(String id) async {
    ref.read(findSongProvider(id).future).then((songObject) async {
      var newQueue = [...state.queue, songObject.toQueueItem()];
      await setQueue(newQueue);
    });
  }

  Future<void> clearQueue() async {
    await _audioHandler.stop();
    await setQueue([]);
    state = state.copyWith(currentIndex: 0);
  }

  Future<void> clear() async {
    await clearQueue();
    state = state.copyWith(
      id: "",
      albumId: "",
      artistId: "",
      displayName: "",
      albumDisplayName: "",
      artistDisplayName: "",
      imageUrl: "",
      position: 0,
      duration: 0,
    );
  }

  Future<void> moveQueueItem(int oldIndex, int newIndex) async {
    List<QueueItem> queue = [...state.queue];
    print("Queue item going from spot $oldIndex to $newIndex");
    if(newIndex < 0){
      print("New index is being snapped to 0");
      newIndex = 0;
    }
    QueueItem s = queue.removeAt(oldIndex);
    queue.insert(newIndex, s);
    await setQueue(queue);
    if(oldIndex == state.currentIndex){
      print("PlayerProvider@moveQueueItem:738 - Playing queue item was moved; updating currentIndex accordingly");
      state = state.copyWith(currentIndex: newIndex);
    }
  }

  Future<void> removeQueueItem(int index, {bool skip = true}) async {
    List<QueueItem> queue = [...state.queue];
    queue.removeAt(index);
      await setQueue(queue);
    if(state.currentIndex == index && skip){
      await this.skip(0);
      // state = state.copyWith(currentIndex: skipDex(1));
    }
  }

  Future<void> playYoutubeId(String id) async {
    needInteraction = false;
    state = state.copyWith(position: 0);
    print("Playing youtube $id");
    state = state.copyWith(thinking: true);
    await _audioHandler.stop();

    // Get a direct playable URL
    var url = await fetchYTVideo(id);
    print("Got YouTube URL: $url");

    // Play the audio using AudioHandler with the direct URL
    await _audioHandler.playUrl(url);

    // Update media item in audio service
    _audioHandler.mediaItem.add(MediaItem(
      id: id,
      title: "YouTube Video",
      artUri: Uri.parse("https://img.youtube.com/vi/$id/0.jpg"),
    ));

    state = state.copyWith(thinking: false);
  }

  Future<void> playFindResult(FindResult result) async {
    needInteraction = false;
    state = state.copyWith(position: 0);
    await playQueueItem(QueueItem(
      type: "found-song",
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      albumId: "found",
      artistId: "found",
      displayName: result.songs[0].title,
      artistName: result.artist,
      albumName: result.album,
      duration: 0,
      imageUrl: "https://i.imgur.com/0fU7kZG.jpg",
      audioUrl: result.songs[0].url,
    ));
  }

  Future<void> shuffle() async {
    List<QueueItem> unshuffled = [...state.queue];
    List<QueueItem> shuffled = [];

    while (unshuffled.isNotEmpty) {
      int index = superShuffle(shuffled.length,
          DateTime.now().millisecondsSinceEpoch, unshuffled.length);
      shuffled.add(unshuffled.removeAt(index));
    }

    await setQueue(shuffled);
    state = state.copyWith(shuffle: true);
    await skipToItem(0);
  }

  Future<void> loop(bool enable) async {
    state = state.copyWith(loop: enable);
    // Use audio handler to set looping
    await _audioHandler.setLooping(enable);
  }

  Future<void> playQueueItem(QueueItem item) async {
    try {
      state = state.copyWith(thinking: true);
      await _audioHandler.stop();
      var url = item.audioUrl;

      print(
          "Playing queue item: ${item.displayName} with URL type: ${url.contains(':') ? url.split(':').first : 'unknown'}");

      // Save if this is the current persisted item for seeking logic
      bool isRestoredItem = needInteraction && item.id == lastSavedSongId;
      int positionToRestore = isRestoredItem ? needSeekTo : 0;

      if (isRestoredItem) {
        print(
            "This is the restored item with saved position: ${positionToRestore}ms");
      }

      // Extract the actual URL to play
      String finalUrl = "";
      try {
        finalUrl = await getAudioUrl(url);
        print("finUrl $finalUrl");

        // If we got a prefetched URL, extract the actual URL
        if (finalUrl.startsWith("prefetched:")) {
          finalUrl =
              RegExp(r'\${{%(.*)%}}\$(.*)').firstMatch(finalUrl)?.group(2) ??
                  "";
        }

        if (finalUrl.isEmpty) {
          throw Exception("Failed to get a playable URL");
        }
      } catch (e) {
        print("Error getting audio URL: $e");
        throw Exception("Failed to get audio URL: $e");
      }

      print("Playing final URL: $finalUrl");

      // Update media item in audio service BEFORE starting playback
      _audioHandler.mediaItem.add(MediaItem(
        id: item.id,
        title: item.displayName,
        album: item.albumName,
        artist: item.artistName,
        artUri: Uri.parse(item.imageUrl),
        duration:
            state.duration > 0 ? Duration(milliseconds: state.duration) : null,
      ));

      // Play audio with AudioHandler
      await _audioHandler.playUrl(finalUrl);

      // Update state to playing after playback starts
      state = state.copyWith(
        thinking: false,
        isPlaying: true,
      );

      // Handle seeking for restored state
      if (isRestoredItem && positionToRestore > 0) {
        print("Seeking to saved position: ${positionToRestore}ms");
        // Delay slightly to ensure audio is loaded
        await Future.delayed(Duration(milliseconds: 300));
        await seek(Duration(milliseconds: positionToRestore));
        needInteraction = false;
        needSeekTo = 0;
      } else {
        needInteraction = false;
      }

      // Rest of your prefetching code...
    } catch (e, stackTrace) {
      print("Error in playQueueItem: $e");
      print(stackTrace);
      state = state.copyWith(thinking: false);
      // Try to recover by stopping completely
      await _audioHandler.stop();
    }
  }

  Future<String> fetchYTVideo(String id) async {
    _cleanYoutubeCache();

    // Check cache first
    if (_youtubeCache.containsKey(id)) {
      var cached = _youtubeCache[id]!;
      if (cached.isValid) {
        print("Youtube: using cached URL for $id");
        // Update last accessed time
        _youtubeCache[id] = _CachedYoutubeUrl(
          url: cached.url,
          timestamp: cached.timestamp,
          lastAccessed: DateTime.now(),
        );
        return cached.url;
      } else {
        _youtubeCache.remove(id);
      }
    }

    // If cache is full, remove least recently used
    if (_youtubeCache.length >= _maxCacheSize) {
      _removeLeastRecentlyUsedYoutubeUrl();
    }

    print("Youtube: fetching video $id");
    var media = await yt.videos.streamsClient.getManifest(id);
    var streamInfo = media.audioOnly
        .where((e) =>
            e.audioCodec != 'opus' && e.container != StreamContainer.webM)
        .withHighestBitrate();
    var url = streamInfo.url.toString();

    // Cache the result
    _youtubeCache[id] = _CachedYoutubeUrl(
      url: url,
      timestamp: DateTime.now(),
    );

    // Persist cache
    await _persistYoutubeCache();

    return url;
  }

  Future<String> getAudioUrl(String audioUrl) async {
    // Check if audioUrl is empty or invalid
    if (audioUrl.isEmpty) {
      print("Warning: Empty audioUrl passed to getAudioUrl");
      return "";
    }

    // Check if URL contains a colon (proper formatting)
    if (!audioUrl.contains(":")) {
      print(
          "Warning: Malformed audioUrl: $audioUrl (adding 'not_fetched:' prefix)");
      // If it doesn't have a scheme, treat it as a not_fetched URL
      audioUrl = "not_fetched:$audioUrl";
    }

    var audioUrlParts = audioUrl.split(":");
    var type = audioUrlParts.first;
    var data = audioUrlParts.sublist(1).join(":");

    print("Processing audio URL of type: $type with data: $data");

    switch (type) {
      case "http":
      case "https":
        return audioUrl;
      case "youtube":
        // Store in prefetched format for internal use
        String actualYoutubeUrl = await fetchYTVideo(data);
        return "prefetched:\${{%$audioUrl%}}\$$actualYoutubeUrl";
      case "not_fetched":
        // This is a URL that needs to be fetched from your backend
        print("Fetching not_fetched URL: $data");
        // Replace with your actual backend URL fetch logic
        // For example:
        if (data.contains("youtube.com") || data.contains("youtu.be")) {
          // Extract YouTube ID from the URL
          var videoId = extractYoutubeId(data);
          if (videoId.isNotEmpty) {
            return await getAudioUrl("youtube:$videoId");
          }
        }
        return data; // Return the raw URL if we can't process it
      case "blank":
      case "scratch":
      case "custom":
        return "";
      case "prefetched":
        // Extract the direct URL when needed
        return RegExp(r'\${{%(.*)%}}\$(.*)').firstMatch(audioUrl)?.group(2) ??
            "";
      default:
        print("Unknown audio URL type: $type");
        return audioUrl; // Return the original URL as a fallback
    }
  }

  // Helper to extract YouTube ID
  String extractYoutubeId(String url) {
    if (url.contains('youtu.be/')) {
      return url.split('youtu.be/')[1].split('?')[0];
    } else if (url.contains('youtube.com/watch')) {
      final uri = Uri.parse(url);
      return uri.queryParameters['v'] ?? '';
    } else if (url.contains('youtube.com/embed/')) {
      return url.split('youtube.com/embed/')[1].split('?')[0];
    }
    return '';
  }

  get canNext {
    print("Checking if can next");
    // Check if we're at the end of the queue and should loop
    if (state.currentIndex + 1 >= state.queue.length && state.loop) {
      if (p.shuffleOnLoop) {
        print("Shuffling on loop");
        shuffle();
        return true;
      }
      // Return true to indicate we should loop back to first item
      return true;
    }
    // Normal case - we have more items in the queue
    return state.currentIndex + 1 < state.queue.length;
  }

  Future<void> persistPlayerState() async {
    if (_sp != null &&
        p.persistInfo &&
        state.id != 'empty' &&
        state.queue.isNotEmpty) {
      print(
          "Persistng player state for: ${state.displayName} at position ${state.position}ms");

      // Create a copy of the state with the latest position
      PlayerInfo stateToPersist = state.copyWith(isPlaying: false);
      await _saveVolumeSettings();

      // Save to SharedPreferences
      await _sp.setString("playerinfo", jsonEncode(stateToPersist.toJson()));
      print("Player state saved successfully");
    } else {
      print(
          "Not persisting player state: persistInfo=${p.persistInfo}, id=${state.id}, queueEmpty=${state.queue.isEmpty}");
    }
  }
}
