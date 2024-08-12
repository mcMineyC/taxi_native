import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../platform_utils.dart';
import '../../service_locator.dart';

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
    // required double percent,
    required bool isPlaying,
    required List<QueueItem> queue,
    required int currentIndex,
    required bool shuffle,
    required bool loop,
  }) = _PlayerInfo;
}

@riverpod
class Player extends _$Player {
  AudioPlayer player = AudioPlayer();
  bool _hIsInit = false;
  late final _sp;
  bool _isInit = false;
  List<QueueItem> _queue = [];
  List<QueueItem> queue = [];
  final String backendUrl = "https://eatthecow.mooo.com:3030";
  bool paused = false;
  bool thinking = false;

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
    if(_hIsInit) return;
    _hIsInit = true;
    print("Playerinfo: init");
    if(!PlatformUtils.isWeb && PlatformUtils.isLinux) JustAudioMediaKit.ensureInitialized();
    player.positionStream.listen((Duration d) {
      state = state.copyWith(position: d.inMilliseconds);
      if(!PlatformUtils.isWeb && PlatformUtils.isIOS && (d.inMilliseconds > (state.duration / 2)) && canNext) next();
    });
    player.durationStream.listen((Duration? d) => state = state.copyWith(duration: d?.inMilliseconds ?? 0));

    player.playerStateStream.listen((state) {
      // print("PlayerState: $state");
      if(state.processingState == ProcessingState.completed && canNext && !thinking) {
        thinking = true;
        next();
      }
      if(state.processingState == ProcessingState.ready && !paused) this.state = this.state.copyWith(isPlaying: true);
    }); 
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
    player.play();
    state = state.copyWith(isPlaying: true);
  }

  void pause() async {
    player.pause();
    state = state.copyWith(isPlaying: false);
  }

  void toggle() async {
    if(state.isPlaying) {
      player.pause();
    }else{
      player.play();
    }
    setPlaying(!state.isPlaying);
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
    // print("skipping $num ${state.currentIndex}");
    int newIndex = skipDex(num);
    skipToItem(newIndex);
    // print("skipping: end ${state.currentIndex}");
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
    skipToItem(0);
  }

  void setAlbum(String id) async {
    ref.read(findSongsByAlbumProvider(id).future).then((songs) async {
      List<QueueItem> newQueue = songs.map((s) => s.toQueueItem()).toList();
      setQueue(newQueue);
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
      _queue = newQueue;
      skipToItem(0);
    });
  }

  void addPlaylistToQueue(String id) async {
    ref.read(findSongsByPlaylistProvider(id).future).then((songs) async {
      var newQueue = [...state.queue, ...songs.map((s) => s.toQueueItem())];
      state = state.copyWith(queue: newQueue);
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
    // player.stop();
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
    if(!enable) {
      state = state.copyWith(shuffle: enable); 
      setQueue(_queue);
      skipToItem(0);
    }else if(enable) {
      List<QueueItem> chew = List<QueueItem>.filled(state.queue.length, QueueItem.empty());
      for(int i = 0; i < state.queue.length; i++) {
        chew[i] = state.queue[superShuffle(i, DateTime.now().millisecondsSinceEpoch, state.queue.length)];
      }
      _queue = chew;
      state = state.copyWith(shuffle: enable);
      setQueue(chew);
      skipToItem(0);
    }
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
    // await player.stop();
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
      print("PREPPED: ${nq[skipDex(1)].displayName}");
      state = state.copyWith(queue: nq);
    }
  }
  Future<String> fetchYTVideo(String id) async {
    print("fetching video $id");
    var url = await http.get(Uri.parse("https://eatthecow.mooo.com:3030/video/url/ios/$id"));
    return url.body;
  }

  get canNext => (state.currentIndex + 1 > state.queue.length) ? false || state.loop : true;
}

