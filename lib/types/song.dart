import 'package:freezed_annotation/freezed_annotation.dart';

part 'song.freezed.dart';
part 'song.g.dart';

@freezed
class Song with _$Song {
  factory Song({
    required String id,
    required String albumId,
    required String artistId,
    required String displayName,
    required String albumDisplayName,
    required String artistDisplayName,
    required int    added,
    required double duration,
  }) = _Song;

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
}

 Song EmptySong(){
  return Song(id: '6cc37f587e73515ef1b0bbc62d51da5aadd11c7833bf9176a8b461e663a34533_12735632cdddfc5ee1adefb9acc5c31b17815eb12a44c5d8980549de7de9fb6e_b000432cae7c8cf56caf78631dd1516fb053baed193c02a4d44f5af9c4629136', albumId: '6cc37f587e73515ef1b0bbc62d51da5aadd11c7833bf9176a8b461e663a34533_12735632cdddfc5ee1adefb9acc5c31b17815eb12a44c5d8980549de7de9fb6e', artistId: '6cc37f587e73515ef1b0bbc62d51da5aadd11c7833bf9176a8b461e663a34533', displayName: 'Unknown', albumDisplayName: 'Unknown', artistDisplayName: 'Unknown', added: 0, duration: 0.1);
}
