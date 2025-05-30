// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hierarchicalListView.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HLVArtist _$HLVArtistFromJson(Map<String, dynamic> json) {
  return _HLVArtist.fromJson(json);
}

/// @nodoc
mixin _$HLVArtist {
  String get name => throw _privateConstructorUsedError;
  List<String> get visibleTo => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  List<HLVAlbum> get albums => throw _privateConstructorUsedError;

  /// Serializes this HLVArtist to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HLVArtist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HLVArtistCopyWith<HLVArtist> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HLVArtistCopyWith<$Res> {
  factory $HLVArtistCopyWith(HLVArtist value, $Res Function(HLVArtist) then) =
      _$HLVArtistCopyWithImpl<$Res, HLVArtist>;
  @useResult
  $Res call(
      {String name,
      List<String> visibleTo,
      String imageUrl,
      List<HLVAlbum> albums});
}

/// @nodoc
class _$HLVArtistCopyWithImpl<$Res, $Val extends HLVArtist>
    implements $HLVArtistCopyWith<$Res> {
  _$HLVArtistCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HLVArtist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? visibleTo = null,
    Object? imageUrl = null,
    Object? albums = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      visibleTo: null == visibleTo
          ? _value.visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      albums: null == albums
          ? _value.albums
          : albums // ignore: cast_nullable_to_non_nullable
              as List<HLVAlbum>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HLVArtistImplCopyWith<$Res>
    implements $HLVArtistCopyWith<$Res> {
  factory _$$HLVArtistImplCopyWith(
          _$HLVArtistImpl value, $Res Function(_$HLVArtistImpl) then) =
      __$$HLVArtistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      List<String> visibleTo,
      String imageUrl,
      List<HLVAlbum> albums});
}

