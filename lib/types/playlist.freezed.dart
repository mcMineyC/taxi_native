// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Playlist _$PlaylistFromJson(Map<String, dynamic> json) {
  return _Playlist.fromJson(json);
}

/// @nodoc
mixin _$Playlist {
  String get id => throw _privateConstructorUsedError;
  String get owner => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  List<String> get visibleTo => throw _privateConstructorUsedError;
  List<String> get inLibrary => throw _privateConstructorUsedError;
  List<String> get allowedCollaborators => throw _privateConstructorUsedError;
  List<String> get songs => throw _privateConstructorUsedError;
  int get added => throw _privateConstructorUsedError;

  /// Serializes this Playlist to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Playlist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaylistCopyWith<Playlist> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaylistCopyWith<$Res> {
  factory $PlaylistCopyWith(Playlist value, $Res Function(Playlist) then) =
      _$PlaylistCopyWithImpl<$Res, Playlist>;
  @useResult
  $Res call(
      {String id,
      String owner,
      String displayName,
      List<String> visibleTo,
      List<String> inLibrary,
      List<String> allowedCollaborators,
      List<String> songs,
      int added});
}

/// @nodoc
class _$PlaylistCopyWithImpl<$Res, $Val extends Playlist>
    implements $PlaylistCopyWith<$Res> {
  _$PlaylistCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Playlist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? owner = null,
    Object? displayName = null,
    Object? visibleTo = null,
    Object? inLibrary = null,
    Object? allowedCollaborators = null,
    Object? songs = null,
    Object? added = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      visibleTo: null == visibleTo
          ? _value.visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inLibrary: null == inLibrary
          ? _value.inLibrary
          : inLibrary // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowedCollaborators: null == allowedCollaborators
          ? _value.allowedCollaborators
          : allowedCollaborators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      added: null == added
          ? _value.added
          : added // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlaylistImplCopyWith<$Res>
    implements $PlaylistCopyWith<$Res> {
  factory _$$PlaylistImplCopyWith(
          _$PlaylistImpl value, $Res Function(_$PlaylistImpl) then) =
      __$$PlaylistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String owner,
      String displayName,
      List<String> visibleTo,
      List<String> inLibrary,
      List<String> allowedCollaborators,
      List<String> songs,
      int added});
}

/// @nodoc
class __$$PlaylistImplCopyWithImpl<$Res>
    extends _$PlaylistCopyWithImpl<$Res, _$PlaylistImpl>
    implements _$$PlaylistImplCopyWith<$Res> {
  __$$PlaylistImplCopyWithImpl(
      _$PlaylistImpl _value, $Res Function(_$PlaylistImpl) _then)
      : super(_value, _then);

  /// Create a copy of Playlist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? owner = null,
    Object? displayName = null,
    Object? visibleTo = null,
    Object? inLibrary = null,
    Object? allowedCollaborators = null,
    Object? songs = null,
    Object? added = null,
  }) {
    return _then(_$PlaylistImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      visibleTo: null == visibleTo
          ? _value._visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inLibrary: null == inLibrary
          ? _value._inLibrary
          : inLibrary // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowedCollaborators: null == allowedCollaborators
          ? _value._allowedCollaborators
          : allowedCollaborators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      songs: null == songs
          ? _value._songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      added: null == added
          ? _value.added
          : added // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaylistImpl implements _Playlist {
  _$PlaylistImpl(
      {required this.id,
      required this.owner,
      required this.displayName,
      required final List<String> visibleTo,
      required final List<String> inLibrary,
      required final List<String> allowedCollaborators,
      required final List<String> songs,
      required this.added})
      : _visibleTo = visibleTo,
        _inLibrary = inLibrary,
        _allowedCollaborators = allowedCollaborators,
        _songs = songs;

  factory _$PlaylistImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaylistImplFromJson(json);

  @override
  final String id;
  @override
  final String owner;
  @override
  final String displayName;
  final List<String> _visibleTo;
  @override
  List<String> get visibleTo {
    if (_visibleTo is EqualUnmodifiableListView) return _visibleTo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visibleTo);
  }

  final List<String> _inLibrary;
  @override
  List<String> get inLibrary {
    if (_inLibrary is EqualUnmodifiableListView) return _inLibrary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inLibrary);
  }

  final List<String> _allowedCollaborators;
  @override
  List<String> get allowedCollaborators {
    if (_allowedCollaborators is EqualUnmodifiableListView)
      return _allowedCollaborators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowedCollaborators);
  }

  final List<String> _songs;
  @override
  List<String> get songs {
    if (_songs is EqualUnmodifiableListView) return _songs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_songs);
  }

  @override
  final int added;

  @override
  String toString() {
    return 'Playlist(id: $id, owner: $owner, displayName: $displayName, visibleTo: $visibleTo, inLibrary: $inLibrary, allowedCollaborators: $allowedCollaborators, songs: $songs, added: $added)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaylistImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            const DeepCollectionEquality()
                .equals(other._visibleTo, _visibleTo) &&
            const DeepCollectionEquality()
                .equals(other._inLibrary, _inLibrary) &&
            const DeepCollectionEquality()
                .equals(other._allowedCollaborators, _allowedCollaborators) &&
            const DeepCollectionEquality().equals(other._songs, _songs) &&
            (identical(other.added, added) || other.added == added));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      owner,
      displayName,
      const DeepCollectionEquality().hash(_visibleTo),
      const DeepCollectionEquality().hash(_inLibrary),
      const DeepCollectionEquality().hash(_allowedCollaborators),
      const DeepCollectionEquality().hash(_songs),
      added);

  /// Create a copy of Playlist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaylistImplCopyWith<_$PlaylistImpl> get copyWith =>
      __$$PlaylistImplCopyWithImpl<_$PlaylistImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaylistImplToJson(
      this,
    );
  }
}

