import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';

class UserAndPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final bool isPass;
  const UserAndPasswordField({
    super.key,
    required this.controller,
    this.isPass = false,
  });

  @override
  State<UserAndPasswordField> createState() => _UserAndPasswordFieldState();
}

class _UserAndPasswordFieldState extends State<UserAndPasswordField> {
  bool obscure = true;
  bool isFocused = false;

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
            validator: (value) => value!.length < 6 ? "Required" : null,
            obscureText: widget.isPass ? obscure : false,
            controller: widget.controller,
            decoration: InputDecoration(
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
                  color: isFocused ? AppColor.kPrimaryButtonColor : Colors.transparent,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
