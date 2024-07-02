import 'package:freezed_annotation/freezed_annotation.dart';

part 'artists.freezed.dart';
part 'artists.g.dart';

@freezed
class Artist with _$Artist {
  factory Artist({
    required String id,
    required String displayName,
    required int    albumCount,
    required int    songCount,
    required String imageUrl,
    required int    added,
  }) = _Artist;

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
}
