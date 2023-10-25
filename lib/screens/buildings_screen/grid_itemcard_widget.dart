import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';

import '../property_screen/property_screen.dart';
import 'buildings_controller.dart';

class GridItemCardWidget extends StatelessWidget {
  final RxCommonModel item;
  final int index;

  final BuildingsController controller = Get.find();
  GridItemCardWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
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
                  title: item.check == false ? Strings.inSample : Strings.tenant,
                  textSize: 12.px,
                  isSmall: false,
                  isBig: true,
                  radius: 20.px,
                  padding: EdgeInsets.all(8.px),
                  color: controller.appColors.textField,
                  textWeight: FontWeight.w600,
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
                      "${index + 1}${(index == 0) ? "st" : (index == 1) ? "nd" : "th"}",
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
            controller.item!.title,
            textStyleNew:
                MyTextStyle(textSize: 16.px, textFamily: fontFamilyRegular, textColor: controller.appColors.lightText),
          ),
          Container(
            height: 1.px,
            color: AppColors().divider,
          ).paddingSymmetric(vertical: 8.px),
          Row(
            children: [
              ClipOval(
                  child: Image.asset(
                item.imgId ?? "",
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
                        textWeight: FontWeight.w500,
                        textColor: controller.appColors.black,
                        textFamily: fontFamilyRegular,
                      ),
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
              ).paddingOnly(right: 8.px),
              MyTextView(
                "06/22/2023",
                textStyleNew: MyTextStyle(
                  textSize: 12.px,
                  textWeight: Utils.isMediumScreen(context) ? FontWeight.w600 : FontWeight.w500,
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
              ).paddingOnly(right: 8.px),
              MyTextView(
                "8:00",
                textStyleNew: MyTextStyle(
                  textSize: 12.px,
                  textColor: controller.appColors.black,
                  textWeight: Utils.isMediumScreen(context) ? FontWeight.w600 : FontWeight.w500,
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
                    Get.toNamed(PropertyScreen.routes, arguments: [controller.item!, item])!
                        .then((value) => controller.update());
                  },
                  height: 44.px,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.px,
                    vertical: 16.px,
                  ),
                  textWeight: FontWeight.w500,
                  textSize: 16.px,
                  color: controller.appColors.transparent,
                  textColor: controller.appColors.appColor)
              .paddingOnly(bottom: 8.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonButton(
                  // icon: icLocationColor,
                  // iconheigth: 20.px,
                  title: Strings.certificates,
                  color: controller.appColors.transparent,
                  textColor: controller.appColors.appColor,
                  textWeight: FontWeight.w500,
                  textSize: 16.px,
                  padding: EdgeInsets.fromLTRB(16.px, 10.px, 24.px, 10.px),
                  onTap: () {
                    // controller.navigateToMap();
                  }),
            ],
          ),
        ],
      ).paddingAll(24.px),
    );
  }
}
