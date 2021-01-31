import 'package:filez/screens/browse/components/browse_controller.dart';
import 'package:filez/widgets/check_permission.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'style/theme_controller.dart';

void main() {
  Get.lazyPut<ThemeController>(() => ThemeController());
  Get.lazyPut<BrowseController>(() => BrowseController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeController.to
        .getThemeModeFromPreferences();

    return GetMaterialApp(
      theme: ThemeData.light().copyWith(primaryColor: Colors.yellow.shade800,
          accentColor: Colors.black),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.yellow.shade800,
          accentColor: Colors.black),
      themeMode: ThemeController.to.themeMode,
      home: CheckPermission(),
    );
  }
}