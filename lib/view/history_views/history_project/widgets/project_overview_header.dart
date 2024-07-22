import 'package:flutter/material.dart';

class ProjectOverviewHeader extends StatelessWidget {
  final String title;
  const ProjectOverviewHeader({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      );
}
