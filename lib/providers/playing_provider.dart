import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../platform_utils.dart';
import '../service_locator.dart';

import 'fetched_data_provider.dart';
import 'info_provider.dart';
import 'playlist_provider.dart';

import '../types/song.dart';
import '../types/searchresult.dart';
import '../types/queueitem.dart';
import '../../miller_shuffle.dart';

part 'playing_provider.g.dart';
part 'playing_provider.freezed.dart';

@freezed
class PlayerInfo with _$PlayerInfo {
  factory PlayerInfo({
    required String id,
    required String artistId,
    required String albumId,
    required String displayName,
    required String artistDisplayName,
    required String albumDisplayName,
    required double duration,
    required int    position,
    // required double percent,
    required bool isPlaying,
    required List<QueueItem> queue,
    required int currentIndex,
    required bool shuffle,
    required bool loop,
  }) = _PlayerInfo;
}

// This will generates a Notifier and NotifierProvider.
// The Notifier class that will be passed to our NotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
// Finally, we are using todosProvider(NotifierProvider) to allow the UI to
// interact with our Todos class.
@riverpod
class Player extends _$Player {
  final AudioHandler audioHandler = ServiceLocator().get<AudioHandler>();
  bool _hIsInit = false;
  late final _sp;
  bool _isInit = false;
  List<QueueItem> _queue = [];

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
      duration: 213.6,
      position: 0,
      isPlaying: false,
      queue: [],
      currentIndex: -1,
      loop: true,
      shuffle: false,
    );
  }

  void init() async {
    if(_hIsInit) return;
    _hIsInit = true;
    print("Playerinfo: init");
    audioHandler.mediaItem.distinct().listen((MediaItem? i) {
      state = state.copyWith(
        displayName: i?.title ?? "",
        albumDisplayName: i?.album ?? "",
        artistDisplayName: i?.artist ?? "",
        duration: i?.duration?.inMilliseconds.toDouble() ?? 0,
        currentIndex: (i?.extras?["index"] ?? -1) as int,
      );
    });
    audioHandler.playbackState.map((state) => state.position).distinct().listen((Duration? d) {
      state = state.copyWith(position: d?.inMilliseconds ?? 0);
    });
    audioHandler.mediaItem.map((state) => state?.duration ?? Duration.zero).distinct().listen((Duration? d) {
      state = state.copyWith(duration: (d?.inMilliseconds.toDouble() ?? 0));
    });
    audioHandler.playbackState.map((s) => s.playing).distinct().listen((bool b) {
      state = state.copyWith(isPlaying: b);
    });
    audioHandler.mediaItem.map((i) => (i?.extras?["song"] ?? Song.empty()) as Song).distinct().listen((Song s) {
      var id = s.id;
      if(id == "empty") return;
      ref.read(addRecentlyPlayedProvider(id).future).then((value) {
        if(value == true) ref.refresh(fetchRecentlyPlayedProvider.future);
      });
    });

    List<QueueItem> q = [];
  }

  void seek(Duration d) {
    audioHandler.seek(d);
  }

  void seekForward(int milliseconds){
    audioHandler.seek(audioHandler.playbackState.value.updatePosition + Duration(milliseconds: milliseconds));
  }

  void seekBackward(int milliseconds){
    Duration computed = audioHandler.playbackState.value.updatePosition - Duration(milliseconds: milliseconds);
    audioHandler.seek(computed.isNegative ? Duration.zero : computed);
  }

  void play() async {
    audioHandler.play();
    state = state.copyWith(isPlaying: true);
  }

  void pause() async {
    audioHandler.pause();
    state = state.copyWith(isPlaying: false);
    // print("paused");
  }

  void toggle() async {
    if(state.isPlaying) {
      audioHandler.pause();
    }else{
      audioHandler.play();
    }
    setPlaying(!state.isPlaying);
  }

  void next() async {
    audioHandler.skipToNext();
  }

  void previous() async {
    audioHandler.skipToPrevious();
  }

  void setPlaying(bool playing) async {
    state = state.copyWith(isPlaying: playing);
    // print(state.isPlaying ? "playing" : "paused");
  }

  void setSong(String id) async {
    // if(state.id == id) return; //Debounce duplicate calls :shrug: maybe this will fix the duplicates in recentlyplayed
    ref.read(findSongProvider(id).future).then((songObject) async {
      state = state.copyWith(
        id: songObject.id,
        artistId: songObject.artistId,
        albumId: songObject.albumId,
        displayName: songObject.displayName,
        albumDisplayName: songObject.albumDisplayName,
        artistDisplayName: songObject.artistDisplayName,
        queue: [songObject.toQueueItem()],
        isPlaying: true,
      );
      _queue = [songObject.toQueueItem()];
      await audioHandler.playMediaItem(songObject.toMediaItem());
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
    audioHandler.updateQueue([i.toMediaItem()]);
    await audioHandler.playMediaItem(i.toMediaItem());
  }

  void setAlbum(String id) async {
    ref.read(findSongsByAlbumProvider(id).future).then((songs) async {
      audioHandler.updateQueue(songs.map((s) => s.toMediaItem()).toList());
      audioHandler.skipToQueueItem(0);
      state = state.copyWith(queue: songs.map((s) => s.toQueueItem()).toList());
      _queue = songs.map((s) => s.toQueueItem()).toList();
    });
  }

  void addAlbumToQueue(String id) async {
    ref.read(findSongsByAlbumProvider(id).future).then((songs) async {
      var newQueue = [...state.queue, ...songs.map((s) => s.toQueueItem())];
      state = state.copyWith(queue: newQueue);
      _queue = newQueue;
      audioHandler.updateQueue([...audioHandler.queue.value, ...songs.map((s) => s.toMediaItem())]);
    });
  }

  void setArtist(String id) async {
    ref.read(findSongsByArtistProvider(id).future).then((songs) async {
      audioHandler.updateQueue(songs.map((s) => s.toMediaItem()).toList());
      audioHandler.skipToQueueItem(0);
      _queue = songs.map((s) => s.toQueueItem()).toList();
      state = state.copyWith(queue: songs.map((s) => s.toQueueItem()).toList());
    });
  }

  void addArtistToQueue(String id) async {
    ref.read(findSongsByArtistProvider(id).future).then((songs) async {
      var newQueue = [...state.queue, ...songs.map((s) => s.toQueueItem())];
      state = state.copyWith(queue: newQueue);
      _queue = newQueue;
      audioHandler.updateQueue([...audioHandler.queue.value, ...songs.map((s) => s.toMediaItem()).toList()]);
    });
  }

  void setPlaylist(String id) async {
    ref.read(findSongsByPlaylistProvider(id).future).then((songs) async {
      var newQueue = songs.map((s) => s.toQueueItem()).toList();
      audioHandler.updateQueue(songs.map((s) => s.toMediaItem()).toList());
      audioHandler.skipToQueueItem(0);
      state = state.copyWith(queue: newQueue);
      _queue = newQueue;
    });
  }

  void addPlaylistToQueue(String id) async {
    ref.read(findSongsByPlaylistProvider(id).future).then((songs) async {
      var newQueue = [...state.queue, ...songs.map((s) => s.toQueueItem())];
      state = state.copyWith(queue: newQueue);
      _queue = newQueue;
      audioHandler.updateQueue([...audioHandler.queue.value, ...songs.map((s) => s.toMediaItem()).toList()]);
    });
  }

  void setQueue(List<Song> queue) async {
    audioHandler.updateQueue(queue.map((s) => s.toMediaItem()).toList());
    var newQueue = queue.map((s) => s.toQueueItem()).toList();
    state = state.copyWith(queue: newQueue);
    _queue = newQueue;
  }

  void addToQueue(Song song) async {
    var newQueue = [...state.queue, song.toQueueItem()];
    state = state.copyWith(
      queue: newQueue,
    );
    _queue = newQueue;
    audioHandler.updateQueue([...audioHandler.queue.value, song.toMediaItem()]);
  }

  void addIdToQueue(String id) async {
    ref.read(findSongProvider(id).future).then((songObject) async {
      var newQueue = [...state.queue, songObject.toQueueItem()];
      state = state.copyWith(
        queue: newQueue,
      );
      _queue = newQueue;
      audioHandler.updateQueue([...audioHandler.queue.value, songObject.toMediaItem()]);
    });
  }

  void clearQueue() async {
    audioHandler.updateQueue([]);
    state = state.copyWith(queue: []);
    _queue = [];
    audioHandler.stop();
  }

  void moveQueueItem(int oldIndex, int newIndex) async {
    List<QueueItem> queue = [...state.queue];
    QueueItem s = queue.removeAt(oldIndex);
    queue.insert(newIndex - 1, s);
    _setQueue(queue, false);
  }

  void playYoutubeId(String id) async {
    final item = MediaItem(
      id: id,
      title: "Youtube Video",
      album: "NOTHING",
      artist: "Some channel",
      duration: Duration(milliseconds: 1000),
      artUri: Uri.parse("https://upload.wikimedia.org/wikipedia/commons/5/5f/Apple_Music_icon.svg"),
    );
    await audioHandler.playMediaItem(item);
  }

  void playFindResult(FindResult result) async {
    final item = MediaItem(
      id: result.songs[0].id,
      title: result.songs[0].title,
      album: result.album,
      artist: result.artist,
      duration: Duration(milliseconds: 1000),
      artUri: Uri.parse("https://determine.com"),
    );
    await audioHandler.playMediaItem(item);
  }

  Future<void> shuffle(bool enable) async {
    if(!enable) {
      state = state.copyWith(shuffle: enable, queue: _queue); 
    }else if(enable) {
      _queue = state.queue;
      List<QueueItem> chew = List<QueueItem>.filled(state.queue.length, QueueItem.empty());
      for(int i = 0; i < state.queue.length; i++) {
        chew[i] = state.queue[superShuffle(i, DateTime.now().millisecondsSinceEpoch, state.queue.length)];
      }
      _setQueue(chew, true);
      state = state.copyWith(shuffle: enable);
    }
    state = state.copyWith(shuffle: enable);
  }

  Future<void> loop(bool enable) async {
    audioHandler.setRepeatMode(enable ? AudioServiceRepeatMode.all : AudioServiceRepeatMode.none);
    state = state.copyWith(loop: enable);
  }

  void _setQueue(List<QueueItem> queue, bool shuffle) async {
    if(!shuffle) _queue = queue;
    state = state.copyWith(queue: queue);
    audioHandler.updateQueue(queue.map((s) => s.toMediaItem()).toList());
    ServiceLocator().get<SharedPreferences>().setString("queue", jsonEncode(queue));
  }
}

class AudioServiceHandler extends BaseAudioHandler 
    with QueueHandler, SeekHandler {
    
    final player = AudioPlayer();
    final bool isWeb = PlatformUtils.isWeb;
    String backendUrl = "";
    int playingIndex = 0;
    bool shuffle = false;
    bool loop = true;
    bool nextPrepped = false;
    String nextUrl = "";
    Duration duration = Duration.zero;
    List<MediaItem> unshuffledQueue = [];

    void init() async {
      if(backendUrl == "") backendUrl = (await SharedPreferences.getInstance()).getString("backendUrl") ?? "https://eatthecow.mooo.com:3030";
      if(PlatformUtils.isLinux || PlatformUtils.isWindows && !PlatformUtils.isWeb) JustAudioMediaKit.ensureInitialized();
      player.positionStream.listen((Duration d) {
        if(PlatformUtils.isIOS && (d.inMilliseconds > (duration.inMilliseconds / 2)) && canNext) {
          print("Hacky workaround for ios. Skipping to next.");
          playbackState.add(playbackState.value.copyWith(playing: false));
          skipToNext();
        }
        print("New position: $d");
        playbackState.add(playbackState.value.copyWith(updatePosition: d));
      });
      player.durationStream.listen((Duration? d) {
        mediaItem.add(mediaItem.value?.copyWith(duration: Duration(milliseconds: ((d?.inMilliseconds ?? 0)/2).ceil())));
        print("New duration: ${mediaItem.value?.duration}");
        duration = d ?? Duration.zero;
      });
      player.currentIndexStream.listen((int? i) {
        if(player.previousIndex == null || (i ?? -1) <= (player.previousIndex ?? 0)) return;
        playbackState.add(playbackState.value.copyWith(playing: false));
        if(canNext) skipToNext();
        if(canNext) print("Going next");
      });
      queue.listen((q) {
        if(q.isNotEmpty && q.length-1 > playingIndex && !nextPrepped && canNext) {
          prepNextItem();
        }
      });
      playbackState.listen((s) {
        // print("PlaybackState: $s");
      });
      playbackState.add(playbackState.value.copyWith(controls: [MediaControl.skipToPrevious, MediaControl.play, MediaControl.skipToNext]));
      mediaItem.listen((m) {
        print("MediaItem: $m");
      });
    }

    @override
    Future<void> addQueueItem(MediaItem mediaItem) async {
      queue.value.add(mediaItem);
      queue.add(queue.value);
    }
    
    @override
    Future<void> addQueueItems(List<MediaItem> mediaItems) async {
      queue.value.addAll(mediaItems);
      queue.add(queue.value);
    }
    
    @override
    Future<void> removeQueueItem(MediaItem mediaItem) async {
      queue.value.remove(mediaItem);
      queue.add(queue.value);
    }
    
    @override
    Future<void> removeQueueItemAt(int index) async {
      queue.value.removeAt(index);
      queue.add(queue.value);
    }
    
    @override
    Future<void> playMediaItem(MediaItem mediaitem) async {
      nextPrepped = false;
      playingIndex = 0;
      player.stop();
      queue.value = [mediaitem];
      queue.add(queue.value);
      await prepMediaItem(mediaitem);
    }

    @override
    Future<void> playFromUri(Uri uri, [Map<String, dynamic>? extras]) async {
      playbackState.add(playbackState.value.copyWith(playing: true));
      await player.setUrl(uri.toString());
      player.play();
    }
    
    @override
    Future<void> play() async {
      playbackState.add(playbackState.value.copyWith(
        playing: true,
        controls: [
          MediaControl.skipToPrevious,
          MediaControl.pause,
          MediaControl.skipToNext
        ]
      ));
      await player.play();
    }
    
    @override
    Future<void> pause() async {
      playbackState.add(playbackState.value.copyWith(
        playing: false,
        controls: [
          MediaControl.skipToPrevious,
          MediaControl.pause,
          MediaControl.skipToNext
        ]
      ));
      await player.pause();
    }
    
    @override
    Future<void> stop() async {
      playbackState.add(playbackState.value.copyWith(
        playing: false,
        controls: [],
        updatePosition: Duration.zero,
      ));
      // mainInUse = !mainInUse;
      nextPrepped = false;
      player.stop();
      player.setUrl("");
      player.dispose();
    }

    @override
    Future<void> seek(Duration position) async {
      player.seek(position);
    }

    @override
    Future<void> skipToQueueItem(int index) async {
      playingIndex = index;
      nextPrepped = false;
      prepMediaItem(queue.value[index]);
      await super.skipToQueueItem(index);
    }
    
    @override
    Future<void> skipToNext() async {
      if(playingIndex+1 > queue.value.length-1) {
        playingIndex = 0;
      }else{
        playingIndex++;
      }
      prepMediaItem(queue.value[playingIndex]);
      await super.skipToNext();
    }
    
    @override
    Future<void> skipToPrevious() async {
      if(playingIndex-1 < 0) {
        playingIndex = queue.value.length - 1;
      }else{
        playingIndex--;
      }
      nextPrepped = false;
      prepMediaItem(queue.value[playingIndex]);
      await super.skipToPrevious();
    }

    Future<void> prepMediaItem(MediaItem mediaITem) async {
      if(queue.value.isEmpty) nextPrepped = false;
      if(!nextPrepped) {
        player.stop();
        MediaItem mediaitem = mediaITem;
        print("MEPREP: $mediaitem");
        var video = await fetchYTVideo(mediaitem.id);
        var url = (PlatformUtils.isWeb) ? "$backendUrl/proxy/$video" : video;
        player.setUrl(url);
        await player.play();
        // if(mediaitem.artUri.toString() == "https://determine.com") mediaitem = mediaitem.copyWith(artUri: Uri.parse(video[1]));
        playbackState.add(playbackState.value.copyWith(
          playing: true,
          processingState: AudioProcessingState.ready,
          controls: [MediaControl.skipToPrevious, MediaControl.pause, MediaControl.skipToNext]
        ));
        mediaItem.add(mediaitem.copyWith(extras: {"song": mediaITem.extras?["song"], "index": playingIndex}));
        print("PREPPED: ${mediaItem.value}");
        prepNextItem();
      }else{
        player.setUrl(nextUrl);
        await player.play();
        nextPrepped = false;
        playbackState.add(playbackState.value.copyWith(playing: true));
        mediaItem.add(mediaITem.copyWith(extras: {"song": mediaITem.extras?["song"], "index": playingIndex}));
        prepNextItem();
      }
    }

    Future<String> fetchYTVideo(String id) async {
      var url = await http.get(Uri.parse("https://eatthecow.mooo.com:3030/video/url${PlatformUtils.isWeb || PlatformUtils.isIOS || PlatformUtils.isMacOS ? "/ios" : ""}/$id"));
      return url.body;
    }
    
    prepNextItem() async {
      if(queue.value.length <= 1) return;
      var nextIndex = (playingIndex + 1 > queue.value.length-1) ? 0 : playingIndex + 1;
      var mediaitem = queue.value[nextIndex];
      var video = await fetchYTVideo(queue.value[nextIndex].id);
      nextUrl = (PlatformUtils.isWeb) ? "$backendUrl/proxy/$video" : video;
      nextPrepped = true;
    }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    loop = repeatMode == AudioServiceRepeatMode.all;
  }

  get canNext => (playingIndex + 1 > queue.value.length-1) ? false || loop : true;
}
