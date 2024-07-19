import 'package:flutter/material.dart';

import '../../../../constants/apptheme/app_colors.dart';
import '../../../../models/project_models/project_overview_vm/project_customer_vm/project_customer.dart';
import '../../../widgets/hinged_widget.dart';
import '../../../widgets/show_project_details.dart';
import 'project_data_headline_widget.dart';

class ProjectDataWidget extends StatelessWidget {
  final ProjectCustomer? customer;
  const ProjectDataWidget({super.key, required this.customer});
  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: customer?.projects.length,
      itemBuilder: (context, int j) {
        final project = customer?.projects[j];
        return HingedWidget(
          contentLength: project!.timeViewModels.length,
          header: ProjectDataHeadlineWidget(project: project),
          // header: _buildHeadLine(project),
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
                                .copyWith(color: AppColor.kLightLabelColor),
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
                                .copyWith(color: AppColor.kLightLabelColor),
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            '${work.durationTotal} Stunden',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: AppColor.kLightLabelColor),
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
