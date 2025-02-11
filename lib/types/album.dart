import 'package:freezed_annotation/freezed_annotation.dart';
import '../providers/data/preferences_provider.dart';
import '../service_locator.dart';

part 'album.freezed.dart';
part 'album.g.dart';

@freezed
class Album with _$Album {
  Album._();
  factory Album({
    required String id,
    required String artistId,
    required String displayName,
    required String artistDisplayName,
    required int    songCount,
    required String imageUrl,
    required int    added,
    required List<String> visibleTo,
    required List<String> inLibrary,
    required String addedBy,
  }) = _Album;

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  factory Album.empty() => Album(
    id: '',
    artistId: '',
    displayName: '',
    artistDisplayName: '',
    songCount: 0,
    imageUrl: '',
    added: 0,
    visibleTo: [],
    inLibrary: ["testguy"],
    addedBy: '',
  );

  bool get isInLibrary => inLibrary.contains(ServiceLocator().get<PreferencesProvider>().username);
}
