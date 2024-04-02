// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumableImpl _$$ConsumableImplFromJson(Map<String, dynamic> json) =>
    _$ConsumableImpl(
      amount: json['amount'] as int? ?? 1,
      price: json['price'] as int?,
      materialUnitID: json['materialUnitID'] as int?,
      materialID: json['materialID'] as String?,
    );

Map<String, dynamic> _$$ConsumableImplToJson(_$ConsumableImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'price': instance.price,
      'materialUnitID': instance.materialUnitID,
      'materialID': instance.materialID,
    };
