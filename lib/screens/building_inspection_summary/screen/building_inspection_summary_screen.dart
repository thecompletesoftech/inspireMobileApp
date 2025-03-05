import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/common_widgets/common_row.dart';
import 'package:public_housing/commons/strings.dart';
import 'package:public_housing/commons/svgImage.dart';
import 'package:public_housing/commons/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:public_housing/commons/common_widgets/base_widgets.dart';
import 'package:public_housing/commons/common_widgets/button_widget.dart';
import 'package:public_housing/commons/common_widgets/my_text_widgets.dart';
import 'package:public_housing/commons/common_widgets/icon_button_widget.dart';
import 'package:public_housing/commons/common_widgets/text_field_widgets.dart';
import 'package:public_housing/commons/common_widgets/common_appbar_widget.dart';
import 'package:public_housing/commons/common_widgets/shadow_container_widgets.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/screen/deficiencies_inside_screen.dart';
import 'package:public_housing/screens/building_standards_screen/controller/building_standards_controller.dart';
import 'package:public_housing/screens/building_inspection_summary/binding/building_inspection_summary_binding.dart';
import 'package:public_housing/screens/building_inspection_summary/controller/building_inspection_summary_controller.dart';

class BuildingInspectionSummaryScreen
    extends GetView<BuildingInspectionSummaryBinding> {
  const BuildingInspectionSummaryScreen({Key? key}) : super(key: key);

  static const routes = "/BuildingInspectionSummaryScreen";

  @override
  Widget build(BuildContext context) {
    BuildingStandardsController buildingStandardsController =
        Get.put(BuildingStandardsController());

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
                  '${buildingStandardsController.propertyInfo['name'] ?? ""} - ${buildingStandardsController.buildingInfo['name'] ?? ""}',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyTextView(
                              Strings.buildingInspectionSummary,
                              textStyleNew: MyTextStyle(
                                textColor: controller.appColors.appColor,
                                textWeight: FontWeight.w600,
                                textFamily: fontFamilyBold,
                                textSize: 32.px,
                              ),
                            ),
                            controller.isManually
                                ? CommonButton(
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
                                    textColor: controller.appColors.white,
                                    color: controller.appColors.appColor,
                                    onTap: () {
                                      controller.createInspection();
                                      controller.update();
                                    },
                                  )
                                : CommonButton(
                                    title: Strings.completeInspection,
                                    radius: 100.px,
                                    width: 171.px,
                                    height: 44.px,
                                    textSize: 16.px,
                                    textWeight: FontWeight.w500,
                                    textFamily: fontFamilyRegular,
                                    textColor: controller.appColors.lightText,
                                    color: controller.appColors.textPink,
                                    onTap: () async {
                                      await controller.createInspection();
                                    },
                                  ),
                          ],
                        ).paddingOnly(
                            left: 32.px,
                            top: 48.px,
                            right: 32.px,
                            bottom: 48.px),
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
                                controller.isManually
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: CommonTextField(
                                              isLable: true,
                                              readOnly: true,
                                              controller: controller
                                                  .inspectorController,
                                              color: controller
                                                  .appColors.transparent,
                                              prefixIcon: SvgPicture.string(
                                                icPerson,
                                                color:
                                                    controller.appColors.grey,
                                              ).paddingOnly(left: 15.px),
                                              padding: EdgeInsets.zero,
                                              contentPadding:
                                                  EdgeInsets.only(left: 15.px),
                                              shadowColor: controller
                                                  .appColors.transparent,
                                              labelText: Strings.userType,
                                            ),
                                          ),
                                          SizedBox(width: 16.px),
                                          Expanded(
                                            child: CommonTextField(
                                              isLable: true,
                                              readOnly: true,
                                              controller: controller
                                                  .inspectionDateController,
                                              color: controller
                                                  .appColors.transparent,
                                              suffixIcon: SvgPicture.string(
                                                icCalender2,
                                                color:
                                                    controller.appColors.grey,
                                              ),
                                              padding: EdgeInsets.zero,
                                              contentPadding:
                                                  EdgeInsets.only(left: 15.px),
                                              shadowColor: controller
                                                  .appColors.transparent,
                                              labelText: Strings.inspectionDate,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: CommonTextRow(
                                              title: 'Inspector: ',
                                              subTitle:
                                                  '${controller.inspectorName}',
                                              imageString: icPerson,
                                            ),
                                          ),
                                          SizedBox(width: 16.px),
                                          Expanded(
                                            child: CommonTextRow(
                                              title: 'Inspection Date: ',
                                              subTitle:
                                                  '${controller.inspectorDate}',
                                              imageString: icCalender2,
                                            ),
                                          ),
                                        ],
                                      ).paddingOnly(top: 24.px),
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
                                controller.isManually
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: CommonTextField(
                                              isLable: true,
                                              readOnly: true,
                                              controller: controller
                                                  .propertyNameController,
                                              color: controller
                                                  .appColors.transparent,
                                              prefixIcon: SvgPicture.string(
                                                icBuildingss,
                                                color:
                                                    controller.appColors.grey,
                                              ).paddingOnly(left: 15.px),
                                              suffixIcon: PopupMenuButton(
                                                key: controller.popupKey1,
                                                position:
                                                    PopupMenuPosition.under,
                                                tooltip: Strings.propertyName,
                                                onSelected: (value) {
                                                  controller
                                                      .actionPropertyNameSelected(
                                                          value);
                                                  controller.update();
                                                },
                                                itemBuilder: (context) =>
                                                    List.generate(
                                                        controller.propertyList
                                                            .length,
                                                        (index) =>
                                                            PopupMenuItem(
                                                              value: index,
                                                              child: Text(controller
                                                                      .propertyList[
                                                                  index]),
                                                            )),
                                                child: SvgPicture.string(
                                                  icDownArrow,
                                                  color:
                                                      controller.appColors.grey,
                                                ).paddingAll(10.px),
                                              ),
                                              padding: EdgeInsets.zero,
                                              contentPadding:
                                                  EdgeInsets.only(left: 15.px),
                                              shadowColor: controller
                                                  .appColors.transparent,
                                              labelText: Strings.propertyName,
                                            ),
                                          ),
                                          SizedBox(width: 16.px),
                                          Expanded(
                                            child: CommonTextField(
                                              readOnly: true,
                                              isLable: true,
                                              controller:
                                                  controller.cityController,
                                              color: controller
                                                  .appColors.transparent,
                                              suffixIcon: SvgPicture.string(
                                                icDownArrow,
                                                color: controller
                                                    .appColors.black
                                                    .withOpacity(.12),
                                              ).paddingAll(10.px),
                                              padding: EdgeInsets.zero,
                                              contentPadding:
                                                  EdgeInsets.only(left: 15.px),
                                              shadowColor: controller
                                                  .appColors.transparent,
                                              isLableColor: controller
                                                  .appColors.black
                                                  .withOpacity(.12),
                                              borderColor: controller
                                                  .appColors.black
                                                  .withOpacity(.12),
                                              labelText: Strings.city,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: CommonTextRow(
                                              title: 'Property Name: ',
                                              subTitle:
                                                  '${controller.propertyName}',
                                              imageString: icBuildingss,
                                            ),
                                          ),
                                        ],
                                      ),
                                controller.isManually
                                    ? Row(
                                        children: [
                                          Expanded(
                                            flex: 11,
                                            child: CommonTextField(
                                              isLable: true,
                                              readOnly: true,
                                              controller: controller
                                                  .propertyIDController,
                                              color: controller
                                                  .appColors.transparent,
                                              padding: EdgeInsets.zero,
                                              contentPadding: EdgeInsets.only(
                                                  left: 15.px,
                                                  top: 16.px,
                                                  bottom: 16.px),
                                              shadowColor: controller
                                                  .appColors.transparent,
                                              labelText: Strings.propertyID,
                                              isLableColor: controller
                                                  .appColors.black
                                                  .withOpacity(.12),
                                              borderColor: controller
                                                  .appColors.black
                                                  .withOpacity(.12),
                                            ),
                                          ),
                                          SizedBox(width: 16.px),
                                          Expanded(
                                            flex: 5,
                                            child: CommonTextField(
                                              isLable: true,
                                              readOnly: true,
                                              controller:
                                                  controller.stateController,
                                              color: controller
                                                  .appColors.transparent,
                                              padding: EdgeInsets.zero,
                                              contentPadding: EdgeInsets.only(
                                                  left: 15.px,
                                                  top: 16.px,
                                                  bottom: 16.px),
                                              shadowColor: controller
                                                  .appColors.transparent,
                                              labelText: Strings.state,
                                              isLableColor: controller
                                                  .appColors.black
                                                  .withOpacity(.12),
                                              borderColor: controller
                                                  .appColors.black
                                                  .withOpacity(.12),
                                            ),
                                          ),
                                          SizedBox(width: 16.px),
                                          Expanded(
                                            flex: 5,
                                            child: CommonTextField(
                                              isLable: true,
                                              readOnly: true,
                                              controller:
                                                  controller.zipController,
                                              color: controller
                                                  .appColors.transparent,
                                              padding: EdgeInsets.zero,
                                              contentPadding: EdgeInsets.only(
                                                  left: 15.px,
                                                  top: 16.px,
                                                  bottom: 16.px),
                                              shadowColor: controller
                                                  .appColors.transparent,
                                              labelText: Strings.zip,
                                              isLableColor: controller
                                                  .appColors.black
                                                  .withOpacity(.12),
                                              borderColor: controller
                                                  .appColors.black
                                                  .withOpacity(.12),
                                            ),
                                          ),
                                        ],
                                      ).paddingOnly(top: 32.px, bottom: 32.px)
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: CommonTextRow(
                                              title: 'Property Address: ',
                                              subTitle:
                                                  '${controller.propertyAddressController.text}, ${controller.cityController.text}, ${controller.stateController.text}, ${controller.zipController.text}',
                                              imageString: icLocation,
                                            ),
                                          ),
                                        ],
                                      ).paddingOnly(top: 12.px),
                                controller.isManually
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: CommonTextField(
                                              isLable: true,
                                              readOnly: true,
                                              controller: controller
                                                  .propertyAddressController,
                                              color: controller
                                                  .appColors.transparent,
                                              prefixIcon: SvgPicture.string(
                                                icLocation,
                                                color: controller
                                                    .appColors.black
                                                    .withOpacity(.12),
                                              ).paddingOnly(left: 15.px),
                                              padding: EdgeInsets.zero,
                                              contentPadding:
                                                  EdgeInsets.only(left: 15.px),
                                              shadowColor: controller
                                                  .appColors.transparent,
                                              labelText:
                                                  Strings.propertyAddress,
                                              isLableColor: controller
                                                  .appColors.black
                                                  .withOpacity(.12),
                                              borderColor: controller
                                                  .appColors.black
                                                  .withOpacity(.12),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: CommonTextRow(
                                              title: 'Property ID: ',
                                              subTitle:
                                                  '${controller.propertyIDController.text}',
                                              imageString: hasTagIcon,
                                            ),
                                          ),
                                        ],
                                      ).paddingOnly(top: 12.px),
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
                                controller.isManually
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: CommonTextField(
                                              isLable: true,
                                              readOnly: true,
                                              controller: controller
                                                  .buildingNameController,
                                              color: controller
                                                  .appColors.transparent,
                                              prefixIcon: SvgPicture.string(
                                                icBuildingss,
                                                color:
                                                    controller.appColors.grey,
                                              ).paddingOnly(left: 15.px),
                                              suffixIcon: PopupMenuButton(
                                                key: controller.popupKey3,
                                                position:
                                                    PopupMenuPosition.under,
                                                tooltip: Strings.buildingName,
                                                onSelected: (value) {
                                                  controller
                                                      .buildingSelected(value);
                                                  controller.update();
                                                },
                                                itemBuilder: (context) =>
                                                    List.generate(
                                                        controller.buildingList
                                                            .length,
                                                        (index) =>
                                                            PopupMenuItem(
                                                              value: index,
                                                              child: Text(controller
                                                                      .buildingList[
                                                                  index]),
                                                            )),
                                                child: SvgPicture.string(
                                                  icDownArrow,
                                                  color:
                                                      controller.appColors.grey,
                                                ).paddingAll(10.px),
                                              ),
                                              padding: EdgeInsets.zero,
                                              contentPadding:
                                                  EdgeInsets.only(left: 15.px),
                                              shadowColor: controller
                                                  .appColors.transparent,
                                              labelText: Strings.buildingName,
                                            ),
                                          ),
                                        ],
                                      ).paddingOnly(bottom: 32.px)
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: CommonTextRow(
                                              title: 'Building Name: ',
                                              subTitle:
                                                  '${controller.buildingNameController.text}',
                                              imageString: icBuildings,
                                            ),
                                          ),
                                          SizedBox(width: 16.px),
                                          Expanded(
                                            child: CommonTextRow(
                                              isImage: true,
                                              title: 'Year Constructed: ',
                                              subTitle:
                                                  '${controller.yearConstructedController.text}',
                                              imageString: icCalender2,
                                            ),
                                          ),
                                        ],
                                      ),
                                controller.isManually
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: CommonTextField(
                                              isLable: true,
                                              readOnly: true,
                                              controller: controller
                                                  .yearConstructedController,
                                              color: controller
                                                  .appColors.transparent,
                                              padding: EdgeInsets.zero,
                                              contentPadding: EdgeInsets.only(
                                                  left: 15.px,
                                                  top: 16.px,
                                                  bottom: 16.px),
                                              shadowColor: controller
                                                  .appColors.transparent,
                                              labelText:
                                                  Strings.yearConstructed,
                                              isLableColor: controller
                                                  .appColors.black
                                                  .withOpacity(.12),
                                              borderColor: controller
                                                  .appColors.black
                                                  .withOpacity(.12),
                                            ),
                                          ),
                                          SizedBox(width: 16.px),
                                          Expanded(
                                            child: CommonTextField(
                                              isLable: true,
                                              readOnly: true,
                                              controller: controller
                                                  .buildingTypeController,
                                              color: controller
                                                  .appColors.transparent,
                                              suffixIcon: SvgPicture.string(
                                                icDownArrow,
                                                color: controller
                                                    .appColors.black
                                                    .withOpacity(.12),
                                              ).paddingAll(10.px),
                                              padding: EdgeInsets.zero,
                                              contentPadding:
                                                  EdgeInsets.only(left: 15.px),
                                              shadowColor: controller
                                                  .appColors.transparent,
                                              labelText: Strings.buildingType,
                                              isLableColor: controller
                                                  .appColors.black
                                                  .withOpacity(.12),
                                              borderColor: controller
                                                  .appColors.black
                                                  .withOpacity(.12),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: CommonTextRow(
                                              title: 'Building Type: ',
                                              subTitle:
                                                  '${controller.buildingTypeController.text}',
                                              imageString: icBuildings,
                                            ),
                                          ),
                                        ],
                                      ).paddingOnly(top: 12.px),
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
                                                        controller.checked[i] =
                                                            value;
                                                        controller
                                                            .allSelected();
                                                        controller
                                                            .getCertificatesJson();
                                                        controller.update();
                                                      },
                                                      value:
                                                          controller.checked[i],
                                                      activeColor: controller
                                                          .appColors.appColor,
                                                    ),
                                                    MyTextView(
                                                      controller
                                                          .certificates![i]
                                                          .certificate,
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
                        ).paddingSymmetric(horizontal: 32.px),
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
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.deficiencyArea.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final item = controller.deficiencyArea[index];
                            return ListView.separated(
                              itemCount: item.deficiencyInspectionsReqModel !=
                                      null
                                  ? item.deficiencyInspectionsReqModel!.length
                                  : 0,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                var data =
                                    item.deficiencyInspectionsReqModel?[i];
                                return ShadowContainer2(
                                  padding: EdgeInsets.zero,
                                  divider: controller.appColors.divider,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MyTextView(
                                            item.name,
                                            isMaxLineWrap: true,
                                            textStyleNew: MyTextStyle(
                                              textSize: 20.px,
                                              textWeight: FontWeight.w600,
                                              textColor: controller
                                                  .appColors.lightText,
                                              textFamily: fontFamilyRegular,
                                            ),
                                          ),
                                          CommonButton(
                                            radius: 100.px,
                                            onTap: () {},
                                            title: data
                                                    ?.deficiencyItemHousingDeficiency
                                                    ?.housingItem
                                                    ?.item ??
                                                "",
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 24.px,
                                              vertical: 10.px,
                                            ),
                                            textWeight: FontWeight.w500,
                                            textSize: 16.px,
                                            color:
                                                controller.appColors.appBGColor,
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
                                                child: ListView.separated(
                                                  itemCount: data
                                                          ?.deficiencyProofPictures
                                                          ?.length ??
                                                      0,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemBuilder: (context, iz) {
                                                    var subData = data!
                                                        .deficiencyProofPictures?[iz];
                                                    return Container(
                                                      height: 184.px,
                                                      width: 184.px,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      13.px),
                                                          image: DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                      subData ??
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
                                                ),
                                              ).paddingAll(10.px),
                                            )
                                          ],
                                        ),
                                      ),
                                      MyTextView(
                                        data?.definition ?? "",
                                        isMaxLineWrap: true,
                                        textStyleNew: MyTextStyle(
                                          textSize: 20.px,
                                          textWeight: FontWeight.w400,
                                          textColor: controller.appColors.black,
                                          textFamily: fontFamilyRegular,
                                        ),
                                      ).paddingOnly(
                                          top: 18.px,
                                          left: 18.px,
                                          right: 18.px),
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
                                                    data?.comment ?? ""),
                                                dotIcons(controller, 'Date',
                                                    data?.date ?? ""),
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
                                                textColor: controller
                                                    .appColors.appColor,
                                                textWeight: FontWeight.w500,
                                                textSize: 14.px,
                                                onTap: () {
                                                  int mainIndex = index;
                                                  int subIndex = i;
                                                  Get.toNamed(
                                                      DeficienciesInsideScreen
                                                          .routes,
                                                      arguments: {
                                                        "deficiencyAreaList": item
                                                            .deficiencyAreaItems,
                                                        "deficiencyInspectionsReqModel":
                                                            data,
                                                        "deficiencyArea":
                                                            controller
                                                                .deficiencyArea[0],
                                                        "successListOfStandards":
                                                            item.deficiencyInspectionsReqModel
                                                      })?.then((value) async {
                                                    if (value != null) {
                                                      if (value[
                                                              'deficiencyInspectionsReqModel'] !=
                                                          null) {
                                                        await controller
                                                            .isDataUpdate(
                                                                mainIndex,
                                                                subIndex,
                                                                value[
                                                                    'deficiencyInspectionsReqModel']);
                                                      } else if (value[
                                                              'isEdit'] ==
                                                          true) {
                                                        controller
                                                            .isDataUpdateSuccess(
                                                                mainIndex,
                                                                subIndex);
                                                      }
                                                      controller.update();
                                                    }
                                                  });
                                                },
                                              ),
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
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 24.px,
                                );
                              },
                            );
                          },
                        ),
                        controller.isManually
                            ? CommonButton(
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
                                textColor: controller.appColors.white,
                                color: controller.appColors.appColor,
                                onTap: () async {
                                  await controller.createInspection();
                                  // if (controller.isSuccess == true) {
                                  //   Get.toNamed(UnitInspection.routes, arguments: {
                                  //     "deficiencyArea": controller.deficiencyArea,
                                  //     "buildingName": controller.buildingName,
                                  //     "buildingtype": controller.buildingType,
                                  //     "imagesList": controller.imagesList,
                                  //     "inspectionName": controller.inspectionName,
                                  //     "propertyInfo": controller.propertyInfo,
                                  //     "buildingInfo": controller.buildingInfo,
                                  //     "certificatesInfo": controller.certificatesInfo,
                                  //     "inspectorName": controller.inspectorName,
                                  //     "inspectorDate": controller.inspectorDate
                                  //   })?.then((value) {
                                  //     controller.update();
                                  //   });
                                  // }
                                  // controller.update();
                                },
                              ).paddingSymmetric(vertical: 24.px)
                            : SizedBox.shrink(),
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
