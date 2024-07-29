import 'package:flutter/material.dart';

import '../../constants/apptheme/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration? inputDecoration;
  final BoxDecoration? decoration;
  final String? hintText;
  final double? textfieldHeight;
  final Icon? suffixIcon;
  final bool isFilled;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(PointerDownEvent)? onTapOutside;

  ///  If A title is given than show Text Widget with Padding.
  final String? title;

  ///  When Custom TextStyle is given than override Default TextTheme.
  final TextStyle? titleStyle;

  /// Change Default dynamic height of the whole Widget.
  final double? widgetHeight;

  /// Change Default dynamic width of the whole Widget.
  final double? widgetWidth;

  /// In default set MaxLine parameter to 1 when set true is set maxLine to null.
  /// this make the textfield multiline accectable.
  final bool isMultiLine;
  final bool readOnly;

  const CustomTextfield({
    super.key,
    required this.controller,
    this.inputDecoration,
    this.onTapOutside,
    this.onEditingComplete,
    this.decoration,
    this.hintText,
    this.isFilled = false,
    this.isMultiLine = false,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
    this.title,
    this.textfieldHeight,
    this.titleStyle,
    this.widgetHeight,
    this.widgetWidth,
  });
  @override
  Widget build(BuildContext context) => SizedBox(
        width: widgetWidth ??
            (MediaQuery.of(context).size.width > 950
                ? 300
                : MediaQuery.of(context).size.width * 0.35),
        height: widgetHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            title != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      title!,
                      style: titleStyle ??
                          Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                    ),
                  )
                : const SizedBox.shrink(),
            Container(
              decoration: decoration,
              height: textfieldHeight,
              child: TextField(
                readOnly: readOnly,
                expands: textfieldHeight == null ? false : true,
                controller: controller,
                maxLines: isMultiLine ? null : 1,
                textInputAction: isMultiLine ? TextInputAction.newline : TextInputAction.next,
                decoration: inputDecoration ??
                    InputDecoration(
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
                      suffixIcon: suffixIcon,
                    ),
                onTap: onTap,
                onTapOutside: onTapOutside,
                onEditingComplete: onEditingComplete,
              ),
            ),
          ],
        ),
      );
}
