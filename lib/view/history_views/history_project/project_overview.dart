import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_customer_vm/project_customer.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_overview.dart';
import 'package:handwerker_app/provider/doku_provider/project_provider.dart';
import 'package:handwerker_app/provider/language_provider/language_provider.dart';
import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/labeld_textfield.dart';

class CostumerOverviewBody extends StatelessWidget {
  const CostumerOverviewBody({super.key});
  @override
  Widget build(context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Text(
                    'KUNDEN ÜBERSICHT',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                _buildAsyncProjectOverview(context),
                // Center(
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 20, bottom: 20),
                //     child: Image.asset(
                //       'assets/images/img_techtool.png',
                //       height: 20,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      );

  Widget _buildAsyncProjectOverview(BuildContext context) =>
      Consumer(builder: (context, ref, child) {
        final futureProjects = ref.read(projectProvider.notifier).getAllProjectEntries();
        return FutureBuilder<List<ProjectCustomer?>>(
            future: futureProjects,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                log((snapshot.data.toString()));
                final customerProjectList = snapshot.data;
                return SizedBox(
                  // height: 500,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: customerProjectList!
                        .map((e) => ListView.builder(
                            shrinkWrap: true,
                            itemCount: customerProjectList.length,
                            itemBuilder: (BuildContext context, i) {
                              final customer = customerProjectList[i];
                              return SizedBox(
                                height: MediaQuery.of(context).size.height - 250,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                      child: Text(customer?.customer ?? 'Kein Kunde??'),
                                    ),
                                    SizedBox(height: 400, child: _buildProjectDetails(customer)),
                                  ],
                                ),
                              );
                            }))
                        .toList(),
                  ),
                );
              }
              return const SizedBox(
                height: 400,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            });
      });

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
                            width: 100,
                            child: Text(
                              '${work.start!.day < 10 ? "0${work.start!.day}" : work.start!.day}.${work.start!.month < 10 ? "0${work.start!.month}" : work.start!.month}.${work.start!.year}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: AppColor.kTextfieldBorder),
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: Text(
                              work.servciceName!,
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
                // ProjectCard(project),
              ],
            ),
          );
        });
  }

  Row _buildHeadLine(ProjectOverview j, BuildContext context) {
    final initDate = '${j.projectCreated.day}.${j.projectCreated.month}.${j.projectCreated.year}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            j!.projectName,
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

class ProjectCard extends ConsumerStatefulWidget {
  final ProjectOverview project;
  const ProjectCard(this.project, {super.key});

  @override
  ConsumerState<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends ConsumerState<ProjectCard> {
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 220,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: LabeledInputWidget(
              label: ref.watch(languangeProvider).description,
              child: SizedBox(
                height: 60,
                child: TextField(
                  cursorHeight: 20,
                  controller: _descriptionController,
                  textAlignVertical: TextAlignVertical.top,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                  decoration: Utilits.textFieldDecorator(context),
                  onChanged: (value) {
                    setState(() {
                      _descriptionController.text = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/projekt_screen.png',
              height: 150,
              width: 150,
            ),
            SizedBox(
              height: 35,
              width: 90,
              child: SymmetricButton(
                color: AppColor.kPrimaryButtonColor,
                text: 'Ändern',
                onPressed: () {
                  // ref.read(projectProvider.notifier).updateProjectOverView(widget.project).then(
                  //     (value) =>
                  //         value ? ref.read(projectProvider.notifier).getAllProjectEntries() : null);
                  log('dies ist ein Text oder ist er fürs Löschen?');
                },
              ),
            )
          ],
        ),
      ],
    );
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

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width - 20,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOutCubic,
      height: _isOpen ? (280 + (widget.contentLength * 50)) : 60,
      child: InkWell(
        onTap: () => setState(() => _isOpen = !_isOpen),
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
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 100),
                  firstChild: const SizedBox.shrink(),
                  secondChild: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      width: MediaQuery.of(context).size.width - 30,
                      child: widget.content),
                  crossFadeState: _isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
