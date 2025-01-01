import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart';
import "package:youtube_explode_dart/youtube_explode_dart.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../platform_utils.dart';
import '../../service_locator.dart';

import '../data/fetched_data_provider.dart';
import '../data/info_provider.dart';
import '../data/playlist_provider.dart';
import '../data/preferences_provider.dart';

import '../../types/song.dart';
import '../../types/searchresult.dart';
import '../../types/queueitem.dart';
import '../../miller_shuffle.dart';

part 'player.g.dart';
part 'player.freezed.dart';

@freezed
class PlayerInfo with _$PlayerInfo {
  factory PlayerInfo({
    required String id,
    required String artistId,
    required String albumId,
    required String displayName,
    required String artistDisplayName,
    required String albumDisplayName,
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
  AudioPlayer player = AudioPlayer();
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
    print("Playerinfo: init");
    if (!PlatformUtils.isWeb &&
        (PlatformUtils.isLinux || PlatformUtils.isWindows))
      JustAudioMediaKit.ensureInitialized();
    player.positionStream.listen((Duration d) {
      state = state.copyWith(position: d.inMilliseconds);
      if (d.inMilliseconds > 0 &&
          state.duration > 0 &&
          !PlatformUtils.isWeb &&
          (PlatformUtils.isIOS || PlatformUtils.isMacOS) &&
          (d.inMilliseconds > state.duration) &&
          canNext) next();
      if (d.inMilliseconds > 0 &&
          state.duration > 0 &&
          !PlatformUtils.isWeb &&
          (PlatformUtils.isIOS || PlatformUtils.isMacOS) &&
          (d.inMilliseconds > state.duration) &&
          canNext) print("Hacky darwin workaround");
    });
    player.durationStream.listen((Duration? d) => state = state.copyWith(
        duration: (d?.inMilliseconds ?? 0) ~/
            (!PlatformUtils.isWeb &&
                    (PlatformUtils.isIOS || PlatformUtils.isMacOS)
                ? 2
                : 1)));
    player.playerStateStream.listen((state) {
      //print("New state: $state");
      if (state.processingState == ProcessingState.completed &&
          canNext &&
          !this.state.thinking) {
        print("Skipping");
        paused = false;
        next();
      }
      if (state.processingState == ProcessingState.ready)
        this.state = this.state.copyWith(isPlaying: state.playing);
      if (state.processingState == ProcessingState.ready &&
          !state.playing &&
          needInteraction) {
        needInteraction = false;
        player.seek(Duration(milliseconds: needSeekTo));
        print("Seeked position to ${needSeekTo}");
      }
    });
    player.playingStream.listen((bool playing) {
      state = state.copyWith(isPlaying: playing);
    });
    if (_sp.containsKey("playerinfo")) {
      var i = PlayerInfo.fromJson(jsonDecode(_sp.getString("playerinfo")!));
      print("Loading persisted playerinfo");
      needSeekTo = i.position;
      state = i;
      needInteraction = true;
      if (!PlatformUtils.isWeb && p.autoResume) {
        await playQueueItem(state.queue[state.currentIndex]);
      }
    }
  }

  void seek(Duration d) {
    player.seek(d);
  }

  void seekForward(int milliseconds) {
    player.seek(Duration(milliseconds: state.position) +
        Duration(milliseconds: milliseconds));
  }

  void seekBackward(int milliseconds) {
    Duration computed = Duration(milliseconds: state.position) -
        Duration(milliseconds: milliseconds);
    player.seek(computed.isNegative ? Duration.zero : computed);
  }

  void stop() {
    player.stop();
    state = state.copyWith(isPlaying: false);
    setQueue([]);
  }

  void play() async {
    if (needInteraction) {
      print("Play called, but need interaction");
      playQueueItem(state.queue[state.currentIndex]);
      await player.play();
      state = state.copyWith(isPlaying: true);
      return;
    }
    player.play();
    state = state.copyWith(isPlaying: true);
  }

  void pause() async {
    player.pause();
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
        isPlaying: false,
        duration: 0,
        position: 0,
      );
      playQueueItem(state.queue[i]);
    } else {
      print(
          "Skipping to $i, but queue has max index of ${state.queue.length - 1}");
    }
  }

  void setSong(String id) async {
    ref.read(findSongProvider(id).future).then((songObject) async {
      _queue = [songObject.toQueueItem()];
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
      queue: [i],
      isPlaying: true,
    );
    _queue = [i];
    setQueue([i]);
    state = state.copyWith(shuffle: false);
    skipToItem(0);
  }

  void setAlbum(String id) async {
    ref.read(findSongsByAlbumProvider(id).future).then((songs) async {
      List<QueueItem> newQueue = songs.map((s) => s.toQueueItem()).toList();
      setQueue(newQueue);
      state = state.copyWith(shuffle: false);
      _queue = newQueue;
      skipToItem(0);
    });
  }

  void addAlbumToQueue(String id) async {
    ref.read(findSongsByAlbumProvider(id).future).then((songs) async {
      var newQueue = [...state.queue, ...songs.map((s) => s.toQueueItem())];
      setQueue(newQueue);
      _queue = newQueue;
    });
  }

  void setArtist(String id) async {
    ref.read(findSongsByArtistProvider(id).future).then((songs) async {
      var newQueue = songs.map((s) => s.toQueueItem()).toList();
      setQueue(newQueue);
      state = state.copyWith(shuffle: false);
      _queue = newQueue;
      skipToItem(0);
    });
  }

  void addArtistToQueue(String id) async {
    ref.read(findSongsByArtistProvider(id).future).then((songs) async {
      var newQueue = [...state.queue, ...songs.map((s) => s.toQueueItem())];
      state = state.copyWith(queue: newQueue);
      _queue = newQueue;
    });
  }

  void setPlaylist(String id) async {
    ref.read(findSongsByPlaylistProvider(id).future).then((songs) async {
      var newQueue = songs.map((s) => s.toQueueItem()).toList();
      setQueue(newQueue);
      state = state.copyWith(shuffle: false);
      _queue = newQueue;
      skipToItem(0);
    });
  }

  void addPlaylistToQueue(String id) async {
    ref.read(findSongsByPlaylistProvider(id).future).then((songs) async {
      var newQueue = [...state.queue, ...songs.map((s) => s.toQueueItem())];
      setQueue(newQueue);
      _queue = newQueue;
    });
  }

  void addToQueue(Song song) async {
    var newQueue = [...state.queue, song.toQueueItem()];
    _queue = newQueue;
    setQueue(newQueue);
  }

  void addIdToQueue(String id) async {
    ref.read(findSongProvider(id).future).then((songObject) async {
      var newQueue = [...state.queue, songObject.toQueueItem()];
      setQueue(newQueue);
      _queue = newQueue;
    });
  }

  void clearQueue() async {
    player.pause();
    setQueue([]);
    _queue = [];
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
    player.pause();
    var url = await fetchYTVideo(id);
    await player.setAudioSource(AudioSource.uri(
      Uri.parse(url),
      //tag: MediaItem(
      //    id: DateTime.now().microsecondsSinceEpoch.toString(),
      //    title: item.displayName,
      //    album: item.albumName,
      //    artist: item.artistName,
      //    artUri: Uri.parse(item.imageUrl)),
      // We probably don't need to update the metadata for a temporary playback
    ));
    player.play();
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
      youtubeId: result.songs[0].id,
      imageUrl: "https://i.imgur.com/0fU7kZG.jpg",
      audioUrl: "not_fetched",
    ));
  }

  Future<void> shuffle() async {
    List<QueueItem> chew =
        List<QueueItem>.filled(state.queue.length, QueueItem.empty());
    for (int i = 0; i < state.queue.length; i++) {
      chew[i] = state.queue[superShuffle(
          i, DateTime.now().millisecondsSinceEpoch, state.queue.length)];
    }
    _queue = chew;
    state = state.copyWith(shuffle: true);
    setQueue(chew);
    skipToItem(0);
  }

  Future<void> loop(bool enable) async {
    state = state.copyWith(loop: enable);
  }

  Future<void> playQueueItem(QueueItem item) async {
    state = state.copyWith(thinking: true);
    player.pause();
    var url = item.audioUrl;
    if (url == "not_fetched") {
      if (PlatformUtils.isWeb) return;
      print("Fetching ${item.displayName}, $url");
      url = await fetchYTVideo(item.youtubeId);
      var nq = state.queue.toList();
      print("NQ Length ${nq.length}");
      nq[state.currentIndex] = item.copyWith(audioUrl: url);
      setQueue(nq);
    }
    //print("Going to play $url");
    await player.setAudioSource(AudioSource.uri(
      Uri.parse(url),
      tag: MediaItem(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: item.displayName,
          album: item.albumName,
          artist: item.artistName,
          artUri: Uri.parse(item.imageUrl)),
    ));
    player.play();
    state = state.copyWith(thinking: false);
    if (item.type == "song") {
      if (item.id == "empty") return;
      ref.read(addRecentlyPlayedProvider(item.id).future).then((value) {
        if (value == true) ref.refresh(fetchRecentlyPlayedProvider.future);
      });
      if (state.queue.length == 1) {
        print("Queue is one, returning");
        return;
      }
      var nextUrl = await fetchYTVideo(state.queue[skipDex(1)].youtubeId);
      if (PlatformUtils.isWeb) nextUrl = "$backendUrl/proxy/$nextUrl";
      var nq = state.queue.toList();
      nq[skipDex(1)] = nq[skipDex(1)].copyWith(audioUrl: nextUrl);
      if (state.queue.length > 1) {
        print("UNPREPPING: ${state.queue[state.currentIndex].displayName}");
        nq[state.currentIndex] =
            state.queue[state.currentIndex].copyWith(audioUrl: "not_fetched");
      }
      print("PREPPED: ${nq[skipDex(1)].displayName}");
      setQueue(nq);
    }
  }

  Future<String> fetchYTVideo(String id) async {
    if (state.queue.length == 1 && state.queue[0].audioUrl != "not_fetched")
      return state.queue[0].audioUrl;
    print("fetching video $id");
    var media = await yt.videos.streamsClient.getManifest(id);
    var streamInfo = media.audioOnly
        .where((e) =>
            e.audioCodec != 'opus' && e.container != StreamContainer.webM)
        .withHighestBitrate();
    var url = streamInfo.url.toString();
    return url;
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
