import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';

class NavTabIcon extends StatelessWidget {
  final Icon icon;
  final Function() onTap;
  final bool isSelected;
  const NavTabIcon({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
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
        onPressed: onTap,
      ),
    );
  }
}
