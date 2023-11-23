import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/certificates_screen/certificates_screen.dart';

import '../buildingdetails_screen/buildingdetails_screen.dart';
import 'buildings_controller.dart';

class ListItemCardWidget extends GetView<BuildingsController> {
  final RxCommonModel item;
  final int index;

  const ListItemCardWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildingsController>(
        init: BuildingsController(),
        assignId: true,
        builder: (controller) {
          return ShadowContainer(
              radius: 8.px,
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
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
                                          text: "${item.massage!} - ",
                                          style: MyTextStyle(
                                            textSize: 20.px,
                                            textWeight: FontWeight.w600,
                                            textColor: controller.appColors.black,
                                            textFamily: fontFamilyRegular,
                                          ),
                                        ),
                                        TextSpan(
                                          text: item.title,
                                          style: MyTextStyle(
                                            textSize: 20.px,
                                            textWeight: FontWeight.w400,
                                            textFamily: fontFamilyRegular,
                                            textColor: controller.appColors.lightText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: MyTextView(
                                          controller.item!.title,
                                          textStyleNew: MyTextStyle(
                                            textSize: 20.px,
                                            textWeight: FontWeight.w400,
                                            textFamily: fontFamilyRegular,
                                            textColor: controller.appColors.textBlack,
                                          ),
                                        ).paddingOnly(right: 24.px),
                                      ),
                                      Utils.isLandScapeMode(context) || Utils.isMediumScreen(context)
                                          ? const SizedBox()
                                          : CommonButton(
                                              title: item.check == false ? Strings.inSample : Strings.tenant,
                                              textSize: 14.px,
                                              isSmall: false,
                                              isBig: true,
                                              radius: 100.px,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (item.status == BuildingStatus.completed.toString() ||
                                item.status == BuildingStatus.inCompleted.toString())
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
                            MyTextView(
                              "${index + 1}${(index == 1) ? "nd" : "th"}",
                              textStyleNew: MyTextStyle(
                                  textSize: 20.px,
                                  textColor: controller.appColors.black,
                                  textWeight: FontWeight.w600,
                                  textFamily: fontFamilyBold),
                            ).paddingOnly(top: 16.px, right: 16.px),
                            !Utils.isLandScapeMode(context) && Utils.isTabletScreen(context)
                                ? const SizedBox()
                                : CommonButton(
                                        title: item.check == false ? Strings.annualInspection : Strings.tenant,
                                        textSize: 14.px,
                                        isSmall: false,
                                        isBig: true,
                                        radius: 100.px,
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
                              height: !Utils.isLandScapeMode(context) && Utils.isTabletScreen(context) ? 94.px : 88.px,
                              fit: BoxFit.cover,
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
                                height: 24.px,
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
                                height: 24.px,
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
                              title: Strings.certificates,
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.px,
                                vertical: 10.px,
                              ),
                              color: controller.appColors.transparent,
                              textColor: controller.appColors.appColor,
                              textWeight: FontWeight.w600,
                              textSize: 16.px,
                              onTap: () {
                                Get.toNamed(CertificatesScreen.routes, arguments: item)!
                                    .then((value) => controller.update());
                              }).paddingOnly(right: 16.px),
                          CommonButton(
                              border: Border.all(color: controller.appColors.border, width: 2),
                              radius: 100.px,
                              title: Utils.isSmallScreen(context)
                                  ? "Details"
                                  : Utils.isLandScapeMode(context) || Utils.isMediumScreen(context)
                                      ? Strings.inspectionDetails
                                      : "Details",
                              onTap: () {
                                Get.toNamed(BuildingDetailsScreen.routes, arguments: item)!.then((value) {
                                  if (value != null) {
                                    printAction(value.toString());
                                    controller.inComplete = true;
                                    controller.checkStatus();
                                    controller.update();
                                  }
                                });
                              },
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.px,
                                vertical: 10.px,
                              ),
                              textWeight: FontWeight.w600,
                              textSize: 16.px,
                              maxLinesNew: 2,
                              color: controller.appColors.transparent,
                              textColor: controller.appColors.appColor),
                        ],
                      ),
                    ],
                  ).paddingAll(16.px),
                ],
              ));
        }).paddingOnly(top: 10.px, bottom: 10.px);
  }
}
