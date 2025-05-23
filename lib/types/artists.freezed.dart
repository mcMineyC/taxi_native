// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'artists.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Artist _$ArtistFromJson(Map<String, dynamic> json) {
  return _Artist.fromJson(json);
}

/// @nodoc
mixin _$Artist {
  String get id => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  int get albumCount => throw _privateConstructorUsedError;
  int get songCount => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  int get added => throw _privateConstructorUsedError;
  List<String> get visibleTo => throw _privateConstructorUsedError;
  List<String> get inLibrary => throw _privateConstructorUsedError;
  String get addedBy => throw _privateConstructorUsedError;

  /// Serializes this Artist to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Artist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArtistCopyWith<Artist> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtistCopyWith<$Res> {
  factory $ArtistCopyWith(Artist value, $Res Function(Artist) then) =
      _$ArtistCopyWithImpl<$Res, Artist>;
  @useResult
  $Res call(
      {String id,
      String displayName,
      int albumCount,
      int songCount,
      String imageUrl,
      int added,
      List<String> visibleTo,
      List<String> inLibrary,
      String addedBy});
}

/// @nodoc
class _$ArtistCopyWithImpl<$Res, $Val extends Artist>
    implements $ArtistCopyWith<$Res> {
  _$ArtistCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Artist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? albumCount = null,
    Object? songCount = null,
    Object? imageUrl = null,
    Object? added = null,
    Object? visibleTo = null,
    Object? inLibrary = null,
    Object? addedBy = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      albumCount: null == albumCount
          ? _value.albumCount
          : albumCount // ignore: cast_nullable_to_non_nullable
              as int,
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
      inLibrary: null == inLibrary
          ? _value.inLibrary
          : inLibrary // ignore: cast_nullable_to_non_nullable
              as List<String>,
      addedBy: null == addedBy
          ? _value.addedBy
          : addedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArtistImplCopyWith<$Res> implements $ArtistCopyWith<$Res> {
  factory _$$ArtistImplCopyWith(
          _$ArtistImpl value, $Res Function(_$ArtistImpl) then) =
      __$$ArtistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String displayName,
      int albumCount,
      int songCount,
      String imageUrl,
      int added,
      List<String> visibleTo,
      List<String> inLibrary,
      String addedBy});
}

/// @nodoc
class __$$ArtistImplCopyWithImpl<$Res>
    extends _$ArtistCopyWithImpl<$Res, _$ArtistImpl>
    implements _$$ArtistImplCopyWith<$Res> {
  __$$ArtistImplCopyWithImpl(
      _$ArtistImpl _value, $Res Function(_$ArtistImpl) _then)
      : super(_value, _then);

  /// Create a copy of Artist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? albumCount = null,
    Object? songCount = null,
    Object? imageUrl = null,
    Object? added = null,
    Object? visibleTo = null,
    Object? inLibrary = null,
    Object? addedBy = null,
  }) {
    return _then(_$ArtistImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      albumCount: null == albumCount
          ? _value.albumCount
          : albumCount // ignore: cast_nullable_to_non_nullable
              as int,
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
      inLibrary: null == inLibrary
          ? _value._inLibrary
          : inLibrary // ignore: cast_nullable_to_non_nullable
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
class _$ArtistImpl extends _Artist {
  _$ArtistImpl(
      {required this.id,
      required this.displayName,
      required this.albumCount,
      required this.songCount,
      required this.imageUrl,
      required this.added,
      required final List<String> visibleTo,
      required final List<String> inLibrary,
      required this.addedBy})
      : _visibleTo = visibleTo,
        _inLibrary = inLibrary,
        super._();

  factory _$ArtistImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArtistImplFromJson(json);

  @override
  final String id;
  @override
  final String displayName;
  @override
  final int albumCount;
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

  final List<String> _inLibrary;
  @override
  List<String> get inLibrary {
    if (_inLibrary is EqualUnmodifiableListView) return _inLibrary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inLibrary);
  }

  @override
  final String addedBy;

  @override
  String toString() {
    return 'Artist(id: $id, displayName: $displayName, albumCount: $albumCount, songCount: $songCount, imageUrl: $imageUrl, added: $added, visibleTo: $visibleTo, inLibrary: $inLibrary, addedBy: $addedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtistImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.albumCount, albumCount) ||
                other.albumCount == albumCount) &&
            (identical(other.songCount, songCount) ||
                other.songCount == songCount) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.added, added) || other.added == added) &&
            const DeepCollectionEquality()
                .equals(other._visibleTo, _visibleTo) &&
            const DeepCollectionEquality()
                .equals(other._inLibrary, _inLibrary) &&
            (identical(other.addedBy, addedBy) || other.addedBy == addedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      displayName,
      albumCount,
      songCount,
      imageUrl,
      added,
      const DeepCollectionEquality().hash(_visibleTo),
      const DeepCollectionEquality().hash(_inLibrary),
      addedBy);

  /// Create a copy of Artist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtistImplCopyWith<_$ArtistImpl> get copyWith =>
      __$$ArtistImplCopyWithImpl<_$ArtistImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArtistImplToJson(
      this,
    );
  }
}

abstract class _Artist extends Artist {
  factory _Artist(
      {required final String id,
      required final String displayName,
      required final int albumCount,
      required final int songCount,
      required final String imageUrl,
      required final int added,
      required final List<String> visibleTo,
      required final List<String> inLibrary,
      required final String addedBy}) = _$ArtistImpl;
  _Artist._() : super._();

  factory _Artist.fromJson(Map<String, dynamic> json) = _$ArtistImpl.fromJson;

  @override
  String get id;
  @override
  String get displayName;
  @override
  int get albumCount;
  @override
  int get songCount;
  @override
  String get imageUrl;
  @override
  int get added;
  @override
  List<String> get visibleTo;
  @override
  List<String> get inLibrary;
  @override
  String get addedBy;

  /// Create a copy of Artist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtistImplCopyWith<_$ArtistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
