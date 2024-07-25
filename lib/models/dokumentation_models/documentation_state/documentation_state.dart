import 'package:handwerker_app/models/customer_models/customer_short_model/customer_short_dm.dart';

import '../../project_models/project_short_vm/project_short_vm.dart';
import '../documentation_entry/documentation_entry.dart';

class DocumentationState {
  final DocumentationEntry _currentDocumentation;
  final List<CustomerShortDM> _allCustomers;
  final CustomerShortDM? _selectedCustomer;
  final List<ProjectShortVM> _projectFromCustomers;
  final ProjectShortVM? _selectedProject;
  const DocumentationState({
    List<CustomerShortDM>? customers,
    CustomerShortDM? currentCustomer,
    DocumentationEntry? doc,
    List<ProjectShortVM>? customersProject,
    ProjectShortVM? project,
  })  : _selectedCustomer = currentCustomer,
        _allCustomers = customers ?? const <CustomerShortDM>[],
        _selectedProject = project,
        _projectFromCustomers = customersProject ?? const <ProjectShortVM>[],
        _currentDocumentation = doc ?? const DocumentationEntry();

// Getter
  List<CustomerShortDM> get customers => _allCustomers;
  CustomerShortDM? get currentCustomer => _selectedCustomer;
  DocumentationEntry get docu => _currentDocumentation;
  ProjectShortVM? get project => _selectedProject;
  List<ProjectShortVM> get customerProject => _projectFromCustomers;

  DocumentationState copyWith({
    List<CustomerShortDM>? newCustomers,
    CustomerShortDM? Function()? editedCustomer,
    ProjectShortVM? Function()? editedProject,
    DocumentationEntry? editedDoc,
    List<ProjectShortVM>? newProjects,
  }) =>
      DocumentationState(
        project: editedProject != null ? editedProject() : _selectedProject,
        customersProject: newProjects ?? _projectFromCustomers,
        doc: editedDoc ?? _currentDocumentation,
        customers: newCustomers ?? _allCustomers,
        currentCustomer: editedCustomer != null ? editedCustomer() : _selectedCustomer,
      );
}
