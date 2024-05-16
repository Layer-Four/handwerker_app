import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/models/time_models/time_entries_vm/time_entries_vm.dart';
import 'package:handwerker_app/provider/settings_provider/language_provider.dart';
import 'package:handwerker_app/view/widgets/hinged_widget.dart';
import 'package:handwerker_app/view/widgets/logo_widget.dart';

class AssignmentViewBody extends ConsumerStatefulWidget {
  const AssignmentViewBody({super.key});

  @override
  ConsumerState<AssignmentViewBody> createState() => _AssignmentViewBodyState();
}

class _AssignmentViewBodyState extends ConsumerState<AssignmentViewBody> {
  bool _isFilteredForTimeEntries = false;
  final List<DateTime> dates = List.generate(2, (index) => DateTime(2024, 06, index + 1));
  final List<TimeEntriesVM> entries = List.generate(
    10,
    (index) {
      if (index < 5) {
        return TimeEntriesVM(
            customerName: 'Kundenname',
            date: DateTime(2024, 06, index + 1),
            startTime: DateTime(2024, 06, index, 8),
            endTime: DateTime(2024, 06, index, 16, 30),
            duration: (DateTime(2024, 06, index, 16, 30).millisecondsSinceEpoch -
                    DateTime(2024, 06, index, 8).millisecondsSinceEpoch) ~/
                60000,
            serviceID: 5,
            type: TimeEntryType.assignment,
            serviceTitle: 'serviceTitle',
            projectID: 15,
            description:
                'dies ist eine klasssische beschreibung eines Auftrags \n dies ist eine klasssische beschreibung eines Auftrags\n dies ist eine klasssische beschreibung eines Auftrags');
      } else {
        return TimeEntriesVM(
          customerName: 'berichte',
          date: DateTime(2024, 06, index + 1),
          description: 'dies ist eine klasssische beschreibung eines Berichts',
          startTime: DateTime(2024, 06, index, 8),
          endTime: DateTime(2024, 06, index, 16, 30),
          duration: (DateTime(2024, 06, index, 16, 30).millisecondsSinceEpoch -
                  DateTime(2024, 06, index, 8).millisecondsSinceEpoch) ~/
              60000,
          serviceID: 5,
          type: TimeEntryType.timeEntry,
          serviceTitle: 'serviceTitle',
          projectID: 15,
        );
      }
    },
  );
  List<TimeEntriesVM> _choosenList = [];
  @override
  void initState() {
    super.initState();
    _choosenList = entries.where((element) => element.type == TimeEntryType.assignment).toList();
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  _isFilteredForTimeEntries == false ? 'Aufträge' : 'Vergangene Aufträge',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              _buildChangeEntriesOrderButton(),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _choosenList.length,
                itemBuilder: (context, int j) {
                  final selected = _choosenList[j];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: HingedWidget(
                      alterHeader: _buildAlterCardHeadLine(selected),
                      contentLength: 3,
                      header: _buildHeadLine(selected),
                      content: AssigmentInfoCard(entry: selected),
                    ),
                  );
                }),
          ),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: LogoWidget(assetString: 'assets/images/img_techtool.png'),
          ),
        ],
      ),
    );
  }

  Padding _buildChangeEntriesOrderButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        elevation: 2,
        child: InkWell(
            child: Container(
              width: 180,
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              alignment: Alignment.center,
              child: Text(
                _isFilteredForTimeEntries ? 'Aufträge' : 'Vergangene Aufträge',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: AppColor.kLightLabelColor),
              ),
            ),
            onTap: () {
              setState(() {
                _isFilteredForTimeEntries = !_isFilteredForTimeEntries;
                if (_isFilteredForTimeEntries) {
                  setState(() {
                    _choosenList = entries
                        .where((element) => element.type == TimeEntryType.timeEntry)
                        .toList();
                  });
                } else {
                  setState(() {
                    _choosenList = entries
                        .where((element) => element.type == TimeEntryType.assignment)
                        .toList();
                  });
                }
              });
            }),
      ),
    );
  }

  // Widget _buildAsyncProjectOverview() => FutureBuilder<List<ProjectCustomer?>>(
  //     future: loadProjects(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Center(child: CircularProgressIndicator());
  //       }
  //       if (snapshot.data != null) {
  //         if (snapshot.data!.isEmpty) return const ShowEmptyMessage();
  //         final customerProjectList = snapshot.data;
  //         return Expanded(
  //           child: ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: customerProjectList!.length,
  //             itemBuilder: (BuildContext context, i) {
  //               final customer = customerProjectList[i];
  //               return Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  //                     child: Text(customer?.customer ?? 'Kein Kunde??'),
  //                   ),
  //                   SizedBox(
  //                     height: MediaQuery.of(context).size.height - 300,
  //                     child: _buildProjectDetails(customer),
  //                   ),
  //                 ],
  //               );
  //             },
  //           ),
  //         );
  //       }
  //       return const ShowEmptyMessage();
  //     });

  // Widget _buildCustomerOverviewHeadLine() {
  //   return Container(
  //     width: double.infinity,
  //     alignment: Alignment.center,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
  //       child: Text(
  //         ref.watch(languangeProvider).overView,
  //         style: Theme.of(context).textTheme.labelLarge,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildHeadLine(TimeEntriesVM e) {
    final dateString = '${e.date.day}.${e.date.month},${e.date.year}';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateString,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                '${e.getDurationInHours()} Stunden',
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${e.customerName} ',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              InkWell(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Ich werde durch ein Popup ersetzt das Kundendaten oder Auftragsdaten anzeigt'),
                        ),
                      ),
                  child: const Icon(
                    Icons.info_outline,
                    size: 16,
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Row _buildAlterCardHeadLine(TimeEntriesVM e) {
    final dateString = '${e.date.day}.${e.date.month}.${e.date.year}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${e.customerName} ',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              InkWell(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Ich werde durch ein Popup ersetzt das Kundendaten oder Auftragsdaten anzeigt'),
                        ),
                      ),
                  child: const Icon(
                    Icons.info_outline,
                    size: 16,
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            dateString,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        )
      ],
    );
  }

  // ListView _todoCardBuilder(List<TimeEntriesVM> entry) {
  //   return ListView.builder(
  //       itemCount: entry.length,
  //       itemBuilder: (context, int j) {
  //         final selected = entry[j];
  //         return HingedWidget(
  //           contentLength: 2,
  //           header: _buildHeadLine(
  //               selected.date, selected.customerName.toString(), selected.duration ?? 100),
  //           content: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  // for (var work in project.timeViewModels)
  //               SizedBox(
  //                 height: 180,
  //                 child: Padding(
  //                   padding: const EdgeInsets.symmetric(vertical: 2.0),
  //                   child: Column(
  //                     children: [
  //                       SizedBox(
  //                         width: 120,
  //                         child: Text(
  //                           '${selected.date.day < 10 ? "0${selected.date.day}" : selected.date.day}.${selected.date.month < 10 ? "0${selected.date.month}" : selected.date.month}-${selected.endTime!.day < 10 ? "0${selected.endTime!.day}" : selected.endTime!.day}.${selected.endTime!.month < 10 ? "0${selected.endTime!.month}" : selected.endTime!.month}',
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .labelMedium!
  //                               .copyWith(color: AppColor.kLightLabelColor),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: 120,
  //                         child: Text(
  //                           selected.serviceTitle ?? 'kein Service ausgewählt',
  //                           overflow: TextOverflow.ellipsis,
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .labelMedium!
  //                               .copyWith(color: AppColor.kLightLabelColor),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         child: Text(
  //                           '${selected.getDurationInHours()} Stunden',
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .labelMedium!
  //                               .copyWith(color: AppColor.kLightLabelColor),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  // ProjectDetails(project: project),
  //             ],
  //           ),
  //         );
  //       });
  // }
}

