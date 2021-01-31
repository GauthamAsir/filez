import 'package:filez/style/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {

  Utils._();

  static Color getBackgroundColor() {
    if(Theme.of(Get.context).brightness == Brightness.dark)
      return ThemeData.dark().scaffoldBackgroundColor;
    return ThemeData.light().scaffoldBackgroundColor;
  }

  static showSnackBar(
      {@required String text,
        FlatButton mainButton,
        Color bgColor}) {

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

}