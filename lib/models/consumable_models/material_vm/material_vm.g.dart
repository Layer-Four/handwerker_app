// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumeableVMImpl _$$ConsumeableVMImplFromJson(Map<String, dynamic> json) =>
    _$ConsumeableVMImpl(
      name: json['name'] as String,
      id: (json['id'] as num).toInt(),
      amount: (json['amount'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      materialUnitName: json['materialUnitName'] as String,
    );

Map<String, dynamic> _$$ConsumeableVMImplToJson(_$ConsumeableVMImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'amount': instance.amount,
      'price': instance.price,
      'materialUnitName': instance.materialUnitName,
    };
