import 'searchresult.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import "package:freezed_annotation/freezed_annotation.dart";

part "hierarchicalListView.freezed.dart";
part 'hierarchicalListView.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class HLVArtist with _$HLVArtist {
  const HLVArtist._();
  factory HLVArtist({
    required String name,
    required List<String> visibleTo,
    required String imageUrl,
    required List<HLVAlbum> albums,
  }) = _HLVArtist;
  factory HLVArtist.fromJson(Map<String, Object?> json) => _$HLVArtistFromJson(json);
}

@Freezed(makeCollectionsUnmodifiable: false)
class HLVAlbum with _$HLVAlbum {
  const HLVAlbum._();
  factory HLVAlbum({
    required String externalId,
    required String name,
    required List<String> visibleTo,
    required String imageUrl,
    required String artistImageUrl,
    required List<HLVSong> songs,
  }) = _HLVAlbum;
  factory HLVAlbum.fromJson(Map<String, Object?> json) => _$HLVAlbumFromJson(json);
}

@Freezed(makeCollectionsUnmodifiable: false)
class HLVSong with _$HLVSong {
  const HLVSong._();
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
  List<HLVArtist> artists = [];
  Map<String, int> artistIndices = {};
  int artistIndex = 0;
  for (var result in results) {
    List<HLVAlbum> workingArtistAlbums = [];
    if (!artists.map((e) => e.name).contains(result.artist)) {
      print("Artist: " + result.artistImageUrl);
      artists.add(HLVArtist(
          name: result.artist, visibleTo: result.visibleTo, imageUrl: result.artistImageUrl, albums: []));
      artistIndices[result.artist] = artistIndex++; // post increment
    }
    if (result.type == "album") {
      if (workingArtistAlbums.isEmpty || !workingArtistAlbums.contains((album) => album.name == result.album)) {
        workingArtistAlbums.add(
          HLVAlbum(
            externalId: result.externalId,
            name: result.album,
            imageUrl: result.imageUrl,
            visibleTo: result.visibleTo,
            songs: [],
            artistImageUrl: result.artistImageUrl
          )
        );
        var albumIndex = workingArtistAlbums.length - 1;
        workingArtistAlbums[albumIndex] = workingArtistAlbums[albumIndex].copyWith(
          songs: result.songs.map((s) => HLVSong(
            externalId: result.externalId,
            name: s.title,
            audioUrl: s.url,
            visibleTo: result.visibleTo,
            imageUrl: workingArtistAlbums[albumIndex].imageUrl,
            artistImageUrl: result.artistImageUrl,
            trackNumber: s.trackNumber
          ))
          .toList()
        );
      }
    }
    if (result.type == "song") {
      int albumIndex = workingArtistAlbums.indexWhere((album) => album.name == result.album);
      // BUG THIS IS DUPLICATED FOR SOME REASON
      if (albumIndex != -1) { // existing album
        HLVAlbum workingAlbum = workingArtistAlbums[albumIndex];
        workingArtistAlbums[albumIndex] = workingAlbum.copyWith(songs: [HLVSong(
            externalId: result.songs[0].externalId,
            name: result.songs[0].title,
            audioUrl: result.songs[0].url,
            visibleTo: result.visibleTo,
            imageUrl: workingAlbum.imageUrl,
            artistImageUrl: result.artistImageUrl,
            trackNumber: result.songs[0].trackNumber)]);
      } else { // new album
        workingArtistAlbums.add(HLVAlbum(
          externalId: result.externalId,
          name: result.album,
          imageUrl: result.imageUrl,
          artistImageUrl: result.artistImageUrl,
          visibleTo: result.visibleTo,
          songs: [
            HLVSong(
              externalId: result.songs[0].externalId,
              name: result.songs[0].title,
              audioUrl: result.songs[0].url,
              visibleTo: result.visibleTo,
              imageUrl: result.imageUrl,
              artistImageUrl: result.artistImageUrl,
              trackNumber: result.songs[0].trackNumber),
            ],
        ));
      }
    }
    artists[artistIndex-1] = artists[artistIndex-1].copyWith(albums: [...artists[artistIndex-1].albums, ...workingArtistAlbums]);
  }
  return artists;
}

void printHLVContent(List<HLVArtist> artists) {
  for (var artist in artists) {
    print("Artist: ${artist.name}");
    for (var album in artist.albums) {
      print("  Album: ${album.name}");
      print("  - Image: ${album.imageUrl}");
      print("  - Artist Image: ${album.artistImageUrl}");
      for (var song in album.songs) {
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
