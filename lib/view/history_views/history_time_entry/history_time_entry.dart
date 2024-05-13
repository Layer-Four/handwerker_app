import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/models/time_models/workday_models/workday_vm.dart';
import 'package:handwerker_app/provider/doku_provider/time_provider.dart';
import 'package:handwerker_app/view/widgets/empty_result_message.dart';
import 'package:handwerker_app/view/widgets/hinged_widget.dart';

class HistoryTimeBody extends ConsumerWidget {
  const HistoryTimeBody({super.key});

  Future<List<Workday?>> listOfWorkDays(WidgetRef ref) async {
    final workdays = await ref.read(timeEntryProvider.notifier).getListOfWorkdays();
    return workdays;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final timeEntries = ref.watch(timeEntryProvider);
    // if (timeEntries.isEmpty) {
    // ref.read(timeEntryProvider.notifier).loadtimeTracks();
    // }
    // final workdays = ref.read(timeEntryProvider.notifier).getListOfWorkdays();

    // if (workdays.isEmpty) {
    //   return const ShowEmptyMessage();
    // }
    return FutureBuilder(
        future: listOfWorkDays(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShowEmptyMessage(message: 'Lade...');
          }
          if (snapshot.hasError) {
            return ShowEmptyMessage(
              message: snapshot.error.toString(),
            );
          }
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const ShowEmptyMessage();
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'TAG',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                  for (var work in snapshot.data!)
                    HingedWidget(
                      basicHeigth: 50,
                      contentLength: work!.timeEntries.length,
                      header: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(' ${work.date.day}.${work.date.month}.${work.date.year}'),
                          Text((work.getSumOfToday())),
                        ]),
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var e in work.timeEntries)
                            Row(
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(e.serviceTitle ?? ''),
                                ),
                                Text(' ${e.getDurationInHours()} Stunden')
                              ],
                            )
                        ],
                      ),
                    )
                ],
              ),
            ),
          );
        });
  }
}
