import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordVisibilityProvider = StateProvider((ref) => false);

class CustomTextField extends ConsumerWidget {
  final TextEditingController controller;
  final bool isPassword;
  final TextInputAction inputAction;
  final bool obscureText;
  final Function(String)? onFieldSubmitted;
  final Function()? togglePasswordVisibility;
  final String? Function(String?)? validator;
  final Function(bool)? onFocusChange;

  const CustomTextField({
    super.key,
    required this.controller,
    this.isPassword = false,
    required this.inputAction,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.togglePasswordVisibility,
    this.validator,
    this.onFocusChange,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isPasswordVisible = ref.watch(passwordVisibilityProvider);

    return Container(
      margin: const EdgeInsets.only(top: 3, bottom: 20),
      width: 355,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 231, 226, 226),
      ),
      child: Focus(
        onFocusChange: onFocusChange != null ? (hasFocus) => onFocusChange!(hasFocus) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 44,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller,
                  obscureText: obscureText && !isPasswordVisible,
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
                            icon: Icon(
                              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                            color: Theme.of(context).iconTheme.color,
                          )
                        : null,
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 0,
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
                    hoverColor: Theme.of(context).primaryColor.withOpacity(0.2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
