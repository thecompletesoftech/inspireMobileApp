import 'package:flutter_svg/svg.dart';
import 'package:public_housing/screens/Unit_building_standards_screen/screen/building_standards_screen.dart';
import 'package:public_housing/screens/unit_Inpection_screen/unitinspection_controller.dart';
import '../../../commons/all.dart';

import '../TitleheadmenuWidgte.dart';

class UnitInspection extends GetView<UnitController> {
  const UnitInspection({Key? key}) : super(key: key);
  static const routes = "/UnitInspection";
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnitController>(
      init: UnitController(),
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
                  Get.back();
                },
              ),
              Expanded(
                child: ListView(
                  children: [
                    Center(
                      child: MyTextView(
                        Strings.unitinpection,
                        textStyleNew: MyTextStyle(
                          textColor: controller.appColors.appColor,
                          textWeight: FontWeight.w600,
                          textFamily: fontFamilyBold,
                          textSize: 32.px,
                        ),
                      ).paddingOnly(
                          top: 24.px, left: 32.px, right: 32.px, bottom: 32.px),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                MyTextView(
                                  Strings.unitInformation,
                                  textStyleNew: MyTextStyle(
                                    textColor: controller.appColors.black,
                                    textWeight: FontWeight.w400,
                                    textFamily: fontFamilyBold,
                                    textSize: 24.px,
                                  ),
                                ).paddingOnly(right: 10.px),
                                Expanded(
                                  child: Container(
                                    height: 2.px,
                                    color: AppColors().divider,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CommonTextField(
                                    isLable: true,
                                    readOnly: false,
                                    controller: controller.unitNumberName,
                                    onChange: ((value) {
                                      controller.update();
                                    }),
                                    color: controller.appColors.transparent,
                                    prefixIcon: SvgPicture.string(
                                      ichome1,
                                      color: controller.appColors.grey,
                                    ).paddingOnly(left: 15.px, right: 15.px),
                                    padding: EdgeInsets.zero,
                                    contentPadding:
                                        EdgeInsets.only(left: 25.px),
                                    shadowColor:
                                        controller.appColors.transparent,
                                    labelText: Strings.unitnumberName,
                                  ),
                                ),
                                SizedBox(width: 16.px),
                                Expanded(
                                  child: CommonTextField(
                                    isLable: true,
                                    readOnly: false,
                                    onChange: ((value) {
                                      controller.update();
                                    }),
                                    controller: controller.unitAddress,
                                    color: controller.appColors.transparent,
                                    prefixIcon: SvgPicture.string(
                                      iclocation,
                                      color: controller.appColors.grey,
                                    ).paddingOnly(left: 15.px, right: 15.px),
                                    padding: EdgeInsets.zero,
                                    contentPadding:
                                        EdgeInsets.only(left: 25.px),
                                    shadowColor:
                                        controller.appColors.transparent,
                                    labelText: Strings.unitaddress,
                                  ),
                                ),
                              ],
                            ).paddingOnly(top: 32.px),
                            Row(
                              children: [
                                Expanded(
                                  child: CommonTextField(
                                    isLable: true,
                                    readOnly: false,
                                    inputType: TextInputType.number,
                                    controller: controller.bedrooms,
                                    color: controller.appColors.transparent,
                                    prefixIcon: SvgPicture.string(
                                      icbedrooms,
                                      color: controller.appColors.grey,
                                    ).paddingOnly(left: 15.px, right: 15.px),
                                    padding: EdgeInsets.zero,
                                    contentPadding:
                                        EdgeInsets.only(left: 25.px),
                                    shadowColor:
                                        controller.appColors.transparent,
                                    labelText: Strings.bedroom,
                                  ),
                                ),
                                SizedBox(width: 16.px),
                                Expanded(
                                  child: CommonTextField(
                                    isLable: true,
                                    readOnly: false,
                                    inputType: TextInputType.number,
                                    controller: controller.bathrooms,
                                    color: controller.appColors.transparent,
                                    prefixIcon: SvgPicture.string(
                                      icbathroom,
                                      color: controller.appColors.grey,
                                    ).paddingOnly(left: 15.px, right: 15.px),
                                    padding: EdgeInsets.zero,
                                    contentPadding:
                                        EdgeInsets.only(left: 25.px),
                                    shadowColor:
                                        controller.appColors.transparent,
                                    labelText: Strings.bathroom,
                                  ),
                                ),
                              ],
                            ).paddingOnly(top: 32.px, bottom: 40.px),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    MyTextView(
                                      Strings.unitoccupied,
                                      textStyleNew: MyTextStyle(
                                        textColor: controller.appColors.black,
                                        textWeight: FontWeight.w400,
                                        textFamily: fontFamilyBold,
                                        textSize: 16.px,
                                      ),
                                    ).paddingOnly(right: 20.px),
                                    Switch(
                                      activeTrackColor:
                                          controller.appColors.appColor,
                                      inactiveTrackColor:
                                          controller.appColors.inactiveColor,
                                      inactiveThumbImage: Image.asset(
                                        ImagePath.uncheckmark,
                                        height: 60,
                                        width: 60,
                                      ).image,
                                      activeThumbImage: Image.asset(
                                        ImagePath.checkmark,
                                        height: 60,
                                        width: 60,
                                      ).image,
                                      // SvgPicture.string(icbathroom),
                                      activeColor: controller.appColors.white,
                                      value: controller.switchButton.value,
                                      onChanged: (value) {
                                        controller.switchButton.value =
                                            !controller.switchButton.value;
                                        controller.update();
                                      },
                                    ),
                                    MyTextView(
                                      controller.switchButton.value
                                          ? Strings.yes
                                          : Strings.no,
                                      textStyleNew: MyTextStyle(
                                        textColor: controller.appColors.black,
                                        textWeight: FontWeight.w400,
                                        textFamily: fontFamilyBold,
                                        textSize: 16.px,
                                      ),
                                    ).paddingOnly(left: 10.px),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: (() {
                                    if (controller.getUnitInspection()) {
                                      controller.unitCannotInspected(
                                          context, Get.arguments);
                                    }
                                  }),
                                  child: MyTextView(
                                    Strings.unitcannitbeinspected,
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.getUnitInspection()
                                          ? controller.appColors.appColor
                                          : controller.appColors.border1,
                                      textWeight: FontWeight.w500,
                                      textFamily: fontFamilyBold,
                                      textSize: 16.px,
                                    ),
                                  ).paddingOnly(right: 10.px),
                                ),
                              ],
                            ),
                          ],
                        ).paddingOnly(
                            top: 32.px,
                            bottom: 30.px,
                            right: 24.px,
                            left: 24.px),
                      ),
                    ).paddingOnly(left: 32.px, right: 32.px, bottom: 10.px),
                    Center(
                      child: CommonButton(
                        title: Strings.startInspection,
                        radius: 100.px,
                        width: 171.px,
                        height: 44.px,
                        padding: EdgeInsets.symmetric(
                          vertical: 15.px,
                          horizontal: 24.px,
                        ),
                        textSize: 16.px,
                        textWeight: FontWeight.w500,
                        textFamily: fontFamilyRegular,
                        textColor: controller.getUnitInspection()
                            ? controller.appColors.black
                            : controller.appColors.border1,
                        color: controller.getUnitInspection()
                            ? controller.appColors.textPink
                            : controller.appColors.black
                                .withOpacity(0.11999999731779099),
                        onTap: () async {
                          if (controller.getUnitInspection()) {
                            controller.getUnitJson();
                            Get.toNamed(
                              UnitBuildingStandardsScreen.routes,
                              preventDuplicates: false,
                              arguments: {
                                "unitinfo": controller.unitJson,
                                "propertyInfo": Get.arguments['propertyInfo'],
                                "buildingInfo": Get.arguments['buildingInfo'],
                                "buildingtype": Get.arguments['buildingtype'],
                                "switchvalue": controller.switchButton.value,
                                "certificatesInfo":
                                    Get.arguments['certificatesInfo'],
                                "inspectorName": Get.arguments['inspectorName'],
                                "inspectorDate": Get.arguments['inspectorDate'],
                              },
                            );
                          }
                        },
                      ).paddingSymmetric(vertical: 24.px),
                    ),
                    Row(
                      children: [
                        MyTextView(
                          Strings.propertyInformation,
                          textStyleNew: MyTextStyle(
                            textColor: controller.appColors.black,
                            textWeight: FontWeight.w400,
                            textFamily: fontFamilyBold,
                            textSize: 24.px,
                          ),
                        ).paddingOnly(right: 10.px),
                        Expanded(
                          child: Container(
                            height: 2.px,
                            color: AppColors().divider,
                          ),
                        ),
                      ],
                    ).paddingOnly(left: 32.px, right: 32.px, bottom: 20.px),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleheadMenu(
                          title: Strings.propertyName,
                          value: controller.propertyInfo['name'].toString(),
                        ),
                        Row(
                          children: [
                            TitleheadMenu(
                              title: Strings.city,
                              value: controller.propertyInfo['city'].toString(),
                            ).paddingOnly(right: 20.px),
                            TitleheadMenu(
                              title: Strings.propertyID,
                              value: controller.propertyInfo['id'].toString(),
                            ),
                          ],
                        ),
                      ],
                    ).paddingOnly(left: 32.px, right: 32.px, bottom: 20.px),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleheadMenu(
                          title: Strings.propertyAddress,
                          value: controller.propertyInfo['address'].toString(),
                        ),
                        Row(
                          children: [
                            TitleheadMenu(
                              title: Strings.state,
                              value:
                                  controller.propertyInfo['state'].toString(),
                            ).paddingOnly(right: 20.px),
                            TitleheadMenu(
                              title: Strings.zip,
                              value: controller.propertyInfo['zip'].toString(),
                            ),
                          ],
                        ),
                      ],
                    ).paddingOnly(left: 32.px, right: 32.px, bottom: 40.px),
                    Row(
                      children: [
                        MyTextView(
                          Strings.buildingInformation,
                          textStyleNew: MyTextStyle(
                            textColor: controller.appColors.black,
                            textWeight: FontWeight.w400,
                            textFamily: fontFamilyBold,
                            textSize: 24.px,
                          ),
                        ).paddingOnly(right: 10.px),
                        Expanded(
                          child: Container(
                            height: 2.px,
                            color: AppColors().divider,
                          ),
                        ),
                      ],
                    ).paddingOnly(left: 32.px, right: 32.px, bottom: 20.px),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleheadMenu(
                          title: Strings.buildingName,
                          value: controller.buildingInfo['name'].toString(),
                        ),
                        TitleheadMenu(
                          title: Strings.buildingType,
                          value: controller.buildingType.value.toString(),
                        ),
                      ],
                    ).paddingOnly(left: 32.px, right: 32.px, bottom: 20.px),
                    TitleheadMenu(
                      title: Strings.yearConstructed,
                      value:
                          controller.buildingInfo['constructed_year'].toString(),
                    ).paddingOnly(left: 32.px, right: 32.px, bottom: 40.px),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
