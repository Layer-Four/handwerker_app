// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProjectDayImpl _$$UserProjectDayImplFromJson(Map<String, dynamic> json) =>
    _$UserProjectDayImpl(
      date: DateTime.parse(json['date'] as String),
      documentationDescription:
          json['documentationDescription'] as String? ?? '',
      filePaths: (json['filePaths'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$UserProjectDayImplToJson(
        _$UserProjectDayImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'documentationDescription': instance.documentationDescription,
      'filePaths': instance.filePaths,
    };
