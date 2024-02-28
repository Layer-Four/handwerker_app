import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class Utilits {
  static Future<DateTime?> selecetDate(context) async {
    return await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2100));
  }

  static Future<File?> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? file;
    file = await picker.pickImage(source: ImageSource.camera);
    if (file != null) return File(file.path);
    return null;
  }

  static Future<File?> pickImageFromGalery() async {
    final ImagePicker picker = ImagePicker();
    XFile? file;
    file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) return File(file.path);
    return null;
  }

  static Future<File?> asktForImage(BuildContext context, WidgetRef ref) async {
    showDialog(
        context: context,
        builder: (context) => Card(
              margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 270),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SymmetricButton(
                        color: Colors.green,
                        text: 'Wähle ein Bild aus \ndeiner Galerie',
                        onPressed: () async {
                          PermissionStatus storeStatus = await Permission.storage.request();
                          if (!storeStatus.isGranted) {
                            await Permission.storage.request();
                          }
                          if (storeStatus.isGranted || storeStatus.isDenied) {
                            final image = await pickImageFromGalery();
                            if (image != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(' Bild ausgewählt')),
                              );
                              return image;
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('kein Bild ausgewählt')),
                              );
                              Navigator.of(context).pop();
                            }
                          }
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: SymmetricButton(
                        color: Colors.green,
                        text: 'Erstelle ein neues \nProfile von dir',
                        onPressed: () async {
                          final cameraPermission = await Permission.camera.request();
                          if (cameraPermission.isGranted || cameraPermission.isDenied) {
                            final image = await pickImageFromCamera();
                            if (image != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(' Bild ausgewählt')),
                              );
                              Navigator.of(context).pop();
                              return image;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('kein Bild ausgewählt')),
                            );
                            Navigator.of(context).pop();
                          }
                        }),
                  ),
                ],
              ),
            ));
    return null;
  }
}
