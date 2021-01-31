import 'dart:io';

import 'package:filez/screens/folder/components/dir_item.dart';
import 'package:filez/screens/folder/components/file_item.dart';
import 'package:filez/screens/folder/components/folder_controller.dart';
import 'package:filez/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

import 'components/path_bar.dart';

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

  List<FileSystemEntity> files = List();

  final folderController = Get.put(FolderController());

  @override
  void initState() {
    folderController.setPath(widget.path);
    folderController.getFiles(folderController.path.value);
    folderController.addPath(folderController.path.value);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      folderController.getFiles(folderController.path.value);
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
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          leading: Container(
            height: 40,
            width: 40,
            child: IconButton(
              icon: Icon(
                Feather.chevron_left,
                color: Colors.black87,
              ),
              onPressed: () {
                if (folderController.paths.length == 1) return Get.back();

                folderController.removeLastPath();
              },
            ),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${widget.title}",
                style: Get.textTheme.subtitle1
                    .copyWith(color: Colors.black87, fontSize: 18),
              ),
              Obx(() => Text(
                    "${folderController.path.value}",
                    style: Get.textTheme.caption
                        .copyWith(color: Colors.black87, fontSize: 14),
                  ))
            ],
          ),
          bottom: PathBar(
            child: Container(
              height: 50,
              alignment: Alignment.centerLeft,
              child: GetX<FolderController>(
                builder: (controller) {
                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return Icon(
                        Feather.chevron_right,
                        size: 20,
                        color: Colors.black38,
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: controller.paths.length,
                    itemBuilder: (context, index) {
                      String i = controller.paths[index];
                      List splited = i.split("/");

                      return index == 0
                          ? IconButton(
                              padding: EdgeInsets.only(left: 12),
                              icon: Icon(
                                widget.path.toString().contains("emulated")
                                    ? Feather.smartphone
                                    : Icons.sd_card,
                                color: index == controller.paths.length - 1
                                    ? Theme.of(context).accentColor
                                    : Colors.black87,
                              ),
                              onPressed: () {
                                controller.setPath(controller.paths[index]);
                                controller.paths.removeRange(
                                    index + 1, controller.paths.length);
                                controller.getFiles(controller.path.value);
                              },
                            )
                          : InkWell(
                              onTap: () {
                                controller.setPath(controller.paths[index]);
                                controller.paths.removeRange(
                                    index + 1, controller.paths.length);
                                controller.getFiles(controller.path.value);
                              },
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  "${splited[splited.length - 1]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: index == controller.paths.length - 1
                                        ? Colors.black87
                                        : Colors.black38,
                                  ),
                                ),
                              ));
                    },
                  );
                },
              ),
            ),
          ),
        ),
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
                            folderController.setPath(file.path);
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
