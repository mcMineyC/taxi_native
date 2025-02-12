// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'searchresult.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) {
  return _SearchResponse.fromJson(json);
}

/// @nodoc
mixin _$SearchResponse {
  List<Song> get songs => throw _privateConstructorUsedError;
  List<Album> get albums => throw _privateConstructorUsedError;
  List<Artist> get artists => throw _privateConstructorUsedError;
  List<Song> get singles => throw _privateConstructorUsedError;
  List<String> get relevancy => throw _privateConstructorUsedError;

  /// Serializes this SearchResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchResponseCopyWith<SearchResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchResponseCopyWith<$Res> {
  factory $SearchResponseCopyWith(
          SearchResponse value, $Res Function(SearchResponse) then) =
      _$SearchResponseCopyWithImpl<$Res, SearchResponse>;
  @useResult
  $Res call(
      {List<Song> songs,
      List<Album> albums,
      List<Artist> artists,
      List<Song> singles,
      List<String> relevancy});
}

/// @nodoc
class _$SearchResponseCopyWithImpl<$Res, $Val extends SearchResponse>
    implements $SearchResponseCopyWith<$Res> {
  _$SearchResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songs = null,
    Object? albums = null,
    Object? artists = null,
    Object? singles = null,
    Object? relevancy = null,
  }) {
    return _then(_value.copyWith(
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      albums: null == albums
          ? _value.albums
          : albums // ignore: cast_nullable_to_non_nullable
              as List<Album>,
      artists: null == artists
          ? _value.artists
          : artists // ignore: cast_nullable_to_non_nullable
              as List<Artist>,
      singles: null == singles
          ? _value.singles
          : singles // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      relevancy: null == relevancy
          ? _value.relevancy
          : relevancy // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchResponseImplCopyWith<$Res>
    implements $SearchResponseCopyWith<$Res> {
  factory _$$SearchResponseImplCopyWith(_$SearchResponseImpl value,
          $Res Function(_$SearchResponseImpl) then) =
      __$$SearchResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Song> songs,
      List<Album> albums,
      List<Artist> artists,
      List<Song> singles,
      List<String> relevancy});
}

/// @nodoc
class __$$SearchResponseImplCopyWithImpl<$Res>
    extends _$SearchResponseCopyWithImpl<$Res, _$SearchResponseImpl>
    implements _$$SearchResponseImplCopyWith<$Res> {
  __$$SearchResponseImplCopyWithImpl(
      _$SearchResponseImpl _value, $Res Function(_$SearchResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songs = null,
    Object? albums = null,
    Object? artists = null,
    Object? singles = null,
    Object? relevancy = null,
  }) {
    return _then(_$SearchResponseImpl(
      songs: null == songs
          ? _value._songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      albums: null == albums
          ? _value._albums
          : albums // ignore: cast_nullable_to_non_nullable
              as List<Album>,
      artists: null == artists
          ? _value._artists
          : artists // ignore: cast_nullable_to_non_nullable
              as List<Artist>,
      singles: null == singles
          ? _value._singles
          : singles // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      relevancy: null == relevancy
          ? _value._relevancy
          : relevancy // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchResponseImpl extends _SearchResponse {
  const _$SearchResponseImpl(
      {required final List<Song> songs,
      required final List<Album> albums,
      required final List<Artist> artists,
      required final List<Song> singles,
      required final List<String> relevancy})
      : _songs = songs,
        _albums = albums,
        _artists = artists,
        _singles = singles,
        _relevancy = relevancy,
        super._();

  factory _$SearchResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchResponseImplFromJson(json);

  final List<Song> _songs;
  @override
  List<Song> get songs {
    if (_songs is EqualUnmodifiableListView) return _songs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_songs);
  }

  final List<Album> _albums;
  @override
  List<Album> get albums {
    if (_albums is EqualUnmodifiableListView) return _albums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_albums);
  }

  final List<Artist> _artists;
  @override
  List<Artist> get artists {
    if (_artists is EqualUnmodifiableListView) return _artists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_artists);
  }

  final List<Song> _singles;
  @override
  List<Song> get singles {
    if (_singles is EqualUnmodifiableListView) return _singles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_singles);
  }

  final List<String> _relevancy;
  @override
  List<String> get relevancy {
    if (_relevancy is EqualUnmodifiableListView) return _relevancy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relevancy);
  }

  @override
  String toString() {
    return 'SearchResponse(songs: $songs, albums: $albums, artists: $artists, singles: $singles, relevancy: $relevancy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchResponseImpl &&
            const DeepCollectionEquality().equals(other._songs, _songs) &&
            const DeepCollectionEquality().equals(other._albums, _albums) &&
            const DeepCollectionEquality().equals(other._artists, _artists) &&
            const DeepCollectionEquality().equals(other._singles, _singles) &&
            const DeepCollectionEquality()
                .equals(other._relevancy, _relevancy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_songs),
      const DeepCollectionEquality().hash(_albums),
      const DeepCollectionEquality().hash(_artists),
      const DeepCollectionEquality().hash(_singles),
      const DeepCollectionEquality().hash(_relevancy));

  /// Create a copy of SearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchResponseImplCopyWith<_$SearchResponseImpl> get copyWith =>
      __$$SearchResponseImplCopyWithImpl<_$SearchResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchResponseImplToJson(
      this,
    );
  }
}

