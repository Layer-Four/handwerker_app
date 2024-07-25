// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'apptheme/app_colors.dart';

class Utilits {
  static Future<DateTime?> selecetDate(context) async {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2100),
        locale: const Locale('de'));
  }

  static Widget buildIndicator({required int selectedIndex, required int length}) =>
      AnimatedSmoothIndicator(
        activeIndex: selectedIndex,
        count: length,
        effect: const SlideEffect(
          dotColor: Colors.grey,
          activeDotColor: Colors.black,
          dotHeight: 8,
          dotWidth: 8,
        ),
      );

  static Future<XFile?> pickImage(
    BuildContext context,
    String projectName, {
    required Permission permission,
  }) async {
    // final permission = Permission.storage.status;
    final source = permission == Permission.camera ? ImageSource.camera : ImageSource.gallery;
    if (await permission.isDenied) await askForPermission(context);
    try {
      return await ImagePicker().pickImage(
        source: source,
        maxHeight: 1024,
        maxWidth: 1024,
      );
      // if (x != null) {
      // TODO:Look here for solution of signaturecontroller.toPngByte():
      //! final String str = String.fromCharCodes(await x.readAsBytes());
      //! final Uint8List acht = utf8.encode(base64String);
      //   final n = XFile.fromData(await x.readAsBytes(), name: 'neuer_Name.png', mimeType: 'png');
      //   return n;
      // }
    } catch (e) {
      // final status = await Permission.storage.status;
      log('permission was denied: $e');
      // ? Second reqeust after denied permisson
      // if (status.isDenied) {
      //   askForPermission(context);
      // }
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

  static InputDecoration textFieldDecoration(BuildContext context, {String? hintText}) =>
      InputDecoration(
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
          borderSide: const BorderSide(
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
