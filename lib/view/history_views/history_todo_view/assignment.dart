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
  final List<TimeEntriesVM> todos = List.generate(
    5,
    (index) => TimeEntriesVM(
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
      userID: 'Hallo123Welt456',
    ),
  );
  final List<TimeEntriesVM> berichte = List.generate(
    5,
    (index) => TimeEntriesVM(
      customerName: 'berichte',
      date: DateTime(2024, 06, index + 1),
      startTime: DateTime(2024, 06, index, 8),
      endTime: DateTime(2024, 06, index, 16, 30),
      duration: (DateTime(2024, 06, index, 16, 30).millisecondsSinceEpoch -
              DateTime(2024, 06, index, 8).millisecondsSinceEpoch) ~/
          60000,
      serviceID: 5,
      type: TimeEntryType.timeEntry,
      serviceTitle: 'serviceTitle',
      projectID: 15,
      userID: 'Hallo123Welt456',
    ),
  );

  List<TimeEntriesVM> all = [];
  List<TimeEntriesVM> _choosenList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    all = [...todos, ...berichte];
    _choosenList = all.where((element) => element.type == TimeEntryType.assignment).toList();
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                  _isFilteredForTimeEntries == false ? 'Aufträge' : 'Berichte',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(8),
                  elevation: 7,
                  child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                        child: Text(
                          _isFilteredForTimeEntries == false ? 'Aufträge' : 'Berichte',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _isFilteredForTimeEntries = !_isFilteredForTimeEntries;
                          if (_isFilteredForTimeEntries) {
                            setState(() {
                              _choosenList = all
                                  .where((element) => element.type == TimeEntryType.timeEntry)
                                  .toList();
                            });
                          } else {
                            setState(() {
                              _choosenList = all
                                  .where((element) => element.type == TimeEntryType.assignment)
                                  .toList();
                            });
                          }
                        });
                      }),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _choosenList.length,
                itemBuilder: (context, int j) {
                  final selected = _choosenList[j];
                  return HingedWidget(
                    alterHeader: Container(
                      padding: EdgeInsets.all(6),
                      color: Colors.amber,
                    ),
                    // TODO: need a variable for is open and transist to other view
                    contentLength: 2,
                    header: _buildHeadLine(
                        selected.date, selected.customerName.toString(), selected.duration ?? 100),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // for (var work in project.timeViewModels)
                        SizedBox(
                          height: 180,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    '${selected.date.day < 10 ? "0${selected.date.day}" : selected.date.day}.${selected.date.month < 10 ? "0${selected.date.month}" : selected.date.month}-${selected.endTime!.day < 10 ? "0${selected.endTime!.day}" : selected.endTime!.day}.${selected.endTime!.month < 10 ? "0${selected.endTime!.month}" : selected.endTime!.month}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(color: AppColor.kTextfieldBorder),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    selected.serviceTitle ?? 'kein Service ausgewählt',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(color: AppColor.kTextfieldBorder),
                                  ),
                                ),
                                SizedBox(
                                  child: Text(
                                    '${selected.getDurationInHours()} Stunden',
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
                        // ProjectDetails(project: project),
                      ],
                    ),
                  );
                }),
          ),
          // ! old version
          //!   ListView.builder(
          //!     shrinkWrap: true,
          //!     itemCount: dates.length,
          //!     itemBuilder: (BuildContext context, i) {
          //!       final date = dates[i];
          //!       final dateString = '${date.day}.${date.month}.${date.year}';
          //!       return Column(
          //!         crossAxisAlignment: CrossAxisAlignment.start,
          //!         children: [
          //!           Padding(
          //!             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          //!             child: Text(dateString),
          //!           ),
          //!           SizedBox(
          //!             height: MediaQuery.of(context).size.height -
          //!                 (MediaQuery.of(context).size.height / 10 * 7),
          //!             child: _todoCardBuilder(choosenList),
          //!           ),
          //!         ],
          //!       );
          //!     },
          //!   ),
          //! ),
          // _buildCustomerOverviewHeadLine(),
          // _buildAsyncProjectOverview(),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: LogoWidget(assetString: 'assets/images/img_techtool.png'),
          ),
        ],
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

  Row _buildHeadLine(DateTime date, String customer, int duration) {
    final dateString = '${date.day}.${date.month},${date.year}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            customer,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            dateString,
            style: Theme.of(context).textTheme.labelMedium,
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
  //               // for (var work in project.timeViewModels)
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
  //                               .copyWith(color: AppColor.kTextfieldBorder),
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
  //                               .copyWith(color: AppColor.kTextfieldBorder),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         child: Text(
  //                           '${selected.getDurationInHours()} Stunden',
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .labelMedium!
  //                               .copyWith(color: AppColor.kTextfieldBorder),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               // ProjectDetails(project: project),
  //             ],
  //           ),
  //         );
  //       });
  // }
}
