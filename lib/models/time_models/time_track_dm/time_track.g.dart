// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeTrackImpl _$$TimeTrackImplFromJson(Map<String, dynamic> json) =>
    _$TimeTrackImpl(
      userId: json['userId'] as String?,
      id: json['id'] as int?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      duration: json['duration'] as int?,
      projectId: json['projectId'] as int?,
      serviceId: json['serviceId'] as int?,
      serviceTitle: json['serviceTitle'] as String?,
      customerName: json['customerName'] as String?,
    );

Map<String, dynamic> _$$TimeTrackImplToJson(_$TimeTrackImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'description': instance.description,
      'duration': instance.duration,
      'projectId': instance.projectId,
      'serviceId': instance.serviceId,
      'serviceTitle': instance.serviceTitle,
      'customerName': instance.customerName,
    };
