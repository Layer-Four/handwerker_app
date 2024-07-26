import 'package:handwerker_app/models/consumable_models/material_vm/material_vm.dart';

import '../../customer_models/customer_short_model/customer_short_dm.dart';
import '../../project_models/project_short_vm/project_short_vm.dart';

class ConsumeableState {
  final ConsumeableVM _currentConsumable;
  final List<CustomerShortDM> _allCustomers;
  final CustomerShortDM? _selectedCustomer;
  final List<ProjectShortVM> _projectFromCustomers;
  final ProjectShortVM? _selectedProject;
  const ConsumeableState({
    List<CustomerShortDM>? customers,
    CustomerShortDM? currentCustomer,
    ConsumeableVM? material,
    List<ProjectShortVM>? customersProject,
    ProjectShortVM? project,
  })  : _selectedCustomer = currentCustomer,
        _allCustomers = customers ?? const <CustomerShortDM>[],
        _selectedProject = project,
        _projectFromCustomers = customersProject ?? const <ProjectShortVM>[],
        _currentConsumable = material ?? const ConsumeableVM(id: 0);

// Getter
  List<CustomerShortDM> get customers => _allCustomers;
  CustomerShortDM? get currentCustomer => _selectedCustomer;
  ConsumeableVM get consumable => _currentConsumable;
  ProjectShortVM? get project => _selectedProject;
  List<ProjectShortVM> get customerProject => _projectFromCustomers;

  ConsumeableState copyWith({
    List<CustomerShortDM>? newCustomers,
    CustomerShortDM? Function()? editedCustomer,
    ProjectShortVM? Function()? editedProject,
    ConsumeableVM? editedConsumable,
    List<ProjectShortVM>? newProjects,
  }) =>
      ConsumeableState(
        project: editedProject != null ? editedProject() : _selectedProject,
        customersProject: newProjects ?? _projectFromCustomers,
        material: editedConsumable ?? _currentConsumable,
        customers: newCustomers ?? _allCustomers,
        currentCustomer: editedCustomer != null ? editedCustomer() : _selectedCustomer,
      );
}
