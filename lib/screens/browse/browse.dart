import 'package:filez/screens/browse/components/browse_controller.dart';
import 'package:filez/utils/file_utils.dart';
import 'package:filez/utils/screen_size.dart';
import 'package:filez/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Browse extends StatefulWidget {
  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  final browseController = Get.put(BrowseController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    double percent;

                    // print('Test ${controller..usedSpace}');

                    if (controller.usedSpace != null &&
                        controller.totalSpace != null &&
                        controller.usedSpaceSD != null &&
                        controller.totalSpaceSD != null) {
                      percent = index == 0
                          ? double.parse((controller.usedSpace /
                                      controller.totalSpace *
                                      100)
                                  .toStringAsFixed(0)) /
                              100
                          : double.parse((controller.usedSpaceSD /
                                      controller.totalSpaceSD *
                                      100)
                                  .toStringAsFixed(0)) /
                              100;
                    }

                    return ListTile(
                        onTap: () async {},
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
                                    ? "${FileUtils.formatBytes(controller.usedSpace, 2)} "
                                        "used of ${FileUtils.formatBytes(controller.totalSpace, 2)}"
                                    : "${FileUtils.formatBytes(controller.usedSpaceSD, 2)} "
                                        "used of ${FileUtils.formatBytes(controller.totalSpaceSD, 2)}",
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
                          child: LinearPercentIndicator(
                            padding: EdgeInsets.all(0),
                            backgroundColor: Colors.grey[300],
                            percent: percent ?? 0.0,
                            progressColor:
                                index == 0 ? Colors.lightBlue : Colors.orange,
                          ),
                        ));
                  });
            },
          )
        ],
      ),
    );
  }
}
