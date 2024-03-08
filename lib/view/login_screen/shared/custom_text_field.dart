import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final bool isPassword;
  final bool isVisable;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode autovalidateMode;

  const CustomTextInput({
    super.key,
    required this.controller,
    this.labelText,
    this.isPassword = false,
    this.isVisable = true,
    this.onChanged,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: autovalidateMode,
      obscureText: isPassword && isVisable,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: const EdgeInsets.all(8),
        isDense: true,
        suffixIcon: isPassword
            ? IconButton(
                icon: isVisable
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
                onPressed: () {
                  // Toggling password visibility
                  onChanged
                      ?.call(""); // Clearing focus to ensure validation occurs
                  onChanged?.call(controller.text); // Restore focus
                },
              )
            : null,
      ),
    );
  }
}
