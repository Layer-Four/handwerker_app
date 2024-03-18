// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectTimeVMImpl _$$ProjectTimeVMImplFromJson(Map<String, dynamic> json) =>
    _$ProjectTimeVMImpl(
      durationTotal: json['durationTotal'] as String,
      end: DateTime.parse(json['end'] as String),
      serviceID: BigInt.parse(json['serviceID'] as String),
      servciceName: json['servciceName'] as String,
      start: DateTime.parse(json['start'] as String),
    );

Map<String, dynamic> _$$ProjectTimeVMImplToJson(_$ProjectTimeVMImpl instance) =>
    <String, dynamic>{
      'durationTotal': instance.durationTotal,
      'end': instance.end.toIso8601String(),
      'serviceID': instance.serviceID.toString(),
      'servciceName': instance.servciceName,
      'start': instance.start.toIso8601String(),
    };
