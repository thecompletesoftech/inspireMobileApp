import 'package:flutter_svg/svg.dart';
import 'package:public_housing/screens/unit_Inpection_screen/unit_inspection_screen.dart';
import 'package:public_housing/screens/unitinspectionsummary_screen/unitinspection_controller.dart';
import '../../commons/all.dart';
import '../building_inspection_screen/building_inspection_screen.dart';
import '../unit_Inpection_screen/TitleheadmenuWidgte.dart';

class UnitInspectionSummary extends GetView<UnitInspectionsummaryController> {
  const UnitInspectionSummary({Key? key}) : super(key: key);
  static const routes = "/UnitInspectionSummary";
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnitInspectionsummaryController>(
      init: UnitInspectionsummaryController(),
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
                  // }
                },
              ),
              Expanded(
                child: ListView(
                  children: [
                    Center(
                      child: MyTextView(
                        '${Strings.propertyNames}${"Building 13" ?? ""}-${"Unit 345" ?? ""}',
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
                          child: CommonTextField(
                            isLable: true,
                            readOnly: false,
                            controller: controller.unithousekeeping,
                            color: controller.appColors.transparent,
                            suffixIcon: PopupMenuButton(
                              offset: Offset(-250, 10),
                              key: controller.popupKey1,
                              position: PopupMenuPosition.under,
                              tooltip: Strings.unitHousekeeping,
                              onSelected: (value) {
                                print(value.toString());
                                controller.actionunitHousekeeping(value);
                                controller.update();
                              },
                              itemBuilder: (context) => List.generate(
                                  controller.unithousekeepingList.length,
                                  (index) => PopupMenuItem(
                                        value: index,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller
                                                  .unithousekeepingList[index]
                                                      ['title']
                                                  .toString(),
                                              style: MyTextStyle(
                                                textColor:
                                                    controller.appColors.black,
                                                textWeight: FontWeight.w400,
                                                textFamily: fontFamilyBold,
                                                textSize: 16.px,
                                              ),
                                            ),
                                            Text(
                                              controller
                                                  .unithousekeepingList[index]
                                                      ['value']
                                                  .toString(),
                                              style: MyTextStyle(
                                                textColor: controller
                                                    .appColors.textcolor,
                                                textWeight: FontWeight.w400,
                                                textFamily: fontFamilyBold,
                                                textSize: 14.px,
                                              ),
                                            ),
                                            if (index !=
                                                controller.unithousekeepingList
                                                        .length -
                                                    1)
                                              Divider()
                                          ],
                                        ),
                                      )),
                              child: SvgPicture.string(
                                icDownArrow,
                                color: controller.appColors.grey,
                              ).paddingAll(10.px),
                            ),
                            padding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.only(left: 15.px),
                            shadowColor: controller.appColors.transparent,
                            labelText: Strings.unitHousekeeping,
                          ),
                        ),
                        SizedBox(width: 16.px),
                        Expanded(
                          child: CommonTextField(
                            isLable: true,
                            readOnly: false,
                            controller: controller.generalphysicalcondition,
                            color: controller.appColors.transparent,
                            suffixIcon: PopupMenuButton(
                              offset: Offset(-55, 10),
                              key: controller.popupKey2,
                              position: PopupMenuPosition.under,
                              tooltip: Strings.generalphysicalcondition,
                              onSelected: (value) {
                                controller.actiongeneralphysical(value);
                                controller.update();
                              },
                              itemBuilder: (context) => List.generate(
                                  controller
                                      .generalphysicalconditionList.length,
                                  (index) => PopupMenuItem(
                                        value: index,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller
                                                  .generalphysicalconditionList[
                                                      index]['title']
                                                  .toString(),
                                              style: MyTextStyle(
                                                textColor:
                                                    controller.appColors.black,
                                                textWeight: FontWeight.w400,
                                                textFamily: fontFamilyBold,
                                                textSize: 16.px,
                                              ),
                                            ),
                                            Text(
                                              controller
                                                  .generalphysicalconditionList[
                                                      index]['value']
                                                  .toString(),
                                              style: MyTextStyle(
                                                textColor: controller
                                                    .appColors.textcolor,
                                                textWeight: FontWeight.w400,
                                                textFamily: fontFamilyBold,
                                                textSize: 14.px,
                                              ),
                                            ),
                                            if (index !=
                                                controller
                                                        .generalphysicalconditionList
                                                        .length -
                                                    1)
                                              Divider()
                                          ],
                                        ),
                                      )),
                              child: SvgPicture.string(
                                icDownArrow,
                                color: controller.appColors.grey,
                              ).paddingAll(10.px),
                            ),
                            padding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.only(left: 15.px),
                            shadowColor: controller.appColors.transparent,
                            labelText: Strings.generalphysicalcondition,
                          ),
                        ),
                      ],
                    ).paddingOnly(left: 32.px, right: 32.px, bottom: 20.px),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (() {
                            Get.toNamed(UnitInspection.routes);
                          }),
                          child: Container(
                            alignment: Alignment.center,
                            height: 44.px,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.px),
                                border: Border.all(
                                    color: controller.appColors.appColor)),
                            child: MyTextView(
                              Strings.saveandunit,
                              textStyleNew: MyTextStyle(
                                textColor: controller.appColors.appColor,
                                textWeight: FontWeight.w500,
                                textFamily: fontFamilyBold,
                                textSize: 16.px,
                              ),
                            )
                                .paddingOnly(left: 8.px)
                                .paddingSymmetric(horizontal: 16.px),
                          ),
                        ).paddingOnly(right: 16.px),
                        // CommonButton(
                        //   title: Strings.saveandunit,
                        //   radius: 100.px,
                        //   width: 171.px,
                        //   height: 44.px,
                        //   padding: EdgeInsets.symmetric(
                        //     vertical: 15.px,
                        //     horizontal: 24.px,
                        //   ),
                        //   textSize: 16.px,
                        //   textWeight: FontWeight.w500,
                        //   textFamily: fontFamilyRegular,
                        //   textColor: controller.getUnitInspectionSummary()
                        //       ? controller.appColors.black
                        //       : controller.appColors.border1,
                        //   color: controller.getUnitInspectionSummary()
                        //       ? controller.appColors.textPink
                        //       : controller.appColors.black
                        //           .withOpacity(0.11999999731779099),
                        //   onTap: () {
                        //     if (controller.getUnitInspectionSummary()) {}
                        //   },
                        // ).paddingOnly(right: 10.px),
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
                          textColor: controller.generalphysicalcondition.text
                                      .isNotEmpty &&
                                  controller.unithousekeeping.text.isNotEmpty
                              ? controller.appColors.black
                              : controller.appColors.border1,
                          color: controller
                                  .generalphysicalcondition.text.isNotEmpty
                              ? controller.appColors.textPink
                              : controller.appColors.black
                                  .withOpacity(0.11999999731779099),
                          onTap: () {
                            if (controller
                                    .generalphysicalcondition.text.isNotEmpty &&
                                controller.unithousekeeping.text.isNotEmpty) {
                              Get.toNamed(BuildingInspectionScreen.routes);
                            }
                          },
                        )
                      ],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleheadMenu(
                          title: Strings.propertyName,
                          value: 'name of property',
                        ),
                        Row(
                          children: [
                            TitleheadMenu(
                              title: Strings.city,
                              value: 'Los Angeles',
                            ).paddingOnly(right: 20.px),
                            TitleheadMenu(
                              title: Strings.propertyID,
                              value: '11111',
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
                          value: 'address',
                        ),
                        Row(
                          children: [
                            TitleheadMenu(
                              title: Strings.state,
                              value: '11',
                            ).paddingOnly(right: 20.px),
                            TitleheadMenu(
                              title: Strings.zip,
                              value: '11111',
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
                          value: 'Building 13',
                        ),
                        TitleheadMenu(
                          title: Strings.buildingType,
                          value: 'Building 1',
                        ),
                      ],
                    ).paddingOnly(left: 32.px, right: 32.px, bottom: 20.px),
                    TitleheadMenu(
                      title: Strings.yearConstructed,
                      value: '1945',
                    ).paddingOnly(left: 32.px, right: 32.px, bottom: 40.px),
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
                                    controller: controller.unitnumberoRname,
                                    onChange: ((value) {
                                      controller.getUnitInspectionSummary();
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
                                      controller.getUnitInspectionSummary();
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
                                    readOnly: true,
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
                                    readOnly: true,
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
                                      value: controller.switchbtn.value,
                                      onChanged: (value) {
                                        controller.switchbtn.value =
                                            !controller.switchbtn.value;
                                        print(controller.switchbtn.value
                                            .toString());
                                        controller.update();
                                      },
                                    ),
                                    MyTextView(
                                      controller.switchbtn.value
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
                                  onTap: (() {}),
                                  child: MyTextView(
                                    Strings.unitcannitbeinspected,
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.appColors.border1,
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
                        left: 32.px, right: 32.px, top: 30.px, bottom: 30.px),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.dataList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final item = controller.dataList[index];
                        return Container(
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                              color: controller.appColors.cardcolor,
                              border: Border.all(
                                  color: controller.appColors.divider),
                              borderRadius: BorderRadius.circular(15)),
                          // divider: controller.appColors.divider,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: controller.appColors.cardcolor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyTextView(
                                      "Cabinet and Storage",
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
                                      color: controller.appColors.appBGColor,
                                      textColor: controller.appColors.textGreen,
                                    ).paddingOnly(left: 24.px),
                                  ],
                                ).paddingAll(18.px),
                              ),
                              ShadowContainer2(
                                padding: EdgeInsets.zero,
                                divider: controller.appColors.divider,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 184.px,
                                        alignment: Alignment.center,
                                        child: Center(
                                          child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  height: 184.px,
                                                  width: 184.px,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13.px),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              item.image ?? ""),
                                                          fit: BoxFit.cover)),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox(width: 24.px);
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
                                        dotIcons(controller, Strings.comments,
                                            '6 of 10 cabinets are missing -NJ'),
                                        dotIcons(
                                            controller, 'Date', '06/18/2023'),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      CommonIconButton(
                                          icon: icEditNotes,
                                          iconheigth: 24.px,
                                          title: 'Edit',
                                          radius: 100.px,
                                          padding: EdgeInsets.fromLTRB(
                                              16.px, 16.px, 20.px, 16.px),
                                          color:
                                              controller.appColors.transparent,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          // onTap: controller.isExpanded,
                          child: Container(
                            alignment: Alignment.center,
                            height: 44.px,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.px),
                                border: Border.all(
                                    color: controller.appColors.appColor)),
                            child: MyTextView(
                              Strings.saveandunit,
                              textStyleNew: MyTextStyle(
                                textColor: controller.appColors.appColor,
                                textWeight: FontWeight.w500,
                                textFamily: fontFamilyBold,
                                textSize: 16.px,
                              ),
                            )
                                .paddingOnly(left: 8.px)
                                .paddingSymmetric(horizontal: 16.px),
                          ),
                        ).paddingOnly(right: 16.px),
                        // CommonButton(
                        //   title: Strings.saveandunit,
                        //   radius: 100.px,
                        //   width: 171.px,
                        //   height: 44.px,
                        //   padding: EdgeInsets.symmetric(
                        //     vertical: 15.px,
                        //     horizontal: 24.px,
                        //   ),
                        //   textSize: 16.px,
                        //   textWeight: FontWeight.w500,
                        //   textFamily: fontFamilyRegular,
                        //   textColor: controller.getUnitInspectionSummary()
                        //       ? controller.appColors.black
                        //       : controller.appColors.border1,
                        //   color: controller.getUnitInspectionSummary()
                        //       ? controller.appColors.textPink
                        //       : controller.appColors.black
                        //           .withOpacity(0.11999999731779099),
                        //   onTap: () {
                        //     if (controller.getUnitInspectionSummary()) {}
                        //   },
                        // ).paddingOnly(right: 10.px),
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
                          textColor: controller.getUnitInspectionSummary()
                              ? controller.appColors.black
                              : controller.appColors.border1,
                          color: controller.getUnitInspectionSummary()
                              ? controller.appColors.textPink
                              : controller.appColors.black
                                  .withOpacity(0.11999999731779099),
                          onTap: () {
                            if (controller.getUnitInspectionSummary()) {}
                          },
                        )
                      ],
                    ).paddingOnly(top: 30.px, bottom: 30.px),
                  ],
                ),
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