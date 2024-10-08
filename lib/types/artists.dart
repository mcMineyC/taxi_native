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
    required List<String> visibleTo,
    required String addedBy,
  }) = _Artist;

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);

  factory Artist.empty() => Artist(
    id: '',
    displayName: '',
    albumCount: 0,
    songCount: 0,
    imageUrl: '',
    added: 0,
    visibleTo: ["all"],
    addedBy: '',
  );
}
