import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/project_vm/project.dart';
import 'package:handwerker_app/models/work_vm.dart';
import 'package:handwerker_app/provider/language_provider/language_provider.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/labeld_textfield.dart';

class HistoryProjectBody extends ConsumerWidget {
  const HistoryProjectBody({super.key});
  @override
  Widget build(context, ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Text(
              'PROJEKT ÜBERSICHT',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          SizedBox(
            // height: projects.length * 500,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (BuildContext context, i) {
                  final j = projects[i];
                  return LargeHingedWidget(
                    //? Header
                    header: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            j.name ?? 'Kunde unbenannt',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            '${j.createDate.day}.${j.createDate.month}.${j.createDate.year}',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        )
                      ],
                    ),
                    //? Header
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var work in workEntry.where((k) => k.projectID == j.name))
                          SizedBox(
                            height: 18,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    child: Text(
                                      '${work.date.day}.${work.date.month}.${work.date.year}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(color: AppColor.kTextfieldBorder),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      work.work,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(color: AppColor.kTextfieldBorder),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Text(
                                      '${work.duration ~/ 60} Stunden',
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
                        const ProjectCard(),
                      ],
                    ),
                  );
                }),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 70, bottom: 20),
              child: Image.asset(
                'assets/images/img_techtool.png',
                height: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProjectCard extends ConsumerStatefulWidget {
  const ProjectCard({super.key});

  @override
  ConsumerState<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends ConsumerState<ProjectCard> {
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
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
        Image.asset(
          'assets/images/projekt_screen.png',
          height: 180,
          width: 180,
        ),
      ],
    );
  }
}

final projects = [
  Project(
    name: 'Sternburger Abc',
    createDate: DateTime(2022, 05, 04),
  ),
  Project(
    name: 'Layer Four Def',
    createDate: DateTime(2022, 01, 04),
  ),
  Project(
    name: 'Tech Ghi',
    createDate: DateTime(2022, 10, 04),
  ),
];
final workEntry = [
  WorkVM(
      duration: 240,
      date: DateTime(2022, 5, 15),
      projectID: 'Sternburger Abc',
      work: 'Fensterausbau'),
  WorkVM(
      duration: 240,
      date: DateTime(2022, 5, 15),
      projectID: 'Layer Four Def',
      work: 'Fensterrahmen'),
  WorkVM(
    duration: 60,
    date: DateTime(2022, 5, 15),
    projectID: 'Tech Ghi',
    work: 'Fenstereinbau',
  ),
  WorkVM(
      duration: 120,
      date: DateTime(2022, 7, 37),
      projectID: 'Sternburger Abc',
      work: 'Fensterausbau'),
  WorkVM(
      duration: 120,
      date: DateTime(2022, 7, 37),
      projectID: 'Layer Four Def',
      work: 'Fensterrahmen'),
  WorkVM(
    duration: 240,
    date: DateTime(2022, 7, 37),
    projectID: 'Tech Ghi',
    work: 'Fenstereinbau',
  ),
  WorkVM(
      duration: 120,
      date: DateTime(1990, 3, 7),
      projectID: 'Sternburger Abc',
      work: 'Fensterausbau'),
  WorkVM(
      duration: 240,
      date: DateTime(2022, 5, 15),
      projectID: 'Layer Four Def',
      work: 'Fundament vorbereiten'),
  WorkVM(
    duration: 240,
    date: DateTime(2022, 5, 15),
    projectID: 'Tech Ghi',
    work: 'Ring Anker mauern',
  ),
  WorkVM(
      duration: 180,
      date: DateTime(2024, 2, 25),
      projectID: 'Sternburger Abc',
      work: 'Haus Reinigung '),
  WorkVM(
      duration: 60,
      date: DateTime(2024, 2, 25),
      projectID: 'Layer Four Def',
      work: 'Fenster putzen'),
  WorkVM(
    duration: 180,
    date: DateTime(2024, 2, 25),
    projectID: 'Tech Ghi',
    work: 'Straße fegen',
  ),
];

class LargeHingedWidget extends StatefulWidget {
  final Widget header;
  final Column content;

  const LargeHingedWidget({
    super.key,
    required this.header,
    required this.content,
  });

  @override
  State<LargeHingedWidget> createState() => _LargeHingedState();
}

class _LargeHingedState extends State<LargeHingedWidget> {
  bool _isOpen = false;
  // final double _collapsedHeight = 50.0; // Adjust this based on your content

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width - 20,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeInOutCubic,
      height: _isOpen ? 400 : 60,
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
                  duration: const Duration(milliseconds: 200),
                  firstChild: const SizedBox.shrink(),
                  secondChild: SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        width: MediaQuery.of(context).size.width - 30,
                        child: widget.content),
                  ),
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
