import "package:freezed_annotation/freezed_annotation.dart";
import "package:just_audio_background/just_audio_background.dart";
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
    required double duration,
    required String audioUrl,
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
    duration: 0,
    audioUrl: "blank:",
  );
    
  MediaItem toMediaItem() => MediaItem(
        id: RegExp(r'\${{%(.*)%}}\$(.*)').firstMatch(audioUrl)?.group(2) ?? "",
        title: displayName,
        album: albumName,
        artist: artistName,
        duration: Duration.zero,
        artUri: Uri.parse(imageUrl),
        extras: {
          "queueItem": this,
        }
      );

  Song toSong() => Song(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    albumId: albumId,
    artistId: artistId,
    displayName: displayName,
    artistDisplayName: artistName,
    albumDisplayName: albumName,
    imageUrl: imageUrl,
    duration: duration,
    audioUrl: audioUrl,
    added: 0,
    addedBy: "jedi",
    visibleTo: ["all"],
    inLibrary: ["testguy"]
  );
}
