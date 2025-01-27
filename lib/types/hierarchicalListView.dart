import 'searchresult.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class HLVArtist {
  final String name;
  List<HLVAlbum> albums;

  HLVArtist(this.name, this.albums);

  // Convert an HLVArtist to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'albums': albums.map((album) => album.toJson()).toList(),
    };
  }
}

class HLVAlbum {
  final String name;
  final String imageUrl;
  List<HLVSong> songs;

  HLVAlbum(this.name, this.imageUrl, this.songs);

  // Convert an HLVAlbum to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'songs': songs.map((song) => song.toJson()).toList(),
    };
  }
}

class HLVSong {
  final String name;
  final String url;
  final String imageUrl;

  HLVSong(this.name, this.url, [this.imageUrl = "changemeplz"]);

  // Convert an HLVSong to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'imageUrl': imageUrl,
    };
  }
}

List<HLVArtist> findResultsToHLVContent(List<FindResult> results) {
  List<HLVArtist> artists = [];
  Map<String, int> artistIndices = {};
  int artistIndex = 0;
  for (var result in results) {
    if (!artists.map((e) => e.name).contains(result.artist)) {
      artists.add(HLVArtist(result.artist, []));
      artistIndices[result.artist] = artistIndex++;
    }
    if (result.type == "album") {
      HLVArtist workingArtist = artists[artistIndices[result.artist]!];
      if (workingArtist.albums.isEmpty ||
          !workingArtist.albums
              .contains((album) => album.name == result.album)) {
        workingArtist.albums.add(HLVAlbum(result.album, result.imageUrl, []));
        var albumIndex = workingArtist.albums.length - 1;
        workingArtist.albums[albumIndex].songs = result.songs
            .map((s) => HLVSong(
                s.title, s.url, workingArtist.albums[albumIndex].imageUrl))
            .toList();
      }
    }
    if (result.type == "song") {
      int artistListIndex = artistIndices[result.artist]!;
      HLVArtist workingArtist = artists[artistListIndex];
      print("RESULT ALBUM: "+result.album);
      int albumIndex = workingArtist.albums.indexWhere((album) => album.name == result.album);
      if(albumIndex != -1){
        HLVAlbum workingAlbum = workingArtist.albums[albumIndex];
        workingAlbum.songs.add(HLVSong(
          result.songs[0].title, result.songs[0].url, workingAlbum.imageUrl));
      }else{
        workingArtist.albums.add(HLVAlbum(result.album, result.imageUrl, [
          HLVSong(
            result.songs[0].title,
            result.songs[0].url,
            result.imageUrl
          ),
        ]));
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
      for (var song in album.songs) {
        print("    Song: ${song.name}");
        print("    - URL: ${song.url}");
        print("    - Image: ${song.imageUrl}");
      }
    }
  }
}
