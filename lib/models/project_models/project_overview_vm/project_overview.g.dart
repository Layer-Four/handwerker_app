// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectOverViewImpl _$$ProjectOverViewImplFromJson(
        Map<String, dynamic> json) =>
    _$ProjectOverViewImpl(
      customerID: (json['customerID'] as num).toInt(),
      customerName: json['customerName'] as String?,
      hasDocumentations: json['hasDocumentations'] as bool? ?? false,
      materialViewModels: (json['materialViewModels'] as List<dynamic>?)
              ?.map((e) => ConsumeableVM.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ConsumeableVM>[],
      projectCreated: DateTime.parse(json['projectCreated'] as String),
      projectID: (json['projectID'] as num).toInt(),
      projectName: json['projectName'] as String?,
      timeViewModels: (json['timeViewModels'] as List<dynamic>?)
              ?.map((e) => ProjectTimeVM.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ProjectTimeVM>[],
    );

Map<String, dynamic> _$$ProjectOverViewImplToJson(
        _$ProjectOverViewImpl instance) =>
    <String, dynamic>{
      'customerID': instance.customerID,
      'customerName': instance.customerName,
      'hasDocumentations': instance.hasDocumentations,
      'materialViewModels': instance.materialViewModels,
      'projectCreated': instance.projectCreated.toIso8601String(),
      'projectID': instance.projectID,
      'projectName': instance.projectName,
      'timeViewModels': instance.timeViewModels,
    };
