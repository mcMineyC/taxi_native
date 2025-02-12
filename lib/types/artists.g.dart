// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArtistImpl _$$ArtistImplFromJson(Map<String, dynamic> json) => _$ArtistImpl(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      albumCount: (json['albumCount'] as num).toInt(),
      songCount: (json['songCount'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      added: (json['added'] as num).toInt(),
      visibleTo:
          (json['visibleTo'] as List<dynamic>).map((e) => e as String).toList(),
      inLibrary:
          (json['inLibrary'] as List<dynamic>).map((e) => e as String).toList(),
      addedBy: json['addedBy'] as String,
    );

Map<String, dynamic> _$$ArtistImplToJson(_$ArtistImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'albumCount': instance.albumCount,
      'songCount': instance.songCount,
      'imageUrl': instance.imageUrl,
      'added': instance.added,
      'visibleTo': instance.visibleTo,
      'inLibrary': instance.inLibrary,
      'addedBy': instance.addedBy,
    };
