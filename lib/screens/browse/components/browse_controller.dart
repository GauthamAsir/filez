import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class BrowseController extends GetxController {

  List<FileSystemEntity> availableStorage = List<FileSystemEntity>().obs;

  int totalSpace;
  int freeSpace;
  int usedSpace;

  int totalSpaceSD;
  int freeSpaceSD;
  int usedSpaceSD;

  @override
  void onInit() {
    super.onInit();
    getAvailableStorage();
    getStorageSPace();
  }

  getStorageSPace() async{
    List<FileSystemEntity> l = await getExternalStorageDirectories();

    MethodChannel platform = MethodChannel('FileZ');
    freeSpace = await platform.invokeMethod("getStorageFreeSpace");
    totalSpace = await platform.invokeMethod("getStorageTotalSpace");

    usedSpace = totalSpace - freeSpace;

    if (l.length > 1) {
      freeSpaceSD = await platform.invokeMethod("getExternalStorageFreeSpace");
      totalSpaceSD = await platform.invokeMethod("getExternalStorageTotalSpace");

      usedSpaceSD = totalSpaceSD - freeSpaceSD;
    }

  }

  getAvailableStorage() async{
    availableStorage.clear();
    List<FileSystemEntity> l = await getExternalStorageDirectories();
    availableStorage.addAll(l);
  }

}