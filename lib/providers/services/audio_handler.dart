
import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class MyAudioHandler extends BaseAudioHandler {
  final AudioPlayer _player = AudioPlayer();

  // Value notifiers for communicating with the Player class
  final ValueNotifier<Duration> positionNotifier = ValueNotifier(Duration.zero);
  final ValueNotifier<Duration> durationNotifier = ValueNotifier(Duration.zero);
  final ValueNotifier<bool> playingNotifier = ValueNotifier(false);
  final ValueNotifier<bool> completedNotifier = ValueNotifier(false);

  MyAudioHandler() {
    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    // Set up position tracking
    _player.onPositionChanged.listen((Duration position) {
      positionNotifier.value = position;
      playbackState.add(playbackState.value.copyWith(
        updatePosition: position,
        bufferedPosition: position + const Duration(seconds: 10),
      ));
    });

    // Set up duration tracking
    _player.onDurationChanged.listen((Duration duration) {
      durationNotifier.value = duration;
      if (mediaItem.value != null) {
        mediaItem.add(mediaItem.value!.copyWith(duration: duration));
      }
    });

    // Set up playback state tracking
    _player.onPlayerStateChanged.listen((PlayerState state) {
      final bool isPlaying = state == PlayerState.playing;
      playingNotifier.value = isPlaying;

      playbackState.add(playbackState.value.copyWith(
        playing: isPlaying,
        processingState: _getProcessingState(state),
        controls: getControls(isPlaying),
      ));
    });

    // Set up completion tracking
    _player.onPlayerComplete.listen((_) {
      completedNotifier.value = true;
      playbackState.add(playbackState.value.copyWith(
        playing: false,
        processingState: AudioProcessingState.completed,
      ));
    });
  }

  // Helper method to get controls based on playback state
  List<MediaControl> getControls(bool playing) {
    return [
      MediaControl.skipToPrevious,
      if (playing) MediaControl.pause else MediaControl.play,
      MediaControl.skipToNext,
      MediaControl.stop,
    ];
  }

  AudioProcessingState _getProcessingState(PlayerState state) {
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

  // Method to play a URL (called by Player)
  Future<void> playUrl(String url) async {
    if (url.isEmpty) return;

    await _player.play(UrlSource(url));
    // Reset completion status when starting a new track
    completedNotifier.value = false;
  }

  @override
  Future<void> play() async {
    await _player.resume();
    playbackState.add(playbackState.value.copyWith(
      playing: true,
      controls: getControls(true),
    ));
  }

  @override
  Future<void> pause() async {
    await _player.pause();
    playbackState.add(playbackState.value.copyWith(
      playing: false,
      controls: getControls(false),
    ));
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    playbackState.add(playbackState.value.copyWith(
      playing: false,
      processingState: AudioProcessingState.idle,
    ));
  }

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
    playbackState.add(playbackState.value.copyWith(updatePosition: position));
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < queue.value.length) {
      mediaItem.add(queue.value[index]);
    }
  }

  // Set looping status
  Future<void> setLooping(bool looping) async {
    await _player.setReleaseMode(looping ? ReleaseMode.loop : ReleaseMode.release);
  }

  // Dispose resources when done
  void dispose() {
    _player.dispose();
  }
}
