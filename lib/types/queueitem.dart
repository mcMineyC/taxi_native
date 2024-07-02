import "package:freezed_annotation/freezed_annotation.dart";

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
    required String youtubeId,
  }) = _QueueItem;

  factory QueueItem.fromJson(Map<String, Object?> json) => _$QueueItemFromJson(json);
}
