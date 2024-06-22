import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audio_service/audio_service.dart';

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
    required double position,
    required double percent,
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
  late AudioHandler audioHandler;
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
      percent: 0,
      isPlaying: false,
      queue: [],
    );
  }

  void init() async {
    if(_hIsInit) return;
    print("Playerinfo: init");
    _hIsInit = true;
    AudioServiceHandler handy = AudioServiceHandler();
    audioHandler = await AudioService.init(
      builder: () => handy,
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.forkleserver.taxi.native.channel.music',
        androidNotificationChannelName: 'Music',
        androidNotificationOngoing: true,
      ),
    );
    handy.init((Duration p) {
      state = state.copyWith(
        position: p.inMilliseconds.toDouble()/1000,
        percent: (p.inMilliseconds.toDouble()/1000) / state.duration
      );
    },
    () {
      state = state.copyWith(isPlaying: false);
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

  void setPlaying(bool playing) async {
    state = state.copyWith(isPlaying: playing);
    print(state.isPlaying ? "playing" : "paused");
  }

  void setSong(String id) async {
    if(state.id == id) return; //Debounce duplicate calls :shrug: maybe this will fix the duplicates in recentlyplayed
    print("Song setter: $id");
    if(!_isInit) _sp = await SharedPreferences.getInstance(); _isInit = true;
    ref.read(findSongProvider(id).future).then((songObject) {
      state = state.copyWith(
        id: songObject.id,
        artistId: songObject.artistId,
        albumId: songObject.albumId,
        displayName: songObject.displayName,
        albumDisplayName: songObject.albumDisplayName,
        artistDisplayName: songObject.artistDisplayName,
        isPlaying: true,
      );
    });
    audioHandler.stop().then((value) async {
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
    List<MediaItem> queued = [];
    int playingIndex = 0;

    void init(positionChangedCallback, playbackFinishedCallback) {
      player.onPositionChanged.listen(positionChangedCallback);
    }

    @override
    Future<void> addQueueItem(MediaItem mediaItem) async {
      queued.add(mediaItem);
    }
    
    @override
    Future<void> addQueueItems(List<MediaItem> mediaItems) async {
      queued.addAll(mediaItems);
    }
    
    @override
    Future<void> removeQueueItem(MediaItem mediaItem) async {
      queued.remove(mediaItem);
    }
    
    @override
    Future<void> removeQueueItemAt(int index) async {
      queued.removeAt(index);
    }
    
    @override
    Future<void> playMediaItem(MediaItem mediaitem) async {
      mediaItem.drain().then((value) {mediaItem.add(mediaitem);});
      queued = [mediaitem];
      player.play(UrlSource(mediaitem.id));
    }

    @override
    Future<void> playFromUri(Uri uri, [Map<String, dynamic>? extras]) async {
      await player.play(UrlSource(uri.toString()));
    }
    
    @override
    Future<void> play() async {
      return player.resume();
    }
    
    @override
    Future<void> pause() async {
      return player.pause();
    }
    
    @override
    Future<void> stop() async {
      return player.stop();
    }

    @override
    Future<void> seek(Duration position) async {
      player.seek(position);
    }

    @override
    Future<void> skipToQueueItem(int index) async {
      playMediaItem(queued[index]);
    }
    
    @override
    Future<void> skipToNext() async {
      if(playingIndex+1 > queued.length-1) {
        playingIndex = 0;
      }else{
        playingIndex++;
      }
      playMediaItem(queued[playingIndex]);
    }
    
    @override
    Future<void> skipToPrevious() async {
      if(playingIndex-1 < queued.length) {
        playingIndex = queued.length - 1;
      }else{
        playingIndex--;
      }
      playMediaItem(queued[playingIndex]);

    }
}
