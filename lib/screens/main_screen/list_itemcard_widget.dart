import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/buildings_screen/buildings_screen.dart';

import '../propertydetails_screen/propertydetails_screen.dart';
import 'main_controller.dart';

class ListItemCardWidget extends StatelessWidget {
  final RxCommonModel item;
  final int index;
  final MainController controller = Get.find();

  ListItemCardWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
        radius: 8.px,
        height: 170.px,
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: item.title!,
                                    style: MyTextStyle(
                                      textSize: 20.px,
                                      textWeight: FontWeight.w600,
                                      textColor: controller.appColors.black,
                                      textFamily: fontFamilyRegular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: MyTextView(
                                    item.subtitle,
                                    textStyleNew: MyTextStyle(
                                      textSize: 20.px,
                                      textWeight: FontWeight.w400,
                                      textFamily: fontFamilyRegular,
                                      textColor: controller.appColors.textBlack,
                                    ),
                                  ).paddingOnly(right: 24.px),
                                ),
                                Utils.isLandScapeMode(context) || Utils.isMediumScreen(context)
                                    ? Container()
                                    : CommonButton(
                                        title: Strings.annual,
                                        textSize: 14.px,
                                        isSmall: false,
                                        isBig: true,
                                        radius: 24.px,
                                        padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
                                        color: controller.appColors.textField,
                                        textWeight: FontWeight.w500,
                                        textColor: item.check == false
                                            ? controller.appColors.textGreen
                                            : controller.appColors.textPink,
                                        onTap: () {}),
                              ],
                            ).paddingOnly(top: 8.px),
                          ],
                        ),
                      )
                    ],
                  ).paddingAll(16.px),
                ),
                Expanded(
                  flex: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.status == InspectionStatus.completed.toString() ||
                          item.status == InspectionStatus.inCompleted.toString())
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                                child: SvgPicture.string(
                              item.status!.contains("completed") ? icComplete : icOops,
                            )).paddingOnly(right: 16.px),
                          ],
                        ).paddingOnly(top: 16.px),
                      !Utils.isLandScapeMode(context) && Utils.isTabletScreen(context)
                          ? Container()
                          : CommonButton(
                                  title: Strings.annual,
                                  textSize: 14.px,
                                  isSmall: false,
                                  isBig: true,
                                  radius: 24.px,
                                  padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
                                  color: controller.appColors.textField,
                                  textWeight: FontWeight.w500,
                                  textColor: item.check == false
                                      ? controller.appColors.textGreen
                                      : controller.appColors.textPink,
                                  onTap: () {})
                              .paddingOnly(right: 16.px, top: 16.px),
                      Image.asset(
                        item.imgId ?? ImagePath.media1,
                        width: 80.px,
                        height: 88.px,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 2.px,
              color: AppColors().divider,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        SvgPicture.string(
                          icCalenderColor,
                        ).paddingOnly(right: 8.px),
                        MyTextView(
                          "06/22/2023",
                          isMaxLineWrap: true,
                          textStyleNew: MyTextStyle(
                            textSize: 16.px,
                            textWeight: FontWeight.w600,
                            textColor: controller.appColors.black,
                            textFamily: fontFamilyRegular,
                          ),
                        ),
                      ],
                    ).paddingOnly(right: 16.px),
                    Row(
                      children: [
                        SvgPicture.string(
                          icTimeColor,
                        ).paddingOnly(right: 8.px),
                        MyTextView(
                          "8:00",
                          isMaxLineWrap: true,
                          textStyleNew: MyTextStyle(
                            textSize: 16.px,
                            textColor: controller.appColors.black,
                            textWeight: FontWeight.w600,
                            textFamily: fontFamilyRegular,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    CommonButton(
                        title: Strings.propertyDetails,
                        padding: EdgeInsets.fromLTRB(16.px, 10.px, 24.px, 10.px),
                        color: controller.appColors.transparent,
                        textColor: controller.appColors.appColor,
                        textWeight: FontWeight.w500,
                        textSize: 16.px,
                        onTap: () {
                          Get.toNamed(PropertyDetailsScreen.routes, arguments: item)!
                              .then((value) => controller.update());
                        }).paddingOnly(right: 16.px),
                    CommonIconButton(
                        icon: icBuilding,
                        iconheigth: 20.px,
                        border: Border.all(color: controller.appColors.border, width: 2),
                        radius: 100.px,
                        title: Strings.buildings,
                        onTap: () {
                          Get.toNamed(BuildingsScreen.routes, arguments: item)!.then((value) => controller.update());
                        },
                        textWeight: FontWeight.w500,
                        textSize: 16.px,
                        maxLinesNew: 2,
                        color: controller.appColors.transparent,
                        textColor: controller.appColors.appColor),
                  ],
                ),
              ],
            ).paddingAll(16.px),
          ],
        )).paddingOnly(top: 10.px, bottom: 10.px);
  }
}
