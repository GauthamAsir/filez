import 'dart:io';

import 'package:get/get.dart';
import 'package:path/path.dart' as pathlib;
import 'package:path/path.dart';

class FolderController extends GetxController {
  List<FileSystemEntity> files = List<FileSystemEntity>().obs;

  List<String> paths = List<String>().obs;

  addPath(String pathName) {
    paths.add(pathName);
  }

  removeLastPath() {
    paths.removeLast();
    getFiles(paths.last);
  }

  getFiles(String path, {bool showHidden = true}) async {
    Directory dir = Directory(path);
    List<FileSystemEntity> l = dir.listSync();
    files.clear();
    for (FileSystemEntity file in l) {
      if (!showHidden) {
        if (!pathlib.basename(file.path).startsWith(".")) {
          files.add(file);
        }
      } else {
        files.add(file);
      }
    }
    sort();
  }

  sort() {
    sortList(files, 0);
  }

  static List<FileSystemEntity> sortList(
      List<FileSystemEntity> list, int sort) {
    switch (sort) {
      case 0:
        if (list.toString().contains("Directory")) {
          list
            ..sort((f1, f2) => basename(f1.path)
                .toLowerCase()
                .compareTo(basename(f2.path).toLowerCase()));
          return list
            ..sort((f1, f2) => f1
                .toString()
                .split(":")[0]
                .toLowerCase()
                .compareTo(f2.toString().split(":")[0].toLowerCase()));
        } else {
          return list
            ..sort((f1, f2) => basename(f1.path)
                .toLowerCase()
                .compareTo(basename(f2.path).toLowerCase()));
        }
        break;

      case 1:
        list.sort((f1, f2) => basename(f1.path)
            .toLowerCase()
            .compareTo(basename(f2.path).toLowerCase()));
        if (list.toString().contains("Directory")) {
          list
            ..sort((f1, f2) => f1
                .toString()
                .split(":")[0]
                .toLowerCase()
                .compareTo(f2.toString().split(":")[0].toLowerCase()));
        }
        return list.reversed.toList();
        break;

      case 2:
        return list
          ..sort((f1, f2) => FileSystemEntity.isFileSync(f1.path) &&
                  FileSystemEntity.isFileSync(f2.path)
              ? File(f1.path)
                  .lastModifiedSync()
                  .compareTo(File(f2.path).lastModifiedSync())
              : 1);
        break;

      case 3:
        list
          ..sort((f1, f2) => FileSystemEntity.isFileSync(f1.path) &&
                  FileSystemEntity.isFileSync(f2.path)
              ? File(f1.path)
                  .lastModifiedSync()
                  .compareTo(File(f2.path).lastModifiedSync())
              : 1);
        return list.reversed.toList();
        break;

      case 4:
        list
          ..sort((f1, f2) => FileSystemEntity.isFileSync(f1.path) &&
                  FileSystemEntity.isFileSync(f2.path)
              ? File(f1.path).lengthSync().compareTo(File(f2.path).lengthSync())
              : 0);
        return list.reversed.toList();
        break;

      case 5:
        return list
          ..sort((f1, f2) => FileSystemEntity.isFileSync(f1.path) &&
                  FileSystemEntity.isFileSync(f2.path)
              ? File(f1.path).lengthSync().compareTo(File(f2.path).lengthSync())
              : 0);
        break;

      default:
        return list..sort();
    }
  }
}
