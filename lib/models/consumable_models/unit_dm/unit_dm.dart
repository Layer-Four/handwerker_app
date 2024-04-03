import 'package:freezed_annotation/freezed_annotation.dart';
part 'unit_dm.freezed.dart';
part 'unit_dm.g.dart';

@freezed
class UnitDM with _$UnitDM {
  const factory UnitDM({
    required String name,
    required int id,
  }) = _UnitDM;
  factory UnitDM.fromJson(Map<String, dynamic> json) => _$UnitDMFromJson(json);
}
