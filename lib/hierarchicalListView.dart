import 'package:flutter/material.dart';
import 'types/hierarchicalListView.dart';

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

