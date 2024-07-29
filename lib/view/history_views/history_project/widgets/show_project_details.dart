import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_overview.dart';
import 'package:handwerker_app/provider/doku_provider/project_vm_provider.dart';

import 'project_docu_widget.dart';

class ProjectDetails extends ConsumerStatefulWidget {
  final ProjectOverview project;
  const ProjectDetails({super.key, required this.project});

  @override
  ConsumerState<ProjectDetails> createState() => _ProjectCardState();
}

class _ProjectCardState extends ConsumerState<ProjectDetails> {
  int currentIndex = 0;
  List<Consumable>? consumables;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      height: 150,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: _showProjectDocumentation(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6),
            child: Text(
              'Material',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: consumables != null
                ? ListView.builder(
                    itemCount: consumables!.length,
                    itemBuilder: ((context, j) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 220,
                            child: Text(
                              'name des Consumables',
                              // consumables[index].name,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColor.kLightLabelColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              '${consumables![j].amount} ', //${consumables[index].unitTypeName}
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColor.kLightLabelColor),
                            ),
                          ),
                        ],
                      );
                    }),
                  )
                : Text('Keine Materialien gefunden',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColor.kLightLabelColor)),
          )
        ],
      ),
    );
  }

  Widget _showProjectDocumentation() {
    final project = widget.project;
    return GestureDetector(
      child: Container(
        height: 20,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColor.kTextfieldBorder)),
        ),
        child: Text('Dokumentation', style: Theme.of(context).textTheme.bodyMedium),
      ),
      onTap: () {
        ref
            .read(projectVMProvider.notifier)
            .loadDocumentationForProject(
              project.projectID,
            )
            .then(
          (value) {
            return showDialog(
              context: context,
              builder: (context) => ShowProjectDocumentation(value: value),
            );
          },
        );
      },
    );
  }
}
