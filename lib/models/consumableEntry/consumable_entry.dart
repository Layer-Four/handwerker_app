import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handwerker_app/models/consumable/consumable.dart';
part 'consumable_entry.freezed.dart';
part 'consumable_entry.g.dart';

@freezed
class ConsumeEntry with _$ConsumeEntry {
  const factory ConsumeEntry({
    DateTime? createDate,
    String? project,
    @Default([]) List<Consumable?> consumables,
    String? duration,
    int? cost,
  }) = _ConsumeEntry;

  factory ConsumeEntry.fromJson(Map<String, dynamic> json) => _$ConsumeEntryFromJson(json);
}
