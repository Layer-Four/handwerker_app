// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumableImpl _$$ConsumableImplFromJson(Map<String, dynamic> json) =>
    _$ConsumableImpl(
      consumableID: json['consumableID'] as String?,
      price: json['price'] as int?,
      name: json['name'] as String,
      amount: json['amount'] as int? ?? 1,
    );

Map<String, dynamic> _$$ConsumableImplToJson(_$ConsumableImpl instance) =>
    <String, dynamic>{
      'consumableID': instance.consumableID,
      'price': instance.price,
      'name': instance.name,
      'amount': instance.amount,
    };
