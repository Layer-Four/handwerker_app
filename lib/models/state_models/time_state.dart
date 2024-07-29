import '../customer_models/customer_short_model/customer_short_dm.dart';
import '../project_models/project_short_vm/project_short_vm.dart';
import '../service_models/service_list_vm/service_list.dart';
import '../time_models/time_entries_vm/time_entries_vm.dart';

class TimeEntryState {
  final TimeEntriesVM _timeEntry;
  final List<TimeEntriesVM> _allTimeEntry;
  final List<ServiceListVM> _allServices;
  final ServiceListVM? _selectedService;
  final List<CustomerShortDM> _allCustomers;
  final CustomerShortDM? _selectedCustomer;
  final List<ProjectShortVM> _projectFromCustomers;
  final ProjectShortVM? _selectedProject;
  const TimeEntryState({
    TimeEntriesVM? timeEntry,
    List<ServiceListVM>? allServices,
    ServiceListVM? selectedService,
    List<TimeEntriesVM>? allTimeEntry,
    List<CustomerShortDM>? customers,
    CustomerShortDM? currentCustomer,
    List<ProjectShortVM>? customersProject,
    ProjectShortVM? project,
  })  : _allCustomers = customers ?? const <CustomerShortDM>[],
        _allServices = allServices ?? const <ServiceListVM>[],
        _allTimeEntry = allTimeEntry ?? const <TimeEntriesVM>[],
        _selectedCustomer = currentCustomer,
        _selectedProject = project,
        _selectedService = selectedService,
        _projectFromCustomers = customersProject ?? const <ProjectShortVM>[],
        _timeEntry = timeEntry ?? const TimeEntriesVM();

  // Getter
  List<CustomerShortDM> get customers => _allCustomers;
  List<ServiceListVM> get allServices => _allServices;
  CustomerShortDM? get currentCustomer => _selectedCustomer;
  List<TimeEntriesVM> get allEntries => _allTimeEntry;
  ServiceListVM? get currentService => _selectedService;
  TimeEntriesVM get entry => _timeEntry;
  ProjectShortVM? get project => _selectedProject;
  List<ProjectShortVM> get customerProject => _projectFromCustomers;
  
  TimeEntryState copyWith({
    TimeEntriesVM? newEntry,
    List<TimeEntriesVM>? newEntries,
    List<ServiceListVM>? newServices,
    ServiceListVM? nextService,
    List<CustomerShortDM>? newCustomers,
    CustomerShortDM? Function()? editedCustomer,
    ProjectShortVM? Function()? editedProject,
    List<ProjectShortVM>? newProjects,
  }) =>
      TimeEntryState(
        allTimeEntry: newEntries ?? _allTimeEntry,
        allServices: newServices ?? _allServices,
        selectedService: nextService ?? _selectedService,
        timeEntry: newEntry ?? _timeEntry,
        project: editedProject != null ? editedProject() : _selectedProject,
        customersProject: newProjects ?? _projectFromCustomers,
        customers: newCustomers ?? _allCustomers,
        currentCustomer: editedCustomer != null ? editedCustomer() : _selectedCustomer,
      );
}
