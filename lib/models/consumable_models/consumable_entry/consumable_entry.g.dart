// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumealbeEntryImpl _$$ConsumealbeEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$ConsumealbeEntryImpl(
      createDate: DateTime.parse(json['createDate'] as String),
      projectID: json['projectID'] as int?,
      consumables: (json['consumables'] as List<dynamic>?)
              ?.map((e) => Consumable.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Consumable>[],
    );

Map<String, dynamic> _$$ConsumealbeEntryImplToJson(
        _$ConsumealbeEntryImpl instance) =>
    <String, dynamic>{
      'createDate': instance.createDate.toIso8601String(),
      'projectID': instance.projectID,
      'consumables': instance.consumables,
    };