abstract class _Playlist implements Playlist {
  factory _Playlist(
      {required final String id,
      required final String owner,
      required final String displayName,
      required final List<String> visibleTo,
      required final List<String> inLibrary,
      required final List<String> allowedCollaborators,
      required final List<String> songs,
      required final int added}) = _$PlaylistImpl;

  factory _Playlist.fromJson(Map<String, dynamic> json) =
      _$PlaylistImpl.fromJson;

  @override
  String get id;
  @override
  String get owner;
  @override
  String get displayName;
  @override
  List<String> get visibleTo;
  @override
  List<String> get inLibrary;
  @override
  List<String> get allowedCollaborators;
  @override
  List<String> get songs;
  @override
  int get added;

  /// Create a copy of Playlist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaylistImplCopyWith<_$PlaylistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FilledPlaylist {
  String get id => throw _privateConstructorUsedError;
  String get owner => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  List<String> get visibleTo => throw _privateConstructorUsedError;
  List<String> get inLibrary => throw _privateConstructorUsedError;
  List<String> get allowedCollaborators => throw _privateConstructorUsedError;
  List<Song> get songs => throw _privateConstructorUsedError;
  int get added => throw _privateConstructorUsedError;

  /// Create a copy of FilledPlaylist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilledPlaylistCopyWith<FilledPlaylist> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilledPlaylistCopyWith<$Res> {
  factory $FilledPlaylistCopyWith(
          FilledPlaylist value, $Res Function(FilledPlaylist) then) =
      _$FilledPlaylistCopyWithImpl<$Res, FilledPlaylist>;
  @useResult
  $Res call(
      {String id,
      String owner,
      String displayName,
      List<String> visibleTo,
      List<String> inLibrary,
      List<String> allowedCollaborators,
      List<Song> songs,
      int added});
}

/// @nodoc
class _$FilledPlaylistCopyWithImpl<$Res, $Val extends FilledPlaylist>
    implements $FilledPlaylistCopyWith<$Res> {
  _$FilledPlaylistCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilledPlaylist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? owner = null,
    Object? displayName = null,
    Object? visibleTo = null,
    Object? inLibrary = null,
    Object? allowedCollaborators = null,
    Object? songs = null,
    Object? added = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      visibleTo: null == visibleTo
          ? _value.visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inLibrary: null == inLibrary
          ? _value.inLibrary
          : inLibrary // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowedCollaborators: null == allowedCollaborators
          ? _value.allowedCollaborators
          : allowedCollaborators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      added: null == added
          ? _value.added
          : added // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FilledPlaylistImplCopyWith<$Res>
    implements $FilledPlaylistCopyWith<$Res> {
  factory _$$FilledPlaylistImplCopyWith(_$FilledPlaylistImpl value,
          $Res Function(_$FilledPlaylistImpl) then) =
      __$$FilledPlaylistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String owner,
      String displayName,
      List<String> visibleTo,
      List<String> inLibrary,
      List<String> allowedCollaborators,
      List<Song> songs,
      int added});
}

