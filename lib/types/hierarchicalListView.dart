import 'searchresult.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class HLVArtist {
  final String name;
  final List<String> visibleTo;
  final String imageUrl;
  List<HLVAlbum> albums;

  HLVArtist(this.name, this.visibleTo, this.albums, this.imageUrl);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'visibleTo': visibleTo,
      'albums': albums.map((album) => album.toJson()).toList(),
    };
  }

  HLVArtist copyWith({
    String? name,
    List<String>? visibleTo,
    String? imageUrl,
    List<HLVAlbum>? albums,
  }) {
    return HLVArtist(
      name ?? this.name,
      visibleTo ?? this.visibleTo,
      albums ?? this.albums,
      imageUrl ?? this.imageUrl,
    );
  }
}

class HLVAlbum {
  final String name;
  final String imageUrl;
  final String artistImageUrl;
  final List<String> visibleTo;
  List<HLVSong> songs;

  HLVAlbum(this.name, this.imageUrl, this.visibleTo, this.songs,
      this.artistImageUrl);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'artistImageUrl': artistImageUrl,
      'visibleTo': visibleTo,
      'songs': songs.map((song) => song.toJson()).toList(),
    };
  }

  HLVAlbum copyWith({
    String? name,
    String? imageUrl,
    String? artistImageUrl,
    List<String>? visibleTo,
    List<HLVSong>? songs,
  }) {
    return HLVAlbum(
      name ?? this.name,
      imageUrl ?? this.imageUrl,
      visibleTo ?? this.visibleTo,
      songs ?? this.songs,
      artistImageUrl ?? this.artistImageUrl,
    );
  }
}

class HLVSong {
  final String name;
  final String url;
  final String imageUrl;
  final String artistImageUrl;
  final List<String> visibleTo;

  HLVSong(
      this.name, this.url, this.visibleTo, this.imageUrl, this.artistImageUrl);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'imageUrl': imageUrl,
      'visibleTo': visibleTo,
      'artistImageUrl': artistImageUrl,
    };
  }

  HLVSong copyWith({
    String? name,
    String? url,
    String? imageUrl,
    String? artistImageUrl,
    List<String>? visibleTo,
  }) {
    return HLVSong(
      name ?? this.name,
      url ?? this.url,
      visibleTo ?? this.visibleTo,
      imageUrl ?? this.imageUrl,
      artistImageUrl ?? this.artistImageUrl,
    );
  }
}

List<HLVArtist> findResultsToHLVContent(List<FindResult> results) {
  List<HLVArtist> artists = [];
  Map<String, int> artistIndices = {};
  int artistIndex = 0;
  for (var result in results) {
    if (!artists.map((e) => e.name).contains(result.artist)) {
      print("Artist: " + result.artistImageUrl);
      artists.add(HLVArtist(result.artist, result.visibleTo, [], result.artistImageUrl));
      artistIndices[result.artist] = artistIndex++;
    }
    if (result.type == "album") {
      HLVArtist workingArtist = artists[artistIndices[result.artist]!];
      if (workingArtist.albums.isEmpty ||
          !workingArtist.albums
              .contains((album) => album.name == result.album)) {
        workingArtist.albums.add(HLVAlbum(result.album, result.imageUrl,
            result.visibleTo, [], result.artistImageUrl));
        var albumIndex = workingArtist.albums.length - 1;
        workingArtist.albums[albumIndex].songs = result.songs
            .map((s) => HLVSong(
                s.title,
                s.url,
                result.visibleTo,
                workingArtist.albums[albumIndex].imageUrl,
                result.artistImageUrl))
            .toList();
      }
    }
    if (result.type == "song") {
      int artistListIndex = artistIndices[result.artist]!;
      HLVArtist workingArtist = artists[artistListIndex];
      print("RESULT ALBUM: " + result.album);
      int albumIndex = workingArtist.albums
          .indexWhere((album) => album.name == result.album);
      if (albumIndex != -1) {
        HLVAlbum workingAlbum = workingArtist.albums[albumIndex];
        workingAlbum.songs.add(HLVSong(
            result.songs[0].title,
            result.songs[0].url,
            result.visibleTo,
            workingAlbum.imageUrl,
            result.artistImageUrl));
      } else {
        workingArtist.albums.add(HLVAlbum(
            result.album,
            result.imageUrl,
            result.visibleTo,
            [
              HLVSong(result.songs[0].title, result.songs[0].url,
                  result.visibleTo, result.imageUrl, result.artistImageUrl),
            ],
            result.artistImageUrl));
      }
    }
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
        print("    - URL: ${song.url}");
        print("    - Image: ${song.imageUrl}");
        print("    - Artist Image: ${song.artistImageUrl}");
      }
    }
  }
}

List<String> kSupportedHLVUrlTypes = ["youtube", "http", "https"];
List<String> kSupportedHLVUrlProtocols = ["youtube:", "http://", "https://"];
final String kSupportedHLVUrlTypesString = kSupportedHLVUrlProtocols.sublist(0, kSupportedHLVUrlProtocols.length - 1).join(", ") + ", or " + kSupportedHLVUrlProtocols[kSupportedHLVUrlProtocols.length - 1];
