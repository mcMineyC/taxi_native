// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GenericItemImpl _$$GenericItemImplFromJson(Map<String, dynamic> json) =>
    _$GenericItemImpl(
      thingId: json['thingId'] as String,
      thingType: json['thingType'] as String,
      texts: (json['texts'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String,
      isInLibrary: json['isInLibrary'] as bool,
      addedBy: json['addedBy'] as String?,
    );

Map<String, dynamic> _$$GenericItemImplToJson(_$GenericItemImpl instance) =>
    <String, dynamic>{
      'thingId': instance.thingId,
      'thingType': instance.thingType,
      'texts': instance.texts,
      'imageUrl': instance.imageUrl,
      'isInLibrary': instance.isInLibrary,
      'addedBy': instance.addedBy,
    };
