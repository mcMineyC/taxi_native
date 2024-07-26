import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import '../platform_utils.dart';
import '../service_locator.dart';

import 'fetched_data_provider.dart';
import 'info_provider.dart';
import 'playlist_provider.dart';

import '../types/song.dart';
import '../types/searchresult.dart';
import '../types/queueitem.dart';

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
  }

  void play() async {
    audioHandler.play();
    state = state.copyWith(isPlaying: true);
  }

  void pause() async {
    audioHandler.pause();
    state = state.copyWith(isPlaying: false);
    print("paused");
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
    print(state.isPlaying ? "playing" : "paused");
  }

  void setSong(String id) async {
    // if(state.id == id) return; //Debounce duplicate calls :shrug: maybe this will fix the duplicates in recentlyplayed
    print("Song setter: $id");
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
    audioHandler.updateQueue([i.toMediaItem()]);
    await audioHandler.playMediaItem(i.toMediaItem());
  }

  void setAlbum(String id) async {
    ref.read(findSongsByAlbumProvider(id).future).then((songs) async {
      audioHandler.updateQueue(songs.map((s) => s.toMediaItem()).toList());
      audioHandler.skipToQueueItem(0);
      state = state.copyWith(queue: songs.map((s) => s.toQueueItem()).toList());
      print("Set album, new length: ${state.queue.length} & ${audioHandler.queue.value.length}");
    });
  }

  void addAlbumToQueue(String id) async {
    ref.read(findSongsByAlbumProvider(id).future).then((songs) async {
      print("Adding ${songs.length} songs to queue");
      state = state.copyWith(queue: [...audioHandler.queue.value.map((s) => s.toQueueItem()), ...songs.map((s) => s.toQueueItem())]);
      audioHandler.updateQueue([...audioHandler.queue.value, ...songs.map((s) => s.toMediaItem())]);
      print("Added album to queue, new length: ${state.queue.length} & ${audioHandler.queue.value.length}");
    });
  }

  void setArtist(String id) async {
    ref.read(findSongsByArtistProvider(id).future).then((songs) async {
      audioHandler.updateQueue(songs.map((s) => s.toMediaItem()).toList());
      audioHandler.skipToQueueItem(0);
      state = state.copyWith(queue: songs.map((s) => s.toQueueItem()).toList());
      print("Set artist, new length: ${state.queue.length} & ${audioHandler.queue.value.length}");
    });
  }

  void addArtistToQueue(String id) async {
    ref.read(findSongsByArtistProvider(id).future).then((songs) async {
      state = state.copyWith(queue: [...audioHandler.queue.value.map((s) => s.toQueueItem()), ...songs.map((s) => s.toQueueItem())]);
      audioHandler.updateQueue([...audioHandler.queue.value, ...songs.map((s) => s.toMediaItem()).toList()]);
      print("Added artist to queue, new length: ${songs.length} : ${state.queue.length}sq & ${audioHandler.queue.value.length}ahq");
    });
  }

  void setPlaylist(String id) async {
    ref.read(findSongsByPlaylistProvider(id).future).then((songs) async {
      audioHandler.updateQueue(songs.map((s) => s.toMediaItem()).toList());
      audioHandler.skipToQueueItem(0);
      state = state.copyWith(queue: songs.map((s) => s.toQueueItem()).toList());
      print("Set artist, new length: ${state.queue.length} & ${audioHandler.queue.value.length}");
    });
  }

  void addPlaylistToQueue(String id) async {
    ref.read(findSongsByPlaylistProvider(id).future).then((songs) async {
      state = state.copyWith(queue: [...audioHandler.queue.value.map((s) => s.toQueueItem()), ...songs.map((s) => s.toQueueItem())]);
      audioHandler.updateQueue([...audioHandler.queue.value, ...songs.map((s) => s.toMediaItem()).toList()]);
      print("Added artist to queue, new length: ${songs.length} : ${state.queue.length}sq & ${audioHandler.queue.value.length}ahq");
    });
  }

  void setQueue(List<Song> queue) async {
    audioHandler.updateQueue(queue.map((s) => s.toMediaItem()).toList());
    state = state.copyWith(queue: queue.map((s) => s.toQueueItem()).toList());
  }

  void addToQueue(Song song) async {
    state = state.copyWith(
      queue: [...state.queue, song.toQueueItem()],
    );
    audioHandler.updateQueue([...audioHandler.queue.value, song.toMediaItem()]);
  }

  void addIdToQueue(String id) async {
    ref.read(findSongProvider(id).future).then((songObject) async {
      state = state.copyWith(
        queue: [...state.queue, songObject.toQueueItem()],
      );
      audioHandler.updateQueue([...audioHandler.queue.value, songObject.toMediaItem()]);
    });
  }

  void clearQueue() async {
    audioHandler.updateQueue([]);
    state = state.copyWith(queue: []);
    audioHandler.stop();
  }

  void moveQueueItem(int oldIndex, int newIndex) async {
    print("Moving queue item $oldIndex to $newIndex");
    List<QueueItem> queue = [...state.queue];
    QueueItem s = queue.removeAt(oldIndex);
    queue.insert(newIndex - 1, s);
    state = state.copyWith(queue: queue);
    audioHandler.updateQueue(queue.map((s) => s.toMediaItem()).toList());
  }

  void playYoutubeId(String id) async {
    // var video = await yt.videos.get(id);
    // print("Playing youtube video $id");
    final item = MediaItem(
      id: id,
      title: "Youtube Video",
      album: "NOTHING",
      artist: "Some channel",
      duration: Duration(milliseconds: 1000),
      artUri: Uri.parse("https://upload.wikimedia.org/wikipedia/commons/5/5f/Apple_Music_icon.svg"),
    );
    await audioHandler.playMediaItem(item);
    audioHandler.updateQueue([item]);
  }

  void playFindResult(FindResult result) async {
    final item = MediaItem(
      id: result.songs[0].id,
      title: result.songs[0].title,
      album: result.album ?? "NOTHING",
      artist: result.artist ?? "NOTHING",
      duration: Duration(milliseconds: 1000),
      artUri: Uri.parse("https://determine.com"),
    );
    await audioHandler.playMediaItem(item);
    audioHandler.updateQueue([item]);
  }
}

