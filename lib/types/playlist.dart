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
    required bool public,
    required List<String> songs,
    required int added,
  }) = _Playlist;

  factory Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);
}

@freezed
class FilledPlaylist with _$FilledPlaylist {
  const FilledPlaylist._();
  factory FilledPlaylist({
    required String id,
    required String owner,
    required String displayName,
    required bool public,
    required List<Song> songs,
    required int added,
  }) = _FilledPlaylist;

  Playlist toPlaylist(){
    return Playlist(
      id: id,
      owner: owner,
      displayName: displayName,
      public: public,
      songs: songs.map((e) => e.id).toList(),
      added: added,
    );
  }

  factory FilledPlaylist.empty() => FilledPlaylist(
    id: "",
    owner: "nobody (:",
    displayName: "",
    public: true,
    songs: [],
    added: 0
  );
}
