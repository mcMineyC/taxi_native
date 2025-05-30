import 'searchresult.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import "package:freezed_annotation/freezed_annotation.dart";

part "hierarchicalListView.freezed.dart";
part 'hierarchicalListView.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class HLVArtist with _$HLVArtist {
  HLVArtist._();
  factory HLVArtist({
    required String name,
    required List<String> visibleTo,
    required String imageUrl,
    required Map<String, HLVAlbum> albums,
  }) = _HLVArtist;
  factory HLVArtist.fromJson(Map<String, Object?> json) => _$HLVArtistFromJson(json);
}

@Freezed(makeCollectionsUnmodifiable: false)
class HLVAlbum with _$HLVAlbum {
  HLVAlbum._();
  factory HLVAlbum({
    required String externalId,
    required String name,
    required List<String> visibleTo,
    required String imageUrl,
    required String artistImageUrl,
    required Map<String, HLVSong> songs,
  }) = _HLVAlbum;
  factory HLVAlbum.fromJson(Map<String, Object?> json) => _$HLVAlbumFromJson(json);
}

@Freezed(makeCollectionsUnmodifiable: false)
class HLVSong with _$HLVSong {
  HLVSong._();
  factory HLVSong({
    required String externalId,
    required String name,
    required List<String> visibleTo,
    required String imageUrl,
    required String artistImageUrl,
    required String audioUrl,
    required int trackNumber,
  }) = _HLVSong;
  factory HLVSong.fromJson(Map<String, Object?> json) => _$HLVSongFromJson(json);
}

List<HLVArtist> findResultsToHLVContent(List<FindResult> results){
  Map<String, HLVArtist> artists = {};
  for (var result in results) {
    if (!artists.keys.contains(result.artist)) {
      print("Artist: " + result.artist + " " + result.visibleTo.toString());
      artists[result.artist] = HLVArtist(
        name: result.artist,
        visibleTo: result.visibleTo,
        imageUrl: result.artistImageUrl,
        albums: {}
      );
    }
    HLVArtist workingArtist = artists[result.artist]!;
    if (result.type == "album") {
      if (workingArtist.albums.isEmpty || !workingArtist.albums.keys.contains(result.name)) {
        artists[result.artist]!.albums[result.album] = HLVAlbum(
          externalId: result.externalId,
          name: result.album,
          imageUrl: result.imageUrl,
          visibleTo: result.visibleTo,
          songs: {},
          artistImageUrl: result.artistImageUrl
        );
        Map<String, HLVSong> albumSongs = {};
        result.songs.forEach((s) => albumSongs[s.title] = HLVSong(
            externalId: result.externalId,
            name: s.title,
            audioUrl: s.url,
            visibleTo: result.visibleTo,
            imageUrl: result.imageUrl,
            artistImageUrl: result.artistImageUrl,
            trackNumber: s.trackNumber
          )
        );
        artists[result.artist]!.albums[result.album] = artists[result.artist]!.albums[result.album]!.copyWith(
          songs: albumSongs
        );
      }
    }
    if (result.type == "song") {
      // BUG THIS IS DUPLICATED FOR SOME REASON
      print("This is 93: ${result.visibleTo}");
      if (artists[result.artist]!.albums.keys.contains(result.album)) { // existing album
        artists[result.artist]!.albums[result.album]!.songs[result.songs[0].title] = (HLVSong(
            externalId: result.songs[0].externalId,
            name: result.songs[0].title,
            audioUrl: result.songs[0].url,
            visibleTo: result.visibleTo,
            imageUrl: result.imageUrl,
            artistImageUrl: result.artistImageUrl,
            trackNumber: result.songs[0].trackNumber));
      } else { // new album
        artists[result.artist]!.albums[result.album] = HLVAlbum(
          externalId: result.externalId,
          name: result.album,
          imageUrl: result.imageUrl,
          artistImageUrl: result.artistImageUrl,
          visibleTo: result.visibleTo,
          songs: {
            result.songs[0].title: 
            HLVSong(
              externalId: result.songs[0].externalId,
              name: result.songs[0].title,
              audioUrl: result.songs[0].url,
              visibleTo: result.visibleTo,
              imageUrl: result.imageUrl,
              artistImageUrl: result.artistImageUrl,
              trackNumber: result.songs[0].trackNumber),
          },
        );
      }
    }
    artists[result.artist] = artists[result.artist]!.copyWith(albums: artists[result.artist]!.albums);
  }
  return artists.values.toList();
}

void printHLVContent(List<HLVArtist> artists) {
  for (var artist in artists) {
    print("Artist: ${artist.name}");
    for (var album in artist.albums.values.toList()) {
      print("  Album: ${album.name}");
      print("  - Image: ${album.imageUrl}");
      print("  - Artist Image: ${album.artistImageUrl}");
      for (var song in album.songs.values.toList()) {
        print("    Song: ${song.name}");
        print("    - URL: ${song.audioUrl}");
        print("    - Image: ${song.imageUrl}");
        print("    - Artist Image: ${song.artistImageUrl}");
      }
    }
  }
}

List<String> kSupportedHLVUrlTypes = ["youtube", "http", "https"];
List<String> kSupportedHLVUrlProtocols = ["youtube:", "http://", "https://"];
final String kSupportedHLVUrlTypesString = kSupportedHLVUrlProtocols
        .sublist(0, kSupportedHLVUrlProtocols.length - 1)
        .join(", ") +
    ", or " +
    kSupportedHLVUrlProtocols[kSupportedHLVUrlProtocols.length - 1];
