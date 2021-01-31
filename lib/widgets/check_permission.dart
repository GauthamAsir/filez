import 'package:filez/screens/home/home.dart';
import 'package:filez/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckPermission extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Permission.storage.request().asStream(),
        builder: (_, AsyncSnapshot<PermissionStatus> status) {

          if(!status.hasData)
            return contents();

          if (status.data.isPermanentlyDenied)
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(Sizes.marginHorizontal),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Storage Permission is Permanently Denied',
                      style: Get.textTheme.headline5,
                    ),
                    FlatButton(
                        onPressed: () {
                          openAppSettings();
                        },
                        child: Text(
                          'Open Settings'.toUpperCase(),
                          style: Get.textTheme.subtitle1,
                        ))
                  ],
                ),
              ),
            );

          if(status.data.isDenied)
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(Sizes.marginHorizontal),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Storage Permission is Denied',
                      style: Get.textTheme.headline5,
                    ),
                    FlatButton(
                        onPressed: () async{
                          await Permission.storage.request();
                        },
                        child: Text(
                          'Grant Permission',
                          style: Get.textTheme.subtitle1,
                        ))
                  ],
                ),
              ),
            );

          if(status.data.isGranted)
            return Home();

          return contents();

        },
      ),
    );
  }

  Widget contents() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Sizes.marginHorizontal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Grant Permission to Continue',
              style: Get.textTheme.headline5,
            ),
            FlatButton(
                onPressed: () async{
                  await Permission.storage.request();
                },
                child: Text(
                  'Grant Permission',
                  style: Get.textTheme.subtitle1,
                ))
          ],
        ),
      ),
    );
  }

}
