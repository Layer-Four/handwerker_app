import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/consumable_models/material_vm/material_vm.dart';
import 'package:handwerker_app/models/customer_models/customer_short_model/customer_short_dm.dart';
import 'package:handwerker_app/models/project_models/project_short_vm/project_short_vm.dart';
import 'package:handwerker_app/models/custom_notifier_model/abstract_entry.methods.dart';

final materialNotifierProvider = NotifierProvider<MaterialNotifier, List<ConsumeableVM>>(
      () => MaterialNotifier(),
);

class MaterialNotifier extends AbstractEntryMethod<List<ConsumeableVM>> {
  final Api _api = Api();
  Future<String?> get mandant async => await _api.getMandant;

  @override
  List<ConsumeableVM> build() {
    // Initialize state with an empty list
    return [];
  }

  @override
  void updateSelectedProject(ProjectShortVM? project) {
    // Implement project update logic if needed
  }

  @override
  void updateSeletedCustomer(CustomerShortDM? customer) {
    // Implement customer update logic if needed
  }

  Future<void> loadData() async {
    try {
      // Fetch Mandant ID from storage
      final mandantID = await _api.getMandant;

      if (mandantID == null) {
        log('Mandant ID is missing');
        return;
      }

      // Fetch customers
      final customers = await getAllCustomer();
      if (customers.isEmpty) {
        state = [];
        return;
      }

      // Fetch projects for the first customer if available
      final projects = customers.isNotEmpty
          ? await getProjectsForCustomer(customers.first.id)
          : <ProjectShortVM>[];

      // Fetch materials from the API
      final response = await _api.getMaterialsList;
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch materials: ${response.statusCode} ${response.data}');
      }

      final data = response.data as List<dynamic>;  // Ensure response data is of type List<dynamic>
      final consumables = data.map((item) => ConsumeableVM.fromJson(item)).toList();

      // Update state with fetched data
      state = consumables;
    } catch (error) {
      log('Error loading data: $error');
      // Handle error appropriately, e.g., update state to indicate an error
    }
  }
}
