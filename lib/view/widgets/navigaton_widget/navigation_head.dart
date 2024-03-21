import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';

class NavigationIcon extends StatelessWidget {
  final String title;
  final bool isCurrent;
  final bool isActiv;
  const NavigationIcon({
    super.key,
    required this.title,
    this.isCurrent = false,
    this.isActiv = true,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(title,
              style: isCurrent
                  ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColor.kPrimaryButtonColor,
                      )
                  : isActiv
                      ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                          )

                      // : const TextStyle(fontSize: 17),
                      : Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColor.kTextfieldBorder)),
          isCurrent
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  width: 25,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: AppColor.kPrimaryButtonColor)),
                )
              : const SizedBox(height: 11)
        ],
      );
}
