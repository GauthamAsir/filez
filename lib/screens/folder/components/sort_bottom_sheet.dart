import 'package:filez/utils/file_utils.dart';
import 'package:filez/utils/screen_size.dart';
import 'package:filez/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class SortBottomSheet extends StatelessWidget {
  final int sortVal;
  final Function onTap;

  SortBottomSheet({Key key, this.sortVal, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.marginHorizontal),
            child: Text(
              Strings.sortBy.toUpperCase(),
              style: Get.textTheme.subtitle2,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
              child: ListView.builder(
                  itemCount: FileUtils.sortList.length,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return ListTile(
                      onTap: () {
                        onTap(index);
                      },
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: Sizes.marginHorizontal),
                      trailing: index == sortVal
                          ? Icon(
                              Feather.check,
                              color: Colors.orange.shade900,
                              size: 17,
                            )
                          : SizedBox(),
                      title: Text(
                        "${FileUtils.sortList[index]}",
                        style: Get.textTheme.subtitle2.copyWith(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w400,
                          color: index == sortVal
                              ? Colors.orange.shade900
                              : Colors.black87,
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
