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

HLVPlaylist _$HLVPlaylistFromJson(Map<String, dynamic> json) {
  return _HLVPlaylist.fromJson(json);
}

/// @nodoc
mixin _$HLVPlaylist {
  String get name => throw _privateConstructorUsedError;
  String get owner => throw _privateConstructorUsedError;
  String get ownerImageUrl => throw _privateConstructorUsedError;
  List<String> get visibleTo => throw _privateConstructorUsedError;
  List<String> get allowedCollaborators => throw _privateConstructorUsedError;
  List<String> get inLibrary => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  List<HLVArtist> get artists => throw _privateConstructorUsedError;

  /// Serializes this HLVPlaylist to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HLVPlaylist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HLVPlaylistCopyWith<HLVPlaylist> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HLVPlaylistCopyWith<$Res> {
  factory $HLVPlaylistCopyWith(
          HLVPlaylist value, $Res Function(HLVPlaylist) then) =
      _$HLVPlaylistCopyWithImpl<$Res, HLVPlaylist>;
  @useResult
  $Res call(
      {String name,
      String owner,
      String ownerImageUrl,
      List<String> visibleTo,
      List<String> allowedCollaborators,
      List<String> inLibrary,
      String imageUrl,
      List<HLVArtist> artists});
}

/// @nodoc
class _$HLVPlaylistCopyWithImpl<$Res, $Val extends HLVPlaylist>
    implements $HLVPlaylistCopyWith<$Res> {
  _$HLVPlaylistCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HLVPlaylist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? owner = null,
    Object? ownerImageUrl = null,
    Object? visibleTo = null,
    Object? allowedCollaborators = null,
    Object? inLibrary = null,
    Object? imageUrl = null,
    Object? artists = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      ownerImageUrl: null == ownerImageUrl
          ? _value.ownerImageUrl
          : ownerImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      visibleTo: null == visibleTo
          ? _value.visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowedCollaborators: null == allowedCollaborators
          ? _value.allowedCollaborators
          : allowedCollaborators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inLibrary: null == inLibrary
          ? _value.inLibrary
          : inLibrary // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      artists: null == artists
          ? _value.artists
          : artists // ignore: cast_nullable_to_non_nullable
              as List<HLVArtist>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HLVPlaylistImplCopyWith<$Res>
    implements $HLVPlaylistCopyWith<$Res> {
  factory _$$HLVPlaylistImplCopyWith(
          _$HLVPlaylistImpl value, $Res Function(_$HLVPlaylistImpl) then) =
      __$$HLVPlaylistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String owner,
      String ownerImageUrl,
      List<String> visibleTo,
      List<String> allowedCollaborators,
      List<String> inLibrary,
      String imageUrl,
      List<HLVArtist> artists});
}

