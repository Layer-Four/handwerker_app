import 'package:flutter/material.dart';
import 'package:handwerker_app/app_theme.dart/colors.dart';

class CustomField extends StatefulWidget {
  final TextEditingController controller;
  final bool isPass;
  const CustomField({
    super.key,
    required this.controller,
    this.isPass = false,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
        validator: (value) => value!.isEmpty ? "Requird" : null,
        obscureText: widget.isPass ? obscure : false,
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 248, 242, 242),
          suffixIcon: widget.isPass
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  icon: const Icon(Icons.abc))
              : const SizedBox(),
          contentPadding: const EdgeInsets.all(10),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: kPrimaryColor)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
