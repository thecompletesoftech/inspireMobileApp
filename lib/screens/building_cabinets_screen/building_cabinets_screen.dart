import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/commons/common_widgets/common_container.dart';
import 'package:public_housing/screens/building_cabinets_screen/building_cabinets_binding.dart';
import 'package:public_housing/screens/building_cabinets_screen/building_cabinets_controller.dart';
import 'package:public_housing/screens/building_cabinets_screen/building_text_common_widget.dart';
import 'package:public_housing/screens/building_standards_screen/building_standards_controller.dart';

class BuildingCabinetsScreen extends GetView<BuildingCabinetsBinding> {
  const BuildingCabinetsScreen({Key? key}) : super(key: key);

  static const routes = "/BuildingCabinetsScreen";

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    var buildingDataModel = data['buildingDataModel'] as BuildingDataModel;
    return GetBuilder<BuildingCabinetsController>(
      init: BuildingCabinetsController(),
      assignId: true,
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ShadowContainer(
                  height: 116.px,
                  radius: 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.string(icBack),
                      ),
                      Image.asset(
                        ImagePath.logo,
                        width: 182.px,
                        height: 40.625.px,
                      ),
                      Flexible(
                        flex: 1,
                        child: Image.asset(
                          ImagePath.user,
                          width: 48.px,
                          height: 48.px,
                        ).paddingOnly(right: 8.px),
                      )
                    ],
                  ).paddingOnly(left: 32.px, right: 32.px),
                ),
                Column(
                  children: [
                    MyTextView(
                      '${Strings.propertyNames}${data['buildingName'] ?? ""}',
                      textStyleNew: MyTextStyle(
                        textColor: controller.appColors.appColor,
                        textWeight: FontWeight.w600,
                        textFamily: fontFamilyBold,
                        textSize: 20.px,
                      ),
                    ).paddingOnly(top: 32.px, bottom: 48.px),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyTextView(
                          "${buildingDataModel.title}",
                          textStyleNew: MyTextStyle(
                            textColor: controller.appColors.appColor,
                            textWeight: FontWeight.w500,
                            textFamily: fontFamilyBold,
                            textSize: 40.px,
                          ),
                        ),
                      ],
                    ).paddingOnly(bottom: 24.px),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CommonContainer(
                          radius: 100.px,
                          height: 44.px,
                          width: 210.px,
                          color: controller.appColors.appColor,
                          child: Row(
                            children: [
                              SvgPicture.string(
                                icArrowRight,
                                height: 24.px,
                              ),
                              MyTextView(
                                Strings.callForAidSystem,
                                textStyleNew: MyTextStyle(
                                  textColor: controller.appColors.white,
                                  textWeight: FontWeight.w500,
                                  textFamily: fontFamilyBold,
                                  textSize: 16.px,
                                ),
                              ).paddingOnly(left: 8.px),
                            ],
                          ).paddingSymmetric(vertical: 2.px, horizontal: 20.px),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                                title: Strings.definition,
                                description: Strings.aDedicated),
                            CommonText(
                              title: Strings.purpose,
                              description: Strings.stowItems,
                            ).paddingSymmetric(vertical: 24.px),
                            CommonText(
                                title: Strings.commonComponents,
                                description: Strings.door),
                            CommonText(
                                    title: Strings.moreInfo,
                                    description: Strings.none)
                                .paddingSymmetric(vertical: 24.px),
                          ],
                        )),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              buildingDataModel.image ?? "",
                              height: 248.px,
                              width: 332.px,
                              fit: BoxFit.cover,
                            ),
                            MyTextView(
                              Strings.location,
                              isMaxLineWrap: true,
                              textStyleNew: MyTextStyle(
                                textColor: AppColors().black,
                                textWeight: FontWeight.w400,
                                textFamily: fontFamilyBold,
                                textSize: 24.px,
                              ),
                            ).paddingOnly(top: 24.px),
                            Row(
                              children: [
                                MyTextView(
                                  Strings.unit,
                                  textStyleNew: MyTextStyle(
                                    textColor: AppColors().black,
                                    textWeight: FontWeight.w400,
                                    textFamily: fontFamilyBold,
                                    textSize: 20.px,
                                  ),
                                ),
                                MyTextView(
                                  Strings.laundry,
                                  textStyleNew: MyTextStyle(
                                    textColor: AppColors().black,
                                    textWeight: FontWeight.w400,
                                    textFamily: fontFamilyBold,
                                    textSize: 20.px,
                                  ),
                                ).paddingOnly(left: 20.px),
                              ],
                            ).paddingSymmetric(vertical: 24.px),
                            Row(
                              children: [
                                MyTextView(
                                  Strings.inside,
                                  textStyleNew: MyTextStyle(
                                    textColor: AppColors().black,
                                    textWeight: FontWeight.w400,
                                    textFamily: fontFamilyBold,
                                    textSize: 20.px,
                                  ),
                                ),
                                MyTextView(
                                  Strings.laundry,
                                  textStyleNew: MyTextStyle(
                                    textColor: AppColors().black,
                                    textWeight: FontWeight.w400,
                                    textFamily: fontFamilyBold,
                                    textSize: 20.px,
                                  ),
                                ).paddingOnly(left: 20.px),
                              ],
                            )
                          ],
                        ))
                      ],
                    ).paddingSymmetric(vertical: 56.px),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextView(
                          Strings.deficiencies,
                          textStyleNew: MyTextStyle(
                            textColor: AppColors().black,
                            textWeight: FontWeight.w400,
                            textFamily: fontFamilyBold,
                            textSize: 32.px,
                          ),
                        ),
                      ],
                    ),
                  ],
                ).paddingSymmetric(horizontal: 32.px),
              ],
            ),
          ),
        );
      },
    );
  }
}
