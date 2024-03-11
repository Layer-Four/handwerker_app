// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) =>
    _$ProjectImpl(
      projectID: BigInt.parse(json['projectID'] as String),
      customerID: BigInt.parse(json['customerID'] as String),
      customerName: json['customerName'] as String,
      projectName: json['projectName'] as String?,
      createDate: DateTime.parse(json['createDate'] as String),
      imageUrl: (json['imageUrl'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) =>
    <String, dynamic>{
      'projectID': instance.projectID.toString(),
      'customerID': instance.customerID.toString(),
      'customerName': instance.customerName,
      'projectName': instance.projectName,
      'createDate': instance.createDate.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };
