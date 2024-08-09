import 'package:freezed_annotation/freezed_annotation.dart';
part 'consumable.freezed.dart';
part 'consumable.g.dart';

@freezed
class ConsumableDM with _$ConsumableDM {
  const factory ConsumableDM({
    @Default(1) double amount,
    int? id,
    int? materialUnitID,
    String? name,
    String? materialID,
    double? netPrice,
    double? grossPrice,
    double? vat,
    String? materialUnitName,
  }) = _ConsumableDM;
  factory ConsumableDM.fromJson(Map<String, dynamic> json) => _$ConsumableDMFromJson(json);
}
