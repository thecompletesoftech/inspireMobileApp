import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';

import '../buildings_screen/buildings_screen.dart';
import '../propertydetails_screen/propertydetails_screen.dart';
import 'property_controller.dart';

class GridItemCardWidget extends GetView<PropertyController> {
  final RxCommonModel item;
  final int index;

  const GridItemCardWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PropertyController>(
        init: PropertyController(),
        assignId: true,
        builder: (controller) {
          return ShadowContainer(
            radius: 8.px,
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonButton(
                        title: Strings.annual,
                        textSize: 14.px,
                        isSmall: false,
                        isBig: true,
                        radius: 100.px,
                        color: controller.appColors.textField,
                        textWeight: FontWeight.w500,
                        textColor: item.check == false ? controller.appColors.textGreen : controller.appColors.textPink,
                        onTap: () {}),
                    Expanded(
                      flex: 0,
                      child: Row(
                        children: [
                          if (item.status == PropertyStatus.completed.toString() ||
                              item.status == PropertyStatus.inCompleted.toString())
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                    child: SvgPicture.string(
                                  item.status!.contains("completed") ? icComplete : icOops,
                                )).paddingOnly(right: 16.px),
                              ],
                            ),
                          InkWell(
                            onTap: () {
                              controller.navigateToMap();
                            },
                            child: SvgPicture.string(
                              icLocationColor,
                              height: 24.px,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).paddingOnly(bottom: 16.px),
                MyTextView(
                  item.title,
                  textStyleNew: MyTextStyle(
                    textColor: controller.appColors.black,
                    textSize: 20.px,
                    textWeight: FontWeight.w600,
                    textFamily: fontFamilyBold,
                  ),
                ).paddingOnly(bottom: 8.px),
                MyTextView(
                  item.subtitle,
                  textStyleNew: MyTextStyle(
                      textSize: 16.px,
                      textFamily: fontFamilyRegular,
                      textWeight: FontWeight.w400,
                      textColor: controller.appColors.lightText),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.string(
                          icCalenderColor ?? "",
                          height: 16.px,
                        ).paddingOnly(right: 8.px),
                        MyTextView(
                          "06/22/2023",
                          textStyleNew: MyTextStyle(
                            textSize: 12.px,
                            textWeight: FontWeight.w600,
                            textColor: controller.appColors.black,
                            textFamily: fontFamilyRegular,
                          ),
                        ),
                      ],
                    ).paddingOnly(bottom: 8.px),
                    Row(
                      children: [
                        SvgPicture.string(
                          icTimeColor ?? "",
                          height: 16.px,
                        ).paddingOnly(right: 8.px),
                        MyTextView(
                          "8:00",
                          textStyleNew: MyTextStyle(
                            textSize: 12.px,
                            textColor: controller.appColors.black,
                            textWeight: FontWeight.w600,
                            textFamily: fontFamilyRegular,
                          ),
                        ),
                      ],
                    )
                  ],
                ).paddingSymmetric(vertical: 16.px),
                CommonIconButton(
                        icon: icBuilding,
                        iconheigth: 20.px,
                        border: Border.all(color: controller.appColors.border, width: 2),
                        radius: 100.px,
                        title: Strings.buildings,
                        onTap: () {
                          Get.toNamed(BuildingsScreen.routes, arguments: item)!.then((value) {
                            if (value != null) {
                              item.status = value == 0
                                  ? PropertyStatus.completed.toString()
                                  : value == 1
                                      ? PropertyStatus.inCompleted.toString()
                                      : PropertyStatus.scheduled.toString();
                            }
                            controller.update();
                          });
                        },
                        padding: EdgeInsets.fromLTRB(16.px, 10.px, 24.px, 10.px),
                        textWeight: FontWeight.w600,
                        textSize: 16.px,
                        color: controller.appColors.transparent,
                        textColor: controller.appColors.appColor)
                    .paddingOnly(bottom: 8.px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonButton(
                        title: Strings.propertyDetails,
                        color: controller.appColors.transparent,
                        textColor: controller.appColors.appColor,
                        textWeight: FontWeight.w600,
                        textSize: 16.px,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.px,
                          vertical: 10.px,
                        ),
                        onTap: () {
                          Get.toNamed(PropertyDetailsScreen.routes, arguments: item)!
                              .then((value) => controller.update());
                        }),
                  ],
                ),
              ],
            ).paddingAll(24.px),
          );
        });
  }
}
