import '../../customer_models/customer_short_model/customer_short_dm.dart';
import '../../project_models/project_short_vm/project_short_vm.dart';
import '../time_entries_vm/time_entries_vm.dart';

class TimeEntryState {
  final TimeEntriesVM _timeEntry;
  final List<CustomerShortDM> _allCustomers;
  final CustomerShortDM? _selectedCustomer;
  final List<ProjectShortVM> _projectFromCustomers;
  final ProjectShortVM? _selectedProject;
  const TimeEntryState({
    TimeEntriesVM? timeEntry,
    List<CustomerShortDM>? customers,
    CustomerShortDM? currentCustomer,
    List<ProjectShortVM>? customersProject,
    ProjectShortVM? project,
  })  : _selectedCustomer = currentCustomer,
        _allCustomers = customers ?? const <CustomerShortDM>[],
        _selectedProject = project,
        _projectFromCustomers = customersProject ?? const <ProjectShortVM>[],
        _timeEntry = timeEntry ?? const TimeEntriesVM();

  // Getter
  List<CustomerShortDM> get customers => _allCustomers;
  CustomerShortDM? get currentCustomer => _selectedCustomer;
  TimeEntriesVM get entry => _timeEntry;
  ProjectShortVM? get project => _selectedProject;
  List<ProjectShortVM> get customerProject => _projectFromCustomers;

  TimeEntryState copyWith({
    TimeEntriesVM? newEntry,
    List<CustomerShortDM>? newCustomers,
    CustomerShortDM? Function()? editedCustomer,
    ProjectShortVM? Function()? editedProject,
    List<ProjectShortVM>? newProjects,
  }) =>
      TimeEntryState(
        timeEntry: newEntry ?? _timeEntry,
        project: editedProject != null ? editedProject() : _selectedProject,
        customersProject: newProjects ?? _projectFromCustomers,
        customers: newCustomers ?? _allCustomers,
        currentCustomer: editedCustomer != null ? editedCustomer() : _selectedCustomer,
      );
}
