import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/commons/common_widgets/common_row.dart';
import 'package:public_housing/screens/building_inspection_screen/controller/building_inspection_controller.dart';
import 'package:public_housing/screens/building_standards_screen/screen/building_standards_screen.dart';
import 'package:public_housing/screens/unit_inspection_screen/screen/unit_inspection_screen.dart';

class BuildingInspectionScreen extends GetView<BuildingInspectionController> {
  const BuildingInspectionScreen({Key? key}) : super(key: key);

  static const routes = "/BuildingInspectionScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildingInspectionController>(
      init: BuildingInspectionController(),
      autoRemove: true,
      assignId: true,
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Image.asset(
                //       ImagePath.logo,
                //       width: 182.px,
                //       height: 40.625.px,
                //     ),
                //     Flexible(
                //       flex: 1,
                //       child: GestureDetector(
                //         onTap: () {
                //           controller.popupKey.currentState?.showButtonMenu();
                //         },
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             Row(
                //               children: [
                //                 GestureDetector(
                //                     onTap: controller.isCheck,
                //                     child: SvgPicture.string(
                //                         isInternet == IsInternet.initial
                //                             ? syncCompleteIcon
                //                             : isInternet == IsInternet.connect
                //                                 ? syncIcon
                //                                 : offlineIcon)),
                //                 Column(
                //                   crossAxisAlignment:
                //                       CrossAxisAlignment.start,
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: [
                //                     Row(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       mainAxisSize: MainAxisSize.min,
                //                       children: [
                //                         Flexible(
                //                           flex: 1,
                //                           child: MyTextView(
                //                             controller.account?.userName ??
                //                                 "",
                //                             textStyleNew: MyTextStyle(
                //                               textColor: controller
                //                                   .appColors.lightText,
                //                               textWeight: FontWeight.w600,
                //                               textFamily: fontFamilyBold,
                //                               textSize: 16.px,
                //                             ),
                //                           ),
                //                         ),
                //                       ],
                //                     ).paddingOnly(bottom: 4.px),
                //                     MyTextView(
                //                       "${controller.getStorageData.readString(controller.getStorageData.clientName)}",
                //                       isMaxLineWrap: true,
                //                       textStyleNew: MyTextStyle(
                //                         textColor:
                //                             controller.appColors.lightText,
                //                         textWeight: FontWeight.w400,
                //                         textFamily: fontFamilyMedium,
                //                         textSize: 14.px,
                //                       ),
                //                     )
                //                   ],
                //                 ),
                //               ],
                //             ),
                //             Column(
                //               mainAxisAlignment:
                //                   MainAxisAlignment.spaceEvenly,
                //               children: [
                //                 PopupMenuButton<int>(
                //                   key: controller.popupKey,
                //                   icon: SvgPicture.string(
                //                     icDownArrow,
                //                     height: 24.px,
                //                   ),
                //                   onSelected: (int value) => controller
                //                       .actionPopUpItemSelected(value),
                //                   itemBuilder: (context) {
                //                     return <PopupMenuEntry<int>>[
                //                       PopupMenuItem(
                //                           value: 0,
                //                           child: ListTile(
                //                               leading: SvgPicture.string(
                //                                 icEdit,
                //                               ),
                //                               title: MyTextView(
                //                                 Strings.editProfile,
                //                                 textStyleNew: MyTextStyle(
                //                                     textSize: 16.px,
                //                                     textColor:
                //                                         AppColors().black,
                //                                     textWeight:
                //                                         FontWeight.w400),
                //                               ))),
                //                       PopupMenuItem(
                //                           value: 1,
                //                           child: ListTile(
                //                               leading: SvgPicture.string(
                //                                 icCopy,
                //                               ),
                //                               title: MyTextView(
                //                                 Strings.inspectionHistory,
                //                                 textStyleNew: MyTextStyle(
                //                                     textSize: 16.px,
                //                                     textColor:
                //                                         AppColors().black,
                //                                     textWeight:
                //                                         FontWeight.w400),
                //                               ))),
                //                       PopupMenuItem(
                //                           value: 2,
                //                           child: ListTile(
                //                               leading: SvgPicture.string(
                //                                 icBook,
                //                               ),
                //                               title: MyTextView(
                //                                 Strings.nSPIREStandards,
                //                                 textStyleNew: MyTextStyle(
                //                                     textSize: 16.px,
                //                                     textColor:
                //                                         AppColors().black,
                //                                     textWeight:
                //                                         FontWeight.w400),
                //                               ))),
                //                       PopupMenuItem(
                //                           value: 3,
                //                           child: ListTile(
                //                               leading: SvgPicture.string(
                //                                 icLogout,
                //                               ),
                //                               title: MyTextView(
                //                                 Strings.logOut,
                //                                 textStyleNew: MyTextStyle(
                //                                     textSize: 16.px,
                //                                     textColor:
                //                                         AppColors().black,
                //                                     textWeight:
                //                                         FontWeight.w400),
                //                               ))),
                //                     ];
                //                   },
                //                 ),
                //                 const SizedBox()
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //     )
                //   ],
                // ).paddingOnly(left: 32.px, right: 32.px, bottom: 20.px),
                CommonAppBar(
                  color: controller.appColors.transparent,
                  radius: 0.px,
                ),
                MyTextView(
                  Strings.buildingInspection,
                  textStyleNew: MyTextStyle(
                    textColor: controller.appColors.appColor,
                    textWeight: FontWeight.w600,
                    textFamily: fontFamilyBold,
                    textSize: 32.px,
                  ),
                ).paddingOnly(top: 24.px, bottom: 32.px),
                Expanded(
                  child: ShadowContainer(
                    padding: EdgeInsets.zero,
                    radius: 8.px,
                    child: SingleChildScrollView(
                      child: Container(
                        color: controller.appColors.white,
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
                                    color: AppColors().divider,
                                  ),
                                ),
                              ],
                            ),
                            controller.isManually == true
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: CommonTextField(
                                          isLable: true,
                                          readOnly: true,
                                          controller:
                                              controller.inspectorController,
                                          color:
                                              controller.appColors.transparent,
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
                                          controller: controller
                                              .inspectionDateController,
                                          color:
                                              controller.appColors.transparent,
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
                                  ).paddingOnly(top: 32.px)
                                : Row(
                                    children: [
                                      Expanded(
                                        child: CommonTextRow(
                                          title: 'Inspector: ',
                                          subTitle: '[Inspector]',
                                          imageString: icPerson,
                                        ),
                                      ),
                                      SizedBox(width: 16.px),
                                      Expanded(
                                        child: CommonTextRow(
                                          title: 'Inspection Date: ',
                                          subTitle: '[Inspection Date]',
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
                                    color: AppColors().divider,
                                  ),
                                ),
                              ],
                            ).paddingOnly(top: 32.px, bottom: 32.px),
                            controller.isManually == true
                                ? Row(
                                    children: [
                                      Expanded(
                                          child: controller
                                                  .propertyList!.isNotEmpty
                                              ? TypeAheadField(
                                                  controller: controller
                                                      .propertyNameController,
                                                  suggestionsCallback:
                                                      (search) {
                                                    controller.searchProperty(
                                                        searchText: search);
                                                    controller.update();
                                                    return controller
                                                        .searchPropertyNameList;
                                                  },
                                                  builder:
                                                      (context, c, focusNode) {
                                                    return CommonTextField(
                                                      focusNode: focusNode,
                                                      isLable: true,
                                                      color: controller
                                                          .appColors
                                                          .transparent,
                                                      prefixIcon:
                                                          SvgPicture.string(
                                                        icBuildingss,
                                                        color: controller
                                                            .appColors.grey,
                                                      ).paddingOnly(
                                                              left: 15.px),
                                                      suffixIcon:
                                                          SvgPicture.string(
                                                        icDownArrow,
                                                        color: controller
                                                            .appColors.grey,
                                                      ).paddingAll(10.px),
                                                      padding: EdgeInsets.zero,
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 15.px),
                                                      shadowColor: controller
                                                          .appColors
                                                          .transparent,
                                                      labelText:
                                                          Strings.propertyName,
                                                      controller: c,
                                                    );
                                                  },
                                                  itemBuilder: (context, i) {
                                                    return ListTile(
                                                      title: MyTextView(
                                                        i.name.toString(),
                                                        textStyleNew:
                                                            MyTextStyle(
                                                          textColor: controller
                                                              .appColors.black,
                                                          textWeight:
                                                              FontWeight.w400,
                                                          textFamily:
                                                              fontFamilyBold,
                                                          textSize: 16.px,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  onSelected: (value) async {
                                                    controller
                                                        .actionProperty(value);
                                                    await controller
                                                        .getBuildingApi(value);
                                                    // await controller.searchBuilding(
                                                    //     searchText: value.name);
                                                    controller.update();
                                                  },
                                                )
                                              : CommonTextField(
                                                  isLable: true,
                                                  color: controller
                                                      .appColors.transparent,
                                                  prefixIcon: SvgPicture.string(
                                                    icBuildingss,
                                                    color: controller
                                                        .appColors.grey,
                                                  ).paddingOnly(left: 15.px),
                                                  suffixIcon: SvgPicture.string(
                                                    icDownArrow,
                                                    color: controller
                                                        .appColors.grey,
                                                  ).paddingAll(10.px),
                                                  padding: EdgeInsets.zero,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 15.px),
                                                  shadowColor: controller
                                                      .appColors.transparent,
                                                  labelText:
                                                      Strings.propertyName,
                                                  controller:
                                                      TextEditingController(),
                                                )),
                                      SizedBox(width: 16.px),
                                      Expanded(
                                        child: CommonTextField(
                                          readOnly: true,
                                          isLable: true,
                                          controller: controller.cityController,
                                          color:
                                              controller.appColors.transparent,
                                          suffixIcon: SvgPicture.string(
                                            icDownArrow,
                                            color: controller.appColors.black
                                                .withOpacity(controller
                                                        .cityController
                                                        .text
                                                        .isEmpty
                                                    ? .12
                                                    : 1.0),
                                          ).paddingAll(10.px),
                                          padding: EdgeInsets.zero,
                                          contentPadding:
                                              EdgeInsets.only(left: 15.px),
                                          shadowColor:
                                              controller.appColors.transparent,
                                          isLableColor: controller
                                              .appColors.black
                                              .withOpacity(controller
                                                      .cityController
                                                      .text
                                                      .isEmpty
                                                  ? .12
                                                  : 1.0),
                                          borderColor: controller
                                              .appColors.black
                                              .withOpacity(controller
                                                      .cityController
                                                      .text
                                                      .isEmpty
                                                  ? .12
                                                  : 1.0),
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
                                          subTitle: '[Property Name]',
                                          imageString: icBuildingss,
                                        ),
                                      ),
                                    ],
                                  ),
                            controller.isManually == true
                                ? Row(
                                    children: [
                                      Expanded(
                                        flex: 11,
                                        child: CommonTextField(
                                          isLable: true,
                                          readOnly: true,
                                          controller:
                                              controller.propertyIDController,
                                          color:
                                              controller.appColors.transparent,
                                          padding: EdgeInsets.zero,
                                          contentPadding: EdgeInsets.only(
                                              left: 15.px,
                                              top: 16.px,
                                              bottom: 16.px),
                                          shadowColor:
                                              controller.appColors.transparent,
                                          labelText: Strings.propertyID,
                                          isLableColor: controller
                                              .appColors.black
                                              .withOpacity(controller
                                                      .propertyIDController
                                                      .text
                                                      .isEmpty
                                                  ? .12
                                                  : 1.0),
                                          borderColor: controller
                                              .appColors.black
                                              .withOpacity(controller
                                                      .propertyIDController
                                                      .text
                                                      .isEmpty
                                                  ? .12
                                                  : 1.0),
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
                                          color:
                                              controller.appColors.transparent,
                                          padding: EdgeInsets.zero,
                                          contentPadding: EdgeInsets.only(
                                              left: 15.px,
                                              top: 16.px,
                                              bottom: 16.px),
                                          shadowColor:
                                              controller.appColors.transparent,
                                          labelText: Strings.state,
                                          isLableColor: controller
                                              .appColors.black
                                              .withOpacity(controller
                                                      .stateController
                                                      .text
                                                      .isEmpty
                                                  ? .12
                                                  : 1.0),
                                          borderColor: controller
                                              .appColors.black
                                              .withOpacity(controller
                                                      .stateController
                                                      .text
                                                      .isEmpty
                                                  ? .12
                                                  : 1.0),
                                        ),
                                      ),
                                      SizedBox(width: 16.px),
                                      Expanded(
                                        flex: 5,
                                        child: CommonTextField(
                                          isLable: true,
                                          readOnly: true,
                                          controller: controller.zipController,
                                          color:
                                              controller.appColors.transparent,
                                          padding: EdgeInsets.zero,
                                          contentPadding: EdgeInsets.only(
                                              left: 15.px,
                                              top: 16.px,
                                              bottom: 16.px),
                                          shadowColor:
                                              controller.appColors.transparent,
                                          labelText: Strings.zip,
                                          isLableColor: controller
                                              .appColors.black
                                              .withOpacity(controller
                                                      .zipController
                                                      .text
                                                      .isEmpty
                                                  ? .12
                                                  : 1.0),
                                          borderColor: controller
                                              .appColors.black
                                              .withOpacity(controller
                                                      .zipController
                                                      .text
                                                      .isEmpty
                                                  ? .12
                                                  : 1.0),
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
                                              '[Property Address], [City], [State], [Zip]',
                                          imageString: icLocation,
                                        ),
                                      ),
                                    ],
                                  ).paddingOnly(top: 12.px),
                            controller.isManually == true
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: CommonTextField(
                                          isLable: true,
                                          readOnly: true,
                                          controller: controller
                                              .propertyAddressController,
                                          color:
                                              controller.appColors.transparent,
                                          prefixIcon: SvgPicture.string(
                                            icLocation,
                                            color: controller.appColors.black
                                                .withOpacity(controller
                                                        .propertyAddressController
                                                        .text
                                                        .isEmpty
                                                    ? .12
                                                    : 1.0),
                                          ).paddingOnly(left: 15.px),
                                          padding: EdgeInsets.zero,
                                          contentPadding:
                                              EdgeInsets.only(left: 15.px),
                                          shadowColor:
                                              controller.appColors.transparent,
                                          labelText: Strings.propertyAddress,
                                          isLableColor: controller
                                              .appColors.black
                                              .withOpacity(controller
                                                      .propertyAddressController
                                                      .text
                                                      .isEmpty
                                                  ? .12
                                                  : 1.0),
                                          borderColor: controller
                                              .appColors.black
                                              .withOpacity(controller
                                                      .propertyAddressController
                                                      .text
                                                      .isEmpty
                                                  ? .12
                                                  : 1.0),
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Expanded(
                                        child: CommonTextRow(
                                          title: 'Property ID: ',
                                          subTitle: '[Property ID]',
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
                                    color: AppColors().divider,
                                  ),
                                ),
                              ],
                            ).paddingOnly(top: 32.px, bottom: 32.px),
                            controller.isManually == true
                                ? Row(
                                    children: [
                                      Expanded(
                                          child: controller
                                                  .buildingList.isNotEmpty
                                              ? TypeAheadField(
                                                  controller: controller
                                                      .buildingNameController,
                                                  suggestionsCallback:
                                                      (search) async {
                                                    await controller
                                                        .searchBuilding(
                                                            searchText: search);
                                                    controller.update();
                                                    return controller
                                                        .searchBuildingList;
                                                  },
                                                  builder:
                                                      (context, c, focusNode) {
                                                    return CommonTextField(
                                                      focusNode: focusNode,
                                                      isLable: true,
                                                      controller: c,
                                                      color: controller
                                                          .appColors
                                                          .transparent,
                                                      prefixIcon:
                                                          SvgPicture.string(
                                                        icBuildingss,
                                                        color: controller
                                                            .appColors.grey,
                                                      ).paddingOnly(
                                                              left: 15.px),
                                                      suffixIcon:
                                                          SvgPicture.string(
                                                        icDownArrow,
                                                        color: controller
                                                            .appColors.grey,
                                                      ).paddingAll(10.px),
                                                      padding: EdgeInsets.zero,
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 15.px),
                                                      shadowColor: controller
                                                          .appColors
                                                          .transparent,
                                                      labelText:
                                                          Strings.buildingName,
                                                    );
                                                  },
                                                  itemBuilder:
                                                      (context, dynamic i) {
                                                    return ListTile(
                                                      title: MyTextView(
                                                        i.name.toString(),
                                                        textStyleNew:
                                                            MyTextStyle(
                                                          textColor: controller
                                                              .appColors.black,
                                                          textWeight:
                                                              FontWeight.w400,
                                                          textFamily:
                                                              fontFamilyBold,
                                                          textSize: 16.px,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  onSelected: (value) async {
                                                    controller
                                                        .actionBuilding(value);
                                                    controller.update();
                                                  },
                                                )
                                              : CommonTextField(
                                                  isLable: true,
                                                  controller: controller
                                                      .buildingNameController,
                                                  color: controller
                                                      .appColors.transparent,
                                                  prefixIcon: SvgPicture.string(
                                                    icBuildingss,
                                                    color: controller
                                                        .appColors.grey,
                                                  ).paddingOnly(left: 15.px),
                                                  suffixIcon: SvgPicture.string(
                                                    icDownArrow,
                                                    color: controller
                                                        .appColors.grey,
                                                  ).paddingAll(10.px),
                                                  onChange: (value) {
                                                    controller.update();
                                                  },
                                                  padding: EdgeInsets.zero,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 15.px),
                                                  shadowColor: controller
                                                      .appColors.transparent,
                                                  labelText:
                                                      Strings.buildingName,
                                                )),
                                    ],
                                  ).paddingOnly(bottom: 32.px)
                                : Row(
                                    children: [
                                      Expanded(
                                        child: CommonTextRow(
                                          title: 'Building Name: ',
                                          subTitle: '[Building Name]',
                                          imageString: icBuildings,
                                        ),
                                      ),
                                      SizedBox(width: 16.px),
                                      Expanded(
                                        child: CommonTextRow(
                                          isImage: true,
                                          title: 'Year Constructed: ',
                                          subTitle: '[Year Constructed]',
                                          imageString: icCalender2,
                                        ),
                                      ),
                                    ],
                                  ),
                            controller.isManually == true
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: CommonTextField(
                                          isLable: true,
                                          readOnly: controller.isEdited(),
                                          controller: controller
                                              .yearConstructedController,
                                          color:
                                              controller.appColors.transparent,
                                          padding: EdgeInsets.zero,
                                          contentPadding: EdgeInsets.only(
                                              left: 15.px,
                                              top: 16.px,
                                              bottom: 16.px),
                                          shadowColor:
                                              controller.appColors.transparent,
                                          labelText: Strings.yearConstructed,
                                          isLableColor: controller
                                              .appColors.black
                                              .withOpacity(controller
                                                          .buildingNameController
                                                          .text
                                                          .isEmpty &&
                                                      controller
                                                          .yearConstructedController
                                                          .text
                                                          .isEmpty
                                                  ? .12
                                                  : 1.0),
                                          borderColor: controller
                                              .appColors.black
                                              .withOpacity(controller
                                                          .buildingNameController
                                                          .text
                                                          .isEmpty &&
                                                      controller
                                                          .yearConstructedController
                                                          .text
                                                          .isEmpty
                                                  ? .12
                                                  : 1.0),
                                        ),
                                      ),
                                      SizedBox(width: 16.px),
                                      Expanded(
                                        child: TypeAheadField(
                                          controller:
                                              controller.buildingTypeController,
                                          suggestionsCallback: controller
                                                  .isSelected
                                              ? (search) {
                                                  return null;
                                                }
                                              : (search) async {
                                                  await controller
                                                      .searchBuildingType(
                                                          searchText: search);
                                                  controller.update();
                                                  return controller
                                                      .searchBuildingTypeList;
                                                },
                                          builder: (context, c, focusNode) {
                                            return CommonTextField(
                                              focusNode: focusNode,
                                              isLable: true,
                                              readOnly:
                                                  controller.isSelected != true
                                                      ? false
                                                      : true,
                                              controller: c,
                                              color: controller
                                                  .appColors.transparent,
                                              suffixIcon: SvgPicture.string(
                                                icDownArrow,
                                                color: controller
                                                    .appColors.black
                                                    .withOpacity(controller
                                                                .buildingNameController
                                                                .text
                                                                .isEmpty &&
                                                            controller
                                                                .buildingTypeController
                                                                .text
                                                                .isEmpty
                                                        ? .12
                                                        : 1.0),
                                              ).paddingAll(10.px),
                                              padding: EdgeInsets.zero,
                                              isLableColor: controller
                                                  .appColors.black
                                                  .withOpacity(controller
                                                              .buildingNameController
                                                              .text
                                                              .isEmpty &&
                                                          controller
                                                              .buildingTypeController
                                                              .text
                                                              .isEmpty
                                                      ? .12
                                                      : 1.0),
                                              borderColor: controller
                                                  .appColors.black
                                                  .withOpacity(controller
                                                              .buildingNameController
                                                              .text
                                                              .isEmpty &&
                                                          controller
                                                              .buildingTypeController
                                                              .text
                                                              .isEmpty
                                                      ? .12
                                                      : 1.0),
                                              contentPadding:
                                                  EdgeInsets.only(left: 15.px),
                                              shadowColor: controller
                                                  .appColors.transparent,
                                              labelText: Strings.buildingType,
                                            );
                                          },
                                          itemBuilder: (context, dynamic i) {
                                            return ListTile(
                                              title: MyTextView(
                                                i.name.toString(),
                                                textStyleNew: MyTextStyle(
                                                  textColor: controller
                                                      .appColors.black,
                                                  textWeight: FontWeight.w400,
                                                  textFamily: fontFamilyBold,
                                                  textSize: 16.px,
                                                ),
                                              ),
                                            );
                                          },
                                          onSelected: (value) async {
                                            controller
                                                .actionBuildingType(value);
                                            controller.update();
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Expanded(
                                        child: CommonTextRow(
                                          title: 'Building Type: ',
                                          subTitle: '[Building Type]',
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
                                            color: controller.appColors.black
                                                .withOpacity(.12))),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Checkbox(
                                              onChanged: (value) async {
                                                await controller.isAllSelected(
                                                    value ?? false);
                                                controller
                                                    .getCertificatesJson();
                                              },
                                              tristate: true,
                                              value: controller.isData,
                                              activeColor:
                                                  controller.appColors.appColor,
                                            ),
                                            MyTextView(
                                              Strings.certificates,
                                              textStyleNew: MyTextStyle(
                                                textColor:
                                                    controller.appColors.black,
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
                                                    controller.allSelected();
                                                    controller
                                                        .getCertificatesJson();
                                                    controller.update();
                                                  },
                                                  value: controller.checked[i],
                                                  activeColor: controller
                                                      .appColors.appColor,
                                                ),
                                                MyTextView(
                                                  controller.certificates![i]
                                                      .certificate,
                                                  textStyleNew: MyTextStyle(
                                                    textColor: controller
                                                        .appColors.black,
                                                    textWeight: FontWeight.w400,
                                                    textFamily: fontFamilyBold,
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
                    ),
                  ).paddingOnly(left: 32.px, right: 32.px),
                ),
                controller.isManually == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonIconButton(
                            title: Strings.inspectUnit,
                            icon: icHome,
                            iconheigth: null,
                            iconColor: controller.getStartInspection()
                                ? controller.appColors.appColor
                                : controller.appColors.black
                                    .withOpacity(0.11999999731779099),
                            radius: 100.px,
                            width: 171.px,
                            height: 44.px,
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.px,
                            ),
                            textSize: 16.px,
                            textWeight: FontWeight.w500,
                            textFamily: fontFamilyRegular,
                            textColor: controller.getStartInspection()
                                ? controller.appColors.appColor
                                : controller.appColors.border1,
                            color: controller.appColors.transparent,
                            border: Border.all(
                                color: controller.getStartInspection()
                                    ? controller.appColors.black
                                    : controller.appColors.black
                                        .withOpacity(0.11999999731779099)),
                            onTap: () async {
                              if (controller.getStartInspection()) {
                                controller.getPropertyJson();
                                if (controller.isSelected == false) {
                                  controller.createBuilding();
                                } else {
                                  controller.getBuildingJson();
                                }
                                Get.toNamed(UnitInspection.routes, arguments: {
                                  "deficiencyArea": [],
                                  "buildingName":
                                      controller.buildingNameController.text,
                                  "buildingtype":
                                      controller.buildingTypeController.text,
                                  "imagesList": [],
                                  "isManually": true,
                                  "inspectionName":
                                      controller.inspectorController.text,
                                  "propertyInfo": controller.propertyInfo,
                                  "buildingInfo": controller.buildingInfo,
                                  "certificatesInfo":
                                      controller.certificatesInfo,
                                  "inspectorName":
                                      controller.inspectorController.text,
                                  "inspectorDate":
                                      controller.inspectionDateController.text
                                });
                              }
                              controller.update();
                            },
                          ).paddingSymmetric(vertical: 24.px),
                          SizedBox(width: 32.px),
                          CommonIconButton(
                            title: Strings.inspectBuilding,
                            radius: 100.px,
                            width: 171.px,
                            height: 44.px,
                            padding: EdgeInsets.symmetric(
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
                            onTap: () {
                              if (controller.getStartInspection()) {
                                // controller.getcertificatesjson();
                                controller.getPropertyJson();
                                if (controller.isSelected == false) {
                                  controller.createBuilding();
                                } else {
                                  controller.getBuildingJson();
                                }
                                Get.toNamed(BuildingStandardsScreen.routes,
                                    arguments: {
                                      "buildingName": controller
                                          .buildingNameController.text,
                                      "propertyInfo": controller.propertyInfo,
                                      "isManually": true,
                                      "buildingInfo": controller.buildingInfo,
                                      "buildingtype": controller
                                          .buildingTypeController.text,
                                      "certificatesInfo":
                                          controller.certificatesInfo,
                                      "inspectorName":
                                          controller.inspectorController.text,
                                      "inspectorDate": controller
                                          .inspectionDateController.text
                                    });
                              }
                            },
                            icon: icBuildings,
                            iconColor: controller.getStartInspection()
                                ? controller.appColors.appColor
                                : controller.appColors.black
                                    .withOpacity(0.11999999731779099),
                            iconheigth: null,
                          ).paddingSymmetric(vertical: 24.px),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonButton(
                            title: Strings.startInspection,
                            radius: 100.px,
                            width: 171.px,
                            height: 44.px,
                            textSize: 16.px,
                            textWeight: FontWeight.w600,
                            textFamily: fontFamilyRegular,
                            textColor: controller.appColors.black,
                            color: controller.appColors.textPink,
                            onTap: () async {
                              Get.toNamed(BuildingStandardsScreen.routes,
                                  arguments: {"isManually": false});
                              controller.update();
                            },
                          ).paddingSymmetric(vertical: 24.px),
                        ],
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
