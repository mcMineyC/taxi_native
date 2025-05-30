import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taxi_native/types/album.dart';
import 'package:taxi_native/types/artists.dart';
import 'package:taxi_native/types/playlist.dart';
import 'package:taxi_native/types/song.dart';
import '../providers/data/preferences_provider.dart';
import '../helpers/service_locator.dart';

part 'generic.freezed.dart';
part 'generic.g.dart';

@freezed
class GenericItem with _$GenericItem{
  GenericItem._();
  factory GenericItem({
    required String thingId,
    required String thingType,
    required List<String> texts,
    required String imageUrl,
    required bool isInLibrary,
    required String? addedBy,
  }) = _GenericItem;

  factory GenericItem.fromJson(Map<String, dynamic> json) => _$GenericItemFromJson(json);

  factory GenericItem.fromSong(Song s) => GenericItem(
    texts: [
      s.displayName,
      "${s.albumDisplayName} - ${s.artistDisplayName}",
    ],
    imageUrl: s.imageUrl,
    thingId: s.id,
    thingType: "song",
    addedBy: s.addedBy,
    isInLibrary: s.isInLibrary,
  );

  factory GenericItem.fromAlbum(Album a) => GenericItem(
    texts: [
      a.displayName,
      a.artistDisplayName,
    ],
    imageUrl: a.imageUrl,
    thingId: a.id,
    thingType: "album",
    addedBy: a.addedBy,
    isInLibrary: a.isInLibrary,
  );

  factory GenericItem.fromArtist(Artist s) => GenericItem(
    texts: [
      s.displayName,
    ],
    imageUrl: s.imageUrl,
    thingId: s.id,
    thingType: "artist",
    addedBy: s.addedBy,
    isInLibrary: s.isInLibrary,
  );

  factory GenericItem.fromPlaylist(Playlist p) => GenericItem(
    texts: [
      p.displayName,
      p.owner,
      p.description,
    ],
    imageUrl: "nada",
    thingId: p.id,
    thingType: "playlist",
    addedBy: p.owner,
    isInLibrary: p.isInLibrary,
  );

  factory GenericItem.placeholder() => GenericItem(
    texts: ["meh who cares"],
    thingId: "idklol",
    thingType: "placeholder",
    imageUrl: "https://placehold.co/512x512.png",
    addedBy: "someone",
    isInLibrary: false,
  );
}