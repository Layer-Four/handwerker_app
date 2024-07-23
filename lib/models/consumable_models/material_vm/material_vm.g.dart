// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumeableVMImpl _$$ConsumeableVMImplFromJson(Map<String, dynamic> json) =>
    _$ConsumeableVMImpl(
      name: json['name'] as String?,
      id: (json['id'] as num).toInt(),
      amount: (json['amount'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$$ConsumeableVMImplToJson(_$ConsumeableVMImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'amount': instance.amount,
      'price': instance.price,
      'unit': instance.unit,
    };
