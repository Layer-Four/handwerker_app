import 'package:flutter/material.dart';

/// This is the Original NavbarIcon from DeHyves
class NavBarIconWidget extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final String name;
  final bool isCurrentView;
  const NavBarIconWidget({
    super.key,
    required this.icon,
    required this.name,
    this.onPressed,
    this.isCurrentView = false,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            isCurrentView
                ? Container(
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1.5, color: Colors.white),
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              height: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(size: 25, color: Colors.white, icon),
                  Text(name, style: const TextStyle(color: Colors.white, fontSize: 10))
                ],
              ),
            ),
          ],
        ),
      );
}
