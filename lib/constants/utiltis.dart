// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Utilits {
  static Future<DateTime?> selecetDate(context) async {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2100),
        locale: const Locale('de'));
  }

  static Widget buildIndicator({required int selectedIndex, required int length}) => AnimatedSmoothIndicator(
        activeIndex: selectedIndex,
        count: length,
        effect: const SlideEffect(
          dotColor: Colors.grey,
          activeDotColor: Colors.black,
          dotHeight: 8,
          dotWidth: 8,
        ),
      );

  static Future<XFile?> pickImageFromCamera(BuildContext context, String projectName) async {
    const Permission storagePermission = Permission.storage;
    if (await storagePermission.isDenied) {
      await askForPermission(context);
    }
    // final permission = await Permission.camera.status;
    try {
      final XFile? file = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 1024,
        maxWidth: 1024,
      );
      if (file != null) return file;
    } catch (e) {
      final status = await Permission.camera.status;
      log('permission was denied: $e');
      if (status.isDenied) {
        askForPermission(context);
      }
    }
    return null;
  }

  static Future<XFile?> pickImageFromGalery(BuildContext context, String projectName) async {
    final permission = Permission.storage.status;
    if (await permission.isDenied) {
      await askForPermission(context);
    }
    try {
      final XFile? file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 1024,
        maxWidth: 1024,
      );
      if (file != null) return XFile(file.path);
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

  static InputDecoration textFieldDecorator(BuildContext context, {String? hintText}) => InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColor.kLightLabelColor,
            ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColor.kTextfieldBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColor.kPrimaryButtonColor),
        ),
      );

  ///need a base64 input string and returned a Image.memory from UInt8List(Base64String)
  static Image writeImage(String base64String) => Image.memory(base64Decode(base64String));
}
