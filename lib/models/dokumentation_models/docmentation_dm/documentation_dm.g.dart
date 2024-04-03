// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documentation_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentationDMImpl _$$DocumentationDMImplFromJson(
        Map<String, dynamic> json) =>
    _$DocumentationDMImpl(
      description: json['description'] as String?,
      imagesUrl: (json['imagesUrl'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$DocumentationDMImplToJson(
        _$DocumentationDMImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'imagesUrl': instance.imagesUrl,
    };
