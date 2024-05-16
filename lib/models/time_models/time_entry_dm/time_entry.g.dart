// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeEntryImpl _$$TimeEntryImplFromJson(Map<String, dynamic> json) =>
    _$TimeEntryImpl(
      customerName: json['customerName'] as String? ?? '',
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      duration: json['duration'] as int?,
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      id: json['id'] as int?,
      pauseEnd: json['pauseEnd'] == null
          ? null
          : DateTime.parse(json['pauseEnd'] as String),
      pauseStart: json['pauseStart'] == null
          ? null
          : DateTime.parse(json['pauseStart'] as String),
      projectID: json['projectID'] as int?,
      projektTitle: json['projektTitle'] as String?,
      serviceID: json['serviceID'] as int?,
      serviceTitle: json['serviceTitle'] as String?,
      startTime: DateTime.parse(json['startTime'] as String),
      type: json['type'] as int? ?? 0,
      userID: json['userID'] as String?,
    );

Map<String, dynamic> _$$TimeEntryImplToJson(_$TimeEntryImpl instance) =>
    <String, dynamic>{
      'customerName': instance.customerName,
      'date': instance.date.toIso8601String(),
      'description': instance.description,
      'duration': instance.duration,
      'endTime': instance.endTime?.toIso8601String(),
      'id': instance.id,
      'pauseEnd': instance.pauseEnd?.toIso8601String(),
      'pauseStart': instance.pauseStart?.toIso8601String(),
      'projectID': instance.projectID,
      'projektTitle': instance.projektTitle,
      'serviceID': instance.serviceID,
      'serviceTitle': instance.serviceTitle,
      'startTime': instance.startTime.toIso8601String(),
      'type': instance.type,
      'userID': instance.userID,
    };
