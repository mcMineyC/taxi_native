// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlbumImpl _$$AlbumImplFromJson(Map<String, dynamic> json) => _$AlbumImpl(
      id: json['id'] as String,
      artistId: json['artistId'] as String,
      displayName: json['displayName'] as String,
      artistDisplayName: json['artistDisplayName'] as String,
      songCount: (json['songCount'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      added: (json['added'] as num).toInt(),
      visibleTo:
          (json['visibleTo'] as List<dynamic>).map((e) => e as String).toList(),
      addedBy: json['addedBy'] as String,
    );

Map<String, dynamic> _$$AlbumImplToJson(_$AlbumImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'artistId': instance.artistId,
      'displayName': instance.displayName,
      'artistDisplayName': instance.artistDisplayName,
      'songCount': instance.songCount,
      'imageUrl': instance.imageUrl,
      'added': instance.added,
      'visibleTo': instance.visibleTo,
      'addedBy': instance.addedBy,
    };
