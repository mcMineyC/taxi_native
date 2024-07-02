import 'package:freezed_annotation/freezed_annotation.dart';

part 'album.freezed.dart';
part 'album.g.dart';

@freezed
class Album with _$Album {
  factory Album({
    required String id,
    required String artistId,
    required String displayName,
    required String artistDisplayName,
    required int    songCount,
    required String imageUrl,
    required int    added,
  }) = _Album;

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
}
