import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/provider/doku_provider/time_provider.dart';
import 'package:handwerker_app/view/widgets/hinged_widget.dart';

class HistoryTimeBody extends ConsumerWidget {
  const HistoryTimeBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeEntries = ref.watch(timeEntryProvider);
    if (timeEntries.isEmpty) {
      ref.read(timeEntryProvider.notifier).loadEntrys();
    }
    final workdays = ref.read(timeEntryProvider.notifier).getListOfWorkdays();
    return Padding(
      padding: const EdgeInsets.all(10),
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
          for (var work in workdays)
            HingedWidget(
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
    );
  }
}
