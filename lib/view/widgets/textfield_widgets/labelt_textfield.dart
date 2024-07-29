import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/utiltis.dart';

class LabeldTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String label;
  final double? heigt;
  final double? width;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final Function()? onTap;
  final Function()? onTapOutside;
  final String? hintText;
  const LabeldTextfield(
      {super.key,
      required this.label,
      this.controller,
      this.heigt = 35,
      this.width,
      this.onChanged,
      this.onTapOutside,
      this.textInputType = TextInputType.text,
      this.textInputAction = TextInputAction.done,
      this.hintText,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          SizedBox(
            height: heigt,
            width: width,
            child: TextField(
              onTapOutside: (event) => onTapOutside,
              readOnly: controller == null,
              // enableInteractiveSelection: true,
              controller: controller,
              textAlignVertical: TextAlignVertical.top,
              expands: textInputType == TextInputType.multiline ? true : false,
              keyboardType: textInputType,
              textInputAction: textInputAction,
              maxLines: textInputType == TextInputType.multiline ? null : 1,
              decoration: Utilits.textFieldDecoration(context, hintText: hintText),
              onChanged: onChanged,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
