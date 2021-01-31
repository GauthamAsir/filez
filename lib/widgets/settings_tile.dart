import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsTile extends StatelessWidget {

  final String title;
  final Widget widget;

  SettingsTile({this.title, this.widget});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: Get.textTheme.subtitle1.copyWith(fontSize: 18, color: Colors.grey),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 10,
        ),
        widget,
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
