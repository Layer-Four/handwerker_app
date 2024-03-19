// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class Utilits {
  static Future<DateTime?> selecetDate(context) async {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2100),
        locale: const Locale('de'));
  }

  static Future<String?> pickImageFromCamera(BuildContext context, String projectName) async {
    // final dir = await getApplicationDocumentsDirectory();
    // const Permission storagePermission = Permission.storage;
    // if (await storagePermission.isDenied) {
    //   await askForPermission(context);
    // }
    // final now = '${DateTime.now().day}.${DateTime.now().month},${DateTime.now().year}';
    // final path = '${dir.path}/$projectName/$now.jpg';
    // ignore: unused_local_variable
    final permission = await Permission.camera.status;
    // log(' permission denied: ${permission.isDenied} \n permission granded: ${permission.isGranted}\n permission Limited: ${permission.isLimited} permisison Storage  denied: ${await Permission.storage.isDenied} ');
    // if (!await dir.exists()) {
    // await dir.create(recursive: true);
    // }
    try {
      final XFile? file = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 1024,
        maxWidth: 1024,
      );
      if (file != null) {
        final fileAsByte = File(file.path).readAsBytesSync();

        return base64Encode(fileAsByte);
      }
    } catch (e) {
      final status = await Permission.camera.status;
      log('permission was denied: $e');
      if (status.isDenied) {
        askForPermission(context);
      }
      //  XFile(file.path,
      //     name:
      //         '$projectName/${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}');
      // log('filename ${newfile.name} ,mimeType: ${newfile.mimeType}');
      // return newfile;
    }
    return null;
  }

  static Future<String?> pickImageFromGalery(BuildContext context, String projectName) async {
    final dir = await getApplicationCacheDirectory();
    final now = '${DateTime.now().day}.${DateTime.now().month},${DateTime.now().year}';
    final path = '${dir.path}/$projectName/$now.jpg';
    final permission = Permission.storage.status;
    log('storage permission: $permission');
    try {
      final XFile? file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 1024,
        maxWidth: 1024,
      );
      if (file != null) {
        final newfile = await File(file.path).copy(path);
        log('imagePath: ${newfile.path}');
        final iamgeAsByte = newfile.readAsBytesSync();
        return base64Encode(iamgeAsByte);
        // final newfile = XFile(file.path,
        //     name:
        //         '$projectName/${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}');
        // log('filename ${newfile.name} ,mimeType: ${newfile.mimeType}');
        // return newfile.path;
      }
    } catch (e) {
      final status = await Permission.storage.status;
      log('permission was denied: $e');
      if (status.isDenied) {
        askForPermission(context);
      }
    }
    return null;
  }

  static Future<dynamic> askForPermission(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Zugriff verweigert'),
        content: const Text(
          'Bitter erlauben sie den Zugriff auf ihr Fotos oder Kamera',
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Abbruch'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => openAppSettings(),
            child: const Text('Einstellungen'),
          ),
        ],
      ),
    );
  }

  static InputDecoration textFieldDecorator(BuildContext context, {String? hintText}) =>
      InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColor.kTextfieldBorder,
            ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColor.kTextfieldBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.kPrimaryButtonColor),
        ),
      );
}
