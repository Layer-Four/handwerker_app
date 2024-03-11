import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handwerker_app/models/consumable/consumable.dart';
part 'consumable_entry.freezed.dart';
part 'consumable_entry.g.dart';

@freezed
class ConsumeEntry with _$ConsumeEntry {
  const factory ConsumeEntry({
    required DateTime createDate,
    @Default('') String entryID,
    String? projectName,
    @Default(<Consumable>[]) List<Consumable> consumables,
    @Default(<String>[]) List<String> dokusPath,
    double? estimatedDuration,
    int? cost,
  }) = _ConsumeEntry;

  factory ConsumeEntry.fromJson(Map<String, dynamic> json) => _$ConsumeEntryFromJson(json);
}
