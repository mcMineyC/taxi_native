// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preferences_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PersistenceOptions _$PersistenceOptionsFromJson(Map<String, dynamic> json) {
  return _PersistenceOptions.fromJson(json);
}

/// @nodoc
mixin _$PersistenceOptions {
  bool get autoplaySong => throw _privateConstructorUsedError;
  bool get persistInfo => throw _privateConstructorUsedError;
  bool get saveLibraryTab => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PersistenceOptionsCopyWith<PersistenceOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersistenceOptionsCopyWith<$Res> {
  factory $PersistenceOptionsCopyWith(
          PersistenceOptions value, $Res Function(PersistenceOptions) then) =
      _$PersistenceOptionsCopyWithImpl<$Res, PersistenceOptions>;
  @useResult
  $Res call({bool autoplaySong, bool persistInfo, bool saveLibraryTab});
}

/// @nodoc
class _$PersistenceOptionsCopyWithImpl<$Res, $Val extends PersistenceOptions>
    implements $PersistenceOptionsCopyWith<$Res> {
  _$PersistenceOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? autoplaySong = null,
    Object? persistInfo = null,
    Object? saveLibraryTab = null,
  }) {
    return _then(_value.copyWith(
      autoplaySong: null == autoplaySong
          ? _value.autoplaySong
          : autoplaySong // ignore: cast_nullable_to_non_nullable
              as bool,
      persistInfo: null == persistInfo
          ? _value.persistInfo
          : persistInfo // ignore: cast_nullable_to_non_nullable
              as bool,
      saveLibraryTab: null == saveLibraryTab
          ? _value.saveLibraryTab
          : saveLibraryTab // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PersistenceOptionsImplCopyWith<$Res>
    implements $PersistenceOptionsCopyWith<$Res> {
  factory _$$PersistenceOptionsImplCopyWith(_$PersistenceOptionsImpl value,
          $Res Function(_$PersistenceOptionsImpl) then) =
      __$$PersistenceOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool autoplaySong, bool persistInfo, bool saveLibraryTab});
}

/// @nodoc
class __$$PersistenceOptionsImplCopyWithImpl<$Res>
    extends _$PersistenceOptionsCopyWithImpl<$Res, _$PersistenceOptionsImpl>
    implements _$$PersistenceOptionsImplCopyWith<$Res> {
  __$$PersistenceOptionsImplCopyWithImpl(_$PersistenceOptionsImpl _value,
      $Res Function(_$PersistenceOptionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? autoplaySong = null,
    Object? persistInfo = null,
    Object? saveLibraryTab = null,
  }) {
    return _then(_$PersistenceOptionsImpl(
      autoplaySong: null == autoplaySong
          ? _value.autoplaySong
          : autoplaySong // ignore: cast_nullable_to_non_nullable
              as bool,
      persistInfo: null == persistInfo
          ? _value.persistInfo
          : persistInfo // ignore: cast_nullable_to_non_nullable
              as bool,
      saveLibraryTab: null == saveLibraryTab
          ? _value.saveLibraryTab
          : saveLibraryTab // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersistenceOptionsImpl implements _PersistenceOptions {
  _$PersistenceOptionsImpl(
      {required this.autoplaySong,
      required this.persistInfo,
      required this.saveLibraryTab});

  factory _$PersistenceOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersistenceOptionsImplFromJson(json);

  @override
  final bool autoplaySong;
  @override
  final bool persistInfo;
  @override
  final bool saveLibraryTab;

  @override
  String toString() {
    return 'PersistenceOptions(autoplaySong: $autoplaySong, persistInfo: $persistInfo, saveLibraryTab: $saveLibraryTab)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersistenceOptionsImpl &&
            (identical(other.autoplaySong, autoplaySong) ||
                other.autoplaySong == autoplaySong) &&
            (identical(other.persistInfo, persistInfo) ||
                other.persistInfo == persistInfo) &&
            (identical(other.saveLibraryTab, saveLibraryTab) ||
                other.saveLibraryTab == saveLibraryTab));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, autoplaySong, persistInfo, saveLibraryTab);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PersistenceOptionsImplCopyWith<_$PersistenceOptionsImpl> get copyWith =>
      __$$PersistenceOptionsImplCopyWithImpl<_$PersistenceOptionsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersistenceOptionsImplToJson(
      this,
    );
  }
}

abstract class _PersistenceOptions implements PersistenceOptions {
  factory _PersistenceOptions(
      {required final bool autoplaySong,
      required final bool persistInfo,
      required final bool saveLibraryTab}) = _$PersistenceOptionsImpl;

  factory _PersistenceOptions.fromJson(Map<String, dynamic> json) =
      _$PersistenceOptionsImpl.fromJson;

  @override
  bool get autoplaySong;
  @override
  bool get persistInfo;
  @override
  bool get saveLibraryTab;
  @override
  @JsonKey(ignore: true)
  _$$PersistenceOptionsImplCopyWith<_$PersistenceOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StorablePrefs _$StorablePrefsFromJson(Map<String, dynamic> json) {
  return _StorablePrefs.fromJson(json);
}

/// @nodoc
mixin _$StorablePrefs {
  bool get shuffleOnLoop => throw _privateConstructorUsedError;
  bool get shuffleDefault => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get backendUrl => throw _privateConstructorUsedError;
  bool get debugMode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StorablePrefsCopyWith<StorablePrefs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorablePrefsCopyWith<$Res> {
  factory $StorablePrefsCopyWith(
          StorablePrefs value, $Res Function(StorablePrefs) then) =
      _$StorablePrefsCopyWithImpl<$Res, StorablePrefs>;
  @useResult
  $Res call(
      {bool shuffleOnLoop,
      bool shuffleDefault,
      String username,
      String backendUrl,
      bool debugMode});
}

/// @nodoc
class _$StorablePrefsCopyWithImpl<$Res, $Val extends StorablePrefs>
    implements $StorablePrefsCopyWith<$Res> {
  _$StorablePrefsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shuffleOnLoop = null,
    Object? shuffleDefault = null,
    Object? username = null,
    Object? backendUrl = null,
    Object? debugMode = null,
  }) {
    return _then(_value.copyWith(
      shuffleOnLoop: null == shuffleOnLoop
          ? _value.shuffleOnLoop
          : shuffleOnLoop // ignore: cast_nullable_to_non_nullable
              as bool,
      shuffleDefault: null == shuffleDefault
          ? _value.shuffleDefault
          : shuffleDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      backendUrl: null == backendUrl
          ? _value.backendUrl
          : backendUrl // ignore: cast_nullable_to_non_nullable
              as String,
      debugMode: null == debugMode
          ? _value.debugMode
          : debugMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StorablePrefsImplCopyWith<$Res>
    implements $StorablePrefsCopyWith<$Res> {
  factory _$$StorablePrefsImplCopyWith(
          _$StorablePrefsImpl value, $Res Function(_$StorablePrefsImpl) then) =
      __$$StorablePrefsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool shuffleOnLoop,
      bool shuffleDefault,
      String username,
      String backendUrl,
      bool debugMode});
}

/// @nodoc
class __$$StorablePrefsImplCopyWithImpl<$Res>
    extends _$StorablePrefsCopyWithImpl<$Res, _$StorablePrefsImpl>
    implements _$$StorablePrefsImplCopyWith<$Res> {
  __$$StorablePrefsImplCopyWithImpl(
      _$StorablePrefsImpl _value, $Res Function(_$StorablePrefsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shuffleOnLoop = null,
    Object? shuffleDefault = null,
    Object? username = null,
    Object? backendUrl = null,
    Object? debugMode = null,
  }) {
    return _then(_$StorablePrefsImpl(
      shuffleOnLoop: null == shuffleOnLoop
          ? _value.shuffleOnLoop
          : shuffleOnLoop // ignore: cast_nullable_to_non_nullable
              as bool,
      shuffleDefault: null == shuffleDefault
          ? _value.shuffleDefault
          : shuffleDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      backendUrl: null == backendUrl
          ? _value.backendUrl
          : backendUrl // ignore: cast_nullable_to_non_nullable
              as String,
      debugMode: null == debugMode
          ? _value.debugMode
          : debugMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StorablePrefsImpl implements _StorablePrefs {
  _$StorablePrefsImpl(
      {required this.shuffleOnLoop,
      required this.shuffleDefault,
      required this.username,
      required this.backendUrl,
      required this.debugMode});

  factory _$StorablePrefsImpl.fromJson(Map<String, dynamic> json) =>
      _$$StorablePrefsImplFromJson(json);

  @override
  final bool shuffleOnLoop;
  @override
  final bool shuffleDefault;
  @override
  final String username;
  @override
  final String backendUrl;
  @override
  final bool debugMode;

  @override
  String toString() {
    return 'StorablePrefs(shuffleOnLoop: $shuffleOnLoop, shuffleDefault: $shuffleDefault, username: $username, backendUrl: $backendUrl, debugMode: $debugMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorablePrefsImpl &&
            (identical(other.shuffleOnLoop, shuffleOnLoop) ||
                other.shuffleOnLoop == shuffleOnLoop) &&
            (identical(other.shuffleDefault, shuffleDefault) ||
                other.shuffleDefault == shuffleDefault) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.backendUrl, backendUrl) ||
                other.backendUrl == backendUrl) &&
            (identical(other.debugMode, debugMode) ||
                other.debugMode == debugMode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, shuffleOnLoop, shuffleDefault,
      username, backendUrl, debugMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StorablePrefsImplCopyWith<_$StorablePrefsImpl> get copyWith =>
      __$$StorablePrefsImplCopyWithImpl<_$StorablePrefsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StorablePrefsImplToJson(
      this,
    );
  }
}

abstract class _StorablePrefs implements StorablePrefs {
  factory _StorablePrefs(
      {required final bool shuffleOnLoop,
      required final bool shuffleDefault,
      required final String username,
      required final String backendUrl,
      required final bool debugMode}) = _$StorablePrefsImpl;

  factory _StorablePrefs.fromJson(Map<String, dynamic> json) =
      _$StorablePrefsImpl.fromJson;

  @override
  bool get shuffleOnLoop;
  @override
  bool get shuffleDefault;
  @override
  String get username;
  @override
  String get backendUrl;
  @override
  bool get debugMode;
  @override
  @JsonKey(ignore: true)
  _$$StorablePrefsImplCopyWith<_$StorablePrefsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
