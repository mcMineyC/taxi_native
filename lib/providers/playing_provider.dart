import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import '../service_locator.dart';

import 'info_provider.dart';

import '../types/song.dart';

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
    required List<Song> queue,
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
      id: '1d822fde641a597beb59ba197388b85e40eafb39d007be53f1c1da9b36d6a8df_00879b25b7e52685100c540611c16c5974b224ef79c692a9f58e43764532064d_afb9215a04c112dd39bcdd9b67b9f45073eb8aa9dbbdb73f6adceaa6e7840e57',
      artistId: '1d822fde641a597beb59ba197388b85e40eafb39d007be53f1c1da9b36d6a8df',
      albumId: '1d822fde641a597beb59ba197388b85e40eafb39d007be53f1c1da9b36d6a8df_00879b25b7e52685100c540611c16c5974b224ef79c692a9f58e43764532064d',
      displayName: '',
      artistDisplayName: '',
      albumDisplayName: '',
      duration: 213.6,
      position: 0,
      isPlaying: false,
      queue: [],
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
    audioHandler.queue.listen((List<MediaItem> l) {
      print("New queue thing: ${l.map((i) => i.title)}");
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
    if(state.id == id) return; //Debounce duplicate calls :shrug: maybe this will fix the duplicates in recentlyplayed
    print("Song setter: $id");
    if(!_isInit) _sp = await SharedPreferences.getInstance(); _isInit = true;
    ref.read(findSongProvider(id).future).then((songObject) async {
      state = state.copyWith(
        id: songObject.id,
        artistId: songObject.artistId,
        albumId: songObject.albumId,
        displayName: songObject.displayName,
        albumDisplayName: songObject.albumDisplayName,
        artistDisplayName: songObject.artistDisplayName,
        isPlaying: true,
      );
      final item = MediaItem(
        id: 'https://eatthecow.mooo.com:3030/info/songs/$id/audio',
        title: state.displayName,
        album: state.albumDisplayName,
        artist: state.artistDisplayName,
        duration: Duration(seconds: state.duration.toInt()),
        artUri: Uri.parse('https://eatthecow.mooo.com:3030/info/songs/$id/image'),
      );
      await audioHandler.playMediaItem(item);
    });
    ref.read(addRecentlyPlayedProvider(id).future).then((value) {
      if(value == true) ref.refresh(fetchRecentlyPlayedProvider.future);
    });
  }

  void setQueue(List<Song> queue) async {
    state = state.copyWith(queue: queue);
  }

  void addToQueue(Song song) async {
    audioHandler.addQueueItem(song.toMediaItem());
    state = state.copyWith(queue: [...state.queue, song]);
  }

  void addIdToQueue(String id) async {
    Song song = await ref.read(findSongProvider(id).future);
    audioHandler.addQueueItem(song.toMediaItem());
    state = state.copyWith(queue: [...state.queue, song]);
  }

  void clearQueue() async {
    state = state.copyWith(queue: []);
  }
}

class AudioServiceHandler extends BaseAudioHandler 
    with QueueHandler {
    
    final player = AudioPlayer();
    int playingIndex = 0;
    bool shuffle = false;

    // void init(positionChangedCallback, playbackFinishedCallback) {
    //   player.onPositionChanged.listen(positionChangedCallback);
    // }

    void init() {
      player.onPositionChanged.listen((Duration d) {
        playbackState.add(playbackState.value.copyWith(updatePosition: d));
      });
      player.onDurationChanged.listen((Duration d) {
        mediaItem.add(mediaItem.value?.copyWith(duration: d));
      });
      player.onPlayerComplete.listen((_) {
        playbackState.add(playbackState.value.copyWith(playing: false));
        mediaItem.drain();
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
    }
    
    @override
    Future<void> removeQueueItem(MediaItem mediaItem) async {
      queue.value.remove(mediaItem);
    }
    
    @override
    Future<void> removeQueueItemAt(int index) async {
      queue.value.removeAt(index);
    }
    
    @override
    Future<void> playMediaItem(MediaItem mediaitem) async {
      await prepMediaItem(mediaitem);
      queue.value = [mediaitem];
    }

    @override
    Future<void> playFromUri(Uri uri, [Map<String, dynamic>? extras]) async {
      playbackState.add(playbackState.value.copyWith(playing: true));
      await player.play(UrlSource(uri.toString()));
    }
    
    @override
    Future<void> play() async {
      playbackState.add(playbackState.value.copyWith(playing: true));
      return player.resume();
    }
    
    @override
    Future<void> pause() async {
      playbackState.add(playbackState.value.copyWith(playing: false));
      return player.pause();
    }
    
    @override
    Future<void> stop() async {
      playbackState.add(playbackState.value.copyWith(playing: false));
      return player.stop();
    }

    @override
    Future<void> seek(Duration position) async {
      player.seek(position);
    }

    @override
    Future<void> skipToQueueItem(int index) async {
      playMediaItem(queue.value[index]);
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
      if(playingIndex-1 < queue.value.length) {
        playingIndex = queue.value.length - 1;
      }else{
        playingIndex--;
      }
        playMediaItem(queue.value[playingIndex]);
    }

    Future<void> prepMediaItem(MediaItem mediaitem) async {
      playbackState.add(playbackState.value.copyWith(playing: true));
      mediaItem.add(mediaitem);
      player.play(UrlSource(mediaitem.id));
    }
}
