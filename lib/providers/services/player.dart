import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
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
  }) = _PlayerInfo;

  factory PlayerInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayerInfoFromJson(json);
}

@riverpod
class Player extends _$Player {
  static final Map<String, _CachedYoutubeUrl> _youtubeCache = {};
  static const int _maxCacheSize = 100;
  static const Duration _cacheDuration = Duration(hours: 1);

  late AudioPlayer _audioPlayer;
  late AudioHandler _audioHandler;
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
    );
  }

  Future<void> init() async {
    if (_isInit) return;
    _isInit = true;
    _sp = await SharedPreferences.getInstance();
    await _loadYoutubeCache();
    print("Playerinfo: init");

    // Initialize audio service
    _audioHandler = await AudioService.init(
      builder: () => MyAudioHandler(),
      config: AudioServiceConfig(
        androidNotificationChannelId: 'com.myapp.audio',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
      ),
    );

    // Initialize AudioPlayer
    _audioPlayer = AudioPlayer();

    // Set up position tracking
    _audioPlayer.onPositionChanged.listen((Duration d) {
      state = state.copyWith(position: d.inMilliseconds);
    });

    // Set up duration tracking
    _audioPlayer.onDurationChanged.listen((Duration d) {
      state = state.copyWith(
          duration: d.inMilliseconds ~/
              (!PlatformUtils.isWeb &&
                      (PlatformUtils.isIOS || PlatformUtils.isMacOS) &&
                      false
                  ? 2
                  : 1));
    });

    // Set up playback state tracking
    _audioPlayer.onPlayerStateChanged.listen((PlayerState playerState) {
      bool isPlaying = playerState == PlayerState.playing;
      state = state.copyWith(isPlaying: isPlaying);

      if (playerState == PlayerState.completed && canNext && !state.thinking) {
        print("Skipping");
        paused = false;
        next();
      }

      if (playerState == PlayerState.playing &&
          needInteraction &&
          lastSavedSongId == state.id) {
        needInteraction = false;
        _audioPlayer.seek(Duration(milliseconds: needSeekTo));
        print("Seeked position to $needSeekTo");
      }
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      if (canNext && !state.thinking) {
        paused = false;
        next();
      }
    });

    if (_sp.containsKey("playerinfo")) {
      var i = PlayerInfo.fromJson(jsonDecode(_sp.getString("playerinfo")!));
      print("Loading persisted playerinfo");
      needSeekTo = i.position;
      lastSavedSongId = i.id;
      state = i;
      needInteraction = true;
      if (!PlatformUtils.isWeb && p.autoResume) {
        await playQueueItem(state.queue[state.currentIndex]);
      }
    }
  }

  void seek(Duration d) {
    _audioPlayer.seek(d);
  }

  void seekForward(int milliseconds) {
    _audioPlayer.seek(Duration(milliseconds: state.position) +
        Duration(milliseconds: milliseconds));
  }

  void seekBackward(int milliseconds) {
    Duration computed = Duration(milliseconds: state.position) -
        Duration(milliseconds: milliseconds);
    _audioPlayer.seek(computed.isNegative ? Duration.zero : computed);
  }

  void stop() {
    _audioPlayer.stop();
    state = state.copyWith(isPlaying: false);
    setQueue([]);
  }

  void play() async {
    if (needInteraction) {
      print("Play called, but need interaction");
      playQueueItem(state.queue[state.currentIndex]);
      await _audioPlayer.resume();
      state = state.copyWith(isPlaying: true);
      return;
    }
    _audioPlayer.resume();
    state = state.copyWith(isPlaying: true);
  }

  void pause() async {
    _audioPlayer.pause();
    state = state.copyWith(isPlaying: false);
  }

  void toggle() async {
    if (state.isPlaying) {
      pause();
    } else {
      play();
    }
    setPlaying(state.isPlaying);
  }

  void next() async {
    skip(1);
  }

  void previous() async {
    skip(-1);
  }

  void setPlaying(bool playing) async {
    state = state.copyWith(isPlaying: playing);
    paused = !playing;
  }

  void setQueue(List<QueueItem> q) {
    state = state.copyWith(queue: q);
    // Update audio service queue
    _audioHandler.updateQueue(q
        .map((item) => MediaItem(
              id: item.id,
              title: item.displayName,
              album: item.albumName,
              artist: item.artistName,
              artUri: Uri.parse(item.imageUrl),
            ))
        .toList());
  }

  void skip(int num) {
    int newIndex = skipDex(num);
    skipToItem(newIndex);
  }

  int skipDex(int num) {
    int newIndex = state.currentIndex + num;
    if (newIndex < 0) {
      return state.queue.length - 1;
    } else if (newIndex > state.queue.length - 1) {
      return 0;
    } else {
      return newIndex;
    }
  }

  void skipToItem(int i) {
    if (i >= 0 && i < state.queue.length) {
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
      playQueueItem(state.queue[i]);

      // Update current media item in audio service
      _audioHandler.skipToQueueItem(i);
    } else {
      print(
          "Skipping to $i, but queue has max index of ${state.queue.length - 1}");
    }
  }

  void setSong(String id) async {
    ref.read(findSongProvider(id).future).then((songObject) async {
      setQueue([songObject.toQueueItem()]);
      state = state.copyWith(shuffle: false);
      skipToItem(0);
    });
  }

  void setItem(QueueItem i) async {
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
    setQueue([i]);
    state = state.copyWith(shuffle: false);
    skipToItem(0);
  }

  void setAlbum(String id) async {
    ref.read(findSongsByAlbumProvider(id).future).then((songs) async {
      List<QueueItem> newQueue = songs.map((s) => s.toQueueItem()).toList();
      setQueue(newQueue);
      state = state.copyWith(shuffle: false);
      skipToItem(0);
    });
  }

  void addAlbumToQueue(String id) async {
    ref.read(findSongsByAlbumProvider(id).future).then((songs) async {
      var newQueue = [...state.queue, ...songs.map((s) => s.toQueueItem())];
      setQueue(newQueue);
    });
  }

  void setArtist(String id) async {
    ref.read(findSongsByArtistProvider(id).future).then((songs) async {
      var newQueue = songs.map((s) => s.toQueueItem()).toList();
      setQueue(newQueue);
      state = state.copyWith(shuffle: false);
      skipToItem(0);
    });
  }

  void addArtistToQueue(String id) async {
    ref.read(findSongsByArtistProvider(id).future).then((songs) async {
      var newQueue = [...state.queue, ...songs.map((s) => s.toQueueItem())];
      state = state.copyWith(queue: newQueue);
    });
  }

  void setPlaylist(String id) async {
    ref.read(findSongsByPlaylistProvider(id).future).then((songs) async {
      var newQueue = songs.map((s) => s.toQueueItem()).toList();
      setQueue(newQueue);
      state = state.copyWith(shuffle: false);
      skipToItem(0);
    });
  }

  void addPlaylistToQueue(String id) async {
    ref.read(findSongsByPlaylistProvider(id).future).then((songs) async {
      var newQueue = [...state.queue, ...songs.map((s) => s.toQueueItem())];
      setQueue(newQueue);
    });
  }

  void addToQueue(Song song) async {
    var newQueue = [...state.queue, song.toQueueItem()];
    setQueue(newQueue);
  }

  void addIdToQueue(String id) async {
    ref.read(findSongProvider(id).future).then((songObject) async {
      var newQueue = [...state.queue, songObject.toQueueItem()];
      setQueue(newQueue);
    });
  }

  void clearQueue() async {
    _audioPlayer.stop();
    setQueue([]);
    state = state.copyWith(currentIndex: 0);
  }

  void clear() {
    clearQueue();
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

  void moveQueueItem(int oldIndex, int newIndex) async {
    List<QueueItem> queue = [...state.queue];
    QueueItem s = queue.removeAt(oldIndex);
    queue.insert(newIndex - 1, s);
    setQueue(queue);
  }

  void playYoutubeId(String id) async {
    needInteraction = false;
    state = state.copyWith(position: 0);
    print("Playing youtube $id");
    state = state.copyWith(thinking: true);
    _audioPlayer.stop();
    var url = await fetchYTVideo(id);

    // Play the audio using AudioPlayers
    await _audioPlayer.play(UrlSource(url));

    // Update media item in audio service
    _audioHandler.mediaItem.add(MediaItem(
      id: id,
      title: "YouTube Video",
      artUri: Uri.parse("https://img.youtube.com/vi/$id/0.jpg"),
    ));

    state = state.copyWith(thinking: false);
  }

  void playFindResult(FindResult result) async {
    needInteraction = false;
    state = state.copyWith(position: 0);
    playQueueItem(QueueItem(
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

    setQueue(shuffled);
    state = state.copyWith(shuffle: true);
    skipToItem(0);
  }

  Future<void> loop(bool enable) async {
    state = state.copyWith(loop: enable);
    if (enable) {
      _audioPlayer.setReleaseMode(ReleaseMode.loop);
    } else {
      _audioPlayer.setReleaseMode(ReleaseMode.release);
    }
  }

  Future<void> playQueueItem(QueueItem item) async {
    state = state.copyWith(thinking: true);
    _audioPlayer.stop();
    var url = item.audioUrl;
    print("audioUrl: $url");
    if (url.split(":").first != "prefetched") {
      if (PlatformUtils.isWeb) return;
      url = await getAudioUrl(url);
    } else {
      url = RegExp(r'\${{%(.*)%}}\$(.*)').firstMatch(url)?.group(2) ?? "";
      if (url.isEmpty)
        throw Exception("Audio url fetch failed: ${item.audioUrl}");
    }
    print("Playing url: $url");

    // Play audio with AudioPlayers
    await _audioPlayer.play(UrlSource(url));

    // Update media item in audio service
    _audioHandler.mediaItem.add(MediaItem(
      id: item.id,
      title: item.displayName,
      album: item.albumName,
      artist: item.artistName,
      artUri: Uri.parse(item.imageUrl),
    ));

    state = state.copyWith(thinking: false);
    if (item.type == "song") {
      if (item.id == "empty") return;
      ref.read(addRecentlyPlayedProvider(item.id).future).then((value) {
        if (value == true) ref.refresh(fetchRecentlyPlayedProvider.future);
      });

      // Prefetch next track
      if (state.queue.length == 1 &&
          state.queue[skipDex(1)].audioUrl.split(":").first == "prefetched") {
        print("Queue is one, returning");
        return;
      }
      var nextUrl = await getAudioUrl(item.audioUrl);
      var nq = state.queue.toList();
      nq[skipDex(1)] = nq[skipDex(1)].copyWith(audioUrl: nextUrl);
      if (state.queue.length > 1) {
        String originalUrl = "";
        if (state.queue[state.currentIndex].audioUrl.split(":").first ==
            "prefetched") {
          originalUrl = RegExp(r'\${{%(.*)%}}\$(.*)')
                  .firstMatch(state.queue[state.currentIndex].audioUrl)
                  ?.group(1) ??
              "";
        } else {
          return;
        }
        print("UNPREPPING: ${state.queue[state.currentIndex].displayName}");
        nq[state.currentIndex] =
            state.queue[state.currentIndex].copyWith(audioUrl: originalUrl);
      }
      print("PREPPED: ${nq[skipDex(1)].displayName}");
      setQueue(nq);
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
    var audioUrlParts = audioUrl.split(":");
    var type = audioUrlParts.first;
    var data = audioUrlParts.sublist(1).join(":");
    switch (type) {
      case "http":
      case "https":
        return audioUrl;
      case "youtube":
        return "prefetched:\${{%$audioUrl%}}\$${await fetchYTVideo(data)}";
      case "blank":
        return "";
      case "scratch":
        return "";
      case "custom":
        return "";
      case "prefetched":
        return RegExp(r'\${{%(.*)%}}\$(.*)').firstMatch(audioUrl)?.group(2) ??
            "";
      default:
        return "";
    }
  }

  get canNext {
    print("Checking if can next");
    if (state.currentIndex + 1 >= state.queue.length &&
        state.loop &&
        p.shuffleOnLoop) {
      print("Shuffling");
      shuffle();
    }
    return (state.currentIndex + 1 >= state.queue.length)
        ? false || state.loop
        : true;
  }
}

// Implementation of AudioHandler for audio_service
class MyAudioHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  MyAudioHandler() {
    _player.onPlayerStateChanged.listen((state) {
      playbackState.add(playbackState.value.copyWith(
        playing: state == PlayerState.playing,
        processingState: _getProcessingState(state),
      ));
    });

    _player.onPositionChanged.listen((position) {
      playbackState.add(playbackState.value.copyWith(
        updatePosition: position,
      ));
    });
  }

  PlaybackState _getProcessingState(PlayerState state) {
    switch (state) {
      case PlayerState.stopped:
        return AudioProcessingState.idle;
      case PlayerState.playing:
        return AudioProcessingState.ready;
      case PlayerState.paused:
        return AudioProcessingState.ready;
      case PlayerState.completed:
        return AudioProcessingState.completed;
      default:
        return AudioProcessingState.idle;
    }
  }

  @override
  Future<void> play() => _player.resume();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() => _player.stop();

  @override
  Future<void> skipToPrevious() => _player.stop();

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < queue.value.length) {
      mediaItem.add(queue.value[index]);
    }
  }
}
