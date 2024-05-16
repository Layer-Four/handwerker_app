import 'dart:developer' as develop;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/models/time_models/time_entries_vm/time_entries_vm.dart';
import 'package:handwerker_app/provider/doku_provider/time_provider.dart';
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
  final List<TimeEntriesVM> entries = List.generate(5, (_) {
    final ranMonth = Random().nextInt(13);
    final ranDay = Random().nextInt(31);
    return TimeEntriesVM(
        customerName: 'Kundenname',
        date: DateTime(2024, ranMonth, ranDay),
        startTime: DateTime(2024, ranMonth, ranDay, 8),
        endTime: DateTime(2024, ranMonth, ranDay, 16, 30),
        duration: (DateTime(2024, ranMonth, ranDay, 16, 30).millisecondsSinceEpoch -
                DateTime(2024, ranMonth, ranDay, 8).millisecondsSinceEpoch) ~/
            60000,
        serviceID: 5,
        type: TimeEntryType.assignment,
        serviceTitle: 'serviceTitle',
        projectID: 15,
        description:
            'dies ist eine klasssische beschreibung eines Auftrags \n dies ist eine klasssische beschreibung eines Auftrags\n dies ist eine klasssische beschreibung eines Auftrags');
  });

  List<TimeEntriesVM> _choosenList = [];
  List<TimeEntriesVM> _allEntries = [];

  int counter = 0;
  @override
  void initState() {
    super.initState();
    ref.read(timeEntriesProvider.notifier).loadTimeEntriesVM();
    entries.sort((a, b) => a.date.compareTo(b.date));
  }

  void getTimeEntries() {
    counter++;
    develop.log('calls amout if getTimeEntries -> $counter');
    if (ref.watch(timeEntriesProvider).isEmpty) {
      Future.delayed(const Duration(milliseconds: 400)).then(
        (value) => setState(() {
          _allEntries = ref.watch(timeEntriesProvider);
          _choosenList = _allEntries.where((e) => e.type == TimeEntryType.assignment).toList();
        }),
      );
    } else {
      setState(() {
        _allEntries = ref.watch(timeEntriesProvider);
        _choosenList = _allEntries.where((e) => e.type == TimeEntryType.assignment).toList();
      });
    }
    return;
  }

  @override
  Widget build(context) {
    if (ref.watch(timeEntriesProvider).isEmpty) {
      // TODO: Talk about performence? Run this code until have resilt or set a inital delay to get a better performence!
      Future.delayed(const Duration(milliseconds: 200))
          .then((value) => WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
                getTimeEntries();
                setState(() {
                  _choosenList =
                      _allEntries.where((el) => el.type == TimeEntryType.assignment).toList();
                });
              }));
    }

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
                child: InkWell(
                  onTap: () => setState(() {
                    _allEntries.addAll(entries);
                  }),
                  child: Text(
                    _isFilteredForTimeEntries ? 'Vergangene Aufträge' : 'Aufträge',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
              _buildChangeEntriesOrderButton(),
            ],
          ),
          _choosenList.isEmpty
              ? Center(
                  child: Text(
                  '       Lade Daten oder\nkeine Einträge gefunden',
                  style: Theme.of(context).textTheme.titleLarge,
                ))
              : Expanded(
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
                    _choosenList = _allEntries
                        .where((element) => element.type == TimeEntryType.timeEntry)
                        .toList();
                    // _choosenList = ref
                    //     .watch(timeEntriesProvider)
                    //     .where((element) => element.type == TimeEntryType.timeEntry)
                    //     .toList();
                  });
                } else {
                  setState(() {
                    _choosenList = _allEntries
                        .where((element) => element.type == TimeEntryType.assignment)
                        .toList();
                    // _choosenList = ref
                    //     .watch(timeEntriesProvider)
                    //     .where((element) => element.type == TimeEntryType.assignment)
                    //     .toList();
                  });
                }
              });
            }),
      ),
    );
  }

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
    return '${begin.hour < 10 ? '0${begin.hour}' : '${begin.hour}'}:${begin.minute < 10 ? '0${begin.minute}' : '${begin.minute}'} - ${ende?.hour != null && ende!.hour < 10 ? '0${ende.hour}' : '${ende?.hour ?? ''}'}:${ende?.minute != null && ende!.minute < 10 ? '0${ende.minute}' : '${ende?.minute ?? ''}'}';
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
