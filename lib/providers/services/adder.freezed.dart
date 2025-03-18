// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'adder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddState {
  String get id => throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;
  SearchType get searchType => throw _privateConstructorUsedError;
  SearchSource get searchSource => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  List<SearchResult> get searchResults => throw _privateConstructorUsedError;
  List<SearchResult> get selectedSearchResults =>
      throw _privateConstructorUsedError;
  List<String> get selectedSearchResultIds =>
      throw _privateConstructorUsedError;
  List<FindResult> get findResults => throw _privateConstructorUsedError;
  FoundPlaylist? get foundPlaylist =>
      throw _privateConstructorUsedError; //required bool
  AddResult get addResult => throw _privateConstructorUsedError;
  bool get done => throw _privateConstructorUsedError;
  bool get authed => throw _privateConstructorUsedError;
  int get totalResults => throw _privateConstructorUsedError;
  int get completedResults => throw _privateConstructorUsedError;

  /// Create a copy of AddState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddStateCopyWith<AddState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddStateCopyWith<$Res> {
  factory $AddStateCopyWith(AddState value, $Res Function(AddState) then) =
      _$AddStateCopyWithImpl<$Res, AddState>;
  @useResult
  $Res call(
      {String id,
      String query,
      SearchType searchType,
      SearchSource searchSource,
      String state,
      List<SearchResult> searchResults,
      List<SearchResult> selectedSearchResults,
      List<String> selectedSearchResultIds,
      List<FindResult> findResults,
      FoundPlaylist? foundPlaylist,
      AddResult addResult,
      bool done,
      bool authed,
      int totalResults,
      int completedResults});

  $FoundPlaylistCopyWith<$Res>? get foundPlaylist;
  $AddResultCopyWith<$Res> get addResult;
}

