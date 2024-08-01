import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';
part 'consumable_entry.freezed.dart';
part 'consumable_entry.g.dart';

@freezed
class ConsumableEntry with _$ConsumableEntry {
  const factory ConsumableEntry({
    required DateTime createDate,
    // @Default('') String entryID,
    // String? projectName,
    int? projectID,
    @Default(<Consumable>[]) List<Consumable> consumables,
    // @Default(<String>[]) List<String> dokusPath,
    // double? estimatedDuration,
    // int? cost,
  }) = _ConsumableEntry;

  factory ConsumableEntry.fromJson(Map<String, dynamic> json) => _$ConsumableEntryFromJson(json);
}