/// @nodoc
class __$$HLVPlaylistImplCopyWithImpl<$Res>
    extends _$HLVPlaylistCopyWithImpl<$Res, _$HLVPlaylistImpl>
    implements _$$HLVPlaylistImplCopyWith<$Res> {
  __$$HLVPlaylistImplCopyWithImpl(
      _$HLVPlaylistImpl _value, $Res Function(_$HLVPlaylistImpl) _then)
      : super(_value, _then);

  /// Create a copy of HLVPlaylist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? owner = null,
    Object? ownerImageUrl = null,
    Object? visibleTo = null,
    Object? allowedCollaborators = null,
    Object? inLibrary = null,
    Object? imageUrl = null,
    Object? artists = null,
  }) {
    return _then(_$HLVPlaylistImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      ownerImageUrl: null == ownerImageUrl
          ? _value.ownerImageUrl
          : ownerImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      visibleTo: null == visibleTo
          ? _value._visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowedCollaborators: null == allowedCollaborators
          ? _value._allowedCollaborators
          : allowedCollaborators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inLibrary: null == inLibrary
          ? _value._inLibrary
          : inLibrary // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      artists: null == artists
          ? _value._artists
          : artists // ignore: cast_nullable_to_non_nullable
              as List<HLVArtist>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HLVPlaylistImpl extends _HLVPlaylist {
  _$HLVPlaylistImpl(
      {required this.name,
      required this.owner,
      required this.ownerImageUrl,
      required final List<String> visibleTo,
      required final List<String> allowedCollaborators,
      required final List<String> inLibrary,
      required this.imageUrl,
      required final List<HLVArtist> artists})
      : _visibleTo = visibleTo,
        _allowedCollaborators = allowedCollaborators,
        _inLibrary = inLibrary,
        _artists = artists,
        super._();

  factory _$HLVPlaylistImpl.fromJson(Map<String, dynamic> json) =>
      _$$HLVPlaylistImplFromJson(json);

  @override
  final String name;
  @override
  final String owner;
  @override
  final String ownerImageUrl;
  final List<String> _visibleTo;
  @override
  List<String> get visibleTo {
    if (_visibleTo is EqualUnmodifiableListView) return _visibleTo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visibleTo);
  }

  final List<String> _allowedCollaborators;
  @override
  List<String> get allowedCollaborators {
    if (_allowedCollaborators is EqualUnmodifiableListView)
      return _allowedCollaborators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowedCollaborators);
  }

  final List<String> _inLibrary;
  @override
  List<String> get inLibrary {
    if (_inLibrary is EqualUnmodifiableListView) return _inLibrary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inLibrary);
  }

  @override
  final String imageUrl;
  final List<HLVArtist> _artists;
  @override
  List<HLVArtist> get artists {
    if (_artists is EqualUnmodifiableListView) return _artists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_artists);
  }

  @override
  String toString() {
    return 'HLVPlaylist(name: $name, owner: $owner, ownerImageUrl: $ownerImageUrl, visibleTo: $visibleTo, allowedCollaborators: $allowedCollaborators, inLibrary: $inLibrary, imageUrl: $imageUrl, artists: $artists)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HLVPlaylistImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.ownerImageUrl, ownerImageUrl) ||
                other.ownerImageUrl == ownerImageUrl) &&
            const DeepCollectionEquality()
                .equals(other._visibleTo, _visibleTo) &&
            const DeepCollectionEquality()
                .equals(other._allowedCollaborators, _allowedCollaborators) &&
            const DeepCollectionEquality()
                .equals(other._inLibrary, _inLibrary) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._artists, _artists));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      owner,
      ownerImageUrl,
      const DeepCollectionEquality().hash(_visibleTo),
      const DeepCollectionEquality().hash(_allowedCollaborators),
      const DeepCollectionEquality().hash(_inLibrary),
      imageUrl,
      const DeepCollectionEquality().hash(_artists));

  /// Create a copy of HLVPlaylist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HLVPlaylistImplCopyWith<_$HLVPlaylistImpl> get copyWith =>
      __$$HLVPlaylistImplCopyWithImpl<_$HLVPlaylistImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HLVPlaylistImplToJson(
      this,
    );
  }
}

abstract class _HLVPlaylist extends HLVPlaylist {
  factory _HLVPlaylist(
      {required final String name,
      required final String owner,
      required final String ownerImageUrl,
      required final List<String> visibleTo,
      required final List<String> allowedCollaborators,
      required final List<String> inLibrary,
      required final String imageUrl,
      required final List<HLVArtist> artists}) = _$HLVPlaylistImpl;
  _HLVPlaylist._() : super._();

  factory _HLVPlaylist.fromJson(Map<String, dynamic> json) =
      _$HLVPlaylistImpl.fromJson;

  @override
  String get name;
  @override
  String get owner;
  @override
  String get ownerImageUrl;
  @override
  List<String> get visibleTo;
  @override
  List<String> get allowedCollaborators;
  @override
  List<String> get inLibrary;
  @override
  String get imageUrl;
  @override
  List<HLVArtist> get artists;

