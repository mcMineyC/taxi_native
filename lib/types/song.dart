import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:audio_service/audio_service.dart';
import '../service_locator.dart';

part 'song.freezed.dart';
part 'song.g.dart';

@freezed
class Song with _$Song {
  const Song._();
  factory Song({
    required String id,
    required String albumId,
    required String artistId,
    required String displayName,
    required String albumDisplayName,
    required String artistDisplayName,
    required String imageUrl,
    required String youtubeId,
    required int    added,
    required double duration,
  }) = _Song;

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);

  factory Song.empty() => EmptySong();
  
  MediaItem toMediaItem() {
    return MediaItem(
      id: id,
      title: displayName,
      album: albumDisplayName,
      artist: artistDisplayName,
      duration: Duration(seconds: duration.toInt()),
      artUri: Uri.parse(imageUrl),
    );
  }
}

 Song EmptySong(){
  return Song(id: 'empty', albumId: 'empty', artistId: 'empty', displayName: 'Unknown', albumDisplayName: 'Unknown', artistDisplayName: 'Unknown', added: 0, duration: 0.1, imageUrl: '', youtubeId: '000000');
}
