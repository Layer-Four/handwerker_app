// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumableEntryImpl _$$ConsumableEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$ConsumableEntryImpl(
      createDate: DateTime.parse(json['createDate'] as String),
      projectID: (json['projectID'] as num?)?.toInt(),
      consumables: (json['consumables'] as List<dynamic>?)
              ?.map((e) => Consumable.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Consumable>[],
    );

Map<String, dynamic> _$$ConsumableEntryImplToJson(
        _$ConsumableEntryImpl instance) =>
    <String, dynamic>{
      'createDate': instance.createDate.toIso8601String(),
      'projectID': instance.projectID,
      'consumables': instance.consumables,
    };
