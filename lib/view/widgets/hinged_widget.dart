import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';

class HingedWidget extends StatefulWidget {
  final Widget header;
  final Column content;
  final int contentLength;
  final double? width;
  final double? basicHeigth;

  const HingedWidget({
    super.key,
    required this.header,
    required this.content,
    required this.contentLength,
    this.width,
    this.basicHeigth,
  });

  @override
  State<HingedWidget> createState() => _LargeHingedState();
}

class _LargeHingedState extends State<HingedWidget> {
  bool _isOpen = false;
  bool _openContent = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width ?? MediaQuery.of(context).size.width - 20,
      duration: const Duration(milliseconds: 100),
      // curve: Curves.linear,
      height: _isOpen ? ((widget.basicHeigth ?? 200) + (widget.contentLength * 22)) : 60,
      onEnd: () => setState(() {
        if (_isOpen) {
          if (!_openContent) {
            _openContent = true;
          }
        }
      }),
      child: GestureDetector(
        onTap: () => setState(() {
          if (_isOpen) {
            _openContent = false;
          }
          _isOpen = !_isOpen;
        }),
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
                _openContent
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        width: MediaQuery.of(context).size.width - 30,
                        child: widget.content)
                    : const SizedBox.shrink(),
                // AnimatedCrossFade(
                //   sizeCurve: Curves.easeIn,
                //   secondCurve: Curves.ease,
                //   firstCurve: Curves.easeIn,
                //   duration: const Duration(milliseconds: 1000),
                //   firstChild: const SizedBox(),
                //   secondChild: Container(
                //       padding: const EdgeInsets.symmetric(horizontal: 12),
                //       width: MediaQuery.of(context).size.width - 30,
                //       child: widget.content),
                //   crossFadeState: _isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:handwerker_app/constants/apptheme/app_colors.dart';

// class HingedWidget extends StatefulWidget {
//   final Widget header;
//   final Column content;
//   final int contentLength;

//   const HingedWidget({
//     super.key,
//     required this.header,
//     required this.content,
//     required this.contentLength,
//   });

//   @override
//   State<HingedWidget> createState() => _HingedWidgetState();
// }

// class _HingedWidgetState extends State<HingedWidget> {
//   bool _isOpen = false;
//   bool _isShowContent = false;
//   // final double _collapsedHeight = 50.0; // Adjust this based on your content

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       width: MediaQuery.of(context).size.width - 20,
//       duration: const Duration(milliseconds: 180),
//       curve: Curves.easeInOutCubic,
//       height: _isOpen ? (60 + (widget.contentLength * 22)) : 50,
//       child: InkWell(
//         onTap: () => setState(() => _isOpen = !_isOpen),
//         child: Card(
//           elevation: 5,
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColor.kWhite,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width - 80,
//                       child: widget.header,
//                     ),
//                     Icon(
//                       _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
//                       size: 40,
//                     ),
//                   ],
//                 ),
//                 AnimatedCrossFade(
//                   duration: const Duration(milliseconds: 20),
//                   firstChild: const SizedBox.shrink(),
//                   secondChild: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                       width: MediaQuery.of(context).size.width - 30,
//                       child: widget.content),
//                   crossFadeState: _isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
