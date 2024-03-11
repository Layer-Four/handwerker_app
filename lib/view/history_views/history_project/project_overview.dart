import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/project_vm/project.dart';
import 'package:handwerker_app/models/time_entry/time_entry.dart';
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
                            j.customerName,
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
                        for (var work in workEntry.where((k) => k.projectID!.toInt() == i))
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
                                      services[work.serviceID!.toInt()],
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(color: AppColor.kTextfieldBorder),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Text(
                                      '${work.duration != null ? work.duration! ~/ 60 : 0} Stunden',
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
              padding: const EdgeInsets.only(top: 70, bottom: 20),
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
    customerName: 'Sternburger Abc',
    projectID: BigInt.from(0),
    createDate: DateTime(2022, 05, 04),
    customerID: BigInt.from(0),
  ),
  Project(
    customerID: BigInt.from(1),
    customerName: 'Layer Four Def',
    projectID: BigInt.from(1),
    createDate: DateTime(2022, 01, 04),
  ),
  Project(
    customerName: 'Tech Ghi',
    customerID: BigInt.from(2),
    projectID: BigInt.from(2),
    createDate: DateTime(2022, 10, 04),
  ),
];
final services = [
  'Fensterausbau',
  'Fensterrahmen',
  'Fenstereinbau',
  'Fundament vorbereiten',
  'Ring Anker mauern',
  'Haus Reinigung',
  'Fenster putzen',
  'Straße fegen',
];
final workEntry = [
  TimeEntry(
    duration: 240,
    date: DateTime(2022, 5, 15),
    startTime: DateTime(2022, 5, 15, 08),
    endTime: DateTime(2022, 5, 15, 12),
    projectID: BigInt.from(0),
    serviceID: BigInt.from(0),
  ),
  TimeEntry(
    duration: 240,
    date: DateTime(2022, 5, 15),
    startTime: DateTime(2022, 5, 15, 12),
    endTime: DateTime(2022, 5, 15, 16),
    projectID: BigInt.from(1),
    serviceID: BigInt.from(1),
  ),
  TimeEntry(
    duration: 60,
    date: DateTime(2022, 5, 15),
    startTime: DateTime(2022, 5, 15, 16, 30),
    endTime: DateTime(2022, 5, 15, 17, 30),
    projectID: BigInt.from(2),
    serviceID: BigInt.from(2),
  ),
  TimeEntry(
    duration: 120,
    date: DateTime(2022, 7, 37),
    startTime: DateTime(2022, 7, 37, 7),
    endTime: DateTime(2022, 7, 37, 9),
    projectID: BigInt.from(0),
    serviceID: BigInt.from(0),
  ),
  TimeEntry(
    duration: 120,
    date: DateTime(2022, 7, 37),
    startTime: DateTime(2022, 7, 37, 9),
    endTime: DateTime(2022, 7, 37, 11),
    projectID: BigInt.from(1),
    serviceID: BigInt.from(1),
  ),
  TimeEntry(
    duration: 240,
    date: DateTime(2022, 7, 37),
    startTime: DateTime(2022, 7, 37, 11),
    pauseStart: DateTime(2022, 7, 37, 13),
    pauseEnd: DateTime(2022, 7, 37, 13, 30),
    endTime: DateTime(2022, 7, 37, 15, 30),
    projectID: BigInt.from(2),
    serviceID: BigInt.from(3),
  ),
  TimeEntry(
    duration: 120,
    date: DateTime(1990, 3, 7),
    startTime: DateTime(1990, 3, 7, 10),
    endTime: DateTime(1990, 3, 7, 12),
    projectID: BigInt.from(0),
    serviceID: BigInt.from(0),
  ),
  TimeEntry(
    duration: 240,
    date: DateTime(2020, 5, 15),
    startTime: DateTime(2020, 5, 15, 7),
    endTime: DateTime(2020, 5, 15, 11),
    projectID: BigInt.from(1),
    serviceID: BigInt.from(3),
  ),
  TimeEntry(
    duration: 240,
    date: DateTime(2020, 5, 15),
    startTime: DateTime(2020, 5, 15, 11),
    endTime: DateTime(2020, 5, 15, 15, 30),
    pauseStart: DateTime(2020, 5, 15, 13),
    pauseEnd: DateTime(2020, 5, 15, 13, 30),
    projectID: BigInt.from(2),
    serviceID: BigInt.from(4),
  ),
  TimeEntry(
    duration: 180,
    date: DateTime(2024, 2, 25),
    startTime: DateTime(2024, 2, 25, 8),
    endTime: DateTime(2024, 2, 25, 11),
    pauseStart: DateTime(2024, 2, 25, 9, 30),
    pauseEnd: DateTime(2024, 2, 25, 10),
    projectID: BigInt.from(0),
    serviceID: BigInt.from(5),
  ),
  TimeEntry(
    duration: 60,
    date: DateTime(2024, 2, 25),
    startTime: DateTime(2024, 2, 25, 11),
    endTime: DateTime(2024, 2, 25, 12),
    projectID: BigInt.from(1),
    serviceID: BigInt.from(6),
  ),
  TimeEntry(
    duration: 180,
    date: DateTime(2024, 2, 25),
    startTime: DateTime(2024, 2, 25, 12),
    endTime: DateTime(2024, 2, 25, 15),
    projectID: BigInt.from(2),
    serviceID: BigInt.from(7),
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
