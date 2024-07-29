import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/models/time_models/workday_models/workday_vm.dart';
import 'package:handwerker_app/provider/doku_provider/time_provider.dart';
import 'package:handwerker_app/view/widgets/empty_result_message.dart';
import 'package:handwerker_app/view/widgets/hinged_widget.dart';

class HistoryTimeBody extends ConsumerWidget {
  const HistoryTimeBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(timeEntriesProvider).allEntries.isEmpty) {
      ref.read(timeEntriesProvider.notifier).loadTimeEntriesVM();
    }
    final List<Workday> workdays = ref.read(timeEntriesProvider.notifier).getListOfWorkdays();

    if (workdays.isEmpty) {
      ref.read(timeEntriesProvider.notifier).loadTimeEntriesVM();
      return const ShowEmptyMessage();
    }
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'TAG',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
          // for (var work in workdays)
          Expanded(
            child: ListView.builder(
              itemCount: workdays.length,
              itemBuilder: (context, i) {
                final e = workdays[i];

                return HingedWidget(
                  basicHeigth: 50,
                  contentLength: e.entries.length,
                  header: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(' ${e.date.day}.${e.date.month}.${e.date.year}'),
                        Text(e.getSumOfToday()),
                      ],
                    ),
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var e in e.timeEntries)
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
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
