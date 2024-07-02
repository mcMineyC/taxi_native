// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playing_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlayerInfo {
  String get id => throw _privateConstructorUsedError;
  String get artistId => throw _privateConstructorUsedError;
  String get albumId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get artistDisplayName => throw _privateConstructorUsedError;
  String get albumDisplayName => throw _privateConstructorUsedError;
  double get duration => throw _privateConstructorUsedError;
  int get position =>
      throw _privateConstructorUsedError; // required double percent,
  bool get isPlaying => throw _privateConstructorUsedError;
  List<Song> get queue => throw _privateConstructorUsedError;
  Song get currentSong => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayerInfoCopyWith<PlayerInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerInfoCopyWith<$Res> {
  factory $PlayerInfoCopyWith(
          PlayerInfo value, $Res Function(PlayerInfo) then) =
      _$PlayerInfoCopyWithImpl<$Res, PlayerInfo>;
  @useResult
  $Res call(
      {String id,
      String artistId,
      String albumId,
      String displayName,
      String artistDisplayName,
      String albumDisplayName,
      double duration,
      int position,
      bool isPlaying,
      List<Song> queue,
      Song currentSong});

  $SongCopyWith<$Res> get currentSong;
}

/// @nodoc
class _$PlayerInfoCopyWithImpl<$Res, $Val extends PlayerInfo>
    implements $PlayerInfoCopyWith<$Res> {
  _$PlayerInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? artistId = null,
    Object? albumId = null,
    Object? displayName = null,
    Object? artistDisplayName = null,
    Object? albumDisplayName = null,
    Object? duration = null,
    Object? position = null,
    Object? isPlaying = null,
    Object? queue = null,
    Object? currentSong = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      artistId: null == artistId
          ? _value.artistId
          : artistId // ignore: cast_nullable_to_non_nullable
              as String,
      albumId: null == albumId
          ? _value.albumId
          : albumId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      artistDisplayName: null == artistDisplayName
          ? _value.artistDisplayName
          : artistDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      albumDisplayName: null == albumDisplayName
          ? _value.albumDisplayName
          : albumDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      queue: null == queue
          ? _value.queue
          : queue // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      currentSong: null == currentSong
          ? _value.currentSong
          : currentSong // ignore: cast_nullable_to_non_nullable
              as Song,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SongCopyWith<$Res> get currentSong {
    return $SongCopyWith<$Res>(_value.currentSong, (value) {
      return _then(_value.copyWith(currentSong: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlayerInfoImplCopyWith<$Res>
    implements $PlayerInfoCopyWith<$Res> {
  factory _$$PlayerInfoImplCopyWith(
          _$PlayerInfoImpl value, $Res Function(_$PlayerInfoImpl) then) =
      __$$PlayerInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String artistId,
      String albumId,
      String displayName,
      String artistDisplayName,
      String albumDisplayName,
      double duration,
      int position,
      bool isPlaying,
      List<Song> queue,
      Song currentSong});

  @override
  $SongCopyWith<$Res> get currentSong;
}

/// @nodoc
class __$$PlayerInfoImplCopyWithImpl<$Res>
    extends _$PlayerInfoCopyWithImpl<$Res, _$PlayerInfoImpl>
    implements _$$PlayerInfoImplCopyWith<$Res> {
  __$$PlayerInfoImplCopyWithImpl(
      _$PlayerInfoImpl _value, $Res Function(_$PlayerInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? artistId = null,
    Object? albumId = null,
    Object? displayName = null,
    Object? artistDisplayName = null,
    Object? albumDisplayName = null,
    Object? duration = null,
    Object? position = null,
    Object? isPlaying = null,
    Object? queue = null,
    Object? currentSong = null,
  }) {
    return _then(_$PlayerInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      artistId: null == artistId
          ? _value.artistId
          : artistId // ignore: cast_nullable_to_non_nullable
              as String,
      albumId: null == albumId
          ? _value.albumId
          : albumId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      artistDisplayName: null == artistDisplayName
          ? _value.artistDisplayName
          : artistDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      albumDisplayName: null == albumDisplayName
          ? _value.albumDisplayName
          : albumDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      queue: null == queue
          ? _value._queue
          : queue // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      currentSong: null == currentSong
          ? _value.currentSong
          : currentSong // ignore: cast_nullable_to_non_nullable
              as Song,
    ));
  }
}

/// @nodoc

class _$PlayerInfoImpl implements _PlayerInfo {
  _$PlayerInfoImpl(
      {required this.id,
      required this.artistId,
      required this.albumId,
      required this.displayName,
      required this.artistDisplayName,
      required this.albumDisplayName,
      required this.duration,
      required this.position,
      required this.isPlaying,
      required final List<Song> queue,
      required this.currentSong})
      : _queue = queue;

  @override
  final String id;
  @override
  final String artistId;
  @override
  final String albumId;
  @override
  final String displayName;
  @override
  final String artistDisplayName;
  @override
  final String albumDisplayName;
  @override
  final double duration;
  @override
  final int position;
// required double percent,
  @override
  final bool isPlaying;
  final List<Song> _queue;
  @override
  List<Song> get queue {
    if (_queue is EqualUnmodifiableListView) return _queue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_queue);
  }

  @override
  final Song currentSong;

  @override
  String toString() {
    return 'PlayerInfo(id: $id, artistId: $artistId, albumId: $albumId, displayName: $displayName, artistDisplayName: $artistDisplayName, albumDisplayName: $albumDisplayName, duration: $duration, position: $position, isPlaying: $isPlaying, queue: $queue, currentSong: $currentSong)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.artistId, artistId) ||
                other.artistId == artistId) &&
            (identical(other.albumId, albumId) || other.albumId == albumId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.artistDisplayName, artistDisplayName) ||
                other.artistDisplayName == artistDisplayName) &&
            (identical(other.albumDisplayName, albumDisplayName) ||
                other.albumDisplayName == albumDisplayName) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            const DeepCollectionEquality().equals(other._queue, _queue) &&
            (identical(other.currentSong, currentSong) ||
                other.currentSong == currentSong));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      artistId,
      albumId,
      displayName,
      artistDisplayName,
      albumDisplayName,
      duration,
      position,
      isPlaying,
      const DeepCollectionEquality().hash(_queue),
      currentSong);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerInfoImplCopyWith<_$PlayerInfoImpl> get copyWith =>
      __$$PlayerInfoImplCopyWithImpl<_$PlayerInfoImpl>(this, _$identity);
}

abstract class _PlayerInfo implements PlayerInfo {
  factory _PlayerInfo(
      {required final String id,
      required final String artistId,
      required final String albumId,
      required final String displayName,
      required final String artistDisplayName,
      required final String albumDisplayName,
      required final double duration,
      required final int position,
      required final bool isPlaying,
      required final List<Song> queue,
      required final Song currentSong}) = _$PlayerInfoImpl;

  @override
  String get id;
  @override
  String get artistId;
  @override
  String get albumId;
  @override
  String get displayName;
  @override
  String get artistDisplayName;
  @override
  String get albumDisplayName;
  @override
  double get duration;
  @override
  int get position;
  @override // required double percent,
  bool get isPlaying;
  @override
  List<Song> get queue;
  @override
  Song get currentSong;
  @override
  @JsonKey(ignore: true)
  _$$PlayerInfoImplCopyWith<_$PlayerInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
