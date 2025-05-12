// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hierarchicalListView.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HLVPlaylistImpl _$$HLVPlaylistImplFromJson(Map<String, dynamic> json) =>
    _$HLVPlaylistImpl(
      name: json['name'] as String,
      owner: json['owner'] as String,
      ownerImageUrl: json['ownerImageUrl'] as String,
      visibleTo:
          (json['visibleTo'] as List<dynamic>).map((e) => e as String).toList(),
      allowedCollaborators: (json['allowedCollaborators'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      inLibrary:
          (json['inLibrary'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String,
      artists: (json['artists'] as List<dynamic>)
          .map((e) => HLVArtist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$HLVPlaylistImplToJson(_$HLVPlaylistImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'owner': instance.owner,
      'ownerImageUrl': instance.ownerImageUrl,
      'visibleTo': instance.visibleTo,
      'allowedCollaborators': instance.allowedCollaborators,
      'inLibrary': instance.inLibrary,
      'imageUrl': instance.imageUrl,
      'artists': instance.artists,
    };

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
      'name': instance.name,
      'visibleTo': instance.visibleTo,
      'imageUrl': instance.imageUrl,
      'artistImageUrl': instance.artistImageUrl,
      'songs': instance.songs,
    };

_$HLVSongImpl _$$HLVSongImplFromJson(Map<String, dynamic> json) =>
    _$HLVSongImpl(
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
      'name': instance.name,
      'visibleTo': instance.visibleTo,
      'imageUrl': instance.imageUrl,
      'artistImageUrl': instance.artistImageUrl,
      'audioUrl': instance.audioUrl,
      'trackNumber': instance.trackNumber,
    };
