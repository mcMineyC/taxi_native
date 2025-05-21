// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchresult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchResponseImpl _$$SearchResponseImplFromJson(Map<String, dynamic> json) =>
    _$SearchResponseImpl(
      songs: (json['songs'] as List<dynamic>)
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      albums: (json['albums'] as List<dynamic>)
          .map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
      artists: (json['artists'] as List<dynamic>)
          .map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      singles: (json['singles'] as List<dynamic>)
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      relevancy:
          (json['relevancy'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$SearchResponseImplToJson(
        _$SearchResponseImpl instance) =>
    <String, dynamic>{
      'songs': instance.songs,
      'albums': instance.albums,
      'artists': instance.artists,
      'singles': instance.singles,
      'relevancy': instance.relevancy,
    };

_$LocalSearchResultImpl _$$LocalSearchResultImplFromJson(
        Map<String, dynamic> json) =>
    _$LocalSearchResultImpl(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      imageUrl: json['imageUrl'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$LocalSearchResultImplToJson(
        _$LocalSearchResultImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'imageUrl': instance.imageUrl,
      'type': instance.type,
    };

_$SearchResultImpl _$$SearchResultImplFromJson(Map<String, dynamic> json) =>
    _$SearchResultImpl(
      externalId: json['externalId'] as String,
      name: json['name'] as String,
      artist: json['artist'] as String,
      album: json['album'] as String,
      imageUrl: json['imageUrl'] as String,
      artistImageUrl: json['artistImageUrl'] as String,
      type: json['type'] as String,
      visibleTo: (json['visibleTo'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      inLibrary: (json['inLibrary'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      extra: json['extra'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$SearchResultImplToJson(_$SearchResultImpl instance) =>
    <String, dynamic>{
      'externalId': instance.externalId,
      'name': instance.name,
      'artist': instance.artist,
      'album': instance.album,
      'imageUrl': instance.imageUrl,
      'artistImageUrl': instance.artistImageUrl,
      'type': instance.type,
      'visibleTo': instance.visibleTo,
      'inLibrary': instance.inLibrary,
      'extra': instance.extra,
    };

_$FindResultImpl _$$FindResultImplFromJson(Map<String, dynamic> json) =>
    _$FindResultImpl(
      externalId: json['externalId'] as String,
      name: json['name'] as String,
      artist: json['artist'] as String,
      album: json['album'] as String,
      imageUrl: json['imageUrl'] as String,
      artistImageUrl: json['artistImageUrl'] as String,
      visibleTo:
          (json['visibleTo'] as List<dynamic>).map((e) => e as String).toList(),
      inLibrary:
          (json['inLibrary'] as List<dynamic>).map((e) => e as String).toList(),
      type: json['type'] as String,
      songs: (json['songs'] as List<dynamic>)
          .map((e) => FindResultSong.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FindResultImplToJson(_$FindResultImpl instance) =>
    <String, dynamic>{
      'externalId': instance.externalId,
      'name': instance.name,
      'artist': instance.artist,
      'album': instance.album,
      'imageUrl': instance.imageUrl,
      'artistImageUrl': instance.artistImageUrl,
      'visibleTo': instance.visibleTo,
      'inLibrary': instance.inLibrary,
      'type': instance.type,
      'songs': instance.songs,
    };

_$FindResultSongImpl _$$FindResultSongImplFromJson(Map<String, dynamic> json) =>
    _$FindResultSongImpl(
      title: json['title'] as String,
      url: json['url'] as String,
      trackNumber: (json['trackNumber'] as num).toInt(),
      externalId: json['externalId'] as String,
    );

Map<String, dynamic> _$$FindResultSongImplToJson(
        _$FindResultSongImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'trackNumber': instance.trackNumber,
      'externalId': instance.externalId,
    };

_$FoundPlaylistImpl _$$FoundPlaylistImplFromJson(Map<String, dynamic> json) {
  print(json);
    return _$FoundPlaylistImpl(
      externalId: json['externalId'] as String,
      name: json['name'] as String,
      owner: json['owner'] as String,
      ownerImageUrl: json['ownerImageUrl'] as String,
      imageUrl: json['imageUrl'] as String,
      visibleTo:
          (json['visibleTo'] as List<dynamic>).map((e) => e as String).toList(),
      allowedCollaborators: (json['allowedCollaborators'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      inLibrary:
          (json['inLibrary'] as List<dynamic>).map((e) => e as String).toList(),
      type: json['type'] as String,
      songs: (json['songs'] as List<dynamic>)
          .map((e) => FoundPlaylistSong.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
}

Map<String, dynamic> _$$FoundPlaylistImplToJson(_$FoundPlaylistImpl instance) =>
    <String, dynamic>{
      'externalId': instance.externalId,
      'name': instance.name,
      'owner': instance.owner,
      'ownerImageUrl': instance.ownerImageUrl,
      'imageUrl': instance.imageUrl,
      'visibleTo': instance.visibleTo,
      'allowedCollaborators': instance.allowedCollaborators,
      'inLibrary': instance.inLibrary,
      'type': instance.type,
      'songs': instance.songs,
    };

_$FoundPlaylistSongImpl _$$FoundPlaylistSongImplFromJson(
        Map<String, dynamic> json) =>
    _$FoundPlaylistSongImpl(
      externalId: json['externalId'] as String,
      title: json['title'] as String,
      album: json['album'] as String,
      artist: json['artist'] as String,
      albumCoverURL: json['albumCoverURL'] as String,
      artistImageUrl: json['artistImageUrl'] as String,
      visibleTo:
          (json['visibleTo'] as List<dynamic>).map((e) => e as String).toList(),
      inLibrary:
          (json['inLibrary'] as List<dynamic>).map((e) => e as String).toList(),
      url: json['url'] as String,
      trackNumber: (json['trackNumber'] as num).toInt(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$$FoundPlaylistSongImplToJson(
        _$FoundPlaylistSongImpl instance) =>
    <String, dynamic>{
      'externalId': instance.externalId,
      'title': instance.title,
      'album': instance.album,
      'artist': instance.artist,
      'albumCoverURL': instance.albumCoverURL,
      'artistImageUrl': instance.artistImageUrl,
      'visibleTo': instance.visibleTo,
      'inLibrary': instance.inLibrary,
      'url': instance.url,
      'trackNumber': instance.trackNumber,
      'type': instance.type,
    };

_$AddResultImpl _$$AddResultImplFromJson(Map<String, dynamic> json) =>
    _$AddResultImpl(
      success: json['success'] as bool,
      count: AddResultCount.fromJson(json['count'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AddResultImplToJson(_$AddResultImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
    };

_$AddResultCountImpl _$$AddResultCountImplFromJson(Map<String, dynamic> json) =>
    _$AddResultCountImpl(
      artists: (json['artists'] as num).toInt(),
      albums: (json['albums'] as num).toInt(),
      songs: (json['songs'] as num).toInt(),
    );

Map<String, dynamic> _$$AddResultCountImplToJson(
        _$AddResultCountImpl instance) =>
    <String, dynamic>{
      'artists': instance.artists,
      'albums': instance.albums,
      'songs': instance.songs,
    };
