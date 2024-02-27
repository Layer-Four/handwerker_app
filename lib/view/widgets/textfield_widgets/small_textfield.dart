import 'package:flutter/material.dart';

class SmallLabelInputWidget extends StatefulWidget {
  final Widget child;
  final String label;

  const SmallLabelInputWidget({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  State createState() => _SmallLabelInputWidgetState();
}

class _SmallLabelInputWidgetState extends State<SmallLabelInputWidget> {
  final controller = TextEditingController();
  @override
  Widget build(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            widget.label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 35, width: 150, child: widget.child),
      ],
    );
  }
}
