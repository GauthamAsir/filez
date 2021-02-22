import 'package:filez/screens/browse/components/browse_controller.dart';
import 'package:filez/screens/folder/folder.dart';
import 'package:filez/utils/file_utils.dart';
import 'package:filez/utils/screen_size.dart';
import 'package:filez/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class Browse extends StatefulWidget {
  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(BrowseController());

    return Scaffold(
      body: Column(
        children: [
          GetX<BrowseController>(
            builder: (controller) {
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
                  itemCount: controller.availableStorage.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 20),
                  itemBuilder: (context, index) {
                    String path = controller.availableStorage[index].path
                        .split("Android")[0];

                    return ListTile(
                        onTap: () {
                          Get.to(Folder(
                              title:
                                  index == 0 ? Strings.device : Strings.sdCard,
                              path: path));
                        },
                        contentPadding: EdgeInsets.only(right: 20),
                        leading: Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.only(left: Sizes.marginHorizontal),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              index == 0
                                  ? Feather.smartphone
                                  : Icons.sd_storage,
                              color:
                                  index == 0 ? Colors.lightBlue : Colors.orange,
                            ),
                          ),
                        ),
                        title: Container(
                          margin:
                              EdgeInsets.only(right: Sizes.marginHorizontal),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                index == 0 ? Strings.device : Strings.sdCard,
                                style: Get.textTheme.subtitle1
                                    .copyWith(fontSize: 17),
                              ),
                              Text(
                                index == 0
                                    ? "${FileUtils.formatBytes(controller.usedSpace ?? 0, 2)} "
                                        "used of ${FileUtils.formatBytes(controller.totalSpace ?? 0, 2)}"
                                    : "${FileUtils.formatBytes(controller.usedSpaceSD ?? 0, 2)} "
                                        "used of ${FileUtils.formatBytes(controller.totalSpaceSD ?? 0, 2)}",
                                style: Get.textTheme.subtitle2
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: LinearProgressIndicator(
                              value: index == 0
                                  ? controller.percent ?? 0
                                  : controller.percentSD ?? 0,
                              backgroundColor: Colors.grey.shade300,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  index == 0
                                      ? Colors.lightBlue
                                      : Colors.orange)),
                        ));
                  });
            },
          )
        ],
      ),
    );
  }
}
