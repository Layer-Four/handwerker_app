import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';

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
          Text(title,
              style: isCurrent
                  ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColor.kPrimaryColor,
                      )
                  : Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                      )

              // : const TextStyle(fontSize: 17),
              ),
          isCurrent
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  width: 25,
                  decoration:
                      BoxDecoration(border: Border.all(width: 1.5, color: AppColor.kPrimaryColor)),
                )
              : const SizedBox()
        ],
      );
}
