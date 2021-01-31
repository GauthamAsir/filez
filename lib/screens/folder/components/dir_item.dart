import 'dart:io';

import 'package:filez/screens/folder/components/more_tools.dart';
import 'package:filez/utils/screen_size.dart';
import 'package:filez/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path/path.dart';

class DirectoryItem extends StatelessWidget {
  final FileSystemEntity file;
  final Function onTap;
  final Function onToolsTap;

  DirectoryItem({
    Key key,
    @required this.file,
    @required this.onTap,
    @required this.onToolsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: () {},
      contentPadding: EdgeInsets.zero,
      leading: Container(
        height: 40,
        width: 40,
        margin: EdgeInsets.only(left: Sizes.marginHorizontal),
        child: Center(
          child: Icon(
            Feather.folder,
          ),
        ),
      ),
      title: Text(
        "${basename(file.path)}",
        style: Utils.getFolderTextStyle(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: onToolsTap == null
          ? null
          : MoreTools(path: file.path, onToolsTap: onToolsTap),
    );
  }
}
