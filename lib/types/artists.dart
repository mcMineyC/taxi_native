import 'package:freezed_annotation/freezed_annotation.dart';

part 'artists.freezed.dart';
part 'artists.g.dart';

@freezed
class Artist with _$Artist {
  factory Artist({
    required String id,
    required String displayName,
  }) = _Artist;

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
}
