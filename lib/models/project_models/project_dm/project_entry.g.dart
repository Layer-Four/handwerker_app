// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjecEntrytImpl _$$ProjecEntrytImplFromJson(Map<String, dynamic> json) =>
    _$ProjecEntrytImpl(
      projectID: json['projectID'] as int?,
      customerID: json['customerID'] as int?,
      customerName: json['customerName'] as String,
      projectName: json['projectName'] as String?,
      createDate: DateTime.parse(json['createDate'] as String),
      imageUrl: (json['imageUrl'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$ProjecEntrytImplToJson(_$ProjecEntrytImpl instance) =>
    <String, dynamic>{
      'projectID': instance.projectID,
      'customerID': instance.customerID,
      'customerName': instance.customerName,
      'projectName': instance.projectName,
      'createDate': instance.createDate.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };
