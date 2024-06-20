import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'info_provider.dart';

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
    required int    percent,
    required bool isPlaying,
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
  final player = AudioPlayer();
  late final _sp;
  bool _isInit = false;
  Player(){
    player.onPositionChanged.listen((Duration p) {
      state = state.copyWith(position: p.inMilliseconds.toDouble()*1000);
    });
    player.onPlayerComplete.listen((event) {
      state = state.copyWith(isPlaying: false);
    });
  }

  @override
  PlayerInfo build() {
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
    );
  }

  void play() async {
    player.resume();
    state = state.copyWith(isPlaying: true);

    print("playing");
    // No need to call "notifyListeners" or anything similar. Calling "state ="
    // will automatically rebuild the UI when necessary.
  }

  void pause() async {
    player.pause();
    state = state.copyWith(isPlaying: false);
    print("paused");
  }

  void toggle() async {
    if(state.isPlaying) {
      player.pause();
    }else{
      player.resume();
    }
    setPlaying(!state.isPlaying);
  }

  void setPlaying(bool playing) async {
    state = state.copyWith(isPlaying: playing);
    print(state.isPlaying ? "playing" : "paused");
  }

  void setSong(id) async {
    if(!_isInit) _sp = await SharedPreferences.getInstance(); _isInit = true;
    ref.read(findSongProvider(id).future).then((songObject) {
      state = state.copyWith(
        id: songObject.id,
        artistId: songObject.artistId,
        albumId: songObject.albumId,
        displayName: songObject.displayName,
        isPlaying: true,
      );
    });
    await player.stop();
    await player.play(UrlSource('https://eatthecow.mooo.com:3030/info/songs/$id/audio?uname=${(await _sp.getString('username'))}'));
  }
}
