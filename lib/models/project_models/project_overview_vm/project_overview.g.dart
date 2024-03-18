// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectOverViewImpl _$$ProjectOverViewImplFromJson(
        Map<String, dynamic> json) =>
    _$ProjectOverViewImpl(
      customerID: BigInt.parse(json['customerID'] as String),
      customerName: json['customerName'] as String,
      hasDocumentations: json['hasDocumentations'] as bool? ?? false,
      materialViewModels: (json['materialViewModels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      projectCreated: DateTime.parse(json['projectCreated'] as String),
      projectID: BigInt.parse(json['projectID'] as String),
      projectMaterials: json['projectMaterials'] as List<dynamic>? ?? const [],
      projectName: json['projectName'] as String,
      timeViewModels: (json['timeViewModels'] as List<dynamic>?)
              ?.map((e) => ProjectTimeVM.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ProjectTimeVM>[],
    );

Map<String, dynamic> _$$ProjectOverViewImplToJson(
        _$ProjectOverViewImpl instance) =>
    <String, dynamic>{
      'customerID': instance.customerID.toString(),
      'customerName': instance.customerName,
      'hasDocumentations': instance.hasDocumentations,
      'materialViewModels': instance.materialViewModels,
      'projectCreated': instance.projectCreated.toIso8601String(),
      'projectID': instance.projectID.toString(),
      'projectMaterials': instance.projectMaterials,
      'projectName': instance.projectName,
      'timeViewModels': instance.timeViewModels,
    };
