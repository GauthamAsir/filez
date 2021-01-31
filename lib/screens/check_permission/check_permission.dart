import 'package:filez/screens/home/home.dart';
import 'package:filez/utils/screen_size.dart';
import 'package:filez/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckPermission extends StatefulWidget {
  @override
  _CheckPermissionState createState() => _CheckPermissionState();
}

class _CheckPermissionState extends State<CheckPermission> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Permission.storage.request().asStream(),
        builder: (_, AsyncSnapshot<PermissionStatus> status) {
          if (!status.hasData) return contents();

          if (status.data.isPermanentlyDenied)
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.marginHorizontal),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      Strings.permissionPermanentlyDenied,
                      style: Get.textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  RaisedButton(
                      onPressed: () {
                        openAppSettings();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Get.theme.primaryColor,
                      child: Text(
                        Strings.openSettings,
                        style: Get.textTheme.subtitle1,
                      ))
                ],
              ),
            );

          if (status.data.isDenied)
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.marginHorizontal),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      Strings.permissionDenied,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.headline5,
                    ),
                  ),
                  RaisedButton(
                      onPressed: () async {
                        await Permission.storage.request();

                        /// Rebuild after requesting permission, coz its not broadcasting properly
                        if (mounted) setState(() {});
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Get.theme.primaryColor,
                      child: Text(
                        Strings.grantPermission,
                        textAlign: TextAlign.center,
                        style: Get.textTheme.subtitle1,
                      ))
                ],
              ),
            );

          if (status.data.isGranted) return Home();

          return contents();
        },
      ),
    );
  }

  Widget contents() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.marginHorizontal),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              Strings.grantPermissionToContinue,
              style: Get.textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
          RaisedButton(
              onPressed: () async {
                await Permission.storage.request();

                /// Rebuild after requesting permission, coz its not broadcasting properly
                if (mounted) setState(() {});
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Get.theme.primaryColor,
              child: Text(
                Strings.grantPermission,
                style: Get.textTheme.subtitle1,
              ))
        ],
      ),
    );
  }
}
