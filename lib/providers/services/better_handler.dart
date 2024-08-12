// import "package:just_audio_media_kit/just_audio_media_kit.dart";
// import "package:just_audio_handlers/just_audio_handlers.dart";
import "../../platform_utils.dart";
import "package:http/http.dart" as http;

class BetterAudioHandler extends BaseAudioHandler 
  with QueueHandler, GetOriginalUri, SeekHandler {
  final player = AudioPlayer();
  final bool isWeb = PlatformUtils.isWeb;
  String backendUrl = "";
  int playingIndex = 0;
  String nextUrl = "";
  bool nextPrepped = false;
  bool loop = true;
  Duration duration = Duration.zero;

  BetterAudioHandler(String backendUrl) {
    this.backendUrl = backendUrl;
    if(!isWeb && (PlatformUtils.isLinux || PlatformUtils.isWindows)) JustAudioMediaKit.ensureInitialized();
    init().then((_) {
      print("AudioService: Init done");
    });
  }

  Future<void> init() async {
    if(backendUrl == "") backendUrl = "https://eatthecow.mooo.com:3030"; //FIXME: change to prefs url
    player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    player.positionStream.listen((Duration d) {
      if(!isWeb && PlatformUtils.isIOS && (d.inMilliseconds > (duration.inMilliseconds / 2)) && canNext) {
        print("Hacky workaround for ios. Skipping to next.");
        playbackState.add(playbackState.value.copyWith(playing: false));
        skipToNext();
      }
      // print("New position: $d");
    });
    player.durationStream.listen((Duration? d) {
      mediaItem.add(mediaItem.value?.copyWith(duration: d));
    });
  }
  

  @override
  Future<void> pause() async {
    await player.pause();
  }

  @override
  Future<void> stop() async {
    await player.stop();
    await super.stop();
  }

  @override
  Future<void> seek(newPosition) async {
    await player.seek(newPosition);
  }

  @override
  Future<void> setSpeed(double speed) async {
    await player.setSpeed(speed);
  }

  @override
  Future<void> updateQueue(List<MediaItem> newQueue) async {
    nextPrepped = false;
    nextUrl = "null!!!";
    prepNextItem();
    super.updateQueue(newQueue);
    skipToQueueItem(0);
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    var mediaitem = queue.value[index];
    await _prepareMediaItem(mediaitem.extras ?? {}, mediaitem);
    player.play();
  }

  Future<void> _prepareMediaItem(
      Map<String, dynamic> extras, MediaItem item) async {
    if (_isPlaying(item.id, extras)) return;
    Uri defaultUri = Uri.parse("");

    final parsedExtras =
        ExtraSettings.fromExtras(extras, defaultUri: defaultUri);

    if (item.extras != null) {
      item.extras!.addAll(extras);
    } else {
      item = item.copyWith(extras: extras);
    }

    print("Preparing item: ${item.id}");
    mediaItem.add(item);
    var video = await fetchYTVideo(item.id.split("youtube.com/watch?v=").last);
    var url = (isWeb) ? "$backendUrl/proxy/$video" : video;
    print("Playing: $url");

    final duration = await player.setAudioSource(
        AudioSource.uri(nextPrepped ? Uri.parse(nextUrl) : Uri.parse(url)),
        initialPosition: parsedExtras.start);
    mediaItem.drain();
    mediaItem.add(item.copyWith(id: url));

    if (duration != null && duration != item.duration) {
      mediaItem.add(item.copyWith(duration: 
        (!isWeb && PlatformUtils.isIOS) ? Duration(milliseconds: (duration.inMilliseconds / 2).round()) : duration
      ));
    }
    print("Item duration: ${item.duration}, output: $duration");

    if(nextPrepped) {
      nextPrepped = false;
      prepNextItem();
    }

    return;
  }

  bool _isPlaying(String id, Map<String, dynamic>? extras) {
    if (mediaItem.valueOrNull?.id == null) {
      return false;
    }

    return mediaItem.valueOrNull?.id == id;
  }

  Future<String> fetchYTVideo(String id) async {
    var url = await http.get(Uri.parse("https://eatthecow.mooo.com:3030/video/url/ios/$id"));
    return url.body;
  }
  
  prepNextItem() async {
    if(queue.value.length <= 1) return;
    var nextIndex = (playingIndex + 1 > queue.value.length-1) ? 0 : playingIndex + 1;
    var mediaitem = queue.value[nextIndex];
    var video = await fetchYTVideo(queue.value[nextIndex].id.split("youtube.com/watch?v=").last);
    nextUrl = (isWeb) ? "$backendUrl/proxy/$video" : video;
    nextPrepped = true;
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    loop = repeatMode == AudioServiceRepeatMode.all;
  }
  get canNext => (playingIndex + 1 > queue.value.length-1) ? false || loop : true;




  PlaybackState _transformEvent(PlaybackEvent event) {
    final isCompleted = player.processingState == ProcessingState.completed;

    return PlaybackState(
      controls: [
        MediaControl.rewind,
        if (player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.fastForward,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        // We don't support playlists yet, so when a class is completed, we're done.
        ProcessingState.completed: AudioProcessingState.idle,
      }[player.processingState]!,
      // If completed, player might say playing, but really we aren't.
      playing: player.playing && !isCompleted,
      updatePosition: player.position,
      bufferedPosition: player.bufferedPosition,
      speed: player.speed,
      queueIndex: event.currentIndex,
    );
  }
}


















class ExtraSettings {
  /// Where to start playback from.
  final Duration start;

  /// The URI to actually play (may be the same as [originalUri]).
  final Uri finalUri;

  /// The URI which the dataset states is the source (may be the same as [finalUri]).
  final Uri originalUri;

  ExtraSettings({required this.start, Uri? originalUri, Uri? finalUri})
      : originalUri = (originalUri ?? finalUri)!,
        finalUri = (finalUri ?? originalUri)!;

  ExtraSettings.fromExtras(Map<String, dynamic>? extras,
      {required Uri defaultUri})
      : this(
            start: getStartTime(extras ?? {}),
            originalUri: getOriginalUri(extras ?? {}) ?? defaultUri,
            finalUri: getOverrideUri(extras ?? {}) ?? defaultUri);

  Map<String, dynamic> toExtra() {
    final extras = Map<String, dynamic>();

    setStartTime(extras, start);
    setOverrideUri(extras, finalUri);
    setOriginalUri(extras, originalUri);

    return extras;
  }

  static Map<String, dynamic> setStartTime(
      Map<String, dynamic> extras, Duration start) {
    extras['playback-start'] = start.inMilliseconds;
    return extras;
  }

  static Duration getStartTime(Map<String, dynamic> extras) =>
      Duration(milliseconds: extras['playback-start'] ?? 0);

  static Map<String, dynamic> setOverrideUri(
      Map<String, dynamic> extras, Uri uri) {
    extras['override-uri'] = uri.toString();
    return extras;
  }

  static Uri? getOverrideUri(Map<String, dynamic> extras) =>
      extras['override-uri'] != null ? Uri.parse(extras['override-uri']) : null;

  static Uri? getOriginalUri(Map<String, dynamic> extras) =>
      extras['original-uri'] != null ? Uri.parse(extras['original-uri']) : null;

  static Uri getOriginalUriFromMediaItem(MediaItem item) =>
      getOriginalUri(item.extras ?? {}) ?? Uri.parse(item.id);

  static Map<String, dynamic> setOriginalUri(
      Map<String, dynamic> extras, Uri originalUri) {
    extras['original-uri'] = originalUri.toString();
    return extras;
  }
}
