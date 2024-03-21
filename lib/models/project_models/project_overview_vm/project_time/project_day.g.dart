// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectTimeVMImpl _$$ProjectTimeVMImplFromJson(Map<String, dynamic> json) =>
    _$ProjectTimeVMImpl(
      durationTotal: json['durationTotal'] as int?,
      end: DateTime.parse(json['end'] as String),
      serviceID: json['serviceID'] as int?,
      serviceName: json['serviceName'] as String?,
      start: DateTime.parse(json['start'] as String),
    );

Map<String, dynamic> _$$ProjectTimeVMImplToJson(_$ProjectTimeVMImpl instance) =>
    <String, dynamic>{
      'durationTotal': instance.durationTotal,
      'end': instance.end.toIso8601String(),
      'serviceID': instance.serviceID,
      'serviceName': instance.serviceName,
      'start': instance.start.toIso8601String(),
    };
