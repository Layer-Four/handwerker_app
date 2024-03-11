import 'package:flutter/material.dart';
import 'package:handwerker_app/view/widgets/hinged_widget.dart';

class HistoryTimeBody extends StatelessWidget {
  const HistoryTimeBody({super.key});

  @override
  Widget build(BuildContext context) {
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
          for (var work in workAccount)
            HingedWidget(
              header: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('${work.date.day}.${work.date.month}.${work.date.year}'),
                  Text('${work.sum} Stunden'),
                ]),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [for (var service in work.works) Text(service)],
              ),
            )
        ],
      ),
    );
  }
}

class WorkDay {
  final DateTime date;
  final List<String> works;
  final int sum;
  const WorkDay({
    required this.date,
    required this.sum,
    required this.works,
  });
}

final workAccount = [
  WorkDay(
    date: DateTime(2022, 5, 15),
    sum: 12,
    works: [
      'Fensterausbau  4h',
      'Fensterrahmen  4h',
      'Fenstereinbau  4h',
    ],
  ),
  WorkDay(
    date: DateTime(2022, 5, 15),
    sum: 12,
    works: [
      'Fensterausbau  4h',
      'Fensterrahmen  4h',
      'Fenstereinbau  4h',
    ],
  ),
];
