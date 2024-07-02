// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queueitem.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QueueItem _$QueueItemFromJson(Map<String, dynamic> json) {
  return _QueueItem.fromJson(json);
}

/// @nodoc
mixin _$QueueItem {
  String get type => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get albumId => throw _privateConstructorUsedError;
  String get artistId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get albumName => throw _privateConstructorUsedError;
  String get youtubeId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QueueItemCopyWith<QueueItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueItemCopyWith<$Res> {
  factory $QueueItemCopyWith(QueueItem value, $Res Function(QueueItem) then) =
      _$QueueItemCopyWithImpl<$Res, QueueItem>;
  @useResult
  $Res call(
      {String type,
      String id,
      String albumId,
      String artistId,
      String displayName,
      String albumName,
      String youtubeId});
}

/// @nodoc
class _$QueueItemCopyWithImpl<$Res, $Val extends QueueItem>
    implements $QueueItemCopyWith<$Res> {
  _$QueueItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = null,
    Object? albumId = null,
    Object? artistId = null,
    Object? displayName = null,
    Object? albumName = null,
    Object? youtubeId = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      albumId: null == albumId
          ? _value.albumId
          : albumId // ignore: cast_nullable_to_non_nullable
              as String,
      artistId: null == artistId
          ? _value.artistId
          : artistId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      albumName: null == albumName
          ? _value.albumName
          : albumName // ignore: cast_nullable_to_non_nullable
              as String,
      youtubeId: null == youtubeId
          ? _value.youtubeId
          : youtubeId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QueueItemImplCopyWith<$Res>
    implements $QueueItemCopyWith<$Res> {
  factory _$$QueueItemImplCopyWith(
          _$QueueItemImpl value, $Res Function(_$QueueItemImpl) then) =
      __$$QueueItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      String id,
      String albumId,
      String artistId,
      String displayName,
      String albumName,
      String youtubeId});
}

/// @nodoc
class __$$QueueItemImplCopyWithImpl<$Res>
    extends _$QueueItemCopyWithImpl<$Res, _$QueueItemImpl>
    implements _$$QueueItemImplCopyWith<$Res> {
  __$$QueueItemImplCopyWithImpl(
      _$QueueItemImpl _value, $Res Function(_$QueueItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = null,
    Object? albumId = null,
    Object? artistId = null,
    Object? displayName = null,
    Object? albumName = null,
    Object? youtubeId = null,
  }) {
    return _then(_$QueueItemImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      albumId: null == albumId
          ? _value.albumId
          : albumId // ignore: cast_nullable_to_non_nullable
              as String,
      artistId: null == artistId
          ? _value.artistId
          : artistId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      albumName: null == albumName
          ? _value.albumName
          : albumName // ignore: cast_nullable_to_non_nullable
              as String,
      youtubeId: null == youtubeId
          ? _value.youtubeId
          : youtubeId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueItemImpl extends _QueueItem {
  _$QueueItemImpl(
      {required this.type,
      required this.id,
      required this.albumId,
      required this.artistId,
      required this.displayName,
      required this.albumName,
      required this.youtubeId})
      : super._();

  factory _$QueueItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueItemImplFromJson(json);

  @override
  final String type;
  @override
  final String id;
  @override
  final String albumId;
  @override
  final String artistId;
  @override
  final String displayName;
  @override
  final String albumName;
  @override
  final String youtubeId;

  @override
  String toString() {
    return 'QueueItem(type: $type, id: $id, albumId: $albumId, artistId: $artistId, displayName: $displayName, albumName: $albumName, youtubeId: $youtubeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueItemImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.albumId, albumId) || other.albumId == albumId) &&
            (identical(other.artistId, artistId) ||
                other.artistId == artistId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.albumName, albumName) ||
                other.albumName == albumName) &&
            (identical(other.youtubeId, youtubeId) ||
                other.youtubeId == youtubeId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, id, albumId, artistId,
      displayName, albumName, youtubeId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueItemImplCopyWith<_$QueueItemImpl> get copyWith =>
      __$$QueueItemImplCopyWithImpl<_$QueueItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueItemImplToJson(
      this,
    );
  }
}

abstract class _QueueItem extends QueueItem {
  factory _QueueItem(
      {required final String type,
      required final String id,
      required final String albumId,
      required final String artistId,
      required final String displayName,
      required final String albumName,
      required final String youtubeId}) = _$QueueItemImpl;
  _QueueItem._() : super._();

  factory _QueueItem.fromJson(Map<String, dynamic> json) =
      _$QueueItemImpl.fromJson;

  @override
  String get type;
  @override
  String get id;
  @override
  String get albumId;
  @override
  String get artistId;
  @override
  String get displayName;
  @override
  String get albumName;
  @override
  String get youtubeId;
  @override
  @JsonKey(ignore: true)
  _$$QueueItemImplCopyWith<_$QueueItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
