// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) =>
    _$ProjectImpl(
      projectID: json['projectID'] == null
          ? null
          : BigInt.parse(json['projectID'] as String),
      customer: json['customer'] == null
          ? null
          : BigInt.parse(json['customer'] as String),
      name: json['name'] as String?,
      createDate: DateTime.parse(json['createDate'] as String),
      imageUrl: (json['imageUrl'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) =>
    <String, dynamic>{
      'projectID': instance.projectID?.toString(),
      'customer': instance.customer?.toString(),
      'name': instance.name,
      'createDate': instance.createDate.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };
