// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  static Future<File?> pickImageFromCamera(BuildContext context) async {
    try {
      final XFile? file = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 1024,
        maxWidth: 1024,
      );
      if (file != null) return File(file.path);
    } catch (e) {
      final status = await Permission.camera.status;
      log('permission was denied: $e');
      if (status.isDenied) {
        askForPermission(context);
      }
    }
    return null;
  }

  static Future<File?> pickImageFromGalery(BuildContext context) async {
    try {
      final XFile? file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 1024,
        maxWidth: 1024,
      );
      if (file != null) return File(file.path);
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
      builder: (context) =>
          // Material(
          //   child: Card(
          //     child: Container(
          //       margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 250),
          //       padding: const EdgeInsets.all(8),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(12),
          //         color: AppColor.kWhite,
          //       ),
          //       child:
          CupertinoAlertDialog(
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
        // ),
        // ),
        // ),
      ),
    );
  }
}
