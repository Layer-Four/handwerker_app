import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_customer_vm/project_customer.dart';
import 'package:handwerker_app/provider/doku_provider/project_vm_provider.dart';
import 'package:handwerker_app/view/history_views/history_project/widgets/project_data_widget.dart';
import 'package:handwerker_app/view/history_views/history_project/widgets/project_overview_header.dart';
import 'package:handwerker_app/view/widgets/empty_result_message.dart';
import 'package:handwerker_app/view/widgets/logo_widget.dart';
import '../../../provider/settings_provider/settings_provider.dart';

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
            ProjectOverviewHeader(title: ref.watch(settingsProv).dictionary.overView),
            _buildAsyncProjectOverview(),
            const LogoWidget(assetString: 'assets/images/img_techtool.png'),
          ],
        ),
      );

  Widget _buildAsyncProjectOverview() => FutureBuilder<List<ProjectCustomer?>>(
      future: loadProjects(),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const Center(child: CircularProgressIndicator());
        // }
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
                      child: ProjectDataWidget(customer: customer),
                      // child: _buildProjectDetails(customer),
                    ),
                  ],
                );
              },
            ),
          );
        }
        return const ShowEmptyMessage();
      });
}
