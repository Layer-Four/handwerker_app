import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';

class UserAndPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final bool isPass;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;

  const UserAndPasswordField({
    super.key,
    this.controller,
    this.isPass = false,
    this.validator,
    this.hintText,
    this.keyboardType,
    this.obscureText = true,
  });

  @override
  State<UserAndPasswordField> createState() => _UserAndPasswordFieldState();
}

class _UserAndPasswordFieldState extends State<UserAndPasswordField> {
  bool obscure = true;
  bool isFocused = false;
  GlobalKey<FormState> formstate = GlobalKey();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColor.kWhiteWOpacity,
          ),
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                isFocused = hasFocus;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isFocused ? 48 : 44,
              child: TextFormField(
                textInputAction: TextInputAction.next,
                validator: (value) {
                  String? validationResult = widget.validator?.call(value);
                  setState(() {
                    errorMessage = validationResult;
                  });
                  return null; // Return null to prevent the internal error display
                },
                obscureText: widget.isPass ? obscure : false,
                controller: widget.controller,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  errorText: null, // Explicitly set errorText to null
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.transparent,
                  suffixIcon: widget.isPass
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          icon: const Icon(Icons.remove_red_eye))
                      : const SizedBox(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColor.kPrimaryButtonColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: isFocused ? AppColor.kPrimaryButtonColor : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (errorMessage != null && errorMessage!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 4.0),
            child: Text(
              errorMessage!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
