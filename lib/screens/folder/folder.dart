import 'dart:io';

import 'package:filez/screens/folder/components/dir_item.dart';
import 'package:filez/screens/folder/components/file_item.dart';
import 'package:filez/screens/folder/components/folder_controller.dart';
import 'package:filez/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Folder extends StatefulWidget {
  final String title;
  final String path;

  Folder({
    Key key,
    @required this.title,
    @required this.path,
  }) : super(key: key);

  @override
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<Folder> with WidgetsBindingObserver {
  String path;

  List<String> paths = List();

  List<FileSystemEntity> files = List();

  final folderController = Get.put(FolderController());

  @override
  void initState() {
    path = widget.path;
    folderController.getFiles(path);
    folderController.addPath(path);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      folderController.getFiles(path);
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (folderController.paths.length == 1) return Future.value(true);

        folderController.removeLastPath();
        path = folderController.paths.last;
        return Future.value(false);
      },
      child: Scaffold(
        body: Container(
          height: Get.size.height,
          child: GetX<FolderController>(
            builder: (controller) {
              if (controller.files.length <= 0)
                return Center(
                  child: Text(
                    Strings.noItemsFound,
                    style: Get.textTheme.headline5
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                );

              return ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 1,
                          color: Theme.of(context).dividerColor,
                          width: MediaQuery.of(context).size.width - 70,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: controller.files.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  FileSystemEntity file = controller.files[index];
                  return file.toString().split(":")[0] == "Directory"
                      ? DirectoryItem(
                          file: file,
                          onTap: () {
                            folderController.addPath(file.path);
                            folderController.getFiles(file.path);
                          },
                          onToolsTap: (selectedTool) {})
                      : FileItem(
                          file: file,
                          onToolsTap: (int) {},
                        );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
