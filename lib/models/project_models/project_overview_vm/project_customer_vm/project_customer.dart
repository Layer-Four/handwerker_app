import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_overview.dart';
part 'project_customer.freezed.dart';
part 'project_customer.g.dart';

@freezed
class ProjectCustomer with _$ProjectCustomer {
  const factory ProjectCustomer({
    required String customer,
    @Default(<ProjectOverview>[]) List<ProjectOverview?> projects,
  }) = _ProjectCustomer;
  const ProjectCustomer._();
  factory ProjectCustomer.fromJson(Map<String, dynamic> json) => _$ProjectCustomerFromJson(json);
}
