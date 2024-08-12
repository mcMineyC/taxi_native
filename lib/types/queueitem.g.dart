// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queueitem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueueItemImpl _$$QueueItemImplFromJson(Map<String, dynamic> json) =>
    _$QueueItemImpl(
      type: json['type'] as String,
      id: json['id'] as String,
      albumId: json['albumId'] as String,
      artistId: json['artistId'] as String,
      displayName: json['displayName'] as String,
      albumName: json['albumName'] as String,
      artistName: json['artistName'] as String,
      imageUrl: json['imageUrl'] as String,
      youtubeId: json['youtubeId'] as String,
      duration: (json['duration'] as num).toDouble(),
      audioUrl: json['audioUrl'] as String,
    );

Map<String, dynamic> _$$QueueItemImplToJson(_$QueueItemImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'albumId': instance.albumId,
      'artistId': instance.artistId,
      'displayName': instance.displayName,
      'albumName': instance.albumName,
      'artistName': instance.artistName,
      'imageUrl': instance.imageUrl,
      'youtubeId': instance.youtubeId,
      'duration': instance.duration,
      'audioUrl': instance.audioUrl,
    };
