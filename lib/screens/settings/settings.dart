import 'package:filez/style/theme_controller.dart';
import 'package:filez/utils/screen_size.dart';
import 'package:filez/utils/strings.dart';
import 'package:filez/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ThemeMode _themeMode;

  @override
  Widget build(BuildContext context) {
    _themeMode = ThemeController.to.themeMode;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(Sizes.marginHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SettingsTile(
              title: Strings.appTheme,
              widget: DropdownButton(
                items: [
                  DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text(
                        Strings.system,
                      )),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text(Strings.dark),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text(Strings.light),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _themeMode = value;
                    ThemeController.to.setThemeMode(value);
                  });
                },
                value: _themeMode,
                style: Get.textTheme.subtitle1.copyWith(fontSize: 18),
                isExpanded: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
