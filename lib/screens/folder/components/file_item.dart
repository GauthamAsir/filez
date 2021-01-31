import 'dart:io';

import 'package:filez/screens/folder/components/more_tools.dart';
import 'package:filez/utils/file_utils.dart';
import 'package:filez/utils/screen_size.dart';
import 'package:filez/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'file_icon.dart';

class FileItem extends StatelessWidget {
  final FileSystemEntity file;
  final Function onToolsTap;

  FileItem({
    Key key,
    @required this.file,
    this.onToolsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // onTap: () => OpenFile.open(file.path),
      contentPadding: EdgeInsets.all(0),
      leading: Container(
        margin: EdgeInsets.only(left: Sizes.marginHorizontal),
        child: FileIcon(
          file: file,
        ),
      ),
      title: Text(
        "${basename(file.path)}",
        style: Utils.getFolderTextStyle(),
        maxLines: 2,
      ),
      subtitle: Text(
        "${FileUtils.formatBytes(file == null ? 678476 : File(file.path).lengthSync(), 2)},"
        " ${file == null ? "Test" : FileUtils.formatTime(File(file.path).lastModifiedSync().toIso8601String())}",
      ),
      trailing: onToolsTap == null
          ? null
          : MoreTools(
              path: file.path,
              onToolsTap: onToolsTap,
            ),
    );
  }
}
