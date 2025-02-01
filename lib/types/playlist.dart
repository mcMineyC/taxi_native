import "package:freezed_annotation/freezed_annotation.dart";
import "song.dart";
part "playlist.freezed.dart";
part "playlist.g.dart";

@freezed
class Playlist with _$Playlist {
  factory Playlist({
    required String id,
    required String owner,
    required String displayName,
    required List<String> visibleTo,
    required List<String> allowedCollaborators,
    required List<String> songs,
    required int added,
  }) = _Playlist;

  factory Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);
  factory Playlist.empty() => Playlist(
    id: "create",
    displayName: "Common",
    songs: [],
    visibleTo: ["all"],
    allowedCollaborators: ["testguy"],
    added: 0,
    owner: "testguy"
  );
}

@freezed
class FilledPlaylist with _$FilledPlaylist {
  const FilledPlaylist._();
  factory FilledPlaylist({
    required String id,
    required String owner,
    required String displayName,
    required List<String> visibleTo,
    required List<String> allowedCollaborators,
    required List<Song> songs,
    required int added,
  }) = _FilledPlaylist;

  Playlist toPlaylist(){
    return Playlist(
      id: id,
      owner: owner,
      displayName: displayName,
      visibleTo: visibleTo,
      allowedCollaborators: allowedCollaborators,
      songs: songs.map((e) => e.id).toList(),
      added: added,
    );
  }

  factory FilledPlaylist.empty() => FilledPlaylist(
    id: "",
    owner: "nobody (:",
    displayName: "",
    visibleTo: ["all"],
    allowedCollaborators: ["testguy"],
    songs: [],
    added: 0
  );
}
