import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/apptheme/app_colors.dart';
import '../../constants/utiltis.dart';
import '../../provider/doku_provider/documentation_provider.dart';
import '../../provider/settings_provider/settings_provider.dart';

class ChooseMediaWidget extends ConsumerWidget {
  const ChooseMediaWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Container(
        // padding: const EdgeInsets.symmetric(vertical: 6),
        height: 150,
        decoration: BoxDecoration(
          color: AppColor.kTextfieldBorder,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(ref.watch(settingsProv).dictionary.makePicture),
                      IconButton(
                        icon: const Icon(Icons.camera_alt, size: 70),
                        onPressed: () async {
                          if (ref.watch(documentationProvider).project == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Center(
                                  child: Text(ref.watch(settingsProv).dictionary.plsChooseProject),
                                ),
                              ),
                            );
                            return;
                          } else {
                            final image = await Utilits.pickImage(
                              context,
                              ref.watch(documentationProvider).project!.title!,
                              permission: Permission.camera,
                            );
                            if (image != null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.transparent,
                                content: Image.memory(
                                  await image.readAsBytes(),
                                  height: 100,
                                  width: 150,
                                ),
                              ));

                              ref.read(documentationProvider.notifier).updateDocumentation(
                                imageUrl: [
                                  ...ref.watch(documentationProvider).docu.imageUrl,
                                  image.path,
                                ],
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(ref.watch(settingsProv).dictionary.takePicture),
                      IconButton(
                        icon: const Icon(Icons.image, size: 68),
                        onPressed: () async {
                          if (ref.watch(documentationProvider).project == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Center(
                                  child: Text(ref.watch(settingsProv).dictionary.plsChooseProject),
                                ),
                              ),
                            );
                            return;
                          } else {
                            final image = await Utilits.pickImage(
                              context,
                              ref.watch(documentationProvider).project!.title ?? 'NoProject',
                              permission: Permission.storage,
                            );
                            if (image != null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.transparent,
                                content: Image.file(
                                  File(image.path),
                                  height: 100,
                                  width: 150,
                                ),
                              ));
                              ref.read(documentationProvider.notifier).updateDocumentation(
                                imageUrl: [
                                  ...ref.watch(documentationProvider).docu.imageUrl,
                                  image.path,
                                ],
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ref.watch(documentationProvider).docu.imageUrl.isEmpty
                ? const SizedBox.shrink()
                : SizedBox(
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Text(
                            '${ref.watch(documentationProvider).docu.imageUrl.length} ${ref.watch(settingsProv).dictionary.choosedImage}',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                        IconButton(
                          onPressed: () => ref.read(documentationProvider.notifier).deleteImage(),
                          icon: const Icon(Icons.delete),
                          iconSize: 20,
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      );
}
