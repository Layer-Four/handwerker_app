// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectCustomerImpl _$$ProjectCustomerImplFromJson(
        Map<String, dynamic> json) =>
    _$ProjectCustomerImpl(
      customer: json['customer'] as String,
      projects: (json['projects'] as List<dynamic>)
          .map((e) => ProjectOverview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProjectCustomerImplToJson(
        _$ProjectCustomerImpl instance) =>
    <String, dynamic>{
      'customer': instance.customer,
      'projects': instance.projects,
    };
