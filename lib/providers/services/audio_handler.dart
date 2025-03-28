import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class MyAudioHandler extends BaseAudioHandler {
  final AudioPlayer _player = AudioPlayer();

  // Value notifiers for communicating with the Player class
  final ValueNotifier<Duration> positionNotifier = ValueNotifier(Duration.zero);
  final ValueNotifier<Duration> durationNotifier = ValueNotifier(Duration.zero);
  final ValueNotifier<bool> playingNotifier = ValueNotifier(false);
  final ValueNotifier<bool> loadingNotifier = ValueNotifier(false); // Add this

  MyAudioHandler() {
    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    // playbackState.add(playbackState.value.copyWith(
    //   systemActions: {
    //     MediaAction.seek,
    //   },
    // ));
    _player.setPlayerMode(PlayerMode.mediaPlayer);
    _player.setReleaseMode(ReleaseMode.release);

    // Set up position tracking
    _player.onPositionChanged.listen((Duration position) {
      positionNotifier.value = position;
      playbackState.add(playbackState.value.copyWith(
        systemActions: {
          MediaAction.seek,
        },
        updatePosition: position,
        bufferedPosition: position + const Duration(seconds: 10),
      ));
    });

    // Set up duration tracking
    _player.onDurationChanged.listen((Duration duration) {
      durationNotifier.value = duration;
      // Indicate loading is complete when we get duration
      loadingNotifier.value = false;

      if (mediaItem.value != null) {
        mediaItem.add(mediaItem.value!.copyWith(duration: duration));
      }
    });

    // Set up playback state tracking
    _player.onPlayerStateChanged.listen((PlayerState state) {
      final bool isPlaying = state == PlayerState.playing;
      playingNotifier.value = isPlaying;

      playbackState.add(playbackState.value.copyWith(
        systemActions: {
          MediaAction.seek,
        },
        playing: isPlaying,
        processingState: _getProcessingState(state),
        controls: getControls(isPlaying),
      ));
    });

    // Set up completion tracking

  _player.onPlayerComplete.listen((_) {
    // completedNotifier.value = true;
    print("Player completed track");

    // Update state first
    playbackState.add(playbackState.value.copyWith(
      playing: false,
      processingState: AudioProcessingState.completed,
    ));
  });

    // Add error listener
    // _player.onPlayerError.listen((error) {
    //   print("AudioPlayer error: $error");
    //   loadingNotifier.value = false;
    //   playbackState.add(playbackState.value.copyWith(
    //     processingState: AudioProcessingState.error,
    //   ));
    // });
  }

  // Helper method to get controls based on playback state
  List<MediaControl> getControls(bool playing) {
    return [
      MediaControl.skipToPrevious,
      if (playing) MediaControl.pause else MediaControl.play,
      MediaControl.skipToNext,
    ];
  }

  AudioProcessingState _getProcessingState(PlayerState state) {
    // If we're still loading, return buffering state
    if (loadingNotifier.value) {
      return AudioProcessingState.buffering;
    }

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

    // Set loading state
    loadingNotifier.value = true;

    // Update the processing state to buffering
    playbackState.add(playbackState.value.copyWith(
      processingState: AudioProcessingState.buffering,
    ));

    try {
      // Stop any existing playback first
      // await _player.stop();

      // Play the new URL
      await _player.play(UrlSource(url));

      // Explicitly set playing state after play is called
      playingNotifier.value = true;
      playbackState.add(playbackState.value.copyWith(
        systemActions: {
          MediaAction.seek,
        },
        playing: true,
        controls: getControls(true),
      ));
    } catch (e) {
      print("Error playing URL: $e");
      loadingNotifier.value = false;
    }
  }

  @override
  Future<void> play() async {
    try {
      await _player.resume();
      playingNotifier.value = true;
      playbackState.add(playbackState.value.copyWith(
        systemActions: {
          MediaAction.seek,
        },
        playing: true,
        controls: getControls(true),
      ));
    } catch (e) {
      print("Error resuming playback: $e");
    }
  }

  @override
  Future<void> pause() async {
    await _player.pause();
    playingNotifier.value = false;
    playbackState.add(playbackState.value.copyWith(
      systemActions: {
        MediaAction.seek,
      },
      playing: false,
      controls: getControls(false),
    ));
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    playingNotifier.value = false;
    playbackState.add(playbackState.value.copyWith(
      systemActions: {
        MediaAction.seek,
      },
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
    if (index >= 0 && index < queue.value.length) {
      print("Audio handler skipping to queue item $index - ${queue.value[index].title}");
      mediaItem.add(queue.value[index]);
    } else {
      print("Audio handler skipToQueueItem: Index $index out of bounds (queue length: ${queue.value.length})");
      // Don't throw an exception, just log the error
    }
  }

  // Set looping status
  Future<void> setLooping(bool looping) async {
    // await _player.setReleaseMode(looping ? ReleaseMode.loop : ReleaseMode.release);
  }

  // Dispose resources when done
  void dispose() {
    _player.dispose();
  }
}
