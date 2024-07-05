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

/// @nodoc
mixin _$Prefs {
  String get backendUrl => throw _privateConstructorUsedError;
  String get authToken => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PrefsCopyWith<Prefs> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrefsCopyWith<$Res> {
  factory $PrefsCopyWith(Prefs value, $Res Function(Prefs) then) =
      _$PrefsCopyWithImpl<$Res, Prefs>;
  @useResult
  $Res call({String backendUrl, String authToken, String username});
}

/// @nodoc
class _$PrefsCopyWithImpl<$Res, $Val extends Prefs>
    implements $PrefsCopyWith<$Res> {
  _$PrefsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backendUrl = null,
    Object? authToken = null,
    Object? username = null,
  }) {
    return _then(_value.copyWith(
      backendUrl: null == backendUrl
          ? _value.backendUrl
          : backendUrl // ignore: cast_nullable_to_non_nullable
              as String,
      authToken: null == authToken
          ? _value.authToken
          : authToken // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrefsImplCopyWith<$Res> implements $PrefsCopyWith<$Res> {
  factory _$$PrefsImplCopyWith(
          _$PrefsImpl value, $Res Function(_$PrefsImpl) then) =
      __$$PrefsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String backendUrl, String authToken, String username});
}

/// @nodoc
class __$$PrefsImplCopyWithImpl<$Res>
    extends _$PrefsCopyWithImpl<$Res, _$PrefsImpl>
    implements _$$PrefsImplCopyWith<$Res> {
  __$$PrefsImplCopyWithImpl(
      _$PrefsImpl _value, $Res Function(_$PrefsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backendUrl = null,
    Object? authToken = null,
    Object? username = null,
  }) {
    return _then(_$PrefsImpl(
      backendUrl: null == backendUrl
          ? _value.backendUrl
          : backendUrl // ignore: cast_nullable_to_non_nullable
              as String,
      authToken: null == authToken
          ? _value.authToken
          : authToken // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PrefsImpl extends _Prefs {
  _$PrefsImpl(
      {required this.backendUrl,
      required this.authToken,
      required this.username})
      : super._();

  @override
  final String backendUrl;
  @override
  final String authToken;
  @override
  final String username;

  @override
  String toString() {
    return 'Prefs(backendUrl: $backendUrl, authToken: $authToken, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrefsImpl &&
            (identical(other.backendUrl, backendUrl) ||
                other.backendUrl == backendUrl) &&
            (identical(other.authToken, authToken) ||
                other.authToken == authToken) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @override
  int get hashCode => Object.hash(runtimeType, backendUrl, authToken, username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrefsImplCopyWith<_$PrefsImpl> get copyWith =>
      __$$PrefsImplCopyWithImpl<_$PrefsImpl>(this, _$identity);
}

abstract class _Prefs extends Prefs {
  factory _Prefs(
      {required final String backendUrl,
      required final String authToken,
      required final String username}) = _$PrefsImpl;
  _Prefs._() : super._();

  @override
  String get backendUrl;
  @override
  String get authToken;
  @override
  String get username;
  @override
  @JsonKey(ignore: true)
  _$$PrefsImplCopyWith<_$PrefsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
