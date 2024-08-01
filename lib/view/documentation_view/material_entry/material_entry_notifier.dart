import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/models/consumable_models/consumable_entry/consumable_entry.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';
import 'package:handwerker_app/provider/doku_provider/consumable_provider.dart';
import 'package:handwerker_app/provider/doku_provider/material_vm_provider.dart';
import 'package:handwerker_app/provider/doku_provider/project_vm_provider.dart';
import 'package:handwerker_app/view/documentation_view/material_entry/material_state_provider.dart';
import 'package:handwerker_app/models/consumable_models/material_vm/material_vm.dart';
import 'package:handwerker_app/models/project_models/project_short_vm/project_short_vm.dart';

final materialEntryProvider = StateNotifierProvider<MaterialEntryNotifier, MaterialEntryState>((ref) {
  return MaterialEntryNotifier(ref);
});

class MaterialEntryNotifier extends StateNotifier<MaterialEntryState> {
  MaterialEntryNotifier(this.ref)
      : super(
          MaterialEntryState(
            entry: ConsumableEntry(createDate: DateTime.now()),
          ),
        ) {
    loadInitialData();
  }

  final Ref ref;

  Future<void> loadInitialData() async {
    final materials = await ref.read(materialVMProvider.notifier).loadMaterials();
    final projects = await ref.read(projectVMProvider.notifier).loadpProject();
    final units = await ref.read(consumableProvider.notifier).getUnits();

    state = state.copyWith(
      materials: materials,
      project: projects.isNotEmpty ? projects.first : null,
      selectedMaterial: materials.isNotEmpty ? materials.first : null,
      units: units,
      unit: units.isNotEmpty ? units.first : null,
    );

    updateSummary();
  }

  void setDate(DateTime date) {
    state = state.copyWith(entry: state.entry.copyWith(createDate: date));
  }

  void setProject(ProjectShortVM project) {
    state = state.copyWith(
      project: project,
      entry: state.entry.copyWith(projectID: project.id),
    );
  }

  void setMaterial(ConsumeableVM material) {
    state = state.copyWith(selectedMaterial: material);
    updateSummary();
  }

  void setAmount(String amount) {
    state = state.copyWith(amount: amount);
    updateSummary();
  }

  void updateSummary() {
    final amount = int.tryParse(state.amount) ?? 1;
    final price = state.selectedMaterial?.price ?? 0;
    state = state.copyWith(summary: (price * amount).toStringAsFixed(2));
  }

  void submitEntry() {
    if (state.selectedMaterial == null || state.project == null || state.unit == null) return;

    final material = Consumable(
      amount: int.tryParse(state.amount) ?? 1,
      materialUnitID: state.unit!.id,
      price: int.tryParse(state.summary) ?? 0,
      materialID: state.selectedMaterial!.id.toString(),
    );

    final updatedEntry = state.entry.copyWith(
      consumables: [material],
      projectID: state.project!.id,
    );

    ref.read(consumableProvider.notifier).uploadConsumableEntry(updatedEntry);

    state = MaterialEntryState(entry: ConsumableEntry(createDate: DateTime.now()));
  }
}
