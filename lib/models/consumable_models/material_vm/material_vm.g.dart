// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

<<<<<<< HEAD
_$ConsumeableVMImpl _$$ConsumeableVMImplFromJson(Map<String, dynamic> json) => _$ConsumeableVMImpl(
      name: json['name'] as String,
      id: (json['id'] as num).toInt(),
      amount: (json['amount'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      materialUnitName: json['materialUnitName'] as String,
=======
_$ConsumeableVMImpl _$$ConsumeableVMImplFromJson(Map<String, dynamic> json) =>
    _$ConsumeableVMImpl(
      name: json['name'] as String?,
      id: (json['id'] as num).toInt(),
      amount: (json['amount'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
>>>>>>> 67d20661715ee3e4832c3122bfea12241541508f
    );

Map<String, dynamic> _$$ConsumeableVMImplToJson(_$ConsumeableVMImpl instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'amount': instance.amount,
      'price': instance.price,
<<<<<<< HEAD
      'materialUnitName': instance.materialUnitName,
=======
      'unit': instance.unit,
>>>>>>> 67d20661715ee3e4832c3122bfea12241541508f
    };
