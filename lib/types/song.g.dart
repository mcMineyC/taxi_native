// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SongImpl _$$SongImplFromJson(Map<String, dynamic> json) => _$SongImpl(
      id: json['id'] as String,
      albumId: json['albumId'] as String,
      artistId: json['artistId'] as String,
      displayName: json['displayName'] as String,
      albumDisplayName: json['albumDisplayName'] as String,
      artistDisplayName: json['artistDisplayName'] as String,
      imageUrl: json['imageUrl'] as String,
      youtubeId: json['youtubeId'] as String,
      added: (json['added'] as num).toInt(),
      duration: (json['duration'] as num).toDouble(),
    );

Map<String, dynamic> _$$SongImplToJson(_$SongImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'albumId': instance.albumId,
      'artistId': instance.artistId,
      'displayName': instance.displayName,
      'albumDisplayName': instance.albumDisplayName,
      'artistDisplayName': instance.artistDisplayName,
      'imageUrl': instance.imageUrl,
      'youtubeId': instance.youtubeId,
      'added': instance.added,
      'duration': instance.duration,
    };
