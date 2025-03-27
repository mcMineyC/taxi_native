import 'package:freezed_annotation/freezed_annotation.dart';
import '../providers/data/preferences_provider.dart';
import '../helpers/service_locator.dart';

part 'artists.freezed.dart';
part 'artists.g.dart';

@freezed
class Artist with _$Artist {
  Artist._();
  factory Artist({
    required String id,
    required String displayName,
    required int    albumCount,
    required int    songCount,
    required String imageUrl,
    required int    added,
    required List<String> visibleTo,
    required List<String> inLibrary,
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
    inLibrary: ["testguy"],
    addedBy: '',
  );
  bool get isInLibrary => inLibrary.contains(ServiceLocator().get<PreferencesProvider>().loginName);
}
