import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  Utils._();

  static TextStyle getFolderTextStyle() {
    return Get.textTheme.subtitle1;
  }

  static Color getBackgroundColor() {
    if (Theme.of(Get.context).brightness == Brightness.dark)
      return ThemeData.dark().scaffoldBackgroundColor;
    return ThemeData.light().scaffoldBackgroundColor;
  }

  static showSnackBar(
      {@required String text, FlatButton mainButton, Color bgColor}) {
    bgColor = bgColor ?? ThemeData.dark().backgroundColor;

    return Get.showSnackbar(GetBar(
      icon: Icon(
        Icons.info,
        color: Colors.white,
      ),
      message: text ?? "Try after sometime...",
      onTap: (object) {},
      mainButton: mainButton,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: bgColor,
      duration: Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
    ));
  }

  static checkStoragePermission() async {

    await Permission.storage.request();
    var status = await Permission.storage.status;
    return Future.value(status);
  }
}
