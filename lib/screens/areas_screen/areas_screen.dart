import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';

import '../../responsive/scaling_query.dart';
import '../inspection_summary_screen/inspection_summary_screen.dart';
import '../kitchen_screen/kitchen_screen.dart';
import 'areas_controller.dart';

class AresScreen extends GetView<AreasController> {
  const AresScreen({Key? key}) : super(key: key);
  static const routes = "/AresScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AreasController>(
      init: AreasController(),
      assignId: true,
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: Column(
            children: [
              CommonAppBar(
                color: controller.appColors.transparent,
                radius: 0.px,
                onClickBack: () {
                  Get.back(result: controller.inComplete);
                },
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: MyTextView(
                            controller.item == null
                                ? ""
                                : "${controller.item!.massage}, ${controller.itemTitle} - ${controller.item!.title}",
                            textStyleNew: MyTextStyle(
                              textSize: Utils.isMediumScreen(context) ? 24.px : 20.px,
                              textWeight: FontWeight.w600,
                              textColor: controller.appColors.appColor,
                              textFamily: fontFamilyBold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.px,
                        ),
                        controller.item != null
                            ? CommonButton(
                                title: controller.item!.check == false ? Strings.annualInspection : Strings.tenant,
                                textSize: 14.px,
                                isSmall: false,
                                isBig: true,
                                radius: 100.px,
                                textWeight: FontWeight.w500,
                                color: controller.appColors.white,
                                textColor: controller.item!.check == false
                                    ? controller.appColors.textGreen
                                    : controller.appColors.textPink,
                                onTap: () {})
                            : const SizedBox(),
                      ],
                    ).paddingSymmetric(vertical: 32.px),
                    Column(
                      children: [
                        Utils.isTabletScreen(context)
                            ? ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.dataList.length,
                                itemBuilder: (context, index) {
                                  RxCommonModel item = controller.dataList[index];
                                  return ShadowContainer(
                                    radius: 8.px,
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.zero,
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(KitchenScreen.routes, arguments: [controller.item, item])!
                                            .then((value) {
                                          if (value != null && value == true) {
                                            item.status = "true";
                                            controller.checkStatus();
                                            controller.update();
                                          }
                                        });
                                      },
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8.px), bottomLeft: Radius.circular(8.px)),
                                              child: Image.asset(
                                                item.image ?? "",
                                                fit: BoxFit.cover,
                                                width: 108.px,
                                              ).paddingOnly(
                                                left: 10.px,
                                                top: 10.px,
                                                bottom: 10.px,
                                              ),
                                            ).paddingOnly(right: 16.px),
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: MyTextView(
                                                        item.title,
                                                        textStyleNew: MyTextStyle(
                                                          textSize: 20.px,
                                                          textWeight: FontWeight.w400,
                                                          textColor: controller.appColors.textBlack1,
                                                          textFamily: fontFamilyRegular,
                                                        ),
                                                      ),
                                                    ),
                                                    if (item.status == "true") ...[
                                                      ClipOval(
                                                          child: SvgPicture.string(
                                                        icComplete,
                                                      ))
                                                    ],
                                                    SizedBox(
                                                      width: 8.px,
                                                    ),
                                                  ],
                                                ).paddingOnly(bottom: 8.px),
                                                if (item.status == "false") ...[
                                                  MyTextView(item.failMessage ?? "1 Failed Standards",
                                                      textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w500,
                                                        textColor: controller.appColors.border,
                                                        textFamily: fontFamilyRegular,
                                                      )).paddingOnly(bottom: 8.px),
                                                ] else ...[
                                                  MyTextView("1 Failed Standards",
                                                      textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.appColors.appColor,
                                                        textFamily: fontFamilyRegular,
                                                      )).paddingOnly(bottom: 8.px),
                                                ],
                                                MyTextView(
                                                  item.subtitle,
                                                  maxLinesNew: 4,
                                                  textStyleNew: MyTextStyle(
                                                    textSize: 16.px,
                                                    textColor: controller.appColors.textBlack2,
                                                    textWeight: FontWeight.w400,
                                                    textFamily: fontFamilyRegular,
                                                  ),
                                                ),
                                              ],
                                            ).paddingSymmetric(horizontal: 8.px, vertical: 16.px),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 32.px,
                                  );
                                },
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const BouncingScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: Utils.isLandScapeMode(context)
                                        ? 2
                                        : Utils.isTabletScreen(context)
                                            ? 1
                                            : 2,
                                    childAspectRatio: Utils.isLandScapeMode(context)
                                        ? Utils.isMediumScreen(context)
                                            ? ScalingQuery(context).moderateScale(1.95.px) // mini
                                            : ScalingQuery(context).moderateScale(2.15.px) //.....
                                        : ScalingQuery(context).scale(0.95.px), //.....
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 32),
                                itemCount: controller.dataList.length,
                                itemBuilder: (context, index) {
                                  RxCommonModel item = controller.dataList[index];
                                  return ShadowContainer(
                                    radius: 8.px,
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.zero,
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(KitchenScreen.routes, arguments: [controller.item, item])!
                                            .then((value) {
                                          if (value != null && value == true) {
                                            item.status = "true";
                                            controller.checkStatus();
                                            controller.update();
                                          }
                                        });
                                      },
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8.px), bottomLeft: Radius.circular(8.px)),
                                              child: Image.asset(
                                                item.image ?? "",
                                                fit: BoxFit.cover,
                                                width: 108.px,
                                              ).paddingOnly(
                                                left: 10.px,
                                                top: 10.px,
                                                bottom: 10.px,
                                              ),
                                            ).paddingOnly(right: 16.px),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: MyTextView(
                                                          item.title,
                                                          textStyleNew: MyTextStyle(
                                                            textSize: 20.px,
                                                            textWeight: FontWeight.w400,
                                                            textColor: controller.appColors.textBlack1,
                                                            textFamily: fontFamilyRegular,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 16.px,
                                                      ),
                                                      if (item.status == "true") ...[
                                                        ClipOval(
                                                            child: SvgPicture.string(
                                                          icComplete,
                                                        ))
                                                      ]
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.px,
                                                ),
                                                if (item.status == "false") ...[
                                                  MyTextView(item.failMessage ?? "1 Failed Standards",
                                                      textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w500,
                                                        textColor: controller.appColors.border,
                                                        textFamily: fontFamilyRegular,
                                                      )).paddingOnly(bottom: 8.px),
                                                ] else ...[
                                                  MyTextView("1 Failed Standards",
                                                      textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.appColors.appColor,
                                                        textFamily: fontFamilyRegular,
                                                      )).paddingOnly(bottom: 8.px),
                                                ],
                                                MyTextView(
                                                  item.subtitle,
                                                  maxLinesNew: 4,
                                                  textStyleNew: MyTextStyle(
                                                    textSize: 16.px,
                                                    textColor: controller.appColors.textBlack2,
                                                    textWeight: FontWeight.w400,
                                                    textFamily: fontFamilyRegular,
                                                  ),
                                                ),
                                              ],
                                            ).paddingSymmetric(horizontal: 8.px, vertical: 16.px),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonButton(
                              color: controller.visibleBtn
                                  ? controller.appColors.buttonColor
                                  : controller.appColors.black.withOpacity(0.11999999731779099),
                              textColor:
                                  controller.visibleBtn ? controller.appColors.black : controller.appColors.border1,
                              title: Strings.inspectionSummary,
                              onTap: () {
                                // if (controller.visibleBtn) {
                                Get.toNamed(InspectionSummaryScreen.routes, arguments: controller.item);
                                // }
                              },
                              padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                              textWeight: FontWeight.w500,
                              radius: 35.px,
                            ),
                          ],
                        ).paddingSymmetric(vertical: 42.px),
                      ],
                    ).paddingSymmetric(horizontal: 32.px),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