abstract class _SearchResponse extends SearchResponse {
  const factory _SearchResponse(
      {required final List<Song> songs,
      required final List<Album> albums,
      required final List<Artist> artists,
      required final List<Song> singles,
      required final List<String> relevancy}) = _$SearchResponseImpl;
  const _SearchResponse._() : super._();

  factory _SearchResponse.fromJson(Map<String, dynamic> json) =
      _$SearchResponseImpl.fromJson;

  @override
  List<Song> get songs;
  @override
  List<Album> get albums;
  @override
  List<Artist> get artists;
  @override
  List<Song> get singles;
  @override
  List<String> get relevancy;

  /// Create a copy of SearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchResponseImplCopyWith<_$SearchResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocalSearchResult _$LocalSearchResultFromJson(Map<String, dynamic> json) {
  return _LocalSearchResult.fromJson(json);
}

/// @nodoc
mixin _$LocalSearchResult {
  String get id => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this LocalSearchResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocalSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalSearchResultCopyWith<LocalSearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalSearchResultCopyWith<$Res> {
  factory $LocalSearchResultCopyWith(
          LocalSearchResult value, $Res Function(LocalSearchResult) then) =
      _$LocalSearchResultCopyWithImpl<$Res, LocalSearchResult>;
  @useResult
  $Res call({String id, String displayName, String imageUrl, String type});
}

/// @nodoc
class _$LocalSearchResultCopyWithImpl<$Res, $Val extends LocalSearchResult>
    implements $LocalSearchResultCopyWith<$Res> {
  _$LocalSearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? imageUrl = null,
    Object? type = null,
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
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocalSearchResultImplCopyWith<$Res>
    implements $LocalSearchResultCopyWith<$Res> {
  factory _$$LocalSearchResultImplCopyWith(_$LocalSearchResultImpl value,
          $Res Function(_$LocalSearchResultImpl) then) =
      __$$LocalSearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String displayName, String imageUrl, String type});
}

