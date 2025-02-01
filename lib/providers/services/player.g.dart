// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerInfoImpl _$$PlayerInfoImplFromJson(Map<String, dynamic> json) =>
    _$PlayerInfoImpl(
      id: json['id'] as String,
      artistId: json['artistId'] as String,
      albumId: json['albumId'] as String,
      displayName: json['displayName'] as String,
      artistDisplayName: json['artistDisplayName'] as String,
      albumDisplayName: json['albumDisplayName'] as String,
      duration: (json['duration'] as num).toInt(),
      position: (json['position'] as num).toInt(),
      isPlaying: json['isPlaying'] as bool,
      queue: (json['queue'] as List<dynamic>)
          .map((e) => QueueItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentIndex: (json['currentIndex'] as num).toInt(),
      shuffle: json['shuffle'] as bool,
      loop: json['loop'] as bool,
      thinking: json['thinking'] as bool,
    );

Map<String, dynamic> _$$PlayerInfoImplToJson(_$PlayerInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'artistId': instance.artistId,
      'albumId': instance.albumId,
      'displayName': instance.displayName,
      'artistDisplayName': instance.artistDisplayName,
      'albumDisplayName': instance.albumDisplayName,
      'duration': instance.duration,
      'position': instance.position,
      'isPlaying': instance.isPlaying,
      'queue': instance.queue,
      'currentIndex': instance.currentIndex,
      'shuffle': instance.shuffle,
      'loop': instance.loop,
      'thinking': instance.thinking,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playerHash() => r'872bb13e531fb3a93d424e72ea8b7902aa232f1b';

/// See also [Player].
@ProviderFor(Player)
final playerProvider = AutoDisposeNotifierProvider<Player, PlayerInfo>.internal(
  Player.new,
  name: r'playerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$playerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Player = AutoDisposeNotifier<PlayerInfo>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
