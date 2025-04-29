import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../../helpers/service_locator.dart';
import '../services/player.dart';
import "../../helpers/platform_utils.dart";

class MyAudioHandler extends BaseAudioHandler {
  final AudioPlayer _player = AudioPlayer();

  // Value notifiers for communicating with the Player class
  final ValueNotifier<bool> completedNotifier = ValueNotifier(false);
  final ValueNotifier<Duration> positionNotifier = ValueNotifier(Duration.zero);
  final ValueNotifier<Duration> durationNotifier = ValueNotifier(Duration.zero);
  final ValueNotifier<bool> playingNotifier = ValueNotifier(false);
  final ValueNotifier<bool> loadingNotifier = ValueNotifier(false); // Add this
  final ValueNotifier<double> volumeNotifier = ValueNotifier(1.0);
  Duration _lastKnownDuration = Duration.zero;

  // Flag to prevent double completion handling
  bool _isHandlingCompletion = false;
  bool _hasPendingDurationUpdate = false;

  MyAudioHandler() {
    _initAudioPlayer();
    // Ensure initial state is consistent
    _updatePlaybackState();
  }

  void _initAudioPlayer() {
    _player.setPlayerMode(PlayerMode.mediaPlayer);
    _player.setReleaseMode(ReleaseMode.release);

    // Set up position tracking with more frequent updates
    _player.onPositionChanged.listen((Duration position) {
      if(PlatformUtils.isMacOS || PlatformUtils.isIOS)
        position = Duration(milliseconds: position.inMilliseconds ~/ 2);
      // Make sure playback state is updated with current position
      _updatePlaybackState(position: position);
    });

    // Set up duration tracking with better handling for zero durations
    _player.onDurationChanged.listen((Duration duration) {
      if(PlatformUtils.isMacOS || PlatformUtils.isIOS)
        duration = Duration(milliseconds: duration.inMilliseconds ~/ 2);
      // If we get a valid duration, store it
      if (duration > Duration.zero) {
        _lastKnownDuration = duration;
        _hasPendingDurationUpdate = false;
      } else if (_lastKnownDuration > Duration.zero) {
        // If we get a zero duration but have a previous value, use that
        duration = _lastKnownDuration;
      } else {
        // If we still have no duration, mark it for update later
        _hasPendingDurationUpdate = true;
        // Don't continue with a zero duration
        return;
      }

      durationNotifier.value = duration;
      loadingNotifier.value = false;

      if (mediaItem.value != null) {
        // Always use a non-zero duration if available
        final Duration effectiveDuration = duration > Duration.zero
            ? duration
            : _lastKnownDuration > Duration.zero
                ? _lastKnownDuration
                : Duration.zero;

        mediaItem.add(mediaItem.value!.copyWith(duration: effectiveDuration));
      }

      // Update playback state with new duration
      _updatePlaybackState();
    });

    // Update the completion handler to preserve duration

    _player.onPlayerComplete.listen((_) {
      print("AudioHandler: Player completed track");

      // Notify listeners that the track has completed
      completedNotifier.value = true;

      // Reset the completed value after a short delay
      Future.delayed(Duration(milliseconds: 100), () {
        completedNotifier.value = false;
      });

      // Update playback state for system notification
      _updatePlaybackState(
        playing: false,
        processingState: AudioProcessingState.completed
      );

      // Make sure the duration notifier doesn't reset to zero
      if (durationNotifier.value == Duration.zero &&
          _lastKnownDuration > Duration.zero) {
        durationNotifier.value = _lastKnownDuration;

        // Also update the media item with preserved duration
        if (mediaItem.value != null) {
          mediaItem.add(mediaItem.value!.copyWith(duration: _lastKnownDuration));
        }
      }
    });

    // Set up playback state tracking with more reliable play/pause sync
    _player.onPlayerStateChanged.listen((PlayerState state) {
      final bool isPlaying = state == PlayerState.playing;

      // Only update if there's a change to avoid unnecessary UI updates
      if (playingNotifier.value != isPlaying) {
        playingNotifier.value = isPlaying;

        // Ensure UI and notification controls are in sync
        _updatePlaybackState(
          playing: isPlaying,
          processingState: _getProcessingState(state)
        );
      }
    });

    // Add error listener to handle playback errors
    // Handle errors in playUrl method instead, as audioplayers package
    // no longer exposes onPlayerError listener in newer versions
    // We'll keep track of errors in the playUrl method
    // This comment block replaces the error listener that was here before
  }

