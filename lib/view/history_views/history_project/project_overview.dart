import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_customer_vm/project_customer.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_overview.dart';
import 'package:handwerker_app/provider/doku_provider/project_provider.dart';
import 'package:handwerker_app/view/widgets/empty_result_message.dart';

class CostumerOverviewBody extends StatelessWidget {
  const CostumerOverviewBody({super.key});
  @override
  Widget build(context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            // TODO: delete headline "Kunde Übersicht"???
            _buildCustomerOverviewHeadLin(context),
            _buildAsyncProjectOverview(),
            _buildLogo()
          ],
        ),
      );

  Widget _buildAsyncProjectOverview() => Consumer(builder: (context, ref, child) {
        Future<List<ProjectCustomer>> futureProjects;
        futureProjects = ref.read(projectProvider.notifier).getAllProjectEntries();
        return FutureBuilder<List<ProjectCustomer?>>(
            future: futureProjects,
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
                              child: _buildProjectDetails(customer)),
                        ],
                      );
                    },
                  ),
                );
              }
              return const SizedBox(
                height: 400,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            });
      });

  Widget _buildCustomerOverviewHeadLin(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Text(
          'ÜBERSICHT',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }

  Row _buildHeadLine(ProjectOverview j, BuildContext context) {
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

  Padding _buildLogo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Image.asset(
          'assets/images/img_techtool.png',
          height: 20,
        ),
      ),
    );
  }

  ListView _buildProjectDetails(ProjectCustomer? customer) {
    return ListView.builder(
        itemCount: customer?.projects.length,
        itemBuilder: (context, int j) {
          final project = customer?.projects[j];
          return LargeHingedWidget(
            contentLength: project!.timeViewModels.length,
            header: _buildHeadLine(project, context),
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
                            width: 90,
                            child: Text(
                              '${work.start.day < 10 ? "0${work.start.day}" : work.start.day}.${work.start.month < 10 ? "0${work.start.month}" : work.start.month}.${work.start.year}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: AppColor.kTextfieldBorder),
                            ),
                          ),
                          SizedBox(
                            width: 140,
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
                // TODO: ask for, project, all entries need own update card
                ProjectDetails(project),
              ],
            ),
          );
        });
  }
}

class LargeHingedWidget extends StatefulWidget {
  final Widget header;
  final Column content;
  final int contentLength;

  const LargeHingedWidget({
    super.key,
    required this.header,
    required this.content,
    required this.contentLength,
  });

  @override
  State<LargeHingedWidget> createState() => _LargeHingedState();
}

class _LargeHingedState extends State<LargeHingedWidget> {
  bool _isOpen = false;
  bool _openContent = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width - 20,
      duration: const Duration(milliseconds: 100),
      // curve: Curves.linear,
      height: _isOpen ? (250 + (widget.contentLength * 25)) : 60,
      onEnd: () => setState(() {
        if (_isOpen) {
          if (!_openContent) {
            _openContent = true;
          }
        }
      }),
      child: GestureDetector(
        onTap: () => setState(() {
          if (_isOpen) {
            _openContent = false;
          }
          _isOpen = !_isOpen;
        }),
        child: Card(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.kWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 90,
                      child: widget.header,
                    ),
                    Icon(
                      _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      size: 40,
                    ),
                  ],
                ),
                _openContent
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        width: MediaQuery.of(context).size.width - 30,
                        child: widget.content)
                    : const SizedBox.shrink(),
                // AnimatedCrossFade(
                //   sizeCurve: Curves.easeIn,
                //   secondCurve: Curves.ease,
                //   firstCurve: Curves.easeIn,
                //   duration: const Duration(milliseconds: 1000),
                //   firstChild: const SizedBox(),
                //   secondChild: Container(
                //       padding: const EdgeInsets.symmetric(horizontal: 12),
                //       width: MediaQuery.of(context).size.width - 30,
                //       child: widget.content),
                //   crossFadeState: _isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectDetails extends ConsumerStatefulWidget {
  final ProjectOverview project;
  const ProjectDetails(this.project, {super.key});

  @override
  ConsumerState<ProjectDetails> createState() => _ProjectCardState();
}

class _ProjectCardState extends ConsumerState<ProjectDetails> {
  final consumables = [
    const Consumable(name: 'Bottle of Beer', amount: 99, unitTypeName: 'Stück'),
    const Consumable(name: 'Bottle of Wine', amount: 98, unitTypeName: 'Meter'),
    const Consumable(name: 'Bottle if Rum', amount: 97, unitTypeName: 'Kilo'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      height: 216,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: _showProjectDocumentation(context),
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
                          consumables[index].name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColor.kTextfieldBorder),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          '${consumables[index].amount} ${consumables[index].unitTypeName}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColor.kTextfieldBorder),
                        ),
                      ),
                    ],
                  );
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [Text('${consumables[index]}')],
                  // );
                })),
          )
        ],
      ),
    );
  }

  Widget _showProjectDocumentation(BuildContext context) {
    return InkWell(
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColor.kTextfieldBorder)),
        ),
        child: Text('Dokumentation', style: Theme.of(context).textTheme.bodyMedium),
      ),
      onTap: () => showDialog(
          context: context,
          builder: (context) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 150),
                child: const Material(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text('Dokumentations details'),
                        ),
                      ),
                      SizedBox(
                          width: 200,
                          height: 200,
                          child: Center(
                            child: Text('Hier könnte ihr Bild sein'),
                          ))
                      // TODO: by multiple file's maybe open in CaruselSlider
                      // Image.file(_writeFile()),
                    ],
                  ),
                ),
              )),
    );
  }

  //  TODO: get image source from Documentation and convert it to a file for Image.file
  File _writeFile() {
    return File('');
  }
}
