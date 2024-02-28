import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/provider/view_provider/view_provider.dart';
import 'package:handwerker_app/routes/app_routes.dart';
import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';

class UserView extends ConsumerWidget {
  const UserView({super.key});
  @override
  Widget build(BuildContext context, ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('User Information'),
          ),
          SymmetricButton(
            color: AppColor.kPrimaryColor,
            text: 'Logout',
            onPressed: () {
              log('log user out');
              ref.read(viewProvider.notifier).state = MainViews.doku;
              Navigator.of(context).pushReplacementNamed(AppRoutes.initialRoute);
            },
          )
        ],
      ),
    );
  }
}
