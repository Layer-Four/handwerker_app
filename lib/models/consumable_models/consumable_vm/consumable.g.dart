// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumableImpl _$$ConsumableImplFromJson(Map<String, dynamic> json) =>
    _$ConsumableImpl(
      amount: json['amount'] as int? ?? 1,
      materialUnitID: json['materialUnitID'] as int?,
      materialID: json['materialID'] as String?,
      price: json['price'] as int?,
      unitTypeName: json['unitTypeName'] as String?,
    );

Map<String, dynamic> _$$ConsumableImplToJson(_$ConsumableImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'materialUnitID': instance.materialUnitID,
      'materialID': instance.materialID,
      'price': instance.price,
      'unitTypeName': instance.unitTypeName,
    };
