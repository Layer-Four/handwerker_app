import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final TextInputAction inputAction;
  final bool obscureText;
  final Function(String)? onFieldSubmitted;
  final Function()? togglePasswordVisibility;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    this.isPassword = false,
    required this.inputAction,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.togglePasswordVisibility,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3, bottom: 20),
      width: 355,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 231, 226, 226),
      ),
      child: Focus(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 40,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            textInputAction: inputAction,
            onFieldSubmitted: onFieldSubmitted,
            validator: validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.all(10),
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: togglePasswordVisibility,
                      icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                      color: Theme.of(context).iconTheme.color,
                    )
                  : null,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColor.kPrimaryButtonColor,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
