import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:public_housing/commons/common_widgets/common_row.dart';
import 'package:public_housing/screens/unit_inspection_screen/widget/title_head_menu_widget.dart';
import 'package:public_housing/screens/unit_inspection_summary_screen/controller/unit_inspection_summary_controller.dart';
import '../../../commons/all.dart';
import '../../unit_deficiencies_inside_screen/screen/unit_deficiencies_inside_screen.dart';

class UnitInspectionSummary extends GetView<UnitInspectionSummaryController> {
  const UnitInspectionSummary({Key? key}) : super(key: key);
  static const routes = "/UnitInspectionSummary";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnitInspectionSummaryController>(
      init: UnitInspectionSummaryController(),
      assignId: true,
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: Stack(
            children: [
              Column(
                children: [
                  CommonAppBar(
                    color: controller.appColors.transparent,
                    radius: 0.px,
                    onClickBack: () {
                      Get.back(result: {
                        "propertyInfo": Get.arguments == null
                            ? ""
                            : Get.arguments['propertyInfo'],
                        "buildingInfo": Get.arguments == null
                            ? ""
                            : Get.arguments['buildingInfo'],
                        "buildingtype": Get.arguments == null
                            ? ""
                            : Get.arguments['buildingtype'],
                        "cerificateList": Get.arguments['certificatesInfo'],
                        "deficiencyArea": Get.arguments['deficiencyArea'],
                        "switchvalue": controller.switchButton.value,
                        "inspectorDate": Get.arguments['inspectorDate']
                      });
                      // }
                    },
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Center(
                          child: MyTextView(
                            '${controller.propertyName} - ${controller.buildingName} - ${controller.unitNumberName.text}',
                            textStyleNew: MyTextStyle(
                              textColor: controller.appColors.appColor,
                              textWeight: FontWeight.w600,
                              textFamily: fontFamilyBold,
                              textSize: 20.px,
                            ),
                          ).paddingOnly(top: 32.px, bottom: 48.px),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: MyTextView(
                            Strings.unitinpectionsummary,
                            textAlignNew: TextAlign.left,
                            textStyleNew: MyTextStyle(
                              textColor: controller.appColors.appColor,
                              textWeight: FontWeight.w600,
                              textFamily: fontFamilyBold,
                              textSize: 32.px,
                            ),
                          ).paddingOnly(left: 24.px, bottom: 40.px),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TypeAheadField(
                              controller: controller.unitHouseKeeping,
                              suggestionsCallback: (search) {
                                // controller.searchBuilding(
                                //     searchText: search);
                                controller.update();
                                return controller.unitHouseKeepingList;
                              },
                              builder: (context, c, focusNode) {
                                return CommonTextField(
                                  focusNode: focusNode,
                                  readOnly: true,
                                  isLable: true,
                                  controller: c,
                                  color: controller.appColors.transparent,
                                  suffixIcon: SvgPicture.string(
                                    icDownArrow,
                                    color: controller.appColors.grey,
                                  ).paddingAll(10.px),
                                  padding: EdgeInsets.zero,
                                  contentPadding: EdgeInsets.only(left: 15.px),
                                  shadowColor: controller.appColors.transparent,
                                  labelText: Strings.unitHousekeeping,
                                );
                              },
                              itemBuilder: (context, dynamic i) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      i['title'].toString(),
                                      style: MyTextStyle(
                                        textColor: controller.appColors.black,
                                        textWeight: FontWeight.w400,
                                        textFamily: fontFamilyBold,
                                        textSize: 16.px,
                                      ),
                                    ),
                                    Text(
                                      i['value'].toString(),
                                      style: MyTextStyle(
                                        textColor:
                                            controller.appColors.textcolor,
                                        textWeight: FontWeight.w400,
                                        textFamily: fontFamilyBold,
                                        textSize: 14.px,
                                      ),
                                    ),
                                    if (i !=
                                        controller.unitHouseKeepingList.length -
                                            1)
                                      Divider()
                                  ],
                                ).paddingSymmetric(horizontal: 10, vertical: 5);
                              },
                              onSelected: (value) async {
                                controller
                                    .actionUnitHousekeeping(value['title']);
                                controller.update();
                              },
                            )),
                            SizedBox(width: 16.px),
                            Expanded(
                              child: TypeAheadField(
                                controller: controller.generalPhysicalCondition,
                                suggestionsCallback: (search) {
                                  controller.update();
                                  return controller
                                      .generalPhysicalConditionList;
                                },
                                builder: (context, c, focusNode) {
                                  return CommonTextField(
                                    focusNode: focusNode,
                                    readOnly: true,
                                    isLable: true,
                                    controller: c,
                                    color: controller.appColors.transparent,
                                    suffixIcon: SvgPicture.string(
                                      icDownArrow,
                                      color: controller.appColors.grey,
                                    ).paddingAll(10.px),
                                    padding: EdgeInsets.zero,
                                    contentPadding:
                                        EdgeInsets.only(left: 15.px),
                                    shadowColor:
                                        controller.appColors.transparent,
                                    labelText: Strings.generalphysicalcondition,
                                  );
                                },
                                itemBuilder: (context, dynamic i) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        i['title'].toString(),
                                        style: MyTextStyle(
                                          textColor: controller.appColors.black,
                                          textWeight: FontWeight.w400,
                                          textFamily: fontFamilyBold,
                                          textSize: 16.px,
                                        ),
                                      ),
                                      Text(
                                        i['value'].toString(),
                                        style: MyTextStyle(
                                          textColor:
                                              controller.appColors.textcolor,
                                          textWeight: FontWeight.w400,
                                          textFamily: fontFamilyBold,
                                          textSize: 14.px,
                                        ),
                                      ),
                                      if (i !=
                                          controller
                                                  .unitHouseKeepingList.length -
                                              1)
                                        Divider()
                                    ],
                                  ).paddingSymmetric(
                                      horizontal: 10, vertical: 5);
                                },
                                onSelected: (value) async {
                                  controller
                                      .actionGeneralPhysical(value['title']);
                                  controller.update();
                                },
                              ),
                            ),
                          ],
                        ).paddingOnly(left: 32.px, right: 32.px, bottom: 20.px),
                        controller.isManually
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (() async {
                                      if (controller.generalPhysicalCondition
                                              .text.isNotEmpty &&
                                          controller.unitHouseKeeping.text
                                              .isNotEmpty) {
                                        await controller
                                            .getInspectionInfoJson();
                                        controller.saveCreateInspection();
                                      }
                                    }),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 44.px,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100.px),
                                          border: Border.all(
                                              color: controller
                                                          .generalPhysicalCondition
                                                          .text
                                                          .isNotEmpty &&
                                                      controller
                                                          .unitHouseKeeping
                                                          .text
                                                          .isNotEmpty
                                                  ? controller
                                                      .appColors.appColor
                                                  : controller.appColors.grey)),
                                      child: MyTextView(
                                        Strings.saveandunit,
                                        textStyleNew: MyTextStyle(
                                          textColor: controller
                                                      .generalPhysicalCondition
                                                      .text
                                                      .isNotEmpty &&
                                                  controller.unitHouseKeeping
                                                      .text.isNotEmpty
                                              ? controller.appColors.appColor
                                              : controller.appColors.grey,
                                          textWeight: FontWeight.w500,
                                          textFamily: fontFamilyBold,
                                          textSize: 16.px,
                                        ),
                                      )
                                          .paddingOnly(left: 8.px)
                                          .paddingSymmetric(horizontal: 16.px),
                                    ),
                                  ).paddingOnly(right: 16.px),
                                  CommonButton(
                                    title: Strings.CompleteInspection,
                                    radius: 100.px,
                                    width: 198.px,
                                    height: 44.px,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 15.px,
                                      horizontal: 24.px,
                                    ),
                                    textSize: 16.px,
                                    textWeight: FontWeight.w500,
                                    textFamily: fontFamilyRegular,
                                    textColor: controller
                                                .generalPhysicalCondition
                                                .text
                                                .isNotEmpty &&
                                            controller.unitHouseKeeping.text
                                                .isNotEmpty
                                        ? controller.appColors.black
                                        : controller.appColors.border1,
                                    color: controller.generalPhysicalCondition
                                            .text.isNotEmpty
                                        ? controller.appColors.textPink
                                        : controller.appColors.black
                                            .withOpacity(0.11999999731779099),
                                    onTap: () async {
                                      if (controller.generalPhysicalCondition
                                              .text.isNotEmpty &&
                                          controller.unitHouseKeeping.text
                                              .isNotEmpty) {
                                        await controller
                                            .getInspectionInfoJson();
                                        controller.createInspection();
                                      }
                                    },
                                  )
                                ],
                              ).paddingOnly(top: 15.px, bottom: 30.px)
                            : Center(
                                child: CommonButton(
                                  title: Strings.CompleteInspection,
                                  radius: 100.px,
                                  width: 198.px,
                                  height: 44.px,
                                  textSize: 16.px,
                                  textWeight: FontWeight.w500,
                                  textFamily: fontFamilyRegular,
                                  textColor: controller.appColors.black,
                                  color: controller.appColors.textPink,
                                  onTap: () async {
                                    if (controller.generalPhysicalCondition.text
                                            .isNotEmpty &&
                                        controller
                                            .unitHouseKeeping.text.isNotEmpty) {
                                      await controller.getInspectionInfoJson();
                                      controller.createInspection();
                                    }
                                  },
                                ),
                              ).paddingOnly(top: 15.px, bottom: 30.px),
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

                        controller.isManually
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TitleheadMenu(
                                    title: Strings.propertyName,
                                    value: Get.arguments == null
                                        ? ""
                                        : Get.arguments['propertyInfo']['name']
                                            .toString(),
                                  ),
                                  Row(
                                    children: [
                                      TitleheadMenu(
                                        title: Strings.city,
                                        value: Get.arguments == null
                                            ? ""
                                            : Get.arguments['propertyInfo']
                                                    ['city']
                                                .toString(),
                                      ).paddingOnly(right: 20.px),
                                      TitleheadMenu(
                                        title: Strings.propertyID,
                                        value: Get.arguments == null
                                            ? ""
                                            : Get.arguments['propertyInfo']
                                                    ['id']
                                                .toString(),
                                      ),
                                    ],
                                  ),
                                ],
                              ).paddingOnly(
                                left: 32.px, right: 32.px, bottom: 20.px)
                            : CommonTextRow(
                                title: 'Property Name: ',
                                subTitle: '${controller.propertyInfo['name']}',
                                imageString: icBuildingss,
                              ).paddingOnly(
                                left: 32.px, right: 32.px, bottom: 20.px),
                        controller.isManually
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TitleheadMenu(
                                    title: Strings.propertyAddress,
                                    value: Get.arguments == null
                                        ? ""
                                        : Get.arguments['propertyInfo']
                                                ['address']
                                            .toString(),
                                  ),
                                  Row(
                                    children: [
                                      TitleheadMenu(
                                        title: Strings.state,
                                        value: Get.arguments == null
                                            ? ""
                                            : Get.arguments['propertyInfo']
                                                    ['state']
                                                .toString(),
                                      ).paddingOnly(right: 20.px),
                                      TitleheadMenu(
                                        title: Strings.zip,
                                        value: Get.arguments == null
                                            ? ""
                                            : Get.arguments['propertyInfo']
                                                    ['zip']
                                                .toString(),
                                      ),
                                    ],
                                  ),
                                ],
                              ).paddingOnly(
                                left: 32.px, right: 32.px, bottom: 40.px)
                            : CommonTextRow(
                                title: 'Property Address: ',
                                subTitle:
                                    '${controller.propertyInfo['address']}, ${controller.propertyInfo['city']}, ${controller.propertyInfo['state']}, ${controller.propertyInfo['zip']}',
                                imageString: icLocation,
                              ).paddingOnly(
                                left: 32.px, right: 32.px, bottom: 20.px),
                        controller.isManually
                            ? SizedBox.shrink()
                            : CommonTextRow(
                                title: 'Property ID: ',
                                subTitle: '${controller.propertyInfo['id']}',
                                imageString: hasTagIcon,
                              ).paddingOnly(
                                left: 32.px, right: 32.px, bottom: 20.px),
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
                        controller.isManually
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TitleheadMenu(
                                    title: Strings.buildingName,
                                    value: Get.arguments == null
                                        ? ""
                                        : Get.arguments['buildingInfo']['name']
                                            .toString(),
                                  ),
                                  TitleheadMenu(
                                    title: Strings.buildingType,
                                    value: Get.arguments == null
                                        ? ""
                                        : Get.arguments['buildingtype']
                                            .toString(),
                                  ),
                                ],
                              ).paddingOnly(
                                left: 32.px, right: 32.px, bottom: 20.px)
                            : Row(
                                children: [
                                  Expanded(
                                    child: CommonTextRow(
                                      title: 'Building Name: ',
                                      subTitle:
                                          '${controller.buildingInfo['name']}',
                                      imageString: icBuildings,
                                    ),
                                  ),
                                  SizedBox(width: 16.px),
                                  Expanded(
                                    child: CommonTextRow(
                                      isImage: true,
                                      title: 'Year Constructed: ',
                                      subTitle:
                                          '${controller.buildingInfo['constructed_year']}',
                                      imageString: icCalender2,
                                    ),
                                  ),
                                ],
                              ).paddingOnly(
                                left: 32.px, right: 32.px, bottom: 20.px),
                        controller.isManually
                            ? TitleheadMenu(
                                title: Strings.yearConstructed,
                                value: Get.arguments == null
                                    ? ""
                                    : Get.arguments['buildingInfo']
                                            ['constructed_year']
                                        .toString()
                                        .toString(),
                              ).paddingOnly(
                                left: 32.px, right: 32.px, bottom: 40.px)
                            : CommonTextRow(
                                title: 'Building Type: ',
                                subTitle:
                                    '${controller.buildingInfo['building_type_id']}',
                                imageString: icBuildings,
                              ).paddingOnly(
                                left: 32.px, right: 32.px, bottom: 40.px),
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
                                          controller.getUnitInspectionSummary();
                                        }),
                                        color: controller.appColors.transparent,
                                        prefixIcon: SvgPicture.string(
                                          ichome1,
                                          color: controller.appColors.grey,
                                        ).paddingOnly(
                                            left: 15.px, right: 15.px),
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
                                          controller.getUnitInspectionSummary();
                                        }),
                                        controller: controller.unitAddress,
                                        color: controller.appColors.transparent,
                                        prefixIcon: SvgPicture.string(
                                          iclocation,
                                          color: controller.appColors.grey,
                                        ).paddingOnly(
                                            left: 15.px, right: 15.px),
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
                                        readOnly: true,
                                        controller: controller.bedrooms,
                                        color: controller.appColors.transparent,
                                        prefixIcon: SvgPicture.string(
                                          icbedrooms,
                                          color: controller.appColors.grey,
                                        ).paddingOnly(
                                            left: 15.px, right: 15.px),
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
                                        readOnly: true,
                                        controller: controller.bathrooms,
                                        color: controller.appColors.transparent,
                                        prefixIcon: SvgPicture.string(
                                          icbathroom,
                                          color: controller.appColors.grey,
                                        ).paddingOnly(
                                            left: 15.px, right: 15.px),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        MyTextView(
                                          Strings.unitoccupied,
                                          textStyleNew: MyTextStyle(
                                            textColor:
                                                controller.appColors.black,
                                            textWeight: FontWeight.w400,
                                            textFamily: fontFamilyBold,
                                            textSize: 16.px,
                                          ),
                                        ).paddingOnly(right: 20.px),
                                        Switch(
                                          activeTrackColor:
                                              controller.appColors.appColor,
                                          inactiveTrackColor: controller
                                              .appColors.inactiveColor,
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
                                          activeColor:
                                              controller.appColors.white,
                                          value: controller.switchButton.value,
                                          onChanged: (value) {
                                            controller.switchButton.value =
                                                !controller.switchButton.value;
                                            print(controller.switchButton.value
                                                .toString());
                                            controller.update();
                                          },
                                        ),
                                        MyTextView(
                                          controller.switchButton.value
                                              ? Strings.yes
                                              : Strings.no,
                                          textStyleNew: MyTextStyle(
                                            textColor:
                                                controller.appColors.black,
                                            textWeight: FontWeight.w400,
                                            textFamily: fontFamilyBold,
                                            textSize: 16.px,
                                          ),
                                        ).paddingOnly(left: 10.px),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: (() {}),
                                      child: MyTextView(
                                        Strings.unitcannitbeinspected,
                                        textStyleNew: MyTextStyle(
                                          textColor:
                                              controller.appColors.border1,
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
                        ).paddingOnly(left: 32.px, right: 32.px),
                        Row(
                          children: [
                            MyTextView(
                              Strings.deficiencies,
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
                        ).paddingOnly(
                            left: 32.px,
                            right: 32.px,
                            top: 30.px,
                            bottom: 30.px),
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
                                            title: Strings.unit,
                                            onTap: () {},
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
                                        item.deficiencyAreaItems![i]
                                            .description,
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
                                                      UnitDeficienciesInsideScreen
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

                        // ListView.separated(
                        //   shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   itemCount: controller.dataList.length,
                        //   scrollDirection: Axis.vertical,
                        //   itemBuilder: (context, index) {
                        //     final item = controller.dataList[index];
                        //     return Container(
                        //       padding: EdgeInsets.zero,
                        //       decoration: BoxDecoration(
                        //           color: controller.appColors.cardcolor,
                        //           border: Border.all(
                        //               color: controller.appColors.divider),
                        //           borderRadius: BorderRadius.circular(15)),
                        //       // divider: controller.appColors.divider,
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Container(
                        //             decoration: BoxDecoration(
                        //                 color: controller.appColors.cardcolor,
                        //                 borderRadius: BorderRadius.only(
                        //                     topLeft: Radius.circular(15),
                        //                     topRight: Radius.circular(15))),
                        //             child: Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //               children: [
                        //                 MyTextView(
                        //                   "Cabinet and Storage",
                        //                   isMaxLineWrap: true,
                        //                   textStyleNew: MyTextStyle(
                        //                     textSize: 20.px,
                        //                     textWeight: FontWeight.w600,
                        //                     textColor:
                        //                         controller.appColors.lightText,
                        //                     textFamily: fontFamilyRegular,
                        //                   ),
                        //                 ),
                        //                 CommonButton(
                        //                   radius: 100.px,
                        //                   title: Strings.inside,
                        //                   onTap: () {},
                        //                   padding: EdgeInsets.symmetric(
                        //                     horizontal: 24.px,
                        //                     vertical: 10.px,
                        //                   ),
                        //                   textWeight: FontWeight.w500,
                        //                   textSize: 16.px,
                        //                   color: controller.appColors.appBGColor,
                        //                   textColor: controller.appColors.textGreen,
                        //                 ).paddingOnly(left: 24.px),
                        //               ],
                        //             ).paddingAll(18.px),
                        //           ),
                        //           ShadowContainer2(
                        //             padding: EdgeInsets.zero,
                        //             divider: controller.appColors.divider,
                        //             child: Row(
                        //               mainAxisAlignment: MainAxisAlignment.center,
                        //               crossAxisAlignment: CrossAxisAlignment.center,
                        //               children: [
                        //                 Expanded(
                        //                   child: Container(
                        //                     height: 184.px,
                        //                     alignment: Alignment.center,
                        //                     child: Center(
                        //                       child: ListView.separated(
                        //                           scrollDirection: Axis.horizontal,
                        //                           itemBuilder: (context, index) {
                        //                             return Container(
                        //                               height: 184.px,
                        //                               width: 184.px,
                        //                               decoration: BoxDecoration(
                        //                                   borderRadius:
                        //                                       BorderRadius.circular(
                        //                                           13.px),
                        //                                   image: DecorationImage(
                        //                                       image: AssetImage(
                        //                                           item.image ?? ""),
                        //                                       fit: BoxFit.cover)),
                        //                             );
                        //                           },
                        //                           separatorBuilder:
                        //                               (context, index) {
                        //                             return SizedBox(width: 24.px);
                        //                           },
                        //                           itemCount: 3),
                        //                     ),
                        //                   ).paddingAll(10.px),
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //           MyTextView(
                        //             item.title,
                        //             isMaxLineWrap: true,
                        //             textStyleNew: MyTextStyle(
                        //               textSize: 20.px,
                        //               textWeight: FontWeight.w400,
                        //               textColor: controller.appColors.black,
                        //               textFamily: fontFamilyRegular,
                        //             ),
                        //           ).paddingOnly(
                        //               top: 18.px, left: 18.px, right: 18.px),
                        //           Row(
                        //             children: [
                        //               Expanded(
                        //                 child: Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   children: [
                        //                     dotIcons(controller, Strings.comments,
                        //                         '6 of 10 cabinets are missing -NJ'),
                        //                     dotIcons(
                        //                         controller, 'Date', '06/18/2023'),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Column(
                        //                 crossAxisAlignment: CrossAxisAlignment.end,
                        //                 children: [
                        //                   CommonIconButton(
                        //                       icon: icEditNotes,
                        //                       iconheigth: 24.px,
                        //                       title: 'Edit',
                        //                       radius: 100.px,
                        //                       padding: EdgeInsets.fromLTRB(
                        //                           16.px, 16.px, 20.px, 16.px),
                        //                       color:
                        //                           controller.appColors.transparent,
                        //                       textColor:
                        //                           controller.appColors.appColor,
                        //                       textWeight: FontWeight.w500,
                        //                       textSize: 14.px,
                        //                       onTap: () {}),
                        //                 ],
                        //               )
                        //             ],
                        //           ).paddingOnly(
                        //               top: 15.px,
                        //               left: 18.px,
                        //               right: 18.px,
                        //               bottom: 18.px)
                        //         ],
                        //       ),
                        //     ).marginSymmetric(horizontal: 32.px);
                        //   },
                        //   separatorBuilder: (BuildContext context, int index) {
                        //     return SizedBox(
                        //       height: 24.px,
                        //     );
                        //   },
                        // ),
                        controller.isManually
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (() async {
                                      if (controller.generalPhysicalCondition
                                              .text.isNotEmpty &&
                                          controller.unitHouseKeeping.text
                                              .isNotEmpty) {
                                        await controller
                                            .getInspectionInfoJson();
                                        controller.saveCreateInspection();
                                      }
                                    }),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 44.px,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100.px),
                                          border: Border.all(
                                            color: controller
                                                        .generalPhysicalCondition
                                                        .text
                                                        .isNotEmpty &&
                                                    controller.unitHouseKeeping
                                                        .text.isNotEmpty
                                                ? controller.appColors.appColor
                                                : controller.appColors.grey,
                                          )),
                                      child: MyTextView(
                                        Strings.saveandunit,
                                        textStyleNew: MyTextStyle(
                                          textColor: controller
                                                      .generalPhysicalCondition
                                                      .text
                                                      .isNotEmpty &&
                                                  controller.unitHouseKeeping
                                                      .text.isNotEmpty
                                              ? controller.appColors.appColor
                                              : controller.appColors.grey,
                                          textWeight: FontWeight.w500,
                                          textFamily: fontFamilyBold,
                                          textSize: 16.px,
                                        ),
                                      )
                                          .paddingOnly(left: 8.px)
                                          .paddingSymmetric(horizontal: 16.px),
                                    ),
                                  ).paddingOnly(right: 16.px),
                                  CommonButton(
                                    title: Strings.CompleteInspection,
                                    radius: 100.px,
                                    width: 198.px,
                                    height: 44.px,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 15.px,
                                      horizontal: 24.px,
                                    ),
                                    textSize: 16.px,
                                    textWeight: FontWeight.w500,
                                    textFamily: fontFamilyRegular,
                                    textColor: controller
                                                .generalPhysicalCondition
                                                .text
                                                .isNotEmpty &&
                                            controller.unitHouseKeeping.text
                                                .isNotEmpty
                                        ? controller.appColors.black
                                        : controller.appColors.border1,
                                    color: controller.generalPhysicalCondition
                                            .text.isNotEmpty
                                        ? controller.appColors.textPink
                                        : controller.appColors.black
                                            .withOpacity(0.11999999731779099),
                                    onTap: () async {
                                      if (controller.generalPhysicalCondition
                                              .text.isNotEmpty &&
                                          controller.unitHouseKeeping.text
                                              .isNotEmpty) {
                                        await controller
                                            .getInspectionInfoJson();
                                        controller.createInspection();
                                      }
                                    },
                                  )
                                ],
                              ).paddingOnly(top: 30.px, bottom: 30.px)
                            : Center(
                                child: CommonButton(
                                  title: Strings.CompleteInspection,
                                  radius: 100.px,
                                  width: 198.px,
                                  height: 44.px,
                                  textSize: 16.px,
                                  textWeight: FontWeight.w500,
                                  textFamily: fontFamilyRegular,
                                  textColor: controller.appColors.black,
                                  color: controller.appColors.textPink,
                                  onTap: () async {
                                    if (controller.generalPhysicalCondition.text
                                            .isNotEmpty &&
                                        controller
                                            .unitHouseKeeping.text.isNotEmpty) {
                                      await controller.getInspectionInfoJson();
                                      controller.createInspection();
                                    }
                                  },
                                ),
                              ).paddingOnly(top: 15.px, bottom: 30.px),
                      ],
                    ),
                  ),
                ],
              ),
              Obx(
                () => controller.isLoading.value == true
                    ? Center(child: CircularProgressIndicator())
                    : Container(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget dotIcons(controller, title, description) {
    return Row(
      children: [
        Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.black),
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
}
