// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersistenceOptionsImpl _$$PersistenceOptionsImplFromJson(
        Map<String, dynamic> json) =>
    _$PersistenceOptionsImpl(
      autoplaySong: json['autoplaySong'] as bool,
      persistInfo: json['persistInfo'] as bool,
      saveLibraryTab: json['saveLibraryTab'] as bool,
    );

Map<String, dynamic> _$$PersistenceOptionsImplToJson(
        _$PersistenceOptionsImpl instance) =>
    <String, dynamic>{
      'autoplaySong': instance.autoplaySong,
      'persistInfo': instance.persistInfo,
      'saveLibraryTab': instance.saveLibraryTab,
    };

_$BackendResponseImpl _$$BackendResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BackendResponseImpl(
      shuffleOnLoop: json['shuffleOnLoop'] as bool,
      shuffleDefault: json['shuffleDefault'] as bool,
      username: json['username'] as String,
      backendUrl: json['backendUrl'] as String,
    );

Map<String, dynamic> _$$BackendResponseImplToJson(
        _$BackendResponseImpl instance) =>
    <String, dynamic>{
      'shuffleOnLoop': instance.shuffleOnLoop,
      'shuffleDefault': instance.shuffleDefault,
      'username': instance.username,
      'backendUrl': instance.backendUrl,
    };
