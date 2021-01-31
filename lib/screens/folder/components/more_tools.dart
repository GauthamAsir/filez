import 'package:filez/utils/screen_size.dart';
import 'package:filez/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MoreTools extends StatelessWidget {
  final String path;
  final Function onToolsTap;

  MoreTools({Key key, this.path, this.onToolsTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Sizes.marginHorizontal),
      child: popMenu(),
    );
  }

  Widget popMenu() {
    return PopupMenuButton<int>(
      onSelected: onToolsTap,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Text(
            Strings.rename,
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Text(
            Strings.delete,
          ),
        ),
      ],
      icon: Icon(
        Feather.more_vertical,
        color: Colors.grey,
        size: 18,
      ),
      offset: Offset(0, 30),
    );
  }
}
