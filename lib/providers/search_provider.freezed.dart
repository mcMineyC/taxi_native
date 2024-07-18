// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchInfo {
  String get query => throw _privateConstructorUsedError;
  bool get hasText => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get hasResults => throw _privateConstructorUsedError;
  List<LocalSearchResult> get albums => throw _privateConstructorUsedError;
  List<LocalSearchResult> get artists => throw _privateConstructorUsedError;
  List<LocalSearchResult> get songs => throw _privateConstructorUsedError;
  List<String> get order => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchInfoCopyWith<SearchInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchInfoCopyWith<$Res> {
  factory $SearchInfoCopyWith(
          SearchInfo value, $Res Function(SearchInfo) then) =
      _$SearchInfoCopyWithImpl<$Res, SearchInfo>;
  @useResult
  $Res call(
      {String query,
      bool hasText,
      bool isLoading,
      bool hasResults,
      List<LocalSearchResult> albums,
      List<LocalSearchResult> artists,
      List<LocalSearchResult> songs,
      List<String> order});
}

/// @nodoc
class _$SearchInfoCopyWithImpl<$Res, $Val extends SearchInfo>
    implements $SearchInfoCopyWith<$Res> {
  _$SearchInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? hasText = null,
    Object? isLoading = null,
    Object? hasResults = null,
    Object? albums = null,
    Object? artists = null,
    Object? songs = null,
    Object? order = null,
  }) {
    return _then(_value.copyWith(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      hasText: null == hasText
          ? _value.hasText
          : hasText // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasResults: null == hasResults
          ? _value.hasResults
          : hasResults // ignore: cast_nullable_to_non_nullable
              as bool,
      albums: null == albums
          ? _value.albums
          : albums // ignore: cast_nullable_to_non_nullable
              as List<LocalSearchResult>,
      artists: null == artists
          ? _value.artists
          : artists // ignore: cast_nullable_to_non_nullable
              as List<LocalSearchResult>,
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<LocalSearchResult>,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchInfoImplCopyWith<$Res>
    implements $SearchInfoCopyWith<$Res> {
  factory _$$SearchInfoImplCopyWith(
          _$SearchInfoImpl value, $Res Function(_$SearchInfoImpl) then) =
      __$$SearchInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String query,
      bool hasText,
      bool isLoading,
      bool hasResults,
      List<LocalSearchResult> albums,
      List<LocalSearchResult> artists,
      List<LocalSearchResult> songs,
      List<String> order});
}

/// @nodoc
class __$$SearchInfoImplCopyWithImpl<$Res>
    extends _$SearchInfoCopyWithImpl<$Res, _$SearchInfoImpl>
    implements _$$SearchInfoImplCopyWith<$Res> {
  __$$SearchInfoImplCopyWithImpl(
      _$SearchInfoImpl _value, $Res Function(_$SearchInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? hasText = null,
    Object? isLoading = null,
    Object? hasResults = null,
    Object? albums = null,
    Object? artists = null,
    Object? songs = null,
    Object? order = null,
  }) {
    return _then(_$SearchInfoImpl(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      hasText: null == hasText
          ? _value.hasText
          : hasText // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasResults: null == hasResults
          ? _value.hasResults
          : hasResults // ignore: cast_nullable_to_non_nullable
              as bool,
      albums: null == albums
          ? _value._albums
          : albums // ignore: cast_nullable_to_non_nullable
              as List<LocalSearchResult>,
      artists: null == artists
          ? _value._artists
          : artists // ignore: cast_nullable_to_non_nullable
              as List<LocalSearchResult>,
      songs: null == songs
          ? _value._songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<LocalSearchResult>,
      order: null == order
          ? _value._order
          : order // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$SearchInfoImpl implements _SearchInfo {
  _$SearchInfoImpl(
      {required this.query,
      required this.hasText,
      required this.isLoading,
      required this.hasResults,
      required final List<LocalSearchResult> albums,
      required final List<LocalSearchResult> artists,
      required final List<LocalSearchResult> songs,
      required final List<String> order})
      : _albums = albums,
        _artists = artists,
        _songs = songs,
        _order = order;

  @override
  final String query;
  @override
  final bool hasText;
  @override
  final bool isLoading;
  @override
  final bool hasResults;
  final List<LocalSearchResult> _albums;
  @override
  List<LocalSearchResult> get albums {
    if (_albums is EqualUnmodifiableListView) return _albums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_albums);
  }

  final List<LocalSearchResult> _artists;
  @override
  List<LocalSearchResult> get artists {
    if (_artists is EqualUnmodifiableListView) return _artists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_artists);
  }

  final List<LocalSearchResult> _songs;
  @override
  List<LocalSearchResult> get songs {
    if (_songs is EqualUnmodifiableListView) return _songs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_songs);
  }

  final List<String> _order;
  @override
  List<String> get order {
    if (_order is EqualUnmodifiableListView) return _order;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_order);
  }

  @override
  String toString() {
    return 'SearchInfo(query: $query, hasText: $hasText, isLoading: $isLoading, hasResults: $hasResults, albums: $albums, artists: $artists, songs: $songs, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchInfoImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.hasText, hasText) || other.hasText == hasText) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.hasResults, hasResults) ||
                other.hasResults == hasResults) &&
            const DeepCollectionEquality().equals(other._albums, _albums) &&
            const DeepCollectionEquality().equals(other._artists, _artists) &&
            const DeepCollectionEquality().equals(other._songs, _songs) &&
            const DeepCollectionEquality().equals(other._order, _order));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      query,
      hasText,
      isLoading,
      hasResults,
      const DeepCollectionEquality().hash(_albums),
      const DeepCollectionEquality().hash(_artists),
      const DeepCollectionEquality().hash(_songs),
      const DeepCollectionEquality().hash(_order));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchInfoImplCopyWith<_$SearchInfoImpl> get copyWith =>
      __$$SearchInfoImplCopyWithImpl<_$SearchInfoImpl>(this, _$identity);
}

abstract class _SearchInfo implements SearchInfo {
  factory _SearchInfo(
      {required final String query,
      required final bool hasText,
      required final bool isLoading,
      required final bool hasResults,
      required final List<LocalSearchResult> albums,
      required final List<LocalSearchResult> artists,
      required final List<LocalSearchResult> songs,
      required final List<String> order}) = _$SearchInfoImpl;

  @override
  String get query;
  @override
  bool get hasText;
  @override
  bool get isLoading;
  @override
  bool get hasResults;
  @override
  List<LocalSearchResult> get albums;
  @override
  List<LocalSearchResult> get artists;
  @override
  List<LocalSearchResult> get songs;
  @override
  List<String> get order;
  @override
  @JsonKey(ignore: true)
  _$$SearchInfoImplCopyWith<_$SearchInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
