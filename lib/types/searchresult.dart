import 'package:freezed_annotation/freezed_annotation.dart';
import "song.dart";
import "album.dart";
import "artists.dart";

part 'searchresult.freezed.dart';
part 'searchresult.g.dart';

@freezed
class SearchResponse with _$SearchResponse {
  const SearchResponse._();
  const factory SearchResponse({
    required List<Song> songs,
    required List<Album> albums,
    required List<Artist> artists,
    required List<Song> singles,
    required List<String> relevancy,
  }) = _SearchResponse;

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  factory SearchResponse.empty() => SearchResponse(
    songs: [],
    albums: [],
    artists: [],
    singles: [],
    relevancy: [],
  );
}

@freezed
class LocalSearchResult with _$LocalSearchResult {
  const LocalSearchResult._();
  const factory LocalSearchResult({
    required String id,
    required String displayName,
    required String imageUrl,
    required String type,
  }) = _LocalSearchResult;

  factory LocalSearchResult.fromJson(Map<String, dynamic> json) =>
      _$LocalSearchResultFromJson(json);
}

@freezed
class SearchResult with _$SearchResult {
  const SearchResult._();
  const factory SearchResult({
    required String id,
    required String name,
    required String artist,
    required String album,
    required String imageUrl,
    required String artistImageUrl,
    required String type,
  }) = _SearchResult;

  get cardString => switch(type) {
    "song" => "$name - $artist: $album",
    "album" => "$name - $artist",
    "artist" => name,
    _ => name
  };

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}

@freezed
class FindResult with _$FindResult {
  const FindResult._();
  const factory FindResult({
    required String name,
    required String artist,
    required String album,
    required String imageUrl,
    required String artistImageUrl,
    required List<String> visibleTo,
    required List<String> inLibrary,
    required String type,
    required List<FindResultSong> songs,
  }) = _FindResult;

  //get cardString => this.artistImageUrl;
  get cardString => switch(type) {
    "song" => "${songs[0].title} - $artist: $name",
    "album" => "$name - $artist",
    "artist" => name,
    "playlist" => name,
    _ => name
  };

  factory FindResult.fromJson(Map<String, dynamic> json) =>
      _$FindResultFromJson(json);

  factory FindResult.fromSong(Song song) => FindResult(
    type: "song",
    name: song.displayName,
    album: song.albumDisplayName,
    artist: song.artistDisplayName,
    imageUrl: song.imageUrl,
    artistImageUrl: song.imageUrl,
    visibleTo: song.visibleTo,
    inLibrary: song.inLibrary,
    songs: [FindResultSong(title: song.displayName, url: song.audioUrl, trackNumber: 0)],
    );

}

@freezed
class FindResultSong with _$FindResultSong {
  const factory FindResultSong({
    required String title,
    required String url, 
    required int trackNumber,
  }) = _FindResultSong;

  factory FindResultSong.fromJson(Map<String, dynamic> json) =>
      _$FindResultSongFromJson(json);

}

@freezed
class AddResult with _$AddResult {
  const AddResult._();
  const factory AddResult({
    required bool success,
    required AddResultCount count,
  }) = _AddResult;

  factory AddResult.fromJson(Map<String, dynamic> json) =>
      _$AddResultFromJson(json);
}

@freezed
class AddResultCount with _$AddResultCount {
  const factory AddResultCount({
    required int artists,
    required int albums,
    required int songs,
  }) = _AddResultCount;

  factory AddResultCount.fromJson(Map<String, dynamic> json) =>
      _$AddResultCountFromJson(json);
}


enum SearchType {
  track('Song', 'track'),
  album('Album', 'album'),
  artist('Artist', 'artist'),
  //playlist('Playlist', 'playlist'),
  url("URL", "url"),
  all('All', 'all');

  const SearchType(this.label, this.type);
  final String label;
  final String type;
}

enum SearchSource {
  spotify('Spotify', 'spotify');
  //spotify('Spotify', 'spotify'),
  //youtube('YouTube', 'youtube'),
  //scratch('Scratch', 'scratch'),
  //custom('Custom (MP3)', 'custom');

  const SearchSource(this.label, this.type);
  final String label;
  final String type;
}
final spotifyUrlRegex = RegExp(r'https:\/\/open\.spotify\.com\/(track|album|artist|playlist)\/([^?]*)(\?si=.*)?');
