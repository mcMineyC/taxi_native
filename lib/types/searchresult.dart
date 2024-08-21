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
    required String type,
    required List<FindResultSong> songs,
  }) = _FindResult;

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
    songs: [FindResultSong(title: song.displayName, id: song.youtubeId, trackNumber: 0)],
    );

}

@freezed
class FindResultSong with _$FindResultSong {
  const factory FindResultSong({
    required String title,
    required String id, 
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
  all('All', 'all');

  const SearchType(this.label, this.type);
  final String label;
  final String type;
}
