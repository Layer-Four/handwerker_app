// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumalbeEntryImpl _$$ConsumalbeEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$ConsumalbeEntryImpl(
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      projectID: (json['projectID'] as num?)?.toInt(),
      consumables: (json['consumables'] as List<dynamic>?)
              ?.map((e) => ConsumableDM.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ConsumableDM>[],
    );

Map<String, dynamic> _$$ConsumalbeEntryImplToJson(
        _$ConsumalbeEntryImpl instance) =>
    <String, dynamic>{
      'createDate': instance.createDate?.toIso8601String(),
      'projectID': instance.projectID,
      'consumables': instance.consumables,
    };
