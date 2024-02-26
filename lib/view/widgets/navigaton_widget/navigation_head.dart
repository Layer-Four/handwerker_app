import 'package:flutter/material.dart';

class NavigationIcon extends StatelessWidget {
  final String title;
  final bool isCurrent;
  const NavigationIcon({
    super.key,
    required this.title,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            title,
            style: isCurrent
                ? const TextStyle(color: Colors.orange, fontSize: 17)
                : const TextStyle(fontSize: 17),
          ),
          isCurrent
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  width: 25,
                  decoration: BoxDecoration(border: Border.all(width: 1.5, color: Colors.orange)),
                )
              : const SizedBox()
        ],
      );
}
