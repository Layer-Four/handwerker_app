import '../consumable_models/consumable_vm/consumable.dart';
import '../customer_models/customer_short_model/customer_short_dm.dart';
import '../project_models/project_short_vm/project_short_vm.dart';

class MaterialState {
  final ConsumableDM _currentConsumable;
  final List<CustomerShortDM> _allCustomers;
  final CustomerShortDM? _selectedCustomer;
  final List<ProjectShortVM> _projectFromCustomers;
  final ProjectShortVM? _selectedProject;
  final List<ConsumableDM> _material;

  const MaterialState({
    List<CustomerShortDM>? customers,
    CustomerShortDM? currentCustomer,
    ConsumableDM? material,
    List<ProjectShortVM>? customersProject,
    ProjectShortVM? project,
    List<ConsumableDM>? materials,
  })  : _selectedCustomer = currentCustomer,
        _allCustomers = customers ?? const <CustomerShortDM>[],
        _selectedProject = project,
        _projectFromCustomers = customersProject ?? const <ProjectShortVM>[],
        _currentConsumable = material ?? const ConsumableDM(),
        _material = materials ?? const <ConsumableDM>[];

  // Getters
  List<CustomerShortDM> get customers => _allCustomers;
  CustomerShortDM? get currentCustomer => _selectedCustomer;
  ConsumableDM get consumable => _currentConsumable;
  ProjectShortVM? get project => _selectedProject;
  List<ProjectShortVM> get customerProjects => _projectFromCustomers;
  List<ConsumableDM> get materials => _material;

  MaterialState copyWith({
    List<CustomerShortDM>? customers,
    CustomerShortDM? currentCustomer,
    ProjectShortVM? project,
    ConsumableDM? material,
    List<ProjectShortVM>? customersProject,
    List<ConsumableDM>? materials,
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
