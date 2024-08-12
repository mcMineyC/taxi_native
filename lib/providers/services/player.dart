import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../platform_utils.dart';

import '../data/fetched_data_provider.dart';
import '../data/info_provider.dart';
import '../data/playlist_provider.dart';

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
    required int    duration,
    required int    position,
    required bool isPlaying,
    required List<QueueItem> queue,
    required int currentIndex,
    required bool shuffle,
    required bool loop,
  }) = _PlayerInfo;

  factory PlayerInfo.fromJson(Map<String, dynamic> json) => _$PlayerInfoFromJson(json);
}

@riverpod
class Player extends _$Player {
  AudioPlayer player = AudioPlayer();
  late final SharedPreferences _sp;
  bool _isInit = false;
  List<QueueItem> _queue = [];
  List<QueueItem> queue = [];
  final String backendUrl = "https://eatthecow.mooo.com:3030";
  bool paused = false;
  bool thinking = false;
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
    );
  }

  Future<void> init() async {
    if(_isInit) return;
    _isInit = true;
    _sp = await SharedPreferences.getInstance();
    print("Playerinfo: init");
    if(!PlatformUtils.isWeb && PlatformUtils.isLinux) JustAudioMediaKit.ensureInitialized();
    player.positionStream.listen((Duration d) {
      state = state.copyWith(position: d.inMilliseconds);
      if(!PlatformUtils.isWeb && PlatformUtils.isIOS && (d.inMilliseconds > (state.duration / 2)) && canNext) next();
    });
    player.durationStream.listen((Duration? d) => state = state.copyWith(duration: (d?.inMilliseconds ?? 0) ~/ (!PlatformUtils.isWeb && PlatformUtils.isIOS ? 2 : 1)));
    player.playerStateStream.listen((state) {
      if(state.processingState == ProcessingState.completed && canNext && !thinking) {
        thinking = true;
        next();
      }
      if(state.processingState == ProcessingState.ready && !paused) this.state = this.state.copyWith(isPlaying: true);
      if(state.processingState == ProcessingState.ready && needInteraction) {
        needInteraction = false;
        player.seek(Duration(milliseconds: needSeekTo));
        print("Seeked position to ${needSeekTo}");
      }
    }); 
    player.playingStream.listen((bool playing) {
      state = state.copyWith(isPlaying: playing);
    });
    if(_sp.containsKey("playerinfo")) {
      var i = PlayerInfo.fromJson(jsonDecode(_sp.getString("playerinfo")!));
      print("Loading persisted playerinfo");
      needSeekTo = i.position;
      state = i;
      needInteraction = true;
    }
  }

  void seek(Duration d) {
    player.seek(d);
  }

  void seekForward(int milliseconds){
    player.seek(Duration(milliseconds: state.position) + Duration(milliseconds: milliseconds));
  }

  void seekBackward(int milliseconds){
    Duration computed = Duration(milliseconds: state.position) - Duration(milliseconds: milliseconds);
    player.seek(computed.isNegative ? Duration.zero : computed);
  }

  void play() async {
    if(needInteraction) {
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
    if(state.isPlaying) {
      pause();
    }else{
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

  void skip(int num){
    int newIndex = skipDex(num);
    skipToItem(newIndex);
  }

  int skipDex(int num){
    int newIndex = state.currentIndex + num;
    if(newIndex < 0){
      return state.queue.length - 1;
    }else if(newIndex > state.queue.length - 1){
      return 0;
    } else {
      return newIndex;
    }
  }

  void skipToItem(int i) {
    if(i >= 0 && i < state.queue.length) {
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
    }else{
      print("Skipping to $i, but queue has max index of ${state.queue.length-1}");
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
  }

  void moveQueueItem(int oldIndex, int newIndex) async {
    List<QueueItem> queue = [...state.queue];
    QueueItem s = queue.removeAt(oldIndex);
    queue.insert(newIndex - 1, s);
    setQueue(queue);
  }

  void playYoutubeId(String id) async {
    playQueueItem(QueueItem(
      type: "youtube-song",
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      artistId: "youtube",
      albumId: "youtube",
      displayName: "Youtube",
      artistName: "Youtube",
      albumName: "Youtube",
      youtubeId: id,
      duration: 0,
      imageUrl: "https://i.imgur.com/0fU7kZG.jpg",
      audioUrl: "not_fetched",
    ));
  }

  void playFindResult(FindResult result) async {
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

  Future<void> shuffle(bool enable) async {
    List<QueueItem> chew = List<QueueItem>.filled(state.queue.length, QueueItem.empty());
    for(int i = 0; i < state.queue.length; i++) {
      chew[i] = state.queue[superShuffle(i, DateTime.now().millisecondsSinceEpoch, state.queue.length)];
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
    var url = item.audioUrl;
    if(url == "not_fetched"){
      url = await fetchYTVideo(item.youtubeId);
      if(PlatformUtils.isWeb) url = "$backendUrl/proxy/$url";
    }
    print("Going to play $url");
    await player.setAudioSource(AudioSource.uri(
      Uri.parse(url),
      tag: MediaItem(id: DateTime.now().microsecondsSinceEpoch.toString(), title: item.displayName, album: item.albumName, artist: item.artistName, artUri: Uri.parse(item.imageUrl)),
    ));
    await player.play();
    thinking = false;
    if(item.type == "song") {
      if(item.id == "empty") return;
      ref.read(addRecentlyPlayedProvider(item.id).future).then((value) {
        if(value == true) ref.refresh(fetchRecentlyPlayedProvider.future);
      });
      var nextUrl = await fetchYTVideo(state.queue[skipDex(1)].youtubeId);
      if(PlatformUtils.isWeb) nextUrl = "$backendUrl/proxy/$nextUrl";
      var nq = state.queue.toList();
      nq[skipDex(1)] = nq[skipDex(1)].copyWith(audioUrl: nextUrl);
      nq[state.currentIndex] = state.queue[state.currentIndex].copyWith(audioUrl: "not_fetched");
      print("PREPPED: ${nq[skipDex(1)].displayName}");
      setQueue(nq);
    }
  }
  Future<String> fetchYTVideo(String id) async {
    print("fetching video $id");
    var url = await http.get(Uri.parse("https://eatthecow.mooo.com:3030/video/url/ios/$id"));
    return url.body;
  }

  get canNext => (state.currentIndex + 1 > state.queue.length) ? false || state.loop : true;
}