  /// Create a copy of HLVPlaylist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HLVPlaylistImplCopyWith<_$HLVPlaylistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

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
          ? _value._visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      albums: null == albums
          ? _value._albums
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
      required final List<String> visibleTo,
      required this.imageUrl,
      required final List<HLVAlbum> albums})
      : _visibleTo = visibleTo,
        _albums = albums,
        super._();

  factory _$HLVArtistImpl.fromJson(Map<String, dynamic> json) =>
      _$$HLVArtistImplFromJson(json);

  @override
  final String name;
  final List<String> _visibleTo;
  @override
  List<String> get visibleTo {
    if (_visibleTo is EqualUnmodifiableListView) return _visibleTo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visibleTo);
  }

  @override
  final String imageUrl;
  final List<HLVAlbum> _albums;
  @override
  List<HLVAlbum> get albums {
    if (_albums is EqualUnmodifiableListView) return _albums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_albums);
  }

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
            const DeepCollectionEquality()
                .equals(other._visibleTo, _visibleTo) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._albums, _albums));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(_visibleTo),
      imageUrl,
      const DeepCollectionEquality().hash(_albums));

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
      {String name,
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
    Object? name = null,
    Object? visibleTo = null,
    Object? imageUrl = null,
    Object? artistImageUrl = null,
    Object? songs = null,
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
      {String name,
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
    Object? name = null,
    Object? visibleTo = null,
    Object? imageUrl = null,
    Object? artistImageUrl = null,
    Object? songs = null,
  }) {
    return _then(_$HLVAlbumImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      visibleTo: null == visibleTo
          ? _value._visibleTo
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
          ? _value._songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<HLVSong>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HLVAlbumImpl extends _HLVAlbum {
  _$HLVAlbumImpl(
      {required this.name,
      required final List<String> visibleTo,
      required this.imageUrl,
      required this.artistImageUrl,
      required final List<HLVSong> songs})
      : _visibleTo = visibleTo,
        _songs = songs,
        super._();

  factory _$HLVAlbumImpl.fromJson(Map<String, dynamic> json) =>
      _$$HLVAlbumImplFromJson(json);

  @override
  final String name;
  final List<String> _visibleTo;
  @override
  List<String> get visibleTo {
    if (_visibleTo is EqualUnmodifiableListView) return _visibleTo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visibleTo);
  }

  @override
  final String imageUrl;
  @override
  final String artistImageUrl;
  final List<HLVSong> _songs;
  @override
  List<HLVSong> get songs {
    if (_songs is EqualUnmodifiableListView) return _songs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_songs);
  }

  @override
  String toString() {
    return 'HLVAlbum(name: $name, visibleTo: $visibleTo, imageUrl: $imageUrl, artistImageUrl: $artistImageUrl, songs: $songs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HLVAlbumImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._visibleTo, _visibleTo) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.artistImageUrl, artistImageUrl) ||
                other.artistImageUrl == artistImageUrl) &&
            const DeepCollectionEquality().equals(other._songs, _songs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(_visibleTo),
      imageUrl,
      artistImageUrl,
      const DeepCollectionEquality().hash(_songs));

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
      {required final String name,
      required final List<String> visibleTo,
      required final String imageUrl,
      required final String artistImageUrl,
      required final List<HLVSong> songs}) = _$HLVAlbumImpl;
  _HLVAlbum._() : super._();

  factory _HLVAlbum.fromJson(Map<String, dynamic> json) =
      _$HLVAlbumImpl.fromJson;

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
      {String name,
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
    Object? name = null,
    Object? visibleTo = null,
    Object? imageUrl = null,
    Object? artistImageUrl = null,
    Object? audioUrl = null,
    Object? trackNumber = null,
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
      {String name,
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
    Object? name = null,
    Object? visibleTo = null,
    Object? imageUrl = null,
    Object? artistImageUrl = null,
    Object? audioUrl = null,
    Object? trackNumber = null,
  }) {
    return _then(_$HLVSongImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      visibleTo: null == visibleTo
          ? _value._visibleTo
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
      {required this.name,
      required final List<String> visibleTo,
      required this.imageUrl,
      required this.artistImageUrl,
      required this.audioUrl,
      required this.trackNumber})
      : _visibleTo = visibleTo,
        super._();

  factory _$HLVSongImpl.fromJson(Map<String, dynamic> json) =>
      _$$HLVSongImplFromJson(json);

  @override
  final String name;
  final List<String> _visibleTo;
  @override
  List<String> get visibleTo {
    if (_visibleTo is EqualUnmodifiableListView) return _visibleTo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visibleTo);
  }

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
    return 'HLVSong(name: $name, visibleTo: $visibleTo, imageUrl: $imageUrl, artistImageUrl: $artistImageUrl, audioUrl: $audioUrl, trackNumber: $trackNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HLVSongImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._visibleTo, _visibleTo) &&
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
      name,
      const DeepCollectionEquality().hash(_visibleTo),
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
      {required final String name,
      required final List<String> visibleTo,
      required final String imageUrl,
      required final String artistImageUrl,
      required final String audioUrl,
      required final int trackNumber}) = _$HLVSongImpl;
  _HLVSong._() : super._();

  factory _HLVSong.fromJson(Map<String, dynamic> json) = _$HLVSongImpl.fromJson;

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