/// @nodoc
class __$$LocalSearchResultImplCopyWithImpl<$Res>
    extends _$LocalSearchResultCopyWithImpl<$Res, _$LocalSearchResultImpl>
    implements _$$LocalSearchResultImplCopyWith<$Res> {
  __$$LocalSearchResultImplCopyWithImpl(_$LocalSearchResultImpl _value,
      $Res Function(_$LocalSearchResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocalSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? imageUrl = null,
    Object? type = null,
  }) {
    return _then(_$LocalSearchResultImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalSearchResultImpl extends _LocalSearchResult {
  const _$LocalSearchResultImpl(
      {required this.id,
      required this.displayName,
      required this.imageUrl,
      required this.type})
      : super._();

  factory _$LocalSearchResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalSearchResultImplFromJson(json);

  @override
  final String id;
  @override
  final String displayName;
  @override
  final String imageUrl;
  @override
  final String type;

  @override
  String toString() {
    return 'LocalSearchResult(id: $id, displayName: $displayName, imageUrl: $imageUrl, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalSearchResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, displayName, imageUrl, type);

  /// Create a copy of LocalSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalSearchResultImplCopyWith<_$LocalSearchResultImpl> get copyWith =>
      __$$LocalSearchResultImplCopyWithImpl<_$LocalSearchResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalSearchResultImplToJson(
      this,
    );
  }
}

abstract class _LocalSearchResult extends LocalSearchResult {
  const factory _LocalSearchResult(
      {required final String id,
      required final String displayName,
      required final String imageUrl,
      required final String type}) = _$LocalSearchResultImpl;
  const _LocalSearchResult._() : super._();

  factory _LocalSearchResult.fromJson(Map<String, dynamic> json) =
      _$LocalSearchResultImpl.fromJson;

  @override
  String get id;
  @override
  String get displayName;
  @override
  String get imageUrl;
  @override
  String get type;

  /// Create a copy of LocalSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalSearchResultImplCopyWith<_$LocalSearchResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) {
  return _SearchResult.fromJson(json);
}

/// @nodoc
mixin _$SearchResult {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get artist => throw _privateConstructorUsedError;
  String get album => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get artistImageUrl => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this SearchResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchResultCopyWith<SearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchResultCopyWith<$Res> {
  factory $SearchResultCopyWith(
          SearchResult value, $Res Function(SearchResult) then) =
      _$SearchResultCopyWithImpl<$Res, SearchResult>;
  @useResult
  $Res call(
      {String id,
      String name,
      String artist,
      String album,
      String imageUrl,
      String artistImageUrl,
      String type});
}

/// @nodoc
class _$SearchResultCopyWithImpl<$Res, $Val extends SearchResult>
    implements $SearchResultCopyWith<$Res> {
  _$SearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? artist = null,
    Object? album = null,
    Object? imageUrl = null,
    Object? artistImageUrl = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      album: null == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      artistImageUrl: null == artistImageUrl
          ? _value.artistImageUrl
          : artistImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchResultImplCopyWith<$Res>
    implements $SearchResultCopyWith<$Res> {
  factory _$$SearchResultImplCopyWith(
          _$SearchResultImpl value, $Res Function(_$SearchResultImpl) then) =
      __$$SearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String artist,
      String album,
      String imageUrl,
      String artistImageUrl,
      String type});
}

/// @nodoc
class __$$SearchResultImplCopyWithImpl<$Res>
    extends _$SearchResultCopyWithImpl<$Res, _$SearchResultImpl>
    implements _$$SearchResultImplCopyWith<$Res> {
  __$$SearchResultImplCopyWithImpl(
      _$SearchResultImpl _value, $Res Function(_$SearchResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? artist = null,
    Object? album = null,
    Object? imageUrl = null,
    Object? artistImageUrl = null,
    Object? type = null,
  }) {
    return _then(_$SearchResultImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      album: null == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      artistImageUrl: null == artistImageUrl
          ? _value.artistImageUrl
          : artistImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchResultImpl extends _SearchResult {
  const _$SearchResultImpl(
      {required this.id,
      required this.name,
      required this.artist,
      required this.album,
      required this.imageUrl,
      required this.artistImageUrl,
      required this.type})
      : super._();

  factory _$SearchResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchResultImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String artist;
  @override
  final String album;
  @override
  final String imageUrl;
  @override
  final String artistImageUrl;
  @override
  final String type;

  @override
  String toString() {
    return 'SearchResult(id: $id, name: $name, artist: $artist, album: $album, imageUrl: $imageUrl, artistImageUrl: $artistImageUrl, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.album, album) || other.album == album) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.artistImageUrl, artistImageUrl) ||
                other.artistImageUrl == artistImageUrl) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, artist, album, imageUrl, artistImageUrl, type);

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchResultImplCopyWith<_$SearchResultImpl> get copyWith =>
      __$$SearchResultImplCopyWithImpl<_$SearchResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchResultImplToJson(
      this,
    );
  }
}

abstract class _SearchResult extends SearchResult {
  const factory _SearchResult(
      {required final String id,
      required final String name,
      required final String artist,
      required final String album,
      required final String imageUrl,
      required final String artistImageUrl,
      required final String type}) = _$SearchResultImpl;
  const _SearchResult._() : super._();

  factory _SearchResult.fromJson(Map<String, dynamic> json) =
      _$SearchResultImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get artist;
  @override
  String get album;
  @override
  String get imageUrl;
  @override
  String get artistImageUrl;
  @override
  String get type;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchResultImplCopyWith<_$SearchResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FindResult _$FindResultFromJson(Map<String, dynamic> json) {
  return _FindResult.fromJson(json);
}

/// @nodoc
mixin _$FindResult {
  String get name => throw _privateConstructorUsedError;
  String get artist => throw _privateConstructorUsedError;
  String get album => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get artistImageUrl => throw _privateConstructorUsedError;
  List<String> get visibleTo => throw _privateConstructorUsedError;
  List<String> get inLibrary => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  List<FindResultSong> get songs => throw _privateConstructorUsedError;

  /// Serializes this FindResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FindResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FindResultCopyWith<FindResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FindResultCopyWith<$Res> {
  factory $FindResultCopyWith(
          FindResult value, $Res Function(FindResult) then) =
      _$FindResultCopyWithImpl<$Res, FindResult>;
  @useResult
  $Res call(
      {String name,
      String artist,
      String album,
      String imageUrl,
      String artistImageUrl,
      List<String> visibleTo,
      List<String> inLibrary,
      String type,
      List<FindResultSong> songs});
}

/// @nodoc
class _$FindResultCopyWithImpl<$Res, $Val extends FindResult>
    implements $FindResultCopyWith<$Res> {
  _$FindResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FindResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? artist = null,
    Object? album = null,
    Object? imageUrl = null,
    Object? artistImageUrl = null,
    Object? visibleTo = null,
    Object? inLibrary = null,
    Object? type = null,
    Object? songs = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      album: null == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      artistImageUrl: null == artistImageUrl
          ? _value.artistImageUrl
          : artistImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      visibleTo: null == visibleTo
          ? _value.visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inLibrary: null == inLibrary
          ? _value.inLibrary
          : inLibrary // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<FindResultSong>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FindResultImplCopyWith<$Res>
    implements $FindResultCopyWith<$Res> {
  factory _$$FindResultImplCopyWith(
          _$FindResultImpl value, $Res Function(_$FindResultImpl) then) =
      __$$FindResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String artist,
      String album,
      String imageUrl,
      String artistImageUrl,
      List<String> visibleTo,
      List<String> inLibrary,
      String type,
      List<FindResultSong> songs});
}

/// @nodoc
class __$$FindResultImplCopyWithImpl<$Res>
    extends _$FindResultCopyWithImpl<$Res, _$FindResultImpl>
    implements _$$FindResultImplCopyWith<$Res> {
  __$$FindResultImplCopyWithImpl(
      _$FindResultImpl _value, $Res Function(_$FindResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of FindResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? artist = null,
    Object? album = null,
    Object? imageUrl = null,
    Object? artistImageUrl = null,
    Object? visibleTo = null,
    Object? inLibrary = null,
    Object? type = null,
    Object? songs = null,
  }) {
    return _then(_$FindResultImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      album: null == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      artistImageUrl: null == artistImageUrl
          ? _value.artistImageUrl
          : artistImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      visibleTo: null == visibleTo
          ? _value._visibleTo
          : visibleTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inLibrary: null == inLibrary
          ? _value._inLibrary
          : inLibrary // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      songs: null == songs
          ? _value._songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<FindResultSong>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FindResultImpl extends _FindResult {
  const _$FindResultImpl(
      {required this.name,
      required this.artist,
      required this.album,
      required this.imageUrl,
      required this.artistImageUrl,
      required final List<String> visibleTo,
      required final List<String> inLibrary,
      required this.type,
      required final List<FindResultSong> songs})
      : _visibleTo = visibleTo,
        _inLibrary = inLibrary,
        _songs = songs,
        super._();

  factory _$FindResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$FindResultImplFromJson(json);

  @override
  final String name;
  @override
  final String artist;
  @override
  final String album;
  @override
  final String imageUrl;
  @override
  final String artistImageUrl;
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
  final String type;
  final List<FindResultSong> _songs;
  @override
  List<FindResultSong> get songs {
    if (_songs is EqualUnmodifiableListView) return _songs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_songs);
  }

  @override
  String toString() {
    return 'FindResult(name: $name, artist: $artist, album: $album, imageUrl: $imageUrl, artistImageUrl: $artistImageUrl, visibleTo: $visibleTo, inLibrary: $inLibrary, type: $type, songs: $songs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FindResultImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.album, album) || other.album == album) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.artistImageUrl, artistImageUrl) ||
                other.artistImageUrl == artistImageUrl) &&
            const DeepCollectionEquality()
                .equals(other._visibleTo, _visibleTo) &&
            const DeepCollectionEquality()
                .equals(other._inLibrary, _inLibrary) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._songs, _songs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      artist,
      album,
      imageUrl,
      artistImageUrl,
      const DeepCollectionEquality().hash(_visibleTo),
      const DeepCollectionEquality().hash(_inLibrary),
      type,
      const DeepCollectionEquality().hash(_songs));

  /// Create a copy of FindResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FindResultImplCopyWith<_$FindResultImpl> get copyWith =>
      __$$FindResultImplCopyWithImpl<_$FindResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FindResultImplToJson(
      this,
    );
  }
}

abstract class _FindResult extends FindResult {
  const factory _FindResult(
      {required final String name,
      required final String artist,
      required final String album,
      required final String imageUrl,
      required final String artistImageUrl,
      required final List<String> visibleTo,
      required final List<String> inLibrary,
      required final String type,
      required final List<FindResultSong> songs}) = _$FindResultImpl;
  const _FindResult._() : super._();

  factory _FindResult.fromJson(Map<String, dynamic> json) =
      _$FindResultImpl.fromJson;

  @override
  String get name;
  @override
  String get artist;
  @override
  String get album;
  @override
  String get imageUrl;
  @override
  String get artistImageUrl;
  @override
  List<String> get visibleTo;
  @override
  List<String> get inLibrary;
  @override
  String get type;
  @override
  List<FindResultSong> get songs;

  /// Create a copy of FindResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FindResultImplCopyWith<_$FindResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FindResultSong _$FindResultSongFromJson(Map<String, dynamic> json) {
  return _FindResultSong.fromJson(json);
}

/// @nodoc
mixin _$FindResultSong {
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  int get trackNumber => throw _privateConstructorUsedError;

  /// Serializes this FindResultSong to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FindResultSong
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FindResultSongCopyWith<FindResultSong> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FindResultSongCopyWith<$Res> {
  factory $FindResultSongCopyWith(
          FindResultSong value, $Res Function(FindResultSong) then) =
      _$FindResultSongCopyWithImpl<$Res, FindResultSong>;
  @useResult
  $Res call({String title, String url, int trackNumber});
}

/// @nodoc
class _$FindResultSongCopyWithImpl<$Res, $Val extends FindResultSong>
    implements $FindResultSongCopyWith<$Res> {
  _$FindResultSongCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FindResultSong
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? trackNumber = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      trackNumber: null == trackNumber
          ? _value.trackNumber
          : trackNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FindResultSongImplCopyWith<$Res>
    implements $FindResultSongCopyWith<$Res> {
  factory _$$FindResultSongImplCopyWith(_$FindResultSongImpl value,
          $Res Function(_$FindResultSongImpl) then) =
      __$$FindResultSongImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String url, int trackNumber});
}

/// @nodoc
class __$$FindResultSongImplCopyWithImpl<$Res>
    extends _$FindResultSongCopyWithImpl<$Res, _$FindResultSongImpl>
    implements _$$FindResultSongImplCopyWith<$Res> {
  __$$FindResultSongImplCopyWithImpl(
      _$FindResultSongImpl _value, $Res Function(_$FindResultSongImpl) _then)
      : super(_value, _then);

  /// Create a copy of FindResultSong
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? trackNumber = null,
  }) {
    return _then(_$FindResultSongImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
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
class _$FindResultSongImpl implements _FindResultSong {
  const _$FindResultSongImpl(
      {required this.title, required this.url, required this.trackNumber});

  factory _$FindResultSongImpl.fromJson(Map<String, dynamic> json) =>
      _$$FindResultSongImplFromJson(json);

  @override
  final String title;
  @override
  final String url;
  @override
  final int trackNumber;

  @override
  String toString() {
    return 'FindResultSong(title: $title, url: $url, trackNumber: $trackNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FindResultSongImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.trackNumber, trackNumber) ||
                other.trackNumber == trackNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, url, trackNumber);

  /// Create a copy of FindResultSong
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FindResultSongImplCopyWith<_$FindResultSongImpl> get copyWith =>
      __$$FindResultSongImplCopyWithImpl<_$FindResultSongImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FindResultSongImplToJson(
      this,
    );
  }
}

abstract class _FindResultSong implements FindResultSong {
  const factory _FindResultSong(
      {required final String title,
      required final String url,
      required final int trackNumber}) = _$FindResultSongImpl;

  factory _FindResultSong.fromJson(Map<String, dynamic> json) =
      _$FindResultSongImpl.fromJson;

  @override
  String get title;
  @override
  String get url;
  @override
  int get trackNumber;

  /// Create a copy of FindResultSong
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FindResultSongImplCopyWith<_$FindResultSongImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddResult _$AddResultFromJson(Map<String, dynamic> json) {
  return _AddResult.fromJson(json);
}

/// @nodoc
mixin _$AddResult {
  bool get success => throw _privateConstructorUsedError;
  AddResultCount get count => throw _privateConstructorUsedError;

  /// Serializes this AddResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddResultCopyWith<AddResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddResultCopyWith<$Res> {
  factory $AddResultCopyWith(AddResult value, $Res Function(AddResult) then) =
      _$AddResultCopyWithImpl<$Res, AddResult>;
  @useResult
  $Res call({bool success, AddResultCount count});

  $AddResultCountCopyWith<$Res> get count;
}

/// @nodoc
class _$AddResultCopyWithImpl<$Res, $Val extends AddResult>
    implements $AddResultCopyWith<$Res> {
  _$AddResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as AddResultCount,
    ) as $Val);
  }

  /// Create a copy of AddResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddResultCountCopyWith<$Res> get count {
    return $AddResultCountCopyWith<$Res>(_value.count, (value) {
      return _then(_value.copyWith(count: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddResultImplCopyWith<$Res>
    implements $AddResultCopyWith<$Res> {
  factory _$$AddResultImplCopyWith(
          _$AddResultImpl value, $Res Function(_$AddResultImpl) then) =
      __$$AddResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, AddResultCount count});

  @override
  $AddResultCountCopyWith<$Res> get count;
}

/// @nodoc
class __$$AddResultImplCopyWithImpl<$Res>
    extends _$AddResultCopyWithImpl<$Res, _$AddResultImpl>
    implements _$$AddResultImplCopyWith<$Res> {
  __$$AddResultImplCopyWithImpl(
      _$AddResultImpl _value, $Res Function(_$AddResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
  }) {
    return _then(_$AddResultImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as AddResultCount,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddResultImpl extends _AddResult {
  const _$AddResultImpl({required this.success, required this.count})
      : super._();

  factory _$AddResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddResultImplFromJson(json);

  @override
  final bool success;
  @override
  final AddResultCount count;

  @override
  String toString() {
    return 'AddResult(success: $success, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddResultImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, count);

  /// Create a copy of AddResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddResultImplCopyWith<_$AddResultImpl> get copyWith =>
      __$$AddResultImplCopyWithImpl<_$AddResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddResultImplToJson(
      this,
    );
  }
}

abstract class _AddResult extends AddResult {
  const factory _AddResult(
      {required final bool success,
      required final AddResultCount count}) = _$AddResultImpl;
  const _AddResult._() : super._();

  factory _AddResult.fromJson(Map<String, dynamic> json) =
      _$AddResultImpl.fromJson;

  @override
  bool get success;
  @override
  AddResultCount get count;

  /// Create a copy of AddResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddResultImplCopyWith<_$AddResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddResultCount _$AddResultCountFromJson(Map<String, dynamic> json) {
  return _AddResultCount.fromJson(json);
}

/// @nodoc
mixin _$AddResultCount {
  int get artists => throw _privateConstructorUsedError;
  int get albums => throw _privateConstructorUsedError;
  int get songs => throw _privateConstructorUsedError;

  /// Serializes this AddResultCount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddResultCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddResultCountCopyWith<AddResultCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddResultCountCopyWith<$Res> {
  factory $AddResultCountCopyWith(
          AddResultCount value, $Res Function(AddResultCount) then) =
      _$AddResultCountCopyWithImpl<$Res, AddResultCount>;
  @useResult
  $Res call({int artists, int albums, int songs});
}

/// @nodoc
class _$AddResultCountCopyWithImpl<$Res, $Val extends AddResultCount>
    implements $AddResultCountCopyWith<$Res> {
  _$AddResultCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddResultCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? artists = null,
    Object? albums = null,
    Object? songs = null,
  }) {
    return _then(_value.copyWith(
      artists: null == artists
          ? _value.artists
          : artists // ignore: cast_nullable_to_non_nullable
              as int,
      albums: null == albums
          ? _value.albums
          : albums // ignore: cast_nullable_to_non_nullable
              as int,
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddResultCountImplCopyWith<$Res>
    implements $AddResultCountCopyWith<$Res> {
  factory _$$AddResultCountImplCopyWith(_$AddResultCountImpl value,
          $Res Function(_$AddResultCountImpl) then) =
      __$$AddResultCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int artists, int albums, int songs});
}

/// @nodoc
class __$$AddResultCountImplCopyWithImpl<$Res>
    extends _$AddResultCountCopyWithImpl<$Res, _$AddResultCountImpl>
    implements _$$AddResultCountImplCopyWith<$Res> {
  __$$AddResultCountImplCopyWithImpl(
      _$AddResultCountImpl _value, $Res Function(_$AddResultCountImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddResultCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? artists = null,
    Object? albums = null,
    Object? songs = null,
  }) {
    return _then(_$AddResultCountImpl(
      artists: null == artists
          ? _value.artists
          : artists // ignore: cast_nullable_to_non_nullable
              as int,
      albums: null == albums
          ? _value.albums
          : albums // ignore: cast_nullable_to_non_nullable
              as int,
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddResultCountImpl implements _AddResultCount {
  const _$AddResultCountImpl(
      {required this.artists, required this.albums, required this.songs});

  factory _$AddResultCountImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddResultCountImplFromJson(json);

  @override
  final int artists;
  @override
  final int albums;
  @override
  final int songs;

  @override
  String toString() {
    return 'AddResultCount(artists: $artists, albums: $albums, songs: $songs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddResultCountImpl &&
            (identical(other.artists, artists) || other.artists == artists) &&
            (identical(other.albums, albums) || other.albums == albums) &&
            (identical(other.songs, songs) || other.songs == songs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, artists, albums, songs);

  /// Create a copy of AddResultCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddResultCountImplCopyWith<_$AddResultCountImpl> get copyWith =>
      __$$AddResultCountImplCopyWithImpl<_$AddResultCountImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddResultCountImplToJson(
      this,
    );
  }
}

abstract class _AddResultCount implements AddResultCount {
  const factory _AddResultCount(
      {required final int artists,
      required final int albums,
      required final int songs}) = _$AddResultCountImpl;

  factory _AddResultCount.fromJson(Map<String, dynamic> json) =
      _$AddResultCountImpl.fromJson;

  @override
  int get artists;
  @override
  int get albums;
  @override
  int get songs;

  /// Create a copy of AddResultCount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddResultCountImplCopyWith<_$AddResultCountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
