// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hierarchicalListView.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HLVArtistImpl _$$HLVArtistImplFromJson(Map<String, dynamic> json) =>
    _$HLVArtistImpl(
      name: json['name'] as String,
      visibleTo:
          (json['visibleTo'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String,
      albums: (json['albums'] as List<dynamic>)
          .map((e) => HLVAlbum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$HLVArtistImplToJson(_$HLVArtistImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'visibleTo': instance.visibleTo,
      'imageUrl': instance.imageUrl,
      'albums': instance.albums,
    };

_$HLVAlbumImpl _$$HLVAlbumImplFromJson(Map<String, dynamic> json) =>
    _$HLVAlbumImpl(
      externalId: json['externalId'] as String,
      name: json['name'] as String,
      visibleTo:
          (json['visibleTo'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String,
      artistImageUrl: json['artistImageUrl'] as String,
      songs: (json['songs'] as List<dynamic>)
          .map((e) => HLVSong.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$HLVAlbumImplToJson(_$HLVAlbumImpl instance) =>
    <String, dynamic>{
      'externalId': instance.externalId,
      'name': instance.name,
      'visibleTo': instance.visibleTo,
      'imageUrl': instance.imageUrl,
      'artistImageUrl': instance.artistImageUrl,
      'songs': instance.songs,
    };

_$HLVSongImpl _$$HLVSongImplFromJson(Map<String, dynamic> json) =>
    _$HLVSongImpl(
      externalId: json['externalId'] as String,
      name: json['name'] as String,
      visibleTo:
          (json['visibleTo'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String,
      artistImageUrl: json['artistImageUrl'] as String,
      audioUrl: json['audioUrl'] as String,
      trackNumber: (json['trackNumber'] as num).toInt(),
    );

Map<String, dynamic> _$$HLVSongImplToJson(_$HLVSongImpl instance) =>
    <String, dynamic>{
      'externalId': instance.externalId,
      'name': instance.name,
      'visibleTo': instance.visibleTo,
      'imageUrl': instance.imageUrl,
      'artistImageUrl': instance.artistImageUrl,
      'audioUrl': instance.audioUrl,
      'trackNumber': instance.trackNumber,
    };
