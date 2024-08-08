import "package:freezed_annotation/freezed_annotation.dart";
import "package:audio_service/audio_service.dart";
import 'song.dart';

part 'queueitem.freezed.dart';
part 'queueitem.g.dart';

@freezed
class QueueItem with _$QueueItem {
  const QueueItem._();
  factory QueueItem({
    required String type,
    required String id,
    required String albumId,
    required String artistId,
    required String displayName,
    required String albumName,
    required String artistName,
    required String imageUrl,
    required String youtubeId,
    required double duration,
  }) = _QueueItem;

  factory QueueItem.fromJson(Map<String, Object?> json) => _$QueueItemFromJson(json);
  
  factory QueueItem.empty() => QueueItem(
    type: "empty",
    id: "",
    albumId: "",
    artistId: "",
    displayName: "",
    albumName: "",
    artistName: "",
    imageUrl: "",
    youtubeId: "",
    duration: 0,
  );
    
  MediaItem toMediaItem() => MediaItem(
        id: youtubeId,
        title: displayName,
        displayTitle: displayName,
        album: albumName,
        artist: artistName,
        duration: Duration.zero,
        artUri: Uri.parse(imageUrl),
        extras: {
          "queueItem": this,
        }
      );

  Song toSong() => Song(
    id: youtubeId,
    albumId: albumId,
    artistId: artistId,
    displayName: displayName,
    artistDisplayName: artistName,
    albumDisplayName: albumName,
    imageUrl: imageUrl,
    duration: duration,
    youtubeId: youtubeId,
    added: 0,
  );


}
