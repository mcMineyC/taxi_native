import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:audio_service/audio_service.dart';
import 'queueitem.dart';

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
    required String audioUrl,
    required int    added,
    required String addedBy,
    required double duration,
    required List<String> visibleTo,
  }) = _Song;

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);

  factory Song.empty() => EmptySong();
  
  MediaItem toMediaItem() {
    return MediaItem(
      id: audioUrl,
      title: displayName,
      album: albumDisplayName,
      artist: artistDisplayName,
      duration: Duration(seconds: duration.toInt()),
      artUri: Uri.parse(imageUrl),
      extras: {
        "song": this
      },
    );
  }

  QueueItem toQueueItem() => QueueItem(
    type: "song",
    id: id,
    albumId: albumId,
    artistId: artistId,
    displayName: displayName,
    albumName: albumDisplayName,
    artistName: artistDisplayName,
    imageUrl: imageUrl,
    duration: duration,
    audioUrl: audioUrl,
  );
}

extension ConvertToQueueItem on MediaItem {
  QueueItem toQueueItem() => QueueItem(
    type: "song",
    id: extras!["song"]?.id ?? "",
    albumId: extras!["song"]?.albumId ?? "",
    artistId: extras!["song"]?.artistId ?? "",
    displayName: extras!["song"]?.displayName ?? "",
    albumName: extras!["song"]?.albumDisplayName ?? "",
    artistName: extras!["song"]?.artistDisplayName ?? "",
    imageUrl: extras!["song"]?.imageUrl ?? "",
    duration: extras!["song"]?.duration ?? 0,
    audioUrl: id,
  );
}    

Song EmptySong(){
  return Song(
    id: 'empty',
    albumId: 'empty',
    artistId: 'empty',
    displayName: 'Unknown',
    albumDisplayName: 'Unknown', 
    artistDisplayName: 'Unknown',
    added: 0,
    duration: 0.1,
    imageUrl: '',
    audioUrl: 'blank:',
    visibleTo: [],
    addedBy: 'testguy'
  );
}
