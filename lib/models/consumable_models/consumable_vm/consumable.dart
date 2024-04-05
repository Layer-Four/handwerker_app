import 'package:freezed_annotation/freezed_annotation.dart';
part 'consumable.freezed.dart';
part 'consumable.g.dart';

@freezed
class Consumable with _$Consumable {
  const factory Consumable({
    @Default(1) int amount,
    int? materialUnitID,
    String? materialID,
    // String? name,
    int? price,
    String? unitTypeName,
  }) = _Consumable;
  factory Consumable.fromJson(Map<String, dynamic> json) => _$ConsumableFromJson(json);
}
