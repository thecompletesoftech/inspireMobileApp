import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/standard_screen/standarditemcard_widget.dart';

import 'standard_controller.dart';

class StandardScreen extends GetView<StandardController> {
  const StandardScreen({Key? key}) : super(key: key);
  static const routes = "/StandardScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StandardController>(
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: Column(
            children: [
              CommonAppBar(
                color: controller.appColors.transparent,
                radius: 0.px,
                onClickBack: () {
                  Get.back(result: controller.change);
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
                                radius: 20.px,
                                textWeight: FontWeight.w500,
                                color: controller.appColors.white,
                                textColor: controller.item!.check == false
                                    ? controller.appColors.textGreen
                                    : controller.appColors.textPink,
                                onTap: () {})
                            : const SizedBox(),
                      ],
                    ).paddingOnly(top: 32.px, bottom: 40.px),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: MyTextView(
                                controller.item1!.title!.toString(),
                                isMaxLineWrap: true,
                                textStyleNew: MyTextStyle(
                                  textSize: 32.px,
                                  textWeight: FontWeight.w600,
                                  textColor: controller.appColors.appColor,
                                  textFamily: fontFamilyBold,
                                ),
                              ),
                            ),
                            if (Utils.isLandScapeMode(context)) ...[
                              Row(
                                children: [
                                  if (controller.index != 0)
                                    CommonIconButton(
                                      textColor: controller.appColors.white,
                                      title: controller.itemDetailsController.dataList[controller.index - 1].title!,
                                      onTap: () {
                                        if (controller.index != 0) {
                                          controller.item1 =
                                              controller.itemDetailsController.dataList[controller.index - 1];
                                          controller.index--;
                                          controller.update();
                                        }
                                      },
                                      padding: EdgeInsets.only(top: 10.px, bottom: 10.px, left: 16.px, right: 24.px),
                                      iconheigth: 20.px,
                                      textWeight: FontWeight.w500,
                                      textSize: 16.px,
                                      color: controller.appColors.appColor,
                                      icon: icArrowLeft,
                                    ),
                                  SizedBox(
                                    width: 16.px,
                                  ),
                                  if (controller.itemDetailsController.dataList.length - 1 != controller.index)
                                    CommonIconButton(
                                      textColor: controller.appColors.white,
                                      title: controller.itemDetailsController.dataList[controller.index + 1].title!,
                                      onTap: () {
                                        if (controller.itemDetailsController.dataList.length - 1 != controller.index) {
                                          controller.item1 =
                                              controller.itemDetailsController.dataList[controller.index + 1];
                                          controller.index++;
                                          controller.update();
                                        }
                                      },
                                      padding: EdgeInsets.only(top: 10.px, bottom: 10.px, left: 16.px, right: 24.px),
                                      iconheigth: 20.px,
                                      textWeight: FontWeight.w500,
                                      textSize: 16.px,
                                      color: controller.appColors.appColor,
                                      icon: icArrowRight,
                                    ),
                                ],
                              ),
                            ]
                          ],
                        ),
                        SizedBox(
                          height: Utils.isMediumScreen(context) ? 56.px : 32.px,
                        ),
                        if (!Utils.isLandScapeMode(context)) ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (controller.index != 0)
                                CommonIconButton(
                                  textColor: controller.appColors.white,
                                  title: controller.itemDetailsController.dataList[controller.index - 1].title!,
                                  onTap: () {
                                    if (controller.index != 0) {
                                      controller.item1 =
                                          controller.itemDetailsController.dataList[controller.index - 1];
                                      controller.index--;
                                      controller.update();
                                    }
                                  },
                                  padding: EdgeInsets.only(top: 10.px, bottom: 10.px, left: 16.px, right: 24.px),
                                  iconheigth: 20.px,
                                  textWeight: FontWeight.w500,
                                  textSize: 16.px,
                                  color: controller.appColors.appColor,
                                  icon: icArrowLeft,
                                ),
                              SizedBox(
                                width: 16.px,
                              ),
                              if (controller.itemDetailsController.dataList.length - 1 != controller.index)
                                CommonIconButton(
                                  textColor: controller.appColors.white,
                                  title: controller.itemDetailsController.dataList[controller.index + 1].title!,
                                  onTap: () {
                                    if (controller.itemDetailsController.dataList.length - 1 != controller.index) {
                                      controller.item1 =
                                          controller.itemDetailsController.dataList[controller.index + 1];
                                      controller.index++;
                                      controller.update();
                                    }
                                  },
                                  padding: EdgeInsets.only(top: 10.px, bottom: 10.px, left: 16.px, right: 24.px),
                                  iconheigth: 20.px,
                                  textWeight: FontWeight.w500,
                                  textSize: 16.px,
                                  color: controller.appColors.appColor,
                                  icon: icArrowRight,
                                )
                            ],
                          ).paddingOnly(bottom: 40.px),
                        ],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyTextView(
                                    Strings.definition,
                                    textStyleNew: MyTextStyle(
                                      textSize: 24.px,
                                      textWeight: FontWeight.w400,
                                      textColor: controller.appColors.black,
                                      textFamily: fontFamilyBold,
                                    ),
                                  ).paddingOnly(bottom: 8.px),
                                  MyTextView(
                                    "A box-shaped piece of furniture with doors or drawers. Some cabinets free-standing while others may be built into, or attached to, a wall.",
                                    isMaxLineWrap: true,
                                    textStyleNew: MyTextStyle(
                                      textSize: 16.px,
                                      textWeight: FontWeight.w400,
                                      textColor: controller.appColors.textBlack2,
                                      textFamily: fontFamilyBold,
                                    ),
                                  ),
                                  MyTextView(
                                    Strings.purpose,
                                    textStyleNew: MyTextStyle(
                                      textSize: 24.px,
                                      textWeight: FontWeight.w400,
                                      textColor: controller.appColors.black,
                                      textFamily: fontFamilyBold,
                                    ),
                                  ).paddingOnly(top: 24.px, bottom: 8.px),
                                  MyTextView(
                                    "Storing items, including food, sanitation, and household supplies.",
                                    isMaxLineWrap: true,
                                    textStyleNew: MyTextStyle(
                                      textSize: 16.px,
                                      textWeight: FontWeight.w400,
                                      textColor: controller.appColors.textBlack2,
                                      textFamily: fontFamilyBold,
                                    ),
                                  ),
                                  MyTextView(
                                    Strings.commonComponents,
                                    textStyleNew: MyTextStyle(
                                      textSize: 24.px,
                                      textWeight: FontWeight.w400,
                                      textColor: controller.appColors.black,
                                      textFamily: fontFamilyBold,
                                    ),
                                  ).paddingOnly(top: 24.px, bottom: 8.px),
                                  MyTextView(
                                    "Doors, Drawers, Hinges; Knobs; Drawer guide or slide; Shelves; Case or box",
                                    isMaxLineWrap: true,
                                    textStyleNew: MyTextStyle(
                                      textSize: 16.px,
                                      textWeight: FontWeight.w400,
                                      textColor: controller.appColors.textBlack2,
                                      textFamily: fontFamilyBold,
                                    ),
                                  ),
                                  MyTextView(
                                    Strings.moreInfo,
                                    textStyleNew: MyTextStyle(
                                      textSize: 24.px,
                                      textWeight: FontWeight.w400,
                                      textColor: controller.appColors.black,
                                      textFamily: fontFamilyBold,
                                    ),
                                  ).paddingOnly(top: 24.px, bottom: 8.px),
                                  SizedBox(
                                    width: 826.px,
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Sharp edges',
                                            style: MyTextStyle(
                                              textColor: controller.appColors.appColor,
                                              textSize: 16.px,
                                              textFamily: fontFamilyRegular,
                                              textWeight: FontWeight.w400,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ', ',
                                            style: MyTextStyle(
                                              textColor: controller.appColors.textBlack2,
                                              textSize: 16.px,
                                              textFamily: fontFamilyRegular,
                                              textWeight: FontWeight.w400,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'sinks',
                                            style: MyTextStyle(
                                              textColor: controller.appColors.appColor,
                                              textSize: 16.px,
                                              textFamily: fontFamilyRegular,
                                              textWeight: FontWeight.w400,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ', and ',
                                            style: MyTextStyle(
                                              textColor: controller.appColors.textBlack2,
                                              textSize: 16.px,
                                              textFamily: fontFamilyRegular,
                                              textWeight: FontWeight.w400,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'leaks',
                                            style: MyTextStyle(
                                              textColor: controller.appColors.appColor,
                                              textSize: 16.px,
                                              textFamily: fontFamilyRegular,
                                              textWeight: FontWeight.w400,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' are related standards.',
                                            style: MyTextStyle(
                                              textColor: controller.appColors.textBlack2,
                                              textSize: 16.px,
                                              textFamily: fontFamilyRegular,
                                              textWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 16.px,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      controller.item1!.image!,
                                      fit: BoxFit.fill,
                                      // scale: ScalingQuery(context).scale(0.3.px),
                                    ),
                                  ),
                                  MyTextView(
                                    Strings.location,
                                    textStyleNew: MyTextStyle(
                                      textSize: 24.px,
                                      textWeight: FontWeight.w400,
                                      textColor: controller.appColors.black,
                                      textFamily: fontFamilyBold,
                                    ),
                                  ).paddingSymmetric(vertical: 24.px),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyTextView(
                                        Strings.unit,
                                        textStyleNew: MyTextStyle(
                                          textSize: 20.px,
                                          textWeight: FontWeight.w400,
                                          textColor: controller.appColors.textBlack1,
                                          textFamily: fontFamilyMedium,
                                        ),
                                      ),
                                      Expanded(
                                          child: MyTextView(
                                        "Kitchens, bathroom, laundry",
                                        textAlignNew: TextAlign.end,
                                        isMaxLineWrap: true,
                                        textStyleNew: MyTextStyle(
                                          textSize: 20.px,
                                          textWeight: FontWeight.w400,
                                          textColor: controller.appColors.textBlack2,
                                          textFamily: fontFamilyMedium,
                                        ),
                                      )),
                                    ],
                                  ).paddingOnly(bottom: 24.px),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyTextView(
                                        Strings.inside,
                                        textStyleNew: MyTextStyle(
                                          textSize: 20.px,
                                          textWeight: FontWeight.w400,
                                          textColor: controller.appColors.textBlack1,
                                          textFamily: fontFamilyMedium,
                                        ),
                                      ),
                                      Expanded(
                                        child: MyTextView(
                                          "Kitchens, bathroom, laundry",
                                          textAlignNew: TextAlign.end,
                                          isMaxLineWrap: true,
                                          textStyleNew: MyTextStyle(
                                            textSize: 20.px,
                                            textWeight: FontWeight.w400,
                                            textColor: controller.appColors.textBlack2,
                                            textFamily: fontFamilyMedium,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ).paddingOnly(bottom: 72.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyTextView(
                              Strings.deficiencies,
                              textStyleNew: MyTextStyle(
                                textSize: 32.px,
                                textWeight: FontWeight.w400,
                                textColor: controller.appColors.black,
                                textFamily: fontFamilyBold,
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                            itemCount: controller.dataList.length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            padding: EdgeInsets.symmetric(vertical: 32.px),
                            itemBuilder: (BuildContext context, int index) {
                              RxCommonModel item = controller.dataList[index];
                              return StandardItemCardWidget(item: item, index: index);
                            }),
                        SizedBox(
                          height: 40.px,
                        )
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