class AudioServiceHandler extends BaseAudioHandler 
    with QueueHandler {
    
    final player = AudioPlayer();
    final secondaryPlayer = AudioPlayer();
    final bool isWeb = PlatformUtils.isWeb;
    String backendUrl = "";
    int playingIndex = 0;
    bool shuffle = false;
    bool nextPrepped = false;
    bool mainInUse = false;
    String nextUrl = "";
    int duration = 0;

    void init() async {
      if(backendUrl == "") backendUrl = (await SharedPreferences.getInstance()).getString("backendUrl") ?? "https://eatthecow.mooo.com:3030";
      player.onPositionChanged.listen((Duration d) {
        if(!mainInUse) return; 
        // print("AudioServiceHandler: player position changed");
        playbackState.add(playbackState.value.copyWith(updatePosition: d));
      });
      player.onDurationChanged.listen((Duration d) {
        if(!mainInUse) return; 
        if(mainInUse) mediaItem.add(mediaItem.value?.copyWith(duration: d));
        duration = d.inMilliseconds;
      });
      player.onPlayerComplete.listen((_) {
        if(!mainInUse) return; 
        playbackState.add(playbackState.value.copyWith(playing: false));
        mediaItem.drain();
        skipToNext();
      });
      secondaryPlayer.onPositionChanged.listen((Duration d) {
        if(mainInUse) return; 
        // print("AudioServiceHandler: player secondary position changed");
        playbackState.add(playbackState.value.copyWith(updatePosition: d));
      });
      secondaryPlayer.onDurationChanged.listen((Duration d) {
        if(mainInUse) return; 
        mediaItem.add(mediaItem.value?.copyWith(duration: d));
        duration = d.inMilliseconds;
      });
      secondaryPlayer.onPlayerComplete.listen((_) {
        if(mainInUse) return; 
        playbackState.add(playbackState.value.copyWith(playing: false));
        mediaItem.drain();
        skipToNext();
      });
      queue.listen((q) {
        if(q.isNotEmpty && q.length-1 > playingIndex && !nextPrepped) {
          prepNextItem();
        }
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
      playingIndex = 0;
      player.stop();
      secondaryPlayer.stop();
      queue.value = [mediaitem];
      queue.add(queue.value);
      await prepMediaItem(mediaitem);
    }

    @override
    Future<void> playFromUri(Uri uri, [Map<String, dynamic>? extras]) async {
      print("AudioServiceHandler: playing using ${mainInUse ? "secondary" : "primary"} player");
      playbackState.add(playbackState.value.copyWith(playing: true));
      await (mainInUse ? secondaryPlayer : player).play(UrlSource(uri.toString()));
      mainInUse = !mainInUse;
    }
    
    @override
    Future<void> play() async {
      print("AudioServiceHandler: playing using ${!mainInUse ? "secondary" : "primary"} player");
      playbackState.add(playbackState.value.copyWith(playing: true));
      return (!mainInUse ? secondaryPlayer : player).resume();
    }
    
    @override
    Future<void> pause() async {
      print("AudioServiceHandler: playing using ${!mainInUse ? "secondary" : "primary"} player");
      playbackState.add(playbackState.value.copyWith(playing: false));
      secondaryPlayer.pause();
      return player.pause();
    }
    
    @override
    Future<void> stop() async {
      playbackState.add(playbackState.value.copyWith(playing: false));
      // mainInUse = !mainInUse;
      nextPrepped = false;
      secondaryPlayer.stop();
      player.stop();
      player.setSourceUrl("");
      secondaryPlayer.setSourceUrl("");
    }

    @override
    Future<void> seek(Duration position) async {
      (!mainInUse ? secondaryPlayer : player).seek(position);
    }

    @override
    Future<void> skipToQueueItem(int index) async {
      playingIndex = index;
      nextPrepped = false;
      prepMediaItem(queue.value[index]);
    }
    
    @override
    Future<void> skipToNext() async {
      if(playingIndex+1 > queue.value.length-1) {
        playingIndex = 0;
      }else{
        playingIndex++;
      }
      prepMediaItem(queue.value[playingIndex]);
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
    }

    Future<void> prepMediaItem(MediaItem mediaITem) async {
      if(queue.value.isEmpty) nextPrepped = false;
      print("AudioServiceHandler: extras: ${mediaITem.extras}");
      if(!nextPrepped) {
        player.stop();
        secondaryPlayer.stop();
        print("AudioServiceHandler: playing item");
        MediaItem mediaitem = mediaITem;
        var video = await fetchYTVideo(mediaitem.id);
        var url = (PlatformUtils.isWeb) ? "$backendUrl/proxy/$video" : video;
        (mainInUse ? secondaryPlayer : player).play(UrlSource(url));
        mainInUse = !mainInUse;
        // if(mediaitem.artUri.toString() == "https://determine.com") mediaitem = mediaitem.copyWith(artUri: Uri.parse(video[1]));
        playbackState.add(playbackState.value.copyWith(playing: true));
        mediaItem.add(mediaitem.copyWith(extras: {"song": mediaITem.extras?["song"], "index": playingIndex}));
        prepNextItem();
      }else{
        print("AudioServiceHandler: playing prepped item");
        (mainInUse ? secondaryPlayer : player).play(UrlSource(nextUrl));
        mainInUse = !mainInUse;
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
      print("AudioServiceHandler: preparing next item ($nextIndex) using ${mainInUse ? "secondary" : "primary"} player");
      var mediaitem = queue.value[nextIndex];
      var video = await fetchYTVideo(queue.value[nextIndex].id);
      nextUrl = (PlatformUtils.isWeb) ? "$backendUrl/proxy/$video" : video;
      print("Prefetching ${queue.value[nextIndex].id} on ${PlatformUtils.isWeb ? "web" : "desktop"}");
      (mainInUse ? secondaryPlayer : player).setSourceUrl(nextUrl);
      // mainInUse = !mainInUse;
      nextPrepped = true;
      print("AudioServiceHandler: prepared next item");
    }
}
