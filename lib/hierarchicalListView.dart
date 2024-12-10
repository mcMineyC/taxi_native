import 'package:flutter/material.dart';
import 'types/artists.dart';
import 'types/album.dart';
import 'types/song.dart';
import 'types/searchresult.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class HierarchicalListView extends StatelessWidget {
  final List<HLVArtist> data;
  HierarchicalListView({required this.data});
  // Example data structure for multiple artists and their albums
  //final List<HLVArtist> artists = searchResultsToHLVContent(listResults);
  //final List<HLVArtist> artists = [
  //  HLVArtist('C418', [
  //    HLVAlbum('Minecraft - Volume Beta', "", [
  //      HLVSong("", 'Sweden'),
  //      HLVSong("", 'Cat'),
  //      HLVSong("", 'Dog'),
  //      HLVSong("", 'Mice on Venus'),
  //    ]),
  //    HLVAlbum('Minecraft - Volume Alpha', "", [
  //      HLVSong("", 'Minecraft'),
  //      HLVSong("", 'The End'),
  //      HLVSong("", 'Haggstrom'),
  //      HLVSong("", 'Alpha'),
  //    ]),
  //    HLVAlbum("", 'Dief', [
  //      HLVSong("", 'Dief'),
  //      HLVSong("", 'Notch'),
  //      HLVSong("", 'Sunrise'),
  //    ]),
  //  ]),
  //  HLVArtist('TheFatRat', [
  //    HLVAlbum('The Remixes', "", [
  //      HLVSong("", 'Unity'),
  //      HLVSong("", 'Monody'),
  //      HLVSong("", 'Fly Away'),
  //      HLVSong("", 'The Calling'),
  //    ]),
  //    HLVAlbum('Paralyzed', "", [
  //      HLVSong("", 'The Calling'),
  //      HLVSong("", 'Fly Away'),
  //      HLVSong("", 'Waves'),
  //    ]),
  //  ]),
  //  HLVArtist('Virtual Riot', [
  //    HLVAlbum('The Classics', "", [
  //      HLVSong("", 'Energy Drink'),
  //      HLVSong("", 'Hyperion'),
  //      HLVSong("", 'Primal'),
  //      HLVSong("", 'Machine'),
  //    ]),
  //  ]),
  //];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: data.map((artist) => _buildHLVArtist(artist, 0)).toList(),
    );
  }

  // Recursive function to build the hierarchical list view with indentation
  Widget _buildHLVArtist(HLVArtist artist, int level) {
    double indentation = 24.0 * level; // Increase indentation with each level

    return Padding(
      padding: EdgeInsets.only(left: indentation),
      child: artist.albums.isEmpty
          ? ListTile(
              title: Text(artist.name),
            )
          : ExpansionTile(
              title: Text(artist.name),
              children: artist.albums
                  .map((album) => _buildHLVAlbum(album, level + 1))
                  .toList(),
            ),
    );
  }

  // Recursive function to build the album list with indentation
  Widget _buildHLVAlbum(HLVAlbum album, int level) {
    double indentation = 24.0 * level; // Increase indentation with each level

    return Padding(
      padding: EdgeInsets.only(left: indentation),
      child: album.songs.isEmpty
          ? ListTile(
              title: Text(album.name),
            )
          : ExpansionTile(
              title: Text(album.name),
              children: album.songs
                  .map((song) => _buildHLVSong(song, level + 1))
                  .toList(),
            ),
    );
  }

  // Build a song item with indentation
  Widget _buildHLVSong(HLVSong song, int level) {
    double indentation = 24.0 * level; // Increase indentation for song items

    return Padding(
      padding: EdgeInsets.only(left: indentation),
      child: ListTile(
        title: Text(song.name),
      ),
    );
  }
}

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
  final String videoId;
  final String imageUrl;

  HLVSong(this.name, this.videoId, [this.imageUrl = "changemeplz"]);

  // Convert an HLVSong to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'videoId': videoId,
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
                s.title, s.id, workingArtist.albums[albumIndex].imageUrl))
            .toList();
      }
    }
    if (result.type == "song") {
      int artistListIndex = artistIndices[result.artist]!;
      HLVArtist workingArtist = artists[artistListIndex];
      HLVAlbum workingAlbum = workingArtist.albums[workingArtist.albums
          .indexWhere((album) => album.name == result.album)];
      workingAlbum.songs.add(HLVSong(
          result.songs[0].title, result.songs[0].id, workingAlbum.imageUrl));
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
        print("    - Video: ${song.videoId}");
        print("    - Image: ${song.imageUrl}");
      }
    }
  }
}
