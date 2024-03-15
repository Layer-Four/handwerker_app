import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';

class HingedWidget extends StatefulWidget {
  final Widget header;
  final Column content;
  final int contentLength;

  const HingedWidget({
    super.key,
    required this.header,
    required this.content,
    required this.contentLength,
  });

  @override
  State<HingedWidget> createState() => _HingedWidgetState();
}

class _HingedWidgetState extends State<HingedWidget> {
  bool _isOpen = false;
  // final double _collapsedHeight = 50.0; // Adjust this based on your content

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width - 20,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeInOutCubic,
      height: _isOpen ? widget.contentLength * 70 : 60,
      child: InkWell(
        onTap: () => setState(() => _isOpen = !_isOpen),
        child: Card(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.kWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 90,
                      child: widget.header,
                    ),
                    Icon(
                      _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      size: 40,
                    ),
                  ],
                ),
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 200),
                  firstChild: const SizedBox.shrink(),
                  secondChild: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      width: MediaQuery.of(context).size.width - 30,
                      child: widget.content),
                  crossFadeState: _isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
