import 'package:flutter/material.dart';

import '../../../../models/project_models/project_overview_vm/project_overview.dart';

class ProjectDataHeadlineWidget extends StatelessWidget {
  final ProjectOverview project;
  const ProjectDataHeadlineWidget({super.key, required this.project});
  @override
  Widget build(BuildContext context) {
    final initDate =
        '${project.projectCreated.day}.${project.projectCreated.month}.${project.projectCreated.year}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            project.projectName!,
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
}
