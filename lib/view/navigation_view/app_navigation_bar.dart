import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({
    Key? key,
    required this.index,
    required this.onChangedTab,
  }) : super(key: key);

  final int index;
  final ValueChanged<int> onChangedTab;

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  @override
  Widget build(BuildContext context) => SizedBox(
        height: 95,
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: AppColor.kPrimary,
          // notchMargin: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildTabItem(0, const Icon(Icons.alarm)),
              buildTabItem(1, const Icon(Icons.note_alt_outlined)),
              // Container(width: 40),
              buildTabItem(2, const Icon(Icons.storage)),
              buildTabItem(3, const Icon(Icons.account_box_outlined)),
            ],
          ),
        ),
      );

  Widget buildTabItem(int index, Icon icon) {
    final isSelected = index == widget.index;

    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
        borderRadius: BorderRadius.circular(30),
        color: AppColor.kPrimaryButtonColor,
      ),
      child: IconButton(
        icon: icon,
        color: AppColor.kWhite,
        onPressed: () => widget.onChangedTab(index),
      ),
    );
  }
}
