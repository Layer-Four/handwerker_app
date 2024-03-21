// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumableImpl _$$ConsumableImplFromJson(Map<String, dynamic> json) =>
    _$ConsumableImpl(
      materialID: json['materialID'] as String?,
      price: json['price'] as int?,
      name: json['name'] as String,
      amount: json['amount'] as int? ?? 1,
      unitTypeName: json['unitTypeName'] as String?,
      materialUnitID: json['materialUnitID'] as int?,
    );

Map<String, dynamic> _$$ConsumableImplToJson(_$ConsumableImpl instance) =>
    <String, dynamic>{
      'materialID': instance.materialID,
      'price': instance.price,
      'name': instance.name,
      'amount': instance.amount,
      'unitTypeName': instance.unitTypeName,
      'materialUnitID': instance.materialUnitID,
    };
