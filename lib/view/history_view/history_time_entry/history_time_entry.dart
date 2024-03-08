import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/models/testmodel.dart';

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
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${work.head.day}.${work.head.month}.${work.head.year}'),
                      Text('${work.sum} Stunden'),
                    ]),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var service in work.works) Text(service),
                ],
              ),
            )
        ],
      ),
    );
  }
}

class HingedWidget extends StatefulWidget {
  final Widget header;
  final Column content;

  const HingedWidget({
    super.key,
    required this.header,
    required this.content,
  });

  @override
  State<HingedWidget> createState() => _HingedWidgetState();
}

class _HingedWidgetState extends State<HingedWidget> {
  bool _isOpen = false;
  // final double _collapsedHeight = 50.0; // Adjust this based on your content

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width - 20,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeInOutCubic,
      height: _isOpen ? 140 : 60,
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
                  secondChild: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      width: MediaQuery.of(context).size.width - 30,
                      child: widget.content),
                  crossFadeState: _isOpen
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final workAccount = [
  TestModel(
    head: DateTime(2022, 5, 15),
    sum: 12,
    works: [
      'Fensterausbau  4h',
      'Fensterrahmen  4h',
      'Fenstereinbau  4h',
    ],
  ),
  TestModel(
    head: DateTime(2022, 7, 37),
    sum: 8,
    works: [
      'Fensterausbau  2h',
      'Fensterrahmen  2h',
      'Fenstereinbau  4h',
    ],
  ),
  TestModel(
    head: DateTime(1990, 3, 7),
    sum: 2,
    works: [
      'Fensterausbau  2h',
    ],
  ),
  TestModel(
    head: DateTime(2022, 5, 15),
    sum: 9,
    works: [
      'Fundament vorbereiten  4h',
      'Ring Anker mauern  4h',
      'Gutachten mit Bier  1h',
    ],
  ),
  TestModel(
    head: DateTime(2024, 2, 25),
    sum: 7,
    works: [
      'Haus Reinigung  3h',
      'Fenster putzen  1h',
      'Straße fegen  3h',
    ],
  ),
];
