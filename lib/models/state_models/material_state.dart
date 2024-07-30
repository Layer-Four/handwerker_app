import 'package:handwerker_app/models/customer_models/customer_short_model/customer_short_dm.dart';
import 'package:handwerker_app/models/project_models/project_short_vm/project_short_vm.dart';
import 'package:handwerker_app/models/consumable_models/material_vm/material_vm.dart';

class MaterialState {
  final ConsumeableVM _currentConsumable;
  final List<CustomerShortDM> _allCustomers;
  final CustomerShortDM? _selectedCustomer;
  final List<ProjectShortVM> _projectFromCustomers;
  final ProjectShortVM? _selectedProject;
  final List<ConsumeableVM> _material;

  const MaterialState({
    List<CustomerShortDM>? customers,
    CustomerShortDM? currentCustomer,
    ConsumeableVM? material,
    List<ProjectShortVM>? customersProject,
    ProjectShortVM? project,
    List<ConsumeableVM>? materials,
  })  : _selectedCustomer = currentCustomer,
        _allCustomers = customers ?? const <CustomerShortDM>[],
        _selectedProject = project,
        _projectFromCustomers = customersProject ?? const <ProjectShortVM>[],
        _currentConsumable = material ??
            const ConsumeableVM(
              id: -1,
              name: 'Please change me',
              amount: 0.1,
              price: 0.0,
              materialUnitName: 'Please change me',
            ),
        _material = materials ?? const <ConsumeableVM>[];

  // Getters
  List<CustomerShortDM> get customers => _allCustomers;
  CustomerShortDM? get currentCustomer => _selectedCustomer;
  ConsumeableVM get consumable => _currentConsumable;
  ProjectShortVM? get project => _selectedProject;
  List<ProjectShortVM> get customerProjects => _projectFromCustomers;
  List<ConsumeableVM> get materials => _material;

  MaterialState copyWith({
    List<CustomerShortDM>? customers,
    CustomerShortDM? currentCustomer,
    ProjectShortVM? project,
    ConsumeableVM? material,
    List<ProjectShortVM>? customersProject,
    List<ConsumeableVM>? materials,
  }) =>
      MaterialState(
        project: project ?? _selectedProject,
        customersProject: customersProject ?? _projectFromCustomers,
        material: material ?? _currentConsumable,
        customers: customers ?? _allCustomers,
        currentCustomer: currentCustomer ?? _selectedCustomer,
        materials: materials ?? _material,
      );
}
