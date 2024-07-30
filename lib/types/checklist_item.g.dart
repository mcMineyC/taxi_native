// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChecklistItemImpl _$$ChecklistItemImplFromJson(Map<String, dynamic> json) =>
    _$ChecklistItemImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      completed: json['completed'] as bool,
      requestedBy: json['requestedBy'] as String,
    );

Map<String, dynamic> _$$ChecklistItemImplToJson(_$ChecklistItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'completed': instance.completed,
      'requestedBy': instance.requestedBy,
    };
