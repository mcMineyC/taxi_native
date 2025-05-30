// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GenericItem _$GenericItemFromJson(Map<String, dynamic> json) {
  return _GenericItem.fromJson(json);
}

/// @nodoc
mixin _$GenericItem {
  String get thingId => throw _privateConstructorUsedError;
  String get thingType => throw _privateConstructorUsedError;
  List<String> get texts => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  bool get isInLibrary => throw _privateConstructorUsedError;
  String? get addedBy => throw _privateConstructorUsedError;

  /// Serializes this GenericItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GenericItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GenericItemCopyWith<GenericItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenericItemCopyWith<$Res> {
  factory $GenericItemCopyWith(
          GenericItem value, $Res Function(GenericItem) then) =
      _$GenericItemCopyWithImpl<$Res, GenericItem>;
  @useResult
  $Res call(
      {String thingId,
      String thingType,
      List<String> texts,
      String imageUrl,
      bool isInLibrary,
      String? addedBy});
}

/// @nodoc
class _$GenericItemCopyWithImpl<$Res, $Val extends GenericItem>
    implements $GenericItemCopyWith<$Res> {
  _$GenericItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GenericItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? thingId = null,
    Object? thingType = null,
    Object? texts = null,
    Object? imageUrl = null,
    Object? isInLibrary = null,
    Object? addedBy = freezed,
  }) {
    return _then(_value.copyWith(
      thingId: null == thingId
          ? _value.thingId
          : thingId // ignore: cast_nullable_to_non_nullable
              as String,
      thingType: null == thingType
          ? _value.thingType
          : thingType // ignore: cast_nullable_to_non_nullable
              as String,
      texts: null == texts
          ? _value.texts
          : texts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isInLibrary: null == isInLibrary
          ? _value.isInLibrary
          : isInLibrary // ignore: cast_nullable_to_non_nullable
              as bool,
      addedBy: freezed == addedBy
          ? _value.addedBy
          : addedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GenericItemImplCopyWith<$Res>
    implements $GenericItemCopyWith<$Res> {
  factory _$$GenericItemImplCopyWith(
          _$GenericItemImpl value, $Res Function(_$GenericItemImpl) then) =
      __$$GenericItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String thingId,
      String thingType,
      List<String> texts,
      String imageUrl,
      bool isInLibrary,
      String? addedBy});
}

/// @nodoc
class __$$GenericItemImplCopyWithImpl<$Res>
    extends _$GenericItemCopyWithImpl<$Res, _$GenericItemImpl>
    implements _$$GenericItemImplCopyWith<$Res> {
  __$$GenericItemImplCopyWithImpl(
      _$GenericItemImpl _value, $Res Function(_$GenericItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of GenericItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? thingId = null,
    Object? thingType = null,
    Object? texts = null,
    Object? imageUrl = null,
    Object? isInLibrary = null,
    Object? addedBy = freezed,
  }) {
    return _then(_$GenericItemImpl(
      thingId: null == thingId
          ? _value.thingId
          : thingId // ignore: cast_nullable_to_non_nullable
              as String,
      thingType: null == thingType
          ? _value.thingType
          : thingType // ignore: cast_nullable_to_non_nullable
              as String,
      texts: null == texts
          ? _value._texts
          : texts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isInLibrary: null == isInLibrary
          ? _value.isInLibrary
          : isInLibrary // ignore: cast_nullable_to_non_nullable
              as bool,
      addedBy: freezed == addedBy
          ? _value.addedBy
          : addedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GenericItemImpl extends _GenericItem {
  _$GenericItemImpl(
      {required this.thingId,
      required this.thingType,
      required final List<String> texts,
      required this.imageUrl,
      required this.isInLibrary,
      required this.addedBy})
      : _texts = texts,
        super._();

  factory _$GenericItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$GenericItemImplFromJson(json);

  @override
  final String thingId;
  @override
  final String thingType;
  final List<String> _texts;
  @override
  List<String> get texts {
    if (_texts is EqualUnmodifiableListView) return _texts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_texts);
  }

  @override
  final String imageUrl;
  @override
  final bool isInLibrary;
  @override
  final String? addedBy;

  @override
  String toString() {
    return 'GenericItem(thingId: $thingId, thingType: $thingType, texts: $texts, imageUrl: $imageUrl, isInLibrary: $isInLibrary, addedBy: $addedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenericItemImpl &&
            (identical(other.thingId, thingId) || other.thingId == thingId) &&
            (identical(other.thingType, thingType) ||
                other.thingType == thingType) &&
            const DeepCollectionEquality().equals(other._texts, _texts) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isInLibrary, isInLibrary) ||
                other.isInLibrary == isInLibrary) &&
            (identical(other.addedBy, addedBy) || other.addedBy == addedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      thingId,
      thingType,
      const DeepCollectionEquality().hash(_texts),
      imageUrl,
      isInLibrary,
      addedBy);

  /// Create a copy of GenericItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GenericItemImplCopyWith<_$GenericItemImpl> get copyWith =>
      __$$GenericItemImplCopyWithImpl<_$GenericItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GenericItemImplToJson(
      this,
    );
  }
}

abstract class _GenericItem extends GenericItem {
  factory _GenericItem(
      {required final String thingId,
      required final String thingType,
      required final List<String> texts,
      required final String imageUrl,
      required final bool isInLibrary,
      required final String? addedBy}) = _$GenericItemImpl;
  _GenericItem._() : super._();

  factory _GenericItem.fromJson(Map<String, dynamic> json) =
      _$GenericItemImpl.fromJson;

  @override
  String get thingId;
  @override
  String get thingType;
  @override
  List<String> get texts;
  @override
  String get imageUrl;
  @override
  bool get isInLibrary;
  @override
  String? get addedBy;

  /// Create a copy of GenericItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GenericItemImplCopyWith<_$GenericItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