/// @nodoc
class __$$HLVArtistImplCopyWithImpl<$Res>
    extends _$HLVArtistCopyWithImpl<$Res, _$HLVArtistImpl>
    implements _$$HLVArtistImplCopyWith<$Res> {
  __$$HLVArtistImplCopyWithImpl(
      _$HLVArtistImpl _value, $Res Function(_$HLVArtistImpl) _then)
      : super(_value, _then);

  /// Create a copy of HLVArtist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? visibleTo = null,
    Object? imageUrl = null,
    Object? albums = null,
  }) {
    return _then(_$HLVArtistImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      visibleTo: null == visibleTo
          ? _value.visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      albums: null == albums
          ? _value.albums
          : albums // ignore: cast_nullable_to_non_nullable
              as List<HLVAlbum>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HLVArtistImpl extends _HLVArtist {
  _$HLVArtistImpl(
      {required this.name,
      required this.visibleTo,
      required this.imageUrl,
      required this.albums})
      : super._();

  factory _$HLVArtistImpl.fromJson(Map<String, dynamic> json) =>
      _$$HLVArtistImplFromJson(json);

  @override
  final String name;
  @override
  final List<String> visibleTo;
  @override
  final String imageUrl;
  @override
  final List<HLVAlbum> albums;

  @override
  String toString() {
    return 'HLVArtist(name: $name, visibleTo: $visibleTo, imageUrl: $imageUrl, albums: $albums)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HLVArtistImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.visibleTo, visibleTo) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other.albums, albums));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(visibleTo),
      imageUrl,
      const DeepCollectionEquality().hash(albums));

  /// Create a copy of HLVArtist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HLVArtistImplCopyWith<_$HLVArtistImpl> get copyWith =>
      __$$HLVArtistImplCopyWithImpl<_$HLVArtistImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HLVArtistImplToJson(
      this,
    );
  }
}

abstract class _HLVArtist extends HLVArtist {
  factory _HLVArtist(
      {required final String name,
      required final List<String> visibleTo,
      required final String imageUrl,
      required final List<HLVAlbum> albums}) = _$HLVArtistImpl;
  _HLVArtist._() : super._();

  factory _HLVArtist.fromJson(Map<String, dynamic> json) =
      _$HLVArtistImpl.fromJson;

  @override
  String get name;
  @override
  List<String> get visibleTo;
  @override
  String get imageUrl;
  @override
  List<HLVAlbum> get albums;

  /// Create a copy of HLVArtist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HLVArtistImplCopyWith<_$HLVArtistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HLVAlbum _$HLVAlbumFromJson(Map<String, dynamic> json) {
  return _HLVAlbum.fromJson(json);
}

/// @nodoc
mixin _$HLVAlbum {
  String get externalId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get visibleTo => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get artistImageUrl => throw _privateConstructorUsedError;
  List<HLVSong> get songs => throw _privateConstructorUsedError;

  /// Serializes this HLVAlbum to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HLVAlbum
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HLVAlbumCopyWith<HLVAlbum> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HLVAlbumCopyWith<$Res> {
  factory $HLVAlbumCopyWith(HLVAlbum value, $Res Function(HLVAlbum) then) =
      _$HLVAlbumCopyWithImpl<$Res, HLVAlbum>;
  @useResult
  $Res call(
      {String externalId,
      String name,
      List<String> visibleTo,
      String imageUrl,
      String artistImageUrl,
      List<HLVSong> songs});
}

/// @nodoc
class _$HLVAlbumCopyWithImpl<$Res, $Val extends HLVAlbum>
    implements $HLVAlbumCopyWith<$Res> {
  _$HLVAlbumCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HLVAlbum
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? externalId = null,
    Object? name = null,
    Object? visibleTo = null,
    Object? imageUrl = null,
    Object? artistImageUrl = null,
    Object? songs = null,
  }) {
    return _then(_value.copyWith(
      externalId: null == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      visibleTo: null == visibleTo
          ? _value.visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      artistImageUrl: null == artistImageUrl
          ? _value.artistImageUrl
          : artistImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<HLVSong>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HLVAlbumImplCopyWith<$Res>
    implements $HLVAlbumCopyWith<$Res> {
  factory _$$HLVAlbumImplCopyWith(
          _$HLVAlbumImpl value, $Res Function(_$HLVAlbumImpl) then) =
      __$$HLVAlbumImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String externalId,
      String name,
      List<String> visibleTo,
      String imageUrl,
      String artistImageUrl,
      List<HLVSong> songs});
}

/// @nodoc
class __$$HLVAlbumImplCopyWithImpl<$Res>
    extends _$HLVAlbumCopyWithImpl<$Res, _$HLVAlbumImpl>
    implements _$$HLVAlbumImplCopyWith<$Res> {
  __$$HLVAlbumImplCopyWithImpl(
      _$HLVAlbumImpl _value, $Res Function(_$HLVAlbumImpl) _then)
      : super(_value, _then);

  /// Create a copy of HLVAlbum
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? externalId = null,
    Object? name = null,
    Object? visibleTo = null,
    Object? imageUrl = null,
    Object? artistImageUrl = null,
    Object? songs = null,
  }) {
    return _then(_$HLVAlbumImpl(
      externalId: null == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      visibleTo: null == visibleTo
          ? _value.visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      artistImageUrl: null == artistImageUrl
          ? _value.artistImageUrl
          : artistImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<HLVSong>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HLVAlbumImpl extends _HLVAlbum {
  _$HLVAlbumImpl(
      {required this.externalId,
      required this.name,
      required this.visibleTo,
      required this.imageUrl,
      required this.artistImageUrl,
      required this.songs})
      : super._();

  factory _$HLVAlbumImpl.fromJson(Map<String, dynamic> json) =>
      _$$HLVAlbumImplFromJson(json);

  @override
  final String externalId;
  @override
  final String name;
  @override
  final List<String> visibleTo;
  @override
  final String imageUrl;
  @override
  final String artistImageUrl;
  @override
  final List<HLVSong> songs;

  @override
  String toString() {
    return 'HLVAlbum(externalId: $externalId, name: $name, visibleTo: $visibleTo, imageUrl: $imageUrl, artistImageUrl: $artistImageUrl, songs: $songs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HLVAlbumImpl &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.visibleTo, visibleTo) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.artistImageUrl, artistImageUrl) ||
                other.artistImageUrl == artistImageUrl) &&
            const DeepCollectionEquality().equals(other.songs, songs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      externalId,
      name,
      const DeepCollectionEquality().hash(visibleTo),
      imageUrl,
      artistImageUrl,
      const DeepCollectionEquality().hash(songs));

  /// Create a copy of HLVAlbum
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HLVAlbumImplCopyWith<_$HLVAlbumImpl> get copyWith =>
      __$$HLVAlbumImplCopyWithImpl<_$HLVAlbumImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HLVAlbumImplToJson(
      this,
    );
  }
}

abstract class _HLVAlbum extends HLVAlbum {
  factory _HLVAlbum(
      {required final String externalId,
      required final String name,
      required final List<String> visibleTo,
      required final String imageUrl,
      required final String artistImageUrl,
      required final List<HLVSong> songs}) = _$HLVAlbumImpl;
  _HLVAlbum._() : super._();

  factory _HLVAlbum.fromJson(Map<String, dynamic> json) =
      _$HLVAlbumImpl.fromJson;

  @override
  String get externalId;
  @override
  String get name;
  @override
  List<String> get visibleTo;
  @override
  String get imageUrl;
  @override
  String get artistImageUrl;
  @override
  List<HLVSong> get songs;

  /// Create a copy of HLVAlbum
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HLVAlbumImplCopyWith<_$HLVAlbumImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HLVSong _$HLVSongFromJson(Map<String, dynamic> json) {
  return _HLVSong.fromJson(json);
}

/// @nodoc
mixin _$HLVSong {
  String get externalId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get visibleTo => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get artistImageUrl => throw _privateConstructorUsedError;
  String get audioUrl => throw _privateConstructorUsedError;
  int get trackNumber => throw _privateConstructorUsedError;

  /// Serializes this HLVSong to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HLVSong
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HLVSongCopyWith<HLVSong> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HLVSongCopyWith<$Res> {
  factory $HLVSongCopyWith(HLVSong value, $Res Function(HLVSong) then) =
      _$HLVSongCopyWithImpl<$Res, HLVSong>;
  @useResult
  $Res call(
      {String externalId,
      String name,
      List<String> visibleTo,
      String imageUrl,
      String artistImageUrl,
      String audioUrl,
      int trackNumber});
}

/// @nodoc
class _$HLVSongCopyWithImpl<$Res, $Val extends HLVSong>
    implements $HLVSongCopyWith<$Res> {
  _$HLVSongCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HLVSong
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? externalId = null,
    Object? name = null,
    Object? visibleTo = null,
    Object? imageUrl = null,
    Object? artistImageUrl = null,
    Object? audioUrl = null,
    Object? trackNumber = null,
  }) {
    return _then(_value.copyWith(
      externalId: null == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      visibleTo: null == visibleTo
          ? _value.visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      artistImageUrl: null == artistImageUrl
          ? _value.artistImageUrl
          : artistImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      audioUrl: null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
      trackNumber: null == trackNumber
          ? _value.trackNumber
          : trackNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HLVSongImplCopyWith<$Res> implements $HLVSongCopyWith<$Res> {
  factory _$$HLVSongImplCopyWith(
          _$HLVSongImpl value, $Res Function(_$HLVSongImpl) then) =
      __$$HLVSongImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String externalId,
      String name,
      List<String> visibleTo,
      String imageUrl,
      String artistImageUrl,
      String audioUrl,
      int trackNumber});
}

/// @nodoc
class __$$HLVSongImplCopyWithImpl<$Res>
    extends _$HLVSongCopyWithImpl<$Res, _$HLVSongImpl>
    implements _$$HLVSongImplCopyWith<$Res> {
  __$$HLVSongImplCopyWithImpl(
      _$HLVSongImpl _value, $Res Function(_$HLVSongImpl) _then)
      : super(_value, _then);

  /// Create a copy of HLVSong
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? externalId = null,
    Object? name = null,
    Object? visibleTo = null,
    Object? imageUrl = null,
    Object? artistImageUrl = null,
    Object? audioUrl = null,
    Object? trackNumber = null,
  }) {
    return _then(_$HLVSongImpl(
      externalId: null == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      visibleTo: null == visibleTo
          ? _value.visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      artistImageUrl: null == artistImageUrl
          ? _value.artistImageUrl
          : artistImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      audioUrl: null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
      trackNumber: null == trackNumber
          ? _value.trackNumber
          : trackNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HLVSongImpl extends _HLVSong {
  _$HLVSongImpl(
      {required this.externalId,
      required this.name,
      required this.visibleTo,
      required this.imageUrl,
      required this.artistImageUrl,
      required this.audioUrl,
      required this.trackNumber})
      : super._();

  factory _$HLVSongImpl.fromJson(Map<String, dynamic> json) =>
      _$$HLVSongImplFromJson(json);

  @override
  final String externalId;
  @override
  final String name;
  @override
  final List<String> visibleTo;
  @override
  final String imageUrl;
  @override
  final String artistImageUrl;
  @override
  final String audioUrl;
  @override
  final int trackNumber;

  @override
  String toString() {
    return 'HLVSong(externalId: $externalId, name: $name, visibleTo: $visibleTo, imageUrl: $imageUrl, artistImageUrl: $artistImageUrl, audioUrl: $audioUrl, trackNumber: $trackNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HLVSongImpl &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.visibleTo, visibleTo) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.artistImageUrl, artistImageUrl) ||
                other.artistImageUrl == artistImageUrl) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl) &&
            (identical(other.trackNumber, trackNumber) ||
                other.trackNumber == trackNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      externalId,
      name,
      const DeepCollectionEquality().hash(visibleTo),
      imageUrl,
      artistImageUrl,
      audioUrl,
      trackNumber);

  /// Create a copy of HLVSong
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HLVSongImplCopyWith<_$HLVSongImpl> get copyWith =>
      __$$HLVSongImplCopyWithImpl<_$HLVSongImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HLVSongImplToJson(
      this,
    );
  }
}

abstract class _HLVSong extends HLVSong {
  factory _HLVSong(
      {required final String externalId,
      required final String name,
      required final List<String> visibleTo,
      required final String imageUrl,
      required final String artistImageUrl,
      required final String audioUrl,
      required final int trackNumber}) = _$HLVSongImpl;
  _HLVSong._() : super._();

  factory _HLVSong.fromJson(Map<String, dynamic> json) = _$HLVSongImpl.fromJson;

  @override
  String get externalId;
  @override
  String get name;
  @override
  List<String> get visibleTo;
  @override
  String get imageUrl;
  @override
  String get artistImageUrl;
  @override
  String get audioUrl;
  @override
  int get trackNumber;

  /// Create a copy of HLVSong
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HLVSongImplCopyWith<_$HLVSongImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
