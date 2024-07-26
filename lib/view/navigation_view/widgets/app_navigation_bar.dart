import 'package:flutter/material.dart';

import 'nav_tab_icon.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({
    super.key,
    required this.index,
    required this.onChangedTab,
  });

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // buildTabItem(0, const Icon(Icons.alarm)),
              NavTabIcon(
                icon: const Icon(Icons.note_alt_outlined),
                isSelected: (widget.index == 1),
                onTap: () {
                  widget.onChangedTab(1);
                },
              ),
              NavTabIcon(
                icon: const Icon(Icons.storage),
                isSelected: (widget.index == 2),
                onTap: () => widget.onChangedTab(2),
              ),
              NavTabIcon(
                icon: const Icon(Icons.account_box_outlined),
                isSelected: (widget.index == 3),
                onTap: () => widget.onChangedTab(3),
              ),
            ],
          ),
        ),
      );
}
               // buildTabItem(1, const Icon(Icons.note_alt_outlined)),
              // buildTabItem(2, const Icon(Icons.storage)),
              // buildTabItem(3, const Icon(Icons.account_box_outlined)),
  // Widget buildTabItem(int index, Icon icon) {
  //   final isSelected = index == widget.index;

  //   return Container(
  //     width: 50.0,
  //     height: 50.0,
  //     decoration: BoxDecoration(
  //       border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
  //       borderRadius: BorderRadius.circular(30),
  //       color: AppColor.kPrimaryButtonColor,
  //     ),
  //     child: IconButton(
  //       icon: icon,
  //       color: AppColor.kWhite,
  //       onPressed: () => widget.onChangedTab(index),
  //     ),
  //   );
  // }
