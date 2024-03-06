// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExecutionImpl _$$ExecutionImplFromJson(Map<String, dynamic> json) =>
    _$ExecutionImpl(
      executionID: json['executionID'] as String?,
      projectID: json['projectID'] as String?,
      date: DateTime.parse(json['date'] as String),
      project: json['project'] as String,
      timeStart: DateTime.parse(json['timeStart'] as String),
      timeEnd: DateTime.parse(json['timeEnd'] as String),
      pasueStart: json['pasueStart'] == null
          ? null
          : DateTime.parse(json['pasueStart'] as String),
      pauseEnd: json['pauseEnd'] == null
          ? null
          : DateTime.parse(json['pauseEnd'] as String),
      duration: json['duration'] as int?,
      service: json['service'] as String?,
      consumables: (json['consumables'] as List<dynamic>?)
              ?.map((e) => e as String?)
              .toList() ??
          const <String>[],
      usersID: (json['usersID'] as List<dynamic>?)
              ?.map((e) => e as String?)
              .toList() ??
          const <String>[],
      descritpion: json['descritpion'] as String?,
    );

Map<String, dynamic> _$$ExecutionImplToJson(_$ExecutionImpl instance) =>
    <String, dynamic>{
      'executionID': instance.executionID,
      'projectID': instance.projectID,
      'date': instance.date.toIso8601String(),
      'project': instance.project,
      'timeStart': instance.timeStart.toIso8601String(),
      'timeEnd': instance.timeEnd.toIso8601String(),
      'pasueStart': instance.pasueStart?.toIso8601String(),
      'pauseEnd': instance.pauseEnd?.toIso8601String(),
      'duration': instance.duration,
      'service': instance.service,
      'consumables': instance.consumables,
      'usersID': instance.usersID,
      'descritpion': instance.descritpion,
    };
