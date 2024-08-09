import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';
part 'consumable_entry.freezed.dart';
part 'consumable_entry.g.dart';

@freezed
class ConsumalbeEntry with _$ConsumalbeEntry {
  const factory ConsumalbeEntry({
    DateTime? createDate,
    int? projectID,
    @Default(<ConsumableDM>[]) List<ConsumableDM> consumables,
  }) = _ConsumalbeEntry;

  factory ConsumalbeEntry.fromJson(Map<String, dynamic> json) => _$ConsumalbeEntryFromJson(json);
}