/// @nodoc
class __$$FilledPlaylistImplCopyWithImpl<$Res>
    extends _$FilledPlaylistCopyWithImpl<$Res, _$FilledPlaylistImpl>
    implements _$$FilledPlaylistImplCopyWith<$Res> {
  __$$FilledPlaylistImplCopyWithImpl(
      _$FilledPlaylistImpl _value, $Res Function(_$FilledPlaylistImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilledPlaylist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? owner = null,
    Object? displayName = null,
    Object? visibleTo = null,
    Object? inLibrary = null,
    Object? allowedCollaborators = null,
    Object? songs = null,
    Object? added = null,
  }) {
    return _then(_$FilledPlaylistImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      visibleTo: null == visibleTo
          ? _value._visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inLibrary: null == inLibrary
          ? _value._inLibrary
          : inLibrary // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowedCollaborators: null == allowedCollaborators
          ? _value._allowedCollaborators
          : allowedCollaborators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      songs: null == songs
          ? _value._songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      added: null == added
          ? _value.added
          : added // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FilledPlaylistImpl extends _FilledPlaylist {
  _$FilledPlaylistImpl(
      {required this.id,
      required this.owner,
      required this.displayName,
      required final List<String> visibleTo,
      required final List<String> inLibrary,
      required final List<String> allowedCollaborators,
      required final List<Song> songs,
      required this.added})
      : _visibleTo = visibleTo,
        _inLibrary = inLibrary,
        _allowedCollaborators = allowedCollaborators,
        _songs = songs,
        super._();

  @override
  final String id;
  @override
  final String owner;
  @override
  final String displayName;
  final List<String> _visibleTo;
  @override
  List<String> get visibleTo {
    if (_visibleTo is EqualUnmodifiableListView) return _visibleTo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visibleTo);
  }

  final List<String> _inLibrary;
  @override
  List<String> get inLibrary {
    if (_inLibrary is EqualUnmodifiableListView) return _inLibrary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inLibrary);
  }

  final List<String> _allowedCollaborators;
  @override
  List<String> get allowedCollaborators {
    if (_allowedCollaborators is EqualUnmodifiableListView)
      return _allowedCollaborators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowedCollaborators);
  }

  final List<Song> _songs;
  @override
  List<Song> get songs {
    if (_songs is EqualUnmodifiableListView) return _songs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_songs);
  }

  @override
  final int added;

  @override
  String toString() {
    return 'FilledPlaylist(id: $id, owner: $owner, displayName: $displayName, visibleTo: $visibleTo, inLibrary: $inLibrary, allowedCollaborators: $allowedCollaborators, songs: $songs, added: $added)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilledPlaylistImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            const DeepCollectionEquality()
                .equals(other._visibleTo, _visibleTo) &&
            const DeepCollectionEquality()
                .equals(other._inLibrary, _inLibrary) &&
            const DeepCollectionEquality()
                .equals(other._allowedCollaborators, _allowedCollaborators) &&
            const DeepCollectionEquality().equals(other._songs, _songs) &&
            (identical(other.added, added) || other.added == added));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      owner,
      displayName,
      const DeepCollectionEquality().hash(_visibleTo),
      const DeepCollectionEquality().hash(_inLibrary),
      const DeepCollectionEquality().hash(_allowedCollaborators),
      const DeepCollectionEquality().hash(_songs),
      added);

  /// Create a copy of FilledPlaylist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilledPlaylistImplCopyWith<_$FilledPlaylistImpl> get copyWith =>
      __$$FilledPlaylistImplCopyWithImpl<_$FilledPlaylistImpl>(
          this, _$identity);
}

abstract class _FilledPlaylist extends FilledPlaylist {
  factory _FilledPlaylist(
      {required final String id,
      required final String owner,
      required final String displayName,
      required final List<String> visibleTo,
      required final List<String> inLibrary,
      required final List<String> allowedCollaborators,
      required final List<Song> songs,
      required final int added}) = _$FilledPlaylistImpl;
  _FilledPlaylist._() : super._();

  @override
  String get id;
  @override
  String get owner;
  @override
  String get displayName;
  @override
  List<String> get visibleTo;
  @override
  List<String> get inLibrary;
  @override
  List<String> get allowedCollaborators;
  @override
  List<Song> get songs;
  @override
  int get added;

  /// Create a copy of FilledPlaylist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilledPlaylistImplCopyWith<_$FilledPlaylistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