// class AudioServiceHandler extends BaseAudioHandler 
//     with QueueHandler, SeekHandler {
//     
//     final player = AudioPlayer();
//     final bool isWeb = PlatformUtils.isWeb;
//     String backendUrl = "";
//     int playingIndex = 0;
//     bool shuffle = false;
//     bool loop = true;
//     bool nextPrepped = false;
//     String nextUrl = "";
//     Duration duration = Duration.zero;
//     List<MediaItem> unshuffledQueue = [];
//
//     Future<void> init() async {
//       if(backendUrl == "") backendUrl = (await SharedPreferences.getInstance()).getString("backendUrl") ?? "https://eatthecow.mooo.com:3030";
//       // if(!isWeb && (PlatformUtils.isLinux || PlatformUtils.isWindows)) JustAudioMediaKit.ensureInitialized();
//       player.onPositionChanged.listen((Duration d) {
//         if(!isWeb && PlatformUtils.isIOS && (d.inMilliseconds > (duration.inMilliseconds / 2)) && canNext) {
//           print("Hacky workaround for ios. Skipping to next.");
//           playbackState.add(playbackState.value.copyWith(playing: false));
//           skipToNext();
//         }
//         playbackState.add(playbackState.value.copyWith(updatePosition: d));
//       });
//       player.onDurationChanged.listen((Duration? d) {
//         mediaItem.add(mediaItem.value?.copyWith(duration: Duration(milliseconds: ((d?.inMilliseconds ?? 0)/(!isWeb && PlatformUtils.isIOS ? 2 : 1)).ceil())));
//         duration = Duration(milliseconds:
//           (
//             (d?.inMilliseconds ?? 0) / (!isWeb && PlatformUtils.isIOS ? 2 : 1)
//           ).ceil()
//         );
//         print("New duration: $duration");
//       });
//       player.onPlayerComplete.listen((_) {
//         playbackState.add(playbackState.value.copyWith(playing: false));
//         if(canNext) skipToNext();
//         if(canNext) print("Going next");
//       });
//       queue.listen((q) {
//         if(q.isNotEmpty && q.length-1 > playingIndex && !nextPrepped && canNext) {
//           prepNextItem();
//         }
//       });
//       playbackState.listen((s) {
//         // print("PlaybackState: $s");
//       });
//       playbackState.add(playbackState.value.copyWith(controls: [MediaControl.skipToPrevious, MediaControl.play, MediaControl.skipToNext]));
//       mediaItem.listen((m) {
//         print("MediaItem: $m");
//       });
//     }
//
//     @override
//     Future<void> addQueueItem(MediaItem mediaItem) async {
//       queue.value.add(mediaItem);
//       queue.add(queue.value);
//     }
//     
//     @override
//     Future<void> addQueueItems(List<MediaItem> mediaItems) async {
//       queue.value.addAll(mediaItems);
//       queue.add(queue.value);
//     }
//     
//     @override
//     Future<void> removeQueueItem(MediaItem mediaItem) async {
//       queue.value.remove(mediaItem);
//       queue.add(queue.value);
//     }
//     
//     @override
//     Future<void> removeQueueItemAt(int index) async {
//       queue.value.removeAt(index);
//       queue.add(queue.value);
//     }
//
//     @override
//     Future<void> updateQueue(List<MediaItem> newQueue) async {
//       queue.add(newQueue);
//       skipToQueueItem(0);
//     }
//     
//     @override
//     Future<void> playMediaItem(MediaItem mediaitem) async {
//       nextPrepped = false;
//       playingIndex = 0;
//       player.stop();
//       queue.value = [mediaitem];
//       queue.add(queue.value);
//       await prepMediaItem(mediaitem);
//     }
//
//     @override
//     Future<void> playFromUri(Uri uri, [Map<String, dynamic>? extras]) async {
//       playbackState.add(playbackState.value.copyWith(playing: true));
//       await player.play(UrlSource(uri.toString()));
//     }
//     
//     @override
//     Future<void> play() async {
//       playbackState.add(playbackState.value.copyWith(
//         playing: true,
//         controls: [
//           MediaControl.skipToPrevious,
//           MediaControl.pause,
//           MediaControl.skipToNext
//         ]
//       ));
//       await player.resume();
//     }
//     
//     @override
//     Future<void> pause() async {
//       playbackState.add(playbackState.value.copyWith(
//         playing: false,
//         controls: [
//           MediaControl.skipToPrevious,
//           MediaControl.pause,
//           MediaControl.skipToNext
//         ]
//       ));
//       await player.pause();
//     }
//     
//     @override
//     Future<void> stop() async {
//       playbackState.add(playbackState.value.copyWith(
//         playing: false,
//         controls: [],
//         updatePosition: Duration.zero,
//       ));
//       // mainInUse = !mainInUse;
//       nextPrepped = false;
//       player.stop();
//       player.setSource(UrlSource(""));
//       player.dispose();
//     }
//
//     @override
//     Future<void> seek(Duration position) async {
//       player.seek(position);
//     }
//
//     @override
//     Future<void> skipToQueueItem(int index) async {
//       playingIndex = index;
//       nextPrepped = false;
//       prepMediaItem(queue.value[index]);
//       await super.skipToQueueItem(index);
//     }
//     
//     @override
//     Future<void> skipToNext() async {
//       if(playingIndex+1 > queue.value.length-1) {
//         playingIndex = 0;
//       }else{
//         playingIndex++;
//       }
//       prepMediaItem(queue.value[playingIndex]);
//       await super.skipToNext();
//     }
//     
//     @override
//     Future<void> skipToPrevious() async {
//       if(playingIndex-1 < 0) {
//         playingIndex = queue.value.length - 1;
//       }else{
//         playingIndex--;
//       }
//       nextPrepped = false;
//       prepMediaItem(queue.value[playingIndex]);
//       await super.skipToPrevious();
//     }
//
//     Future<void> prepMediaItem(MediaItem mediaITem) async {
//       if(queue.value.isEmpty) nextPrepped = false;
//       if(!nextPrepped) {
//         player.stop();
//         MediaItem mediaitem = mediaITem;
//         print("MEPREP: $mediaitem");
//         var video = await fetchYTVideo(mediaitem.id);
//         var url = (isWeb) ? "$backendUrl/proxy/$video" : video;
//         await player.play(UrlSource(url));
//         // if(mediaitem.artUri.toString() == "https://determine.com") mediaitem = mediaitem.copyWith(artUri: Uri.parse(video[1]));
//         playbackState.add(playbackState.value.copyWith(
//           playing: true,
//           processingState: AudioProcessingState.ready,
//           controls: [MediaControl.skipToPrevious, MediaControl.pause, MediaControl.skipToNext]
//         ));
//         mediaItem.add(mediaitem.copyWith(extras: {"song": mediaITem.extras?["song"], "index": playingIndex}));
//         print("PREPPED: ${mediaItem.value}");
//         prepNextItem();
//       }else{
//         await player.play(UrlSource(nextUrl));
//         nextPrepped = false;
//         playbackState.add(playbackState.value.copyWith(playing: true));
//         mediaItem.add(mediaITem.copyWith(extras: {"song": mediaITem.extras?["song"], "index": playingIndex}));
//         prepNextItem();
//       }
//     }
//
//     Future<String> fetchYTVideo(String id) async {
//       var url = await http.get(Uri.parse("https://eatthecow.mooo.com:3030/video/url${PlatformUtils.isWeb || PlatformUtils.isIOS || PlatformUtils.isMacOS ? "/ios" : ""}/$id"));
//       return url.body;
//     }
//     
//     prepNextItem() async {
//       if(queue.value.length <= 1) return;
//       var nextIndex = (playingIndex + 1 > queue.value.length-1) ? 0 : playingIndex + 1;
//       var mediaitem = queue.value[nextIndex];
//       var video = await fetchYTVideo(queue.value[nextIndex].id);
//       nextUrl = (isWeb) ? "$backendUrl/proxy/$video" : video;
//       nextPrepped = true;
//     }
//
//   @override
//   Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
//     loop = repeatMode == AudioServiceRepeatMode.all;
//   }
//
//   get canNext => (playingIndex + 1 > queue.value.length-1) ? false || loop : true;
// }
