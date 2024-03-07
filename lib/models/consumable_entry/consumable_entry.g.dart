// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumeEntryImpl _$$ConsumeEntryImplFromJson(Map<String, dynamic> json) =>
    _$ConsumeEntryImpl(
      createDate: DateTime.parse(json['createDate'] as String),
      project: json['project'] as String?,
      consumables: (json['consumables'] as List<dynamic>?)
              ?.map((e) => e == null
                  ? null
                  : Consumable.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      duration: json['duration'] as String?,
      cost: json['cost'] as int?,
    );

Map<String, dynamic> _$$ConsumeEntryImplToJson(_$ConsumeEntryImpl instance) =>
    <String, dynamic>{
      'createDate': instance.createDate.toIso8601String(),
      'project': instance.project,
      'consumables': instance.consumables,
      'duration': instance.duration,
      'cost': instance.cost,
    };
