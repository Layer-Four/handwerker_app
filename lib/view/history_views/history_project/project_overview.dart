import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_customer_vm/project_customer.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_overview.dart';
import 'package:handwerker_app/provider/doku_provider/project_vm_provider.dart';
import 'package:handwerker_app/provider/settings_provider/language_provider.dart';
import 'package:handwerker_app/view/widgets/empty_result_message.dart';
import 'package:handwerker_app/view/widgets/hinged_widget.dart';
import 'package:handwerker_app/view/widgets/logo_widget.dart';
import 'package:handwerker_app/view/widgets/show_project_details.dart';

class CostumerOverviewBody extends ConsumerStatefulWidget {
  const CostumerOverviewBody({super.key});

  @override
  ConsumerState<CostumerOverviewBody> createState() => _CostumerOverviewBodyState();
}

class _CostumerOverviewBodyState extends ConsumerState<CostumerOverviewBody> {
  List<ProjectCustomer>? futureProjects;

  Future<List<ProjectCustomer>> loadProjects() async {
    final value = await ref.read(projectVMProvider.notifier).getAllProjectEntries();
    setState(() => futureProjects = value);
    return value;
  }

  @override
  Widget build(context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCustomerOverviewHeadLine(),
            _buildAsyncProjectOverview(),
            const LogoWidget(assetString: 'assets/images/img_techtool.png'),
          ],
        ),
      );

  Widget _buildAsyncProjectOverview() => FutureBuilder<List<ProjectCustomer?>>(
      future: loadProjects(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          if (snapshot.data!.isEmpty) return const ShowEmptyMessage();
          final customerProjectList = snapshot.data;
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: customerProjectList!.length,
              itemBuilder: (BuildContext context, i) {
                final customer = customerProjectList[i];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: Text(customer?.customer ?? 'Kein Kunde??'),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 300,
                      child: _buildProjectDetails(customer),
                    ),
                  ],
                );
              },
            ),
          );
        }
        // TODO: Look add TimeEntryOverview for default screen
        return const SizedBox(
          height: 400,
          child: Center(child: CircularProgressIndicator()),
        );
      });

  Widget _buildCustomerOverviewHeadLine() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Text(
          ref.watch(languangeProvider).overView,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }

  Row _buildHeadLine(ProjectOverview j) {
    final initDate = '${j.projectCreated.day}.${j.projectCreated.month}.${j.projectCreated.year}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            j.projectName!,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            initDate,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        )
      ],
    );
  }

  ListView _buildProjectDetails(ProjectCustomer? customer) {
    return ListView.builder(
        itemCount: customer?.projects.length,
        itemBuilder: (context, int j) {
          final project = customer?.projects[j];
          return HingedWidget(
            contentLength: project!.timeViewModels.length,
            header: _buildHeadLine(project),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var work in project.timeViewModels)
                  SizedBox(
                    height: 18,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(
                              '${work.start.day < 10 ? "0${work.start.day}" : work.start.day}.${work.start.month < 10 ? "0${work.start.month}" : work.start.month}-${work.end.day < 10 ? "0${work.end.day}" : work.end.day}.${work.end.month < 10 ? "0${work.end.month}" : work.end.month}.${work.end.year}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: AppColor.kTextfieldBorder),
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: Text(
                              work.serviceName ?? 'kein Service ausgewählt',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: AppColor.kTextfieldBorder),
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              '${work.durationTotal} Stunden',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: AppColor.kTextfieldBorder),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ProjectDetails(project: project),
              ],
            ),
          );
        });
  }
}
