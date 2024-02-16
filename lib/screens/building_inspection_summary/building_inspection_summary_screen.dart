import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:public_housing/commons/common_widgets/base_widgets.dart';
import 'package:public_housing/commons/common_widgets/button_widget.dart';
import 'package:public_housing/commons/common_widgets/common_appbar_widget.dart';
import 'package:public_housing/commons/common_widgets/iconbutton_widget.dart';
import 'package:public_housing/commons/common_widgets/mytext_widgets.dart';
import 'package:public_housing/commons/common_widgets/shadowcontainer_widgets.dart';
import 'package:public_housing/commons/common_widgets/textfeild_widgets.dart';
import 'package:public_housing/commons/constants.dart';
import 'package:public_housing/commons/strings.dart';
import 'package:public_housing/commons/svgImage.dart';
import 'package:public_housing/screens/building_inspection_summary/building_inspection_summary_binding.dart';
import 'package:public_housing/screens/building_inspection_summary/building_inspection_summary_controller.dart';
import 'package:public_housing/screens/inspection_screen/deficienciesCard_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildingInspectionSummaryScreen
    extends GetView<BuildingInspectionSummaryBinding> {
  const BuildingInspectionSummaryScreen({Key? key}) : super(key: key);

  static const routes = "/BuildingInspectionSummaryScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildingInspectionSummaryController>(
      init: BuildingInspectionSummaryController(),
      autoRemove: false,
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonAppBar(
                  color: controller.appColors.transparent,
                  radius: 0.px,
                  onClickBack: () {
                    Get.back();
                  },
                ),
                MyTextView(
                  '${Strings.propertyNames}${controller.buildingName}',
                  textStyleNew: MyTextStyle(
                    textColor: controller.appColors.appColor,
                    textWeight: FontWeight.w600,
                    textFamily: fontFamilyBold,
                    textSize: 20.px,
                  ),
                ).paddingOnly(top: 32.px, bottom: 48.px),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ShadowContainer(
                          radius: 8.px,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    MyTextView(
                                      Strings.inspectionInformation,
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
                                        color: controller.appColors.divider,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CommonTextField(
                                        isLable: true,
                                        readOnly: true,
                                        controller:
                                            controller.inspectorController,
                                        color: controller.appColors.transparent,
                                        prefixIcon: SvgPicture.string(
                                          icPerson,
                                          color: controller.appColors.grey,
                                        ).paddingOnly(left: 15.px),
                                        padding: EdgeInsets.zero,
                                        contentPadding:
                                            EdgeInsets.only(left: 15.px),
                                        shadowColor:
                                            controller.appColors.transparent,
                                        labelText: Strings.userType,
                                      ),
                                    ),
                                    SizedBox(width: 16.px),
                                    Expanded(
                                      child: CommonTextField(
                                        isLable: true,
                                        readOnly: true,
                                        controller:
                                            controller.inspectionDateController,
                                        color: controller.appColors.transparent,
                                        suffixIcon: SvgPicture.string(
                                          icCalender2,
                                          color: controller.appColors.grey,
                                        ),
                                        padding: EdgeInsets.zero,
                                        contentPadding:
                                            EdgeInsets.only(left: 15.px),
                                        shadowColor:
                                            controller.appColors.transparent,
                                        labelText: Strings.inspectionDate,
                                      ),
                                    ),
                                  ],
                                ).paddingOnly(top: 32.px),
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
                                        color: controller.appColors.divider,
                                      ),
                                    ),
                                  ],
                                ).paddingOnly(top: 32.px, bottom: 32.px),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CommonTextField(
                                        isLable: true,
                                        readOnly: true,
                                        controller:
                                            controller.propertyNameController,
                                        color: controller.appColors.transparent,
                                        prefixIcon: SvgPicture.string(
                                          icBuildingss,
                                          color: controller.appColors.grey,
                                        ).paddingOnly(left: 15.px),
                                        suffixIcon: PopupMenuButton(
                                          key: controller.popupKey1,
                                          position: PopupMenuPosition.under,
                                          tooltip: Strings.propertyName,
                                          onSelected: (value) {
                                            controller
                                                .actionPropertyNameSelected(
                                                    value);
                                            controller.update();
                                          },
                                          itemBuilder: (context) =>
                                              List.generate(
                                                  controller
                                                      .propertyList.length,
                                                  (index) => PopupMenuItem(
                                                        value: index,
                                                        child: Text(controller
                                                                .propertyList[
                                                            index]),
                                                      )),
                                          child: SvgPicture.string(
                                            icDownArrow,
                                            color: controller.appColors.grey,
                                          ).paddingAll(10.px),
                                        ),
                                        padding: EdgeInsets.zero,
                                        contentPadding:
                                            EdgeInsets.only(left: 15.px),
                                        shadowColor:
                                            controller.appColors.transparent,
                                        labelText: Strings.propertyName,
                                      ),
                                    ),
                                    SizedBox(width: 16.px),
                                    Expanded(
                                      child: CommonTextField(
                                        readOnly: true,
                                        isLable: true,
                                        controller: controller.cityController,
                                        color: controller.appColors.transparent,
                                        suffixIcon: SvgPicture.string(
                                          icDownArrow,
                                          color: controller.appColors.black
                                              .withOpacity(.12),
                                        ).paddingAll(10.px),
                                        padding: EdgeInsets.zero,
                                        contentPadding:
                                            EdgeInsets.only(left: 15.px),
                                        shadowColor:
                                            controller.appColors.transparent,
                                        isLableColor: controller.appColors.black
                                            .withOpacity(.12),
                                        borderColor: controller.appColors.black
                                            .withOpacity(.12),
                                        labelText: Strings.city,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 11,
                                      child: CommonTextField(
                                        isLable: true,
                                        readOnly: true,
                                        controller:
                                            controller.propertyIDController,
                                        color: controller.appColors.transparent,
                                        padding: EdgeInsets.zero,
                                        contentPadding: EdgeInsets.only(
                                            left: 15.px,
                                            top: 16.px,
                                            bottom: 16.px),
                                        shadowColor:
                                            controller.appColors.transparent,
                                        labelText: Strings.propertyID,
                                        isLableColor: controller.appColors.black
                                            .withOpacity(.12),
                                        borderColor: controller.appColors.black
                                            .withOpacity(.12),
                                      ),
                                    ),
                                    SizedBox(width: 16.px),
                                    Expanded(
                                      flex: 5,
                                      child: CommonTextField(
                                        isLable: true,
                                        readOnly: true,
                                        controller: controller.stateController,
                                        color: controller.appColors.transparent,
                                        padding: EdgeInsets.zero,
                                        contentPadding: EdgeInsets.only(
                                            left: 15.px,
                                            top: 16.px,
                                            bottom: 16.px),
                                        shadowColor:
                                            controller.appColors.transparent,
                                        labelText: Strings.state,
                                        isLableColor: controller.appColors.black
                                            .withOpacity(.12),
                                        borderColor: controller.appColors.black
                                            .withOpacity(.12),
                                      ),
                                    ),
                                    SizedBox(width: 16.px),
                                    Expanded(
                                      flex: 5,
                                      child: CommonTextField(
                                        isLable: true,
                                        readOnly: true,
                                        controller: controller.zipController,
                                        color: controller.appColors.transparent,
                                        padding: EdgeInsets.zero,
                                        contentPadding: EdgeInsets.only(
                                            left: 15.px,
                                            top: 16.px,
                                            bottom: 16.px),
                                        shadowColor:
                                            controller.appColors.transparent,
                                        labelText: Strings.zip,
                                        isLableColor: controller.appColors.black
                                            .withOpacity(.12),
                                        borderColor: controller.appColors.black
                                            .withOpacity(.12),
                                      ),
                                    ),
                                  ],
                                ).paddingOnly(top: 32.px, bottom: 32.px),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CommonTextField(
                                        isLable: true,
                                        readOnly: true,
                                        controller: controller
                                            .propertyAddressController,
                                        color: controller.appColors.transparent,
                                        prefixIcon: SvgPicture.string(
                                          icLocation,
                                          color: controller.appColors.black
                                              .withOpacity(.12),
                                        ).paddingOnly(left: 15.px),
                                        padding: EdgeInsets.zero,
                                        contentPadding:
                                            EdgeInsets.only(left: 15.px),
                                        shadowColor:
                                            controller.appColors.transparent,
                                        labelText: Strings.propertyAddress,
                                        isLableColor: controller.appColors.black
                                            .withOpacity(.12),
                                        borderColor: controller.appColors.black
                                            .withOpacity(.12),
                                      ),
                                    ),
                                  ],
                                ),
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
                                        color: controller.appColors.divider,
                                      ),
                                    ),
                                  ],
                                ).paddingOnly(top: 32.px, bottom: 32.px),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CommonTextField(
                                        isLable: true,
                                        readOnly: true,
                                        controller:
                                            controller.buildingNameController,
                                        color: controller.appColors.transparent,
                                        prefixIcon: SvgPicture.string(
                                          icBuildingss,
                                          color: controller.appColors.grey,
                                        ).paddingOnly(left: 15.px),
                                        suffixIcon: PopupMenuButton(
                                          key: controller.popupKey3,
                                          position: PopupMenuPosition.under,
                                          tooltip: Strings.buildingName,
                                          onSelected: (value) {
                                            controller.buildingSelected(value);
                                            controller.update();
                                          },
                                          itemBuilder: (context) =>
                                              List.generate(
                                                  controller
                                                      .buildingList.length,
                                                  (index) => PopupMenuItem(
                                                        value: index,
                                                        child: Text(controller
                                                                .buildingList[
                                                            index]),
                                                      )),
                                          child: SvgPicture.string(
                                            icDownArrow,
                                            color: controller.appColors.grey,
                                          ).paddingAll(10.px),
                                        ),
                                        padding: EdgeInsets.zero,
                                        contentPadding:
                                            EdgeInsets.only(left: 15.px),
                                        shadowColor:
                                            controller.appColors.transparent,
                                        labelText: Strings.buildingName,
                                      ),
                                    ),
                                  ],
                                ).paddingOnly(bottom: 32.px),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CommonTextField(
                                        isLable: true,
                                        readOnly: true,
                                        controller: controller
                                            .yearConstructedController,
                                        color: controller.appColors.transparent,
                                        padding: EdgeInsets.zero,
                                        contentPadding: EdgeInsets.only(
                                            left: 15.px,
                                            top: 16.px,
                                            bottom: 16.px),
                                        shadowColor:
                                            controller.appColors.transparent,
                                        labelText: Strings.yearConstructed,
                                        isLableColor: controller.appColors.black
                                            .withOpacity(.12),
                                        borderColor: controller.appColors.black
                                            .withOpacity(.12),
                                      ),
                                    ),
                                    SizedBox(width: 16.px),
                                    Expanded(
                                      child: CommonTextField(
                                        isLable: true,
                                        readOnly: true,
                                        controller:
                                            controller.buildingTypeController,
                                        color: controller.appColors.transparent,
                                        suffixIcon: SvgPicture.string(
                                          icDownArrow,
                                          color: controller.appColors.black
                                              .withOpacity(.12),
                                        ).paddingAll(10.px),
                                        padding: EdgeInsets.zero,
                                        contentPadding:
                                            EdgeInsets.only(left: 15.px),
                                        shadowColor:
                                            controller.appColors.transparent,
                                        labelText: Strings.buildingType,
                                        isLableColor: controller.appColors.black
                                            .withOpacity(.12),
                                        borderColor: controller.appColors.black
                                            .withOpacity(.12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.px)),
                                            border: Border.all(
                                                color: controller
                                                    .appColors.black
                                                    .withOpacity(.12))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Checkbox(
                                                  onChanged: (value) {
                                                    controller.isAllSelected(
                                                        value ?? false);
                                                  },
                                                  tristate: true,
                                                  value: controller.isData,
                                                  activeColor: controller
                                                      .appColors.appColor,
                                                ),
                                                MyTextView(
                                                  Strings.certificates,
                                                  textStyleNew: MyTextStyle(
                                                    textColor: controller
                                                        .appColors.black,
                                                    textWeight: FontWeight.w400,
                                                    textFamily: fontFamilyBold,
                                                    textSize: 16.px,
                                                  ),
                                                )
                                              ],
                                            ),
                                            for (var i = 0;
                                                i < controller.checked.length;
                                                i += 1)
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.symmetric(
                                                        horizontal: BorderSide(
                                                            color: controller
                                                                .appColors.black
                                                                .withOpacity(
                                                                    .12)))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Checkbox(
                                                      onChanged: (value) {
                                                        controller.checked[i]
                                                            .isChecked = value;
                                                        controller
                                                            .allSelected();
                                                        controller.update();
                                                      },
                                                      value: controller
                                                          .checked[i].isChecked,
                                                      activeColor: controller
                                                          .appColors.appColor,
                                                    ),
                                                    MyTextView(
                                                      controller
                                                          .checked[i].name,
                                                      textStyleNew: MyTextStyle(
                                                        textColor: controller
                                                            .appColors.black,
                                                        textWeight:
                                                            FontWeight.w400,
                                                        textFamily:
                                                            fontFamilyBold,
                                                        textSize: 16.px,
                                                      ),
                                                    ),
                                                  ],
                                                ).paddingOnly(left: 30.px),
                                              ),
                                          ],
                                        ),
                                      ).paddingOnly(top: 32.px),
                                    ),
                                  ],
                                )
                              ],
                            ).paddingOnly(
                                top: 32.px,
                                bottom: 30.px,
                                right: 24.px,
                                left: 24.px),
                          ),
                        ).paddingOnly(left: 32.px, right: 32.px),
                        Row(
                          children: [
                            MyTextView(
                              '${Strings.deficiencies}',
                              textStyleNew: MyTextStyle(
                                textColor: controller.appColors.black,
                                textWeight: FontWeight.w400,
                                textFamily: fontFamilyBold,
                                textSize: 24.px,
                              ),
                            ),
                            SizedBox(width: 16.px),
                            Expanded(
                              child: Container(
                                height: 2.px,
                                color: controller.appColors.divider,
                              ),
                            ),
                          ],
                        ).paddingAll(32.px),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.dataList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final item = controller.dataList[index];
                            return ShadowContainer2(
                              padding: EdgeInsets.zero,
                              divider: controller.appColors.divider,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyTextView(
                                        controller.inspectionName,
                                        isMaxLineWrap: true,
                                        textStyleNew: MyTextStyle(
                                          textSize: 20.px,
                                          textWeight: FontWeight.w600,
                                          textColor:
                                              controller.appColors.lightText,
                                          textFamily: fontFamilyRegular,
                                        ),
                                      ),
                                      CommonButton(
                                        radius: 100.px,
                                        title: Strings.inside,
                                        onTap: () {},
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 24.px,
                                          vertical: 10.px,
                                        ),
                                        textWeight: FontWeight.w500,
                                        textSize: 16.px,
                                        color: controller.appColors.buttonColor,
                                        textColor:
                                            controller.appColors.textGreen,
                                      ).paddingOnly(left: 24.px),
                                    ],
                                  ).paddingAll(18.px),
                                  ShadowContainer2(
                                    padding: EdgeInsets.zero,
                                    divider: controller.appColors.divider,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 184.px,
                                            alignment: Alignment.center,
                                            child: Center(
                                              child: ListView.separated(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      height: 184.px,
                                                      width: 184.px,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      13.px),
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  item.image ??
                                                                      ""),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return SizedBox(
                                                        width: 24.px);
                                                  },
                                                  itemCount: 3),
                                            ),
                                          ).paddingAll(10.px),
                                        )
                                      ],
                                    ),
                                  ),
                                  MyTextView(
                                    item.title,
                                    isMaxLineWrap: true,
                                    textStyleNew: MyTextStyle(
                                      textSize: 20.px,
                                      textWeight: FontWeight.w400,
                                      textColor: controller.appColors.black,
                                      textFamily: fontFamilyRegular,
                                    ),
                                  ).paddingOnly(
                                      top: 18.px, left: 18.px, right: 18.px),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            dotIcons(
                                                controller,
                                                Strings.comments,
                                                '6 of 10 cabinets are missing -NJ'),
                                            dotIcons(controller, 'Date',
                                                '06/18/2023'),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          CommonIconButton(
                                              icon: icEditNotes,
                                              iconheigth: 24.px,
                                              title: 'Edit',
                                              radius: 100.px,
                                              padding: EdgeInsets.fromLTRB(
                                                  16.px, 16.px, 20.px, 16.px),
                                              color: controller
                                                  .appColors.transparent,
                                              textColor:
                                                  controller.appColors.appColor,
                                              textWeight: FontWeight.w500,
                                              textSize: 14.px,
                                              onTap: () {}),
                                        ],
                                      )
                                    ],
                                  ).paddingOnly(
                                      top: 15.px,
                                      left: 18.px,
                                      right: 18.px,
                                      bottom: 18.px)
                                ],
                              ),
                            ).marginSymmetric(horizontal: 32.px);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 24.px,
                            );
                          },
                        ),
                        
                        
                        CommonButton(
                          title: Strings.saveAddUnit,
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
                          textColor: controller.getStartInspection()
                              ? controller.appColors.black
                              : controller.appColors.border1,
                          color: controller.getStartInspection()
                              ? controller.appColors.textPink
                              : controller.appColors.black
                                  .withOpacity(0.11999999731779099),
                          onTap: () {},
                        ).paddingSymmetric(vertical: 24.px),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget dotIcons(controller, title, description) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        width: 5,
        height: 5,
      ),
      MyTextView(
        '${title}: ',
        isMaxLineWrap: true,
        textStyleNew: MyTextStyle(
          textSize: 20.px,
          textWeight: FontWeight.w400,
          textColor: controller.appColors.black,
          textFamily: fontFamilyRegular,
        ),
      ).paddingOnly(left: 10.px),
      MyTextView(
        description,
        isMaxLineWrap: true,
        textStyleNew: MyTextStyle(
          textSize: 18.px,
          textWeight: FontWeight.w300,
          textColor: controller.appColors.black,
          textFamily: fontFamilyRegular,
        ),
      ),
    ],
  );
}
