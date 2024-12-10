var fs = require('fs');
function flattenData(input) {
  const artists = [];
  const albums = [];
  const songs = [];

  input.forEach(artistData => {
    // Flatten artists
    const artistName = artistData.name;
    artists.push({name : artistName});

    artistData.albums.forEach(albumData => {
      // Flatten albums
      const albumName = albumData.name;
      const albumImageUrl = albumData.imageUrl;
      albums.push(
          {name : albumName, artist : artistName, imageUrl : albumImageUrl});

      albumData.songs.forEach(songData => {
        // Flatten songs
        songs.push({
          name : songData.name,
          videoId : songData.videoId,
          imageUrl : songData.imageUrl,
          album : albumName,
          artist : artistName
        });
      });
    });
  });

  return {artists, albums, songs};
}
var input = JSON.parse(fs.readFileSync('out.json', 'utf-8'));
const {artists, albums, songs} = flattenData(input);
console.log({artists, albums, songs});
