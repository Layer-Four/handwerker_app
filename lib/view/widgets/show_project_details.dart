import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';
import 'package:handwerker_app/models/dokumentation_models/docmentation_dm/documentation_dm.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_overview.dart';
import 'package:handwerker_app/provider/doku_provider/project_vm_provider.dart';

class ProjectDetails extends ConsumerStatefulWidget {
  final ProjectOverview project;
  const ProjectDetails({super.key, required this.project});

  @override
  ConsumerState<ProjectDetails> createState() => _ProjectCardState();
}

class _ProjectCardState extends ConsumerState<ProjectDetails> {
  int currentIndex = 0;
  // TODO: overthinking API for consumables
  final consumables = [
    const Consumable(),
    // const Consumable(name: 'Bottle of Beer', amount: 99, unitTypeName: 'Stück'),
    const Consumable(),
    // const Consumable(name: 'Bottle of Wine', amount: 98, unitTypeName: 'Meter'),
    const Consumable(),
    // const Consumable(name: 'Bottle if Rum', amount: 97, unitTypeName: 'Kilo'),
  ];

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
            child: ListView.builder(
              itemCount: consumables.length,
              itemBuilder: ((context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 220,
                      child: Text(
                        'name des Consumables',
                        // consumables[index].name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColor.kTextfieldBorder),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        '${consumables[index].amount} ', //${consumables[index].unitTypeName}
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColor.kTextfieldBorder),
                      ),
                    ),
                  ],
                );
              }),
            ),
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
        decoration: BoxDecoration(
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

class ShowProjectDocumentation extends StatefulWidget {
  final List<DocumentationDM>? value;
  const ShowProjectDocumentation({super.key, required this.value});

  @override
  State<ShowProjectDocumentation> createState() => _ShowProjectDocumentationState();
}

class _ShowProjectDocumentationState extends State<ShowProjectDocumentation> {
  int currentIndex = 0;
  late final List<DocumentationDM>? value;
  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.value;
    });
  }

  @override
  Widget build(context) => (value == null || value!.isEmpty)
      ? const SizedBox.expand(
          child: Center(
            child: Text('keine Dokumentationen gefunden'),
          ),
        )
      : Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: Material(
            child: Expanded(
              child: ListView.builder(
                  itemCount: value!.length,
                  itemBuilder: (context, index) {
                    List<Image> image =
                        value![index].imagesUrl.map((e) => Image.network(e)).toList();
                    return Container(
                      margin: const EdgeInsets.all(0.2),
                      decoration:
                          BoxDecoration(border: Border.all(color: AppColor.kTextfieldBorder)),
                      height: image.isEmpty ? 65 : 210,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            value![index].description ?? 'Keine Beschreibung',
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          image.isEmpty
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CarouselSlider.builder(
                                    itemCount: image.length,
                                    itemBuilder: (context, i, _) => image[i],
                                    options: CarouselOptions(
                                      viewportFraction: 1,
                                      height: 150,
                                      enableInfiniteScroll: false,
                                      // enlargeCenterPage: true,
                                      onPageChanged: (index, _) =>
                                          setState(() => currentIndex = index),
                                    ),
                                  ),
                                ),
                          image.length > 1
                              ? Utilits.buildIndicator(
                                  selectedIndex: currentIndex,
                                  length: image.length,
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        );
}