  // Helper method to consistently update playback state
  void _updatePlaybackState({
    bool? playing,
    AudioProcessingState? processingState,
    Duration? position,
  }) {
    // Get current values if not provided
    playing = playing ?? playingNotifier.value;
    processingState = processingState ??
      _getProcessingState(_player.state);
    position = position ?? positionNotifier.value;

    // Ensure we have a valid buffered position
    final bufferedPosition = position + const Duration(seconds: 10);

    // Use last known duration if current is zero
    final effectiveDuration = durationNotifier.value > Duration.zero
        ? durationNotifier.value
        : _lastKnownDuration;

    // Update the playback state with all information
    playbackState.add(playbackState.value.copyWith(
      systemActions: {
        MediaAction.play,
        MediaAction.pause,
        MediaAction.skipToNext,
        MediaAction.skipToPrevious,
        MediaAction.seek,
      },
      playing: playing,
      processingState: processingState,
      updatePosition: position,
      bufferedPosition: bufferedPosition,
      controls: getControls(playing),
    ));

    // Check if we have a pending duration update and now have data
    if (_hasPendingDurationUpdate && effectiveDuration > Duration.zero) {
      _hasPendingDurationUpdate = false;
      durationNotifier.value = effectiveDuration;

      // Also update the media item
      if (mediaItem.value != null) {
        mediaItem.add(mediaItem.value!.copyWith(duration: effectiveDuration));
      }
    }
  }

  Future<void> setVolume(double volume) async {
    // Ensure volume is between 0.0 and 1.0
    volume = volume.clamp(0.0, 1.0);

    // Update player volume
    await _player.setVolume(volume);

    // Update notifier
    volumeNotifier.value = volume;

    // Log for debugging
    print('Volume set to: $volume');
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

    // Reset completion handling flag when starting new playback
    _isHandlingCompletion = false;

    // Remember the current duration before starting new playback
    final Duration currentDuration = durationNotifier.value > Duration.zero
        ? durationNotifier.value
        : _lastKnownDuration;

    // Set loading state
    loadingNotifier.value = true;

    // Update the processing state to buffering
    _updatePlaybackState(processingState: AudioProcessingState.buffering);

    try {
      // Play the new URL
      await _player.play(UrlSource(url));

      // Explicitly set playing state after play is called
      playingNotifier.value = true;

      // If we're replaying the same track or have a previous duration,
      // retain that duration to ensure seekbar appears immediately
      if (mediaItem.value != null && currentDuration > Duration.zero) {
        // This ensures the progress bar doesn't disappear during looping
        durationNotifier.value = currentDuration;
        mediaItem.add(mediaItem.value!.copyWith(duration: currentDuration));
      }

      // Update playback state to playing with current duration
      _updatePlaybackState(
        playing: true,
        processingState: AudioProcessingState.ready
      );
    } catch (e) {
      print("Error playing URL: $e");
      loadingNotifier.value = false;
      _updatePlaybackState(processingState: AudioProcessingState.error);
    }
  }

  @override
  Future<void> play() async {
    try {
      await _player.resume();
      playingNotifier.value = true;
      _updatePlaybackState(
        playing: true,
        processingState: AudioProcessingState.ready
      );
    } catch (e) {
      print("Error resuming playback: $e");
    }
  }

  @override
  Future<void> pause() async {
    await _player.pause();
    playingNotifier.value = false;
    _updatePlaybackState(
      playing: false,
      processingState: AudioProcessingState.ready
    );
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    playingNotifier.value = false;
    _updatePlaybackState(
      playing: false,
      processingState: AudioProcessingState.idle
    );
  }

  @override
  Future<void> seek(Duration position) async {
    print("Audio handler: pre-seek to $position");
    _player.seek(position);
    positionNotifier.value = position; // Update immediately for smoother UI
    _updatePlaybackState(position: position);
    print("Audio handler: seek to $position");
    return;
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index >= 0 && index < queue.value.length) {
      print(
          "Audio handler skipping to queue item $index - ${queue.value[index].title}");

      // Keep any known duration when updating the media item
      var item = queue.value[index];
      if (_lastKnownDuration > Duration.zero) {
        mediaItem.add(item.copyWith(duration: _lastKnownDuration));
      } else {
        mediaItem.add(item);
      }
    } else {
      print(
          "Audio handler skipToQueueItem: Index $index out of bounds (queue length: ${queue.value.length})");
      // Don't throw an exception, just log the error
    }
  }

  @override
  Future<void> skipToNext() async {
    // Call the player's next() method
    print("Audio handler: skipToNext called from notification");
    try {
      final player = ServiceLocator().get<Player>();
      await player.next();
    } catch (e) {
      print("Error in skipToNext: $e");
    }
  }

  @override
  Future<void> skipToPrevious() async {
    // Call the player's previous() method
    print("Audio handler: skipToPrevious called from notification");
    try {
      final player = ServiceLocator().get<Player>();
      await player.previous();
    } catch (e) {
      print("Error in skipToPrevious: $e");
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
