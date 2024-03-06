import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/main.dart';
import 'package:handwerker_app/view/widgets/logo.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/text_field.dart';

class ForgetScreen extends ConsumerStatefulWidget {
  const ForgetScreen({super.key});

  @override
  ConsumerState<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends ConsumerState<ForgetScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailCon = TextEditingController();
    return Material(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Positioned(
                    child: Transform.scale(
                      scale: 0.6,
                      child: Switch(
                        value: ref.watch(themeProvider),
                        onChanged: (_) {
                          ref.read(themeProvider.notifier).state =
                              !ref.watch(themeProvider);
                        },
                        activeColor: AppColor
                            .kPrimaryButtonColor, // Specify active color
                        inactiveThumbColor:
                            Colors.grey, // Specify inactive thumb color
                        inactiveTrackColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                const LogoApp(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "bitte benachrichtige den Adminstrator",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Colors.black, width: 2), // Add border here
                  ),
                  child: UserAndPasswordField(
                    hintText: 'Nutzername',
                    controller: emailCon,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: AppColor.kPrimaryButtonColor,
                    padding: const EdgeInsets.all(10),
                  ),
                  child: Center(
                    child: Text(
                      "Senden".toUpperCase(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