class AssigmentInfoCard extends ConsumerWidget {
  final TimeEntriesVM entry;
  const AssigmentInfoCard({
    super.key,
    required this.entry,
  });
  String getTimeString() {
    final begin = entry.startTime;
    final ende = entry.endTime;
    return '${begin?.hour != null && begin!.hour < 10 ? '0${begin.hour}' : '${begin?.hour ?? ''}'}:${begin?.minute != null && begin!.minute < 10 ? '0${begin.minute}' : '${begin?.minute ?? ''}'} - ${ende?.hour != null && ende!.hour < 10 ? '0${ende.hour}' : '${ende?.hour ?? ''}'}:${ende?.minute != null && ende!.minute < 10 ? '0${ende.minute}' : '${ende?.minute ?? ''}'}';
  }

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _labeledInput(
                    context,
                    ref.watch(languangeProvider).projectName,
                    entry.customerName,
                  ),
                  Text(
                    getTimeString(),
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColor.kPrimaryButtonColor),
                  ),
                ],
              ),
              _labeledInput(context, ref.watch(languangeProvider).service,
                  entry.serviceTitle ?? 'Kein Titel'),
              _labeldDescripction(ref, context),
            ],
          ),
        ),
      ],
    );
  }

  Padding _labeldDescripction(WidgetRef ref, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ref.watch(languangeProvider).description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColor.kLightLabelColor,
                ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColor.kTextfieldBorder,
              ),
            ),
            child: SingleChildScrollView(
              child: Text(
                entry.description ?? '',
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _labeledInput(
    BuildContext context,
    String label,
    String text, {
    double? paddingV,
    double? paddingH,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingH ?? 0, vertical: paddingV ?? 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColor.kLightLabelColor,
                  ),
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      );
}
