import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';

import '../consumable_models/consumable_entry/consumable_entry.dart';

import '../customer_models/customer_short_model/customer_short_dm.dart';
import '../project_models/project_short_vm/project_short_vm.dart';

class ConsumableState {
  final List<ConsumableDM> _allConsumables;
  final List<CustomerShortDM> _allCustomers;
  final ConsumalbeEntry _entry;
  final List<ProjectShortVM> _projectFromCustomers;
  final ConsumableDM? _selectedConsumable;
  final CustomerShortDM? _selectedCustomer;
  final ProjectShortVM? _selectedProject;
  const ConsumableState({
    List<ConsumableDM>? allConsumables,
    List<CustomerShortDM>? customers,
    List<ProjectShortVM>? customersProject,
    CustomerShortDM? currentCustomer,
    ConsumableDM? material,
    ConsumalbeEntry? materialEnty,
    ProjectShortVM? project,
  })  : _allConsumables = allConsumables ?? const <ConsumableDM>[],
        _allCustomers = customers ?? const <CustomerShortDM>[],
        _entry = materialEnty ?? const ConsumalbeEntry(),
        _projectFromCustomers = customersProject ?? const <ProjectShortVM>[],
        _selectedCustomer = currentCustomer,
        _selectedProject = project,
        _selectedConsumable = material;

// Getter
  List<ConsumableDM> get consumables => _allConsumables;
  ConsumalbeEntry? get entry => _entry;
  ConsumableDM? get consumable => _selectedConsumable;
  CustomerShortDM? get currentCustomer => _selectedCustomer;
  List<CustomerShortDM> get customers => _allCustomers;
  List<ProjectShortVM> get customerProject => _projectFromCustomers;
  ProjectShortVM? get project => _selectedProject;

  ConsumableState copyWith({
    ConsumableDM? editedConsumable,
    List<ConsumableDM>? newConsumalbels,
    CustomerShortDM? Function()? editedCustomer,
    ProjectShortVM? Function()? editedProject,
    List<CustomerShortDM>? newCustomers,
    ConsumalbeEntry? newEntry,
    List<ProjectShortVM>? newProjects,
  }) =>
      ConsumableState(
        allConsumables: newConsumalbels ?? _allConsumables,
        currentCustomer: editedCustomer != null ? editedCustomer() : _selectedCustomer,
        customersProject: newProjects ?? _projectFromCustomers,
        customers: newCustomers ?? _allCustomers,
        materialEnty: newEntry ?? _entry,
        material: editedConsumable ?? _selectedConsumable,
        project: editedProject != null ? editedProject() : _selectedProject,
      );
}
