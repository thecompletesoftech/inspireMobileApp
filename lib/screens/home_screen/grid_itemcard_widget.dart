import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';

import '../inspection_screen/inspection_screen.dart';
import 'home_controller.dart';

class GridItemCardWidget extends GetView<HomeController> {
  final RxCommonModel item;

  const GridItemCardWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
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
                        title: item.check == false ? Strings.annualInspection : Strings.tenant,
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
                            ),
                          MyTextView(
                            "${item.id}${(item.id == 1) ? "st" : (item.id == 2) ? "nd" : (item.id == 3) ? "rd" : "th"}",
                            textStyleNew: MyTextStyle(
                              textColor: controller.appColors.black,
                              textSize: 20.px,
                              textWeight: FontWeight.w600,
                              textFamily: fontFamilyBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).paddingOnly(bottom: 16.px),
                MyTextView(
                  item.massage,
                  textStyleNew: MyTextStyle(
                    textColor: controller.appColors.black,
                    textSize: 20.px,
                    textWeight: FontWeight.w600,
                    textFamily: fontFamilyBold,
                  ),
                ).paddingOnly(bottom: 8.px),
                MyTextView(
                  controller.item!.massage,
                  textStyleNew: MyTextStyle(
                      textSize: 16.px,
                      textFamily: fontFamilyRegular,
                      textWeight: FontWeight.w400,
                      textColor: controller.appColors.lightText),
                ),
                Container(
                  height: 1.px,
                  color: AppColors().divider,
                ).paddingSymmetric(vertical: 8.px),
                Row(
                  children: [
                    ClipOval(
                        child: Image.asset(
                      item.image ?? "",
                      width: 40.px,
                      height: 40.px,
                    )).paddingOnly(right: 8.px),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTextView(
                            item.title,
                            textStyleNew: MyTextStyle(
                              textSize: 14.px,
                              textWeight: FontWeight.w600,
                              textColor: controller.appColors.black,
                              textFamily: fontFamilyRegular,
                            ),
                          ).paddingOnly(bottom: 4.px),
                          MyTextView(
                            item.subtitle,
                            textStyleNew: MyTextStyle(
                                textSize: 12.px,
                                textWeight: FontWeight.w400,
                                textFamily: fontFamilyRegular,
                                textColor: controller.appColors.lightText),
                          ),
                        ],
                      ),
                    )
                  ],
                ).paddingOnly(bottom: 9.px),
                Container(
                  height: 1.px,
                  color: AppColors().divider,
                ).paddingOnly(bottom: 16.px),
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
                      "8:00 - 10:00 AM",
                      textStyleNew: MyTextStyle(
                        textSize: 12.px,
                        textColor: controller.appColors.black,
                        textWeight: FontWeight.w600,
                        textFamily: fontFamilyRegular,
                      ),
                    ),
                  ],
                ).paddingOnly(bottom: 16.px),
                CommonButton(
                        border: Border.all(color: controller.appColors.border, width: 2),
                        radius: 100.px,
                        title: Strings.inspectionDetails,
                        onTap: () {
                          Get.toNamed(InspectionScreen.routes, arguments: item)!.then((value) {
                            controller.inComplete = true;
                            controller.checkStatus();
                            controller.update();
                          });
                        },
                        height: 44.px,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.px,
                          vertical: 10.px,
                        ),
                        textWeight: FontWeight.w600,
                        textSize: 16.px,
                        textFamily: fontFamilyBold,
                        color: controller.appColors.transparent,
                        textColor: controller.appColors.appColor)
                    .paddingOnly(bottom: 8.px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonIconButton(
                        icon: icLocationColor,
                        iconheigth: 20.px,
                        title: Strings.mapRoute,
                        color: controller.appColors.transparent,
                        textColor: controller.appColors.appColor,
                        textWeight: FontWeight.w600,
                        textSize: 16.px,
                        padding: EdgeInsets.fromLTRB(16.px, 10.px, 24.px, 10.px),
                        textFamily: fontFamilyBold,
                        onTap: () {
                          try {
                            controller.navigateToMap();
                          }catch(e){
                            printError(e.toString());
                          }
                        }),
                  ],
                ),
              ],
            ).paddingAll(24.px),
          );
        });
  }
}
