import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/apptheme/app_colors.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final DateTime initDate;
  final String? hintText;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final String? title;
  final TextStyle? titleStyle;
  final bool isFilled;
  final BoxDecoration? decoration;
  const CustomDatePicker({
    super.key,
    required this.controller,
    required this.initDate,
    this.decoration,
    this.isFilled = false,
    this.height,
    this.hintText,
    this.padding,
    this.title,
    this.titleStyle,
    this.width,
  });
  @override
  Widget build(BuildContext context) => SizedBox(
        width: width ??
            (MediaQuery.of(context).size.width > 950
                ? 300
                : MediaQuery.of(context).size.width * 0.35),
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      title!,
                      style: titleStyle ??
                          Theme.of(context).textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
            Container(
              padding: padding,
              decoration: decoration,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  filled: isFilled,
                  fillColor: AppColor.kTextfieldColor,
                  hintText: hintText,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now().add(const Duration(days: -(5 * 365))),
                    initialDate: initDate,
                    lastDate: DateTime.now().add(const Duration(days: (10 * 365))),
                  );
                  if (date != null) {
                    controller.text = DateFormat('d.M.y').format(date);
                  }
                  return;
                },
              ),
            ),
          ],
        ),
      );
}
