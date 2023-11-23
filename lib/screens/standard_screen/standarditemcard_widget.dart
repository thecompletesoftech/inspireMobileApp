import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/standard_screen/standard_controller.dart';

import '../progress_screen/progress_screen.dart';

class StandardItemCardWidget extends GetView<StandardController> {
  final RxCommonModel item;
  final int index;
  const StandardItemCardWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StandardController>(
      init: StandardController(),
      assignId: true,
      builder: (controller) {
        return Column(
          children: [
            Container(
              color: Colors.grey,
              height: 1.px,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(ProgressScreen.routes, arguments: [controller.item, item]);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyTextView(
                      item.title,
                      maxLinesNew: 3,
                      textStyleNew: MyTextStyle(
                        textColor: controller.appColors.textBlack1,
                        textSize: 20.px,
                        textWeight: FontWeight.w400,
                        textFamily: fontFamilyRegular,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      if (item.status == "true") ...[
                        Row(
                          children: [
                            ClipOval(
                                child: SvgPicture.string(
                              icComplete,
                            )).paddingOnly(right: 16.px),
                          ],
                        ),
                      ],
                      CommonButton(
                          radius: 100.px,
                          title: Strings.seeMore,
                          onTap: () {
                            Get.toNamed(ProgressScreen.routes, arguments: [controller.item, item])!.then((value) {
                              if (value != null) {
                                item.status = "true";
                                controller.change = value;
                                controller.update();
                              }
                            });
                          },
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.px,
                            vertical: 10.px,
                          ),
                          textWeight: FontWeight.w500,
                          textSize: 16.px,
                          color: controller.appColors.buttonColor,
                          textColor: controller.appColors.black),
                    ],
                  ),
                ],
              ),
            ).paddingSymmetric(vertical: 16.px),
            if (index == controller.dataList.length - 1) ...[
              Container(
                color: Colors.grey,
                height: 1.px,
              ),
            ]
          ],
        );
      },
    );
  }
}
