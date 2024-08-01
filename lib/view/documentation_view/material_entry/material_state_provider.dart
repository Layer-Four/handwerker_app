import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/models/consumable_models/material_vm/material_vm.dart';
import 'package:handwerker_app/models/project_models/project_short_vm/project_short_vm.dart';
import 'package:handwerker_app/models/consumable_models/consumable_entry/consumable_entry.dart';
import 'package:handwerker_app/view/documentation_view/material_entry/material_entry_notifier.dart';

import '../../../models/consumable_models/unit_dm/unit_dm.dart';

final materialEntryProvider = StateNotifierProvider<MaterialEntryNotifier, MaterialEntryState>((ref) {
  return MaterialEntryNotifier(ref);
});

class MaterialEntryState {
  final ConsumableEntry entry;
  final List<ConsumeableVM> materials;
  final List<ProjectShortVM> projects;
  final ProjectShortVM? project;
  final ConsumeableVM? selectedMaterial;
  final List<UnitDM>? units;
  final UnitDM? unit;
  final String amount;
  final String summary;

  MaterialEntryState({
    required this.entry,
    this.materials = const [],
    this.projects = const [],
    this.project,
    this.selectedMaterial,
    this.units,
    this.unit,
    this.amount = '1',
    this.summary = '',
  });

  MaterialEntryState copyWith({
    ConsumableEntry? entry,
    UnitDM? unit,
    List<UnitDM>? units,
    List<ConsumeableVM>? materials,
    ProjectShortVM? project,
    ProjectShortVM? projects,
    ConsumeableVM? selectedMaterial,
    String? amount,
    String? summary,
  }) {
    return MaterialEntryState(
      entry: entry ?? this.entry,
      unit: unit ?? this.unit,
      units: units ?? this.units,
      materials: materials ?? this.materials,
      project: project ?? this.project,
      selectedMaterial: selectedMaterial ?? this.selectedMaterial,
      amount: amount ?? this.amount,
      summary: summary ?? this.summary,
    );
  }
}
