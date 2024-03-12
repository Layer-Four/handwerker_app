import 'package:freezed_annotation/freezed_annotation.dart';
part 'consumable.freezed.dart';
part 'consumable.g.dart';

@freezed
class Consumable with _$Consumable {
  const factory Consumable({
    String? consumableID,
    int? price,
    required String name,
    @Default(1) int amount,
  }) = _Consumable;
  factory Consumable.fromJson(Map<String, dynamic> json) => _$ConsumableFromJson(json);
}
