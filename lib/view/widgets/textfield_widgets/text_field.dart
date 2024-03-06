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
    Key? key,
    this.controller,
    this.isPass = false,
    this.validator,
    this.hintText,
    this.keyboardType,
    this.obscureText = true,
  }) : super(key: key);

  @override
  State<UserAndPasswordField> createState() => _UserAndPasswordFieldState();
}

class _UserAndPasswordFieldState extends State<UserAndPasswordField> {
  bool obscure = true;
  bool isFocused = false;
  GlobalKey<FormState> formstate = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.kWhilteWOpacity,
      ),
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            isFocused = hasFocus;
          });
        },
        child: SizedBox(
          height: 35,
          child: TextFormField(
            autofocus: false,
            key: formstate,
            validator: widget.validator,
            obscureText: widget.isPass ? obscure : false,
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey),
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
              contentPadding: const EdgeInsets.all(6),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColor.kPrimaryButtonColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: isFocused
                      ? AppColor.kPrimaryButtonColor
                      : Colors.transparent,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
