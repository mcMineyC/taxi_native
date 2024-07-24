// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaylistImpl _$$PlaylistImplFromJson(Map<String, dynamic> json) =>
    _$PlaylistImpl(
      id: json['id'] as String,
      owner: json['owner'] as String,
      displayName: json['displayName'] as String,
      public: json['public'] as bool,
      songs: (json['songs'] as List<dynamic>).map((e) => e as String).toList(),
      added: (json['added'] as num).toInt(),
    );

Map<String, dynamic> _$$PlaylistImplToJson(_$PlaylistImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner': instance.owner,
      'displayName': instance.displayName,
      'public': instance.public,
      'songs': instance.songs,
      'added': instance.added,
    };
