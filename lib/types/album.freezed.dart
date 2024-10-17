// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'album.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Album _$AlbumFromJson(Map<String, dynamic> json) {
  return _Album.fromJson(json);
}

/// @nodoc
mixin _$Album {
  String get id => throw _privateConstructorUsedError;
  String get artistId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get artistDisplayName => throw _privateConstructorUsedError;
  int get songCount => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  int get added => throw _privateConstructorUsedError;
  List<String> get visibleTo => throw _privateConstructorUsedError;
  String get addedBy => throw _privateConstructorUsedError;

  /// Serializes this Album to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlbumCopyWith<Album> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlbumCopyWith<$Res> {
  factory $AlbumCopyWith(Album value, $Res Function(Album) then) =
      _$AlbumCopyWithImpl<$Res, Album>;
  @useResult
  $Res call(
      {String id,
      String artistId,
      String displayName,
      String artistDisplayName,
      int songCount,
      String imageUrl,
      int added,
      List<String> visibleTo,
      String addedBy});
}

/// @nodoc
class _$AlbumCopyWithImpl<$Res, $Val extends Album>
    implements $AlbumCopyWith<$Res> {
  _$AlbumCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? artistId = null,
    Object? displayName = null,
    Object? artistDisplayName = null,
    Object? songCount = null,
    Object? imageUrl = null,
    Object? added = null,
    Object? visibleTo = null,
    Object? addedBy = null,
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
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      artistDisplayName: null == artistDisplayName
          ? _value.artistDisplayName
          : artistDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      songCount: null == songCount
          ? _value.songCount
          : songCount // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      added: null == added
          ? _value.added
          : added // ignore: cast_nullable_to_non_nullable
              as int,
      visibleTo: null == visibleTo
          ? _value.visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      addedBy: null == addedBy
          ? _value.addedBy
          : addedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlbumImplCopyWith<$Res> implements $AlbumCopyWith<$Res> {
  factory _$$AlbumImplCopyWith(
          _$AlbumImpl value, $Res Function(_$AlbumImpl) then) =
      __$$AlbumImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String artistId,
      String displayName,
      String artistDisplayName,
      int songCount,
      String imageUrl,
      int added,
      List<String> visibleTo,
      String addedBy});
}

/// @nodoc
class __$$AlbumImplCopyWithImpl<$Res>
    extends _$AlbumCopyWithImpl<$Res, _$AlbumImpl>
    implements _$$AlbumImplCopyWith<$Res> {
  __$$AlbumImplCopyWithImpl(
      _$AlbumImpl _value, $Res Function(_$AlbumImpl) _then)
      : super(_value, _then);

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? artistId = null,
    Object? displayName = null,
    Object? artistDisplayName = null,
    Object? songCount = null,
    Object? imageUrl = null,
    Object? added = null,
    Object? visibleTo = null,
    Object? addedBy = null,
  }) {
    return _then(_$AlbumImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      artistId: null == artistId
          ? _value.artistId
          : artistId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      artistDisplayName: null == artistDisplayName
          ? _value.artistDisplayName
          : artistDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      songCount: null == songCount
          ? _value.songCount
          : songCount // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      added: null == added
          ? _value.added
          : added // ignore: cast_nullable_to_non_nullable
              as int,
      visibleTo: null == visibleTo
          ? _value._visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      addedBy: null == addedBy
          ? _value.addedBy
          : addedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlbumImpl implements _Album {
  _$AlbumImpl(
      {required this.id,
      required this.artistId,
      required this.displayName,
      required this.artistDisplayName,
      required this.songCount,
      required this.imageUrl,
      required this.added,
      required final List<String> visibleTo,
      required this.addedBy})
      : _visibleTo = visibleTo;

  factory _$AlbumImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlbumImplFromJson(json);

  @override
  final String id;
  @override
  final String artistId;
  @override
  final String displayName;
  @override
  final String artistDisplayName;
  @override
  final int songCount;
  @override
  final String imageUrl;
  @override
  final int added;
  final List<String> _visibleTo;
  @override
  List<String> get visibleTo {
    if (_visibleTo is EqualUnmodifiableListView) return _visibleTo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visibleTo);
  }

  @override
  final String addedBy;

  @override
  String toString() {
    return 'Album(id: $id, artistId: $artistId, displayName: $displayName, artistDisplayName: $artistDisplayName, songCount: $songCount, imageUrl: $imageUrl, added: $added, visibleTo: $visibleTo, addedBy: $addedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlbumImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.artistId, artistId) ||
                other.artistId == artistId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.artistDisplayName, artistDisplayName) ||
                other.artistDisplayName == artistDisplayName) &&
            (identical(other.songCount, songCount) ||
                other.songCount == songCount) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.added, added) || other.added == added) &&
            const DeepCollectionEquality()
                .equals(other._visibleTo, _visibleTo) &&
            (identical(other.addedBy, addedBy) || other.addedBy == addedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      artistId,
      displayName,
      artistDisplayName,
      songCount,
      imageUrl,
      added,
      const DeepCollectionEquality().hash(_visibleTo),
      addedBy);

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlbumImplCopyWith<_$AlbumImpl> get copyWith =>
      __$$AlbumImplCopyWithImpl<_$AlbumImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlbumImplToJson(
      this,
    );
  }
}

abstract class _Album implements Album {
  factory _Album(
      {required final String id,
      required final String artistId,
      required final String displayName,
      required final String artistDisplayName,
      required final int songCount,
      required final String imageUrl,
      required final int added,
      required final List<String> visibleTo,
      required final String addedBy}) = _$AlbumImpl;

  factory _Album.fromJson(Map<String, dynamic> json) = _$AlbumImpl.fromJson;

  @override
  String get id;
  @override
  String get artistId;
  @override
  String get displayName;
  @override
  String get artistDisplayName;
  @override
  int get songCount;
  @override
  String get imageUrl;
  @override
  int get added;
  @override
  List<String> get visibleTo;
  @override
  String get addedBy;

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlbumImplCopyWith<_$AlbumImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
