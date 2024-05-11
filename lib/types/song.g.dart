// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SongImpl _$$SongImplFromJson(Map<String, dynamic> json) => _$SongImpl(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      albumId: json['albumId'] as String,
      artistId: json['artistId'] as String,
      duration: (json['duration'] as num).toDouble(),
    );

Map<String, dynamic> _$$SongImplToJson(_$SongImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'albumId': instance.albumId,
      'artistId': instance.artistId,
      'duration': instance.duration,
    };