/// @nodoc
class _$AddStateCopyWithImpl<$Res, $Val extends AddState>
    implements $AddStateCopyWith<$Res> {
  _$AddStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? query = null,
    Object? searchType = null,
    Object? searchSource = null,
    Object? state = null,
    Object? searchResults = null,
    Object? selectedSearchResults = null,
    Object? selectedSearchResultIds = null,
    Object? findResults = null,
    Object? foundPlaylist = freezed,
    Object? addResult = null,
    Object? done = null,
    Object? authed = null,
    Object? totalResults = null,
    Object? completedResults = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      searchType: null == searchType
          ? _value.searchType
          : searchType // ignore: cast_nullable_to_non_nullable
              as SearchType,
      searchSource: null == searchSource
          ? _value.searchSource
          : searchSource // ignore: cast_nullable_to_non_nullable
              as SearchSource,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      searchResults: null == searchResults
          ? _value.searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as List<SearchResult>,
      selectedSearchResults: null == selectedSearchResults
          ? _value.selectedSearchResults
          : selectedSearchResults // ignore: cast_nullable_to_non_nullable
              as List<SearchResult>,
      selectedSearchResultIds: null == selectedSearchResultIds
          ? _value.selectedSearchResultIds
          : selectedSearchResultIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      findResults: null == findResults
          ? _value.findResults
          : findResults // ignore: cast_nullable_to_non_nullable
              as List<FindResult>,
      foundPlaylist: freezed == foundPlaylist
          ? _value.foundPlaylist
          : foundPlaylist // ignore: cast_nullable_to_non_nullable
              as FoundPlaylist?,
      addResult: null == addResult
          ? _value.addResult
          : addResult // ignore: cast_nullable_to_non_nullable
              as AddResult,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      authed: null == authed
          ? _value.authed
          : authed // ignore: cast_nullable_to_non_nullable
              as bool,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
      completedResults: null == completedResults
          ? _value.completedResults
          : completedResults // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of AddState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FoundPlaylistCopyWith<$Res>? get foundPlaylist {
    if (_value.foundPlaylist == null) {
      return null;
    }

    return $FoundPlaylistCopyWith<$Res>(_value.foundPlaylist!, (value) {
      return _then(_value.copyWith(foundPlaylist: value) as $Val);
    });
  }

  /// Create a copy of AddState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddResultCopyWith<$Res> get addResult {
    return $AddResultCopyWith<$Res>(_value.addResult, (value) {
      return _then(_value.copyWith(addResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddStateImplCopyWith<$Res>
    implements $AddStateCopyWith<$Res> {
  factory _$$AddStateImplCopyWith(
          _$AddStateImpl value, $Res Function(_$AddStateImpl) then) =
      __$$AddStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String query,
      SearchType searchType,
      SearchSource searchSource,
      String state,
      List<SearchResult> searchResults,
      List<SearchResult> selectedSearchResults,
      List<String> selectedSearchResultIds,
      List<FindResult> findResults,
      FoundPlaylist? foundPlaylist,
      AddResult addResult,
      bool done,
      bool authed,
      int totalResults,
      int completedResults});

  @override
  $FoundPlaylistCopyWith<$Res>? get foundPlaylist;
  @override
  $AddResultCopyWith<$Res> get addResult;
}

/// @nodoc
class __$$AddStateImplCopyWithImpl<$Res>
    extends _$AddStateCopyWithImpl<$Res, _$AddStateImpl>
    implements _$$AddStateImplCopyWith<$Res> {
  __$$AddStateImplCopyWithImpl(
      _$AddStateImpl _value, $Res Function(_$AddStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? query = null,
    Object? searchType = null,
    Object? searchSource = null,
    Object? state = null,
    Object? searchResults = null,
    Object? selectedSearchResults = null,
    Object? selectedSearchResultIds = null,
    Object? findResults = null,
    Object? foundPlaylist = freezed,
    Object? addResult = null,
    Object? done = null,
    Object? authed = null,
    Object? totalResults = null,
    Object? completedResults = null,
  }) {
    return _then(_$AddStateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      searchType: null == searchType
          ? _value.searchType
          : searchType // ignore: cast_nullable_to_non_nullable
              as SearchType,
      searchSource: null == searchSource
          ? _value.searchSource
          : searchSource // ignore: cast_nullable_to_non_nullable
              as SearchSource,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      searchResults: null == searchResults
          ? _value._searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as List<SearchResult>,
      selectedSearchResults: null == selectedSearchResults
          ? _value._selectedSearchResults
          : selectedSearchResults // ignore: cast_nullable_to_non_nullable
              as List<SearchResult>,
      selectedSearchResultIds: null == selectedSearchResultIds
          ? _value._selectedSearchResultIds
          : selectedSearchResultIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      findResults: null == findResults
          ? _value._findResults
          : findResults // ignore: cast_nullable_to_non_nullable
              as List<FindResult>,
      foundPlaylist: freezed == foundPlaylist
          ? _value.foundPlaylist
          : foundPlaylist // ignore: cast_nullable_to_non_nullable
              as FoundPlaylist?,
      addResult: null == addResult
          ? _value.addResult
          : addResult // ignore: cast_nullable_to_non_nullable
              as AddResult,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      authed: null == authed
          ? _value.authed
          : authed // ignore: cast_nullable_to_non_nullable
              as bool,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
      completedResults: null == completedResults
          ? _value.completedResults
          : completedResults // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AddStateImpl extends _AddState {
  _$AddStateImpl(
      {required this.id,
      required this.query,
      required this.searchType,
      required this.searchSource,
      required this.state,
      required final List<SearchResult> searchResults,
      required final List<SearchResult> selectedSearchResults,
      required final List<String> selectedSearchResultIds,
      required final List<FindResult> findResults,
      this.foundPlaylist,
      required this.addResult,
      required this.done,
      required this.authed,
      required this.totalResults,
      required this.completedResults})
      : _searchResults = searchResults,
        _selectedSearchResults = selectedSearchResults,
        _selectedSearchResultIds = selectedSearchResultIds,
        _findResults = findResults,
        super._();

  @override
  final String id;
  @override
  final String query;
  @override
  final SearchType searchType;
  @override
  final SearchSource searchSource;
  @override
  final String state;
  final List<SearchResult> _searchResults;
  @override
  List<SearchResult> get searchResults {
    if (_searchResults is EqualUnmodifiableListView) return _searchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchResults);
  }

  final List<SearchResult> _selectedSearchResults;
  @override
  List<SearchResult> get selectedSearchResults {
    if (_selectedSearchResults is EqualUnmodifiableListView)
      return _selectedSearchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedSearchResults);
  }

  final List<String> _selectedSearchResultIds;
  @override
  List<String> get selectedSearchResultIds {
    if (_selectedSearchResultIds is EqualUnmodifiableListView)
      return _selectedSearchResultIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedSearchResultIds);
  }

  final List<FindResult> _findResults;
  @override
  List<FindResult> get findResults {
    if (_findResults is EqualUnmodifiableListView) return _findResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_findResults);
  }

  @override
  final FoundPlaylist? foundPlaylist;
//required bool
  @override
  final AddResult addResult;
  @override
  final bool done;
  @override
  final bool authed;
  @override
  final int totalResults;
  @override
  final int completedResults;

  @override
  String toString() {
    return 'AddState(id: $id, query: $query, searchType: $searchType, searchSource: $searchSource, state: $state, searchResults: $searchResults, selectedSearchResults: $selectedSearchResults, selectedSearchResultIds: $selectedSearchResultIds, findResults: $findResults, foundPlaylist: $foundPlaylist, addResult: $addResult, done: $done, authed: $authed, totalResults: $totalResults, completedResults: $completedResults)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddStateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.searchType, searchType) ||
                other.searchType == searchType) &&
            (identical(other.searchSource, searchSource) ||
                other.searchSource == searchSource) &&
            (identical(other.state, state) || other.state == state) &&
            const DeepCollectionEquality()
                .equals(other._searchResults, _searchResults) &&
            const DeepCollectionEquality()
                .equals(other._selectedSearchResults, _selectedSearchResults) &&
            const DeepCollectionEquality().equals(
                other._selectedSearchResultIds, _selectedSearchResultIds) &&
            const DeepCollectionEquality()
                .equals(other._findResults, _findResults) &&
            (identical(other.foundPlaylist, foundPlaylist) ||
                other.foundPlaylist == foundPlaylist) &&
            (identical(other.addResult, addResult) ||
                other.addResult == addResult) &&
            (identical(other.done, done) || other.done == done) &&
            (identical(other.authed, authed) || other.authed == authed) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
            (identical(other.completedResults, completedResults) ||
                other.completedResults == completedResults));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      query,
      searchType,
      searchSource,
      state,
      const DeepCollectionEquality().hash(_searchResults),
      const DeepCollectionEquality().hash(_selectedSearchResults),
      const DeepCollectionEquality().hash(_selectedSearchResultIds),
      const DeepCollectionEquality().hash(_findResults),
      foundPlaylist,
      addResult,
      done,
      authed,
      totalResults,
      completedResults);

  /// Create a copy of AddState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddStateImplCopyWith<_$AddStateImpl> get copyWith =>
      __$$AddStateImplCopyWithImpl<_$AddStateImpl>(this, _$identity);
}

abstract class _AddState extends AddState {
  factory _AddState(
      {required final String id,
      required final String query,
      required final SearchType searchType,
      required final SearchSource searchSource,
      required final String state,
      required final List<SearchResult> searchResults,
      required final List<SearchResult> selectedSearchResults,
      required final List<String> selectedSearchResultIds,
      required final List<FindResult> findResults,
      final FoundPlaylist? foundPlaylist,
      required final AddResult addResult,
      required final bool done,
      required final bool authed,
      required final int totalResults,
      required final int completedResults}) = _$AddStateImpl;
  _AddState._() : super._();

  @override
  String get id;
  @override
  String get query;
  @override
  SearchType get searchType;
  @override
  SearchSource get searchSource;
  @override
  String get state;
  @override
  List<SearchResult> get searchResults;
  @override
  List<SearchResult> get selectedSearchResults;
  @override
  List<String> get selectedSearchResultIds;
  @override
  List<FindResult> get findResults;
  @override
  FoundPlaylist? get foundPlaylist; //required bool
  @override
  AddResult get addResult;
  @override
  bool get done;
  @override
  bool get authed;
  @override
  int get totalResults;
  @override
  int get completedResults;

  /// Create a copy of AddState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddStateImplCopyWith<_$AddStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
