import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/inspection_list_screen/controller/inspection_list_controller.dart';
import 'package:public_housing/screens/no_show_screen/screen/no_show_screen.dart';
import 'package:public_housing/screens/inspection_standards_screen/screen/inspection_standards_screen.dart';
import 'package:public_housing/screens/manual_unit_inspection_screen/controller/manual_unit_inspection_controller.dart';

class ManualUnitInspectionScreen
    extends GetView<ManualUnitInspectionController> {
  const ManualUnitInspectionScreen({Key? key}) : super(key: key);

  static const routes = "/ManualUnitInspectionScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManualUnitInspectionController>(
      init: ManualUnitInspectionController(),
      autoRemove: true,
      assignId: true,
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
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: MyTextView(
                          Strings.unitinpection,
                          textStyleNew: MyTextStyle(
                              textSize: 32.px,
                              textColor: AppColors().appColor,
                              textWeight: FontWeight.w600),
                        ),
                      ).paddingOnly(top: 16.px, bottom: 48.px),
                      ShadowContainer(
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: CommonTextField(
                                        isLable: true,
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
                                      Strings.unitinpection,
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
                                ).paddingSymmetric(vertical: 32.px),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CommonTextField(
                                        isLable: true,
                                        onChange: ((value) {
                                          controller.update();
                                        }),
                                        controller:
                                            controller.tenantNameController,
                                        color: controller.appColors.transparent,
                                        prefixIcon: SvgPicture.string(ichome1)
                                            .paddingSymmetric(
                                                horizontal: 15.px),
                                        padding: EdgeInsets.zero,
                                        contentPadding:
                                            EdgeInsets.only(left: 15.px),
                                        shadowColor:
                                            controller.appColors.transparent,
                                        labelText: Strings.tenantName,
                                      ),
                                    ),
                                    SizedBox(width: 16.px),
                                    Expanded(
                                      child: CommonTextField(
                                        isLable: true,
                                        onChange: ((value) {
                                          controller.update();
                                        }),
                                        controller:
                                            controller.unitAddressController,
                                        color: controller.appColors.transparent,
                                        prefixIcon:
                                            SvgPicture.string(icLocation)
                                                .paddingOnly(left: 15.px),
                                        padding: EdgeInsets.zero,
                                        contentPadding:
                                            EdgeInsets.only(left: 15.px),
                                        shadowColor:
                                            controller.appColors.transparent,
                                        labelText: Strings.unitAddress,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CommonTextField(
                                        isLable: true,
                                        onChange: ((value) {
                                          controller.update();
                                        }),
                                        controller:
                                            controller.landlordNameController,
                                        color: controller.appColors.transparent,
                                        prefixIcon: SvgPicture.string(ichome1)
                                            .paddingSymmetric(
                                                horizontal: 15.px),
                                        padding: EdgeInsets.zero,
                                        contentPadding:
                                            EdgeInsets.only(left: 15.px),
                                        shadowColor:
                                            controller.appColors.transparent,
                                        labelText: Strings.landlordName,
                                      ),
                                    ),
                                    SizedBox(width: 16.px),
                                    Expanded(
                                      child: TypeAheadField(
                                        controller:
                                            controller.inspectionTypeController,
                                        suggestionsCallback:
                                            controller.isSelected
                                                ? (search) {
                                                    return null;
                                                  }
                                                : (search) async {
                                                    await controller
                                                        .searchInspectionType(
                                                            searchText: search);
                                                    controller.update();
                                                    return controller
                                                        .selectInspectionTypeList;
                                                  },
                                        builder: (context, c, focusNode) {
                                          return CommonTextField(
                                            focusNode: focusNode,
                                            isLable: true,
                                            readOnly: false,
                                            controller: c,
                                            color: controller
                                                .appColors.transparent,
                                            suffixIcon: SvgPicture.string(
                                              icDownArrow,
                                              color: controller.appColors.black
                                                  .withOpacity(1.0),
                                            ).paddingAll(10.px),
                                            padding: EdgeInsets.zero,
                                            borderColor: controller
                                                .appColors.black
                                                .withOpacity(1.0),
                                            contentPadding:
                                                EdgeInsets.only(left: 15.px),
                                            shadowColor: controller
                                                .appColors.transparent,
                                            labelText: Strings.inspectionType,
                                            onChange: ((value) {
                                              controller.update();
                                            }),
                                          );
                                        },
                                        itemBuilder: (context, dynamic i) {
                                          return ListTile(
                                            title: MyTextView(
                                              i.type.toString(),
                                              textStyleNew: MyTextStyle(
                                                textColor:
                                                    controller.appColors.black,
                                                textWeight: FontWeight.w400,
                                                textFamily: fontFamilyBold,
                                                textSize: 16.px,
                                              ),
                                            ),
                                          );
                                        },
                                        onSelected: (value) {
                                          controller.actionBuildingType(value);
                                          controller.update();
                                        },
                                      ),
                                    ),
                                  ],
                                ).paddingOnly(top: 32.px),
                                MyTextView(
                                  Strings.inspectorNotes,
                                  textStyleNew: MyTextStyle(
                                    textColor: controller.appColors.black,
                                    textWeight: FontWeight.w400,
                                    textFamily: fontFamilyBold,
                                    textSize: 24.px,
                                  ),
                                ).paddingOnly(
                                    right: 10.px, top: 32.px, bottom: 24.px),
                                CommonTextField(
                                  isLable: true,
                                  controller:
                                      controller.inspectionNotesController,
                                  color: controller.appColors.transparent,
                                  prefixIcon: SvgPicture.string(
                                    icMsg,
                                    color: controller.appColors.lightText,
                                  ).paddingOnly(left: 15.px),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.listen();
                                    },
                                    child: SvgPicture.string(
                                      icMike,
                                      color: controller.isListening.value
                                          ? controller.appColors.appColor
                                          : controller.appColors.lightText,
                                    ),
                                  ),
                                  padding: EdgeInsets.zero,
                                  labelText: Strings.inspectionNotes,
                                  hintText: Strings.inspectionNotes,
                                ).paddingOnly(bottom: 32.px),
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
                              ],
                            ).paddingOnly(
                                top: 32.px,
                                bottom: 30.px,
                                right: 24.px,
                                left: 24.px),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonButton(
                            title: Strings.noShow,
                            textWeight: FontWeight.w600,
                            textSize: 16.px,
                            onTap: () {
                              inspectionReqModel.inspection?.date =
                                  DateTime.parse(
                                      controller.inspectionDateController.text);
                              inspectionReqModel.inspection?.inspectorId =
                                  controller.getStorageData
                                      .readString(
                                          controller.getStorageData.inspectorId)
                                      .toString();
                              inspectionReqModel.inspection?.inspectionTypeId =
                                  controller.inspectionType.id.toString();
                              inspectionReqModel.unit?.occupied =
                                  controller.switchButton.value;
                              inspectionReqModel.unit?.name =
                                  controller.tenantNameController.text;
                              inspectionReqModel.unit?.address =
                                  controller.unitAddressController.text;
                              inspectionReqModel.inspection?.inspectionStateId =
                                  '1';

                              Get.toNamed(
                                NoShowScreen.routes,
                                arguments: {
                                  "unitAddress":
                                      controller.unitAddressController.text,
                                  "unitName":
                                      controller.tenantNameController.text,
                                  "inspectionType": controller.inspectionType,
                                },
                              );
                            },
                            width: 115.px,
                            border: Border.all(
                                color: controller.getStartInspection()
                                    ? controller.appColors.black
                                    : controller.appColors.black
                                        .withOpacity(0.11999999731779099)),
                            height: 44.px,
                            textColor: controller.getStartInspection()
                                ? controller.appColors.appColor
                                : controller.appColors.border1,
                            color: controller.appColors.transparent,
                          ),
                          SizedBox(width: 24.px),
                          CommonButton(
                            title: Strings.startInspection,
                            textWeight: FontWeight.w600,
                            textSize: 16.px,
                            onTap: () {
                              if (controller.getStartInspection()) {
                                inspectionReqModel.inspection?.date =
                                    DateTime.parse(controller
                                        .inspectionDateController.text);
                                inspectionReqModel.inspection?.inspectorId =
                                    controller.getStorageData
                                        .readString(controller
                                            .getStorageData.inspectorId)
                                        .toString();
                                inspectionReqModel
                                        .inspection?.inspectionTypeId =
                                    controller.inspectionType.id.toString();
                                inspectionReqModel.unit?.occupied =
                                    controller.switchButton.value;
                                inspectionReqModel.unit?.name =
                                    controller.tenantNameController.text;
                                inspectionReqModel.unit?.address =
                                    controller.unitAddressController.text;
                                inspectionReqModel
                                    .inspection?.inspectionStateId = '1';

                                Get.toNamed(InspectionStandardsScreen.routes,
                                    arguments: {
                                      "unitAddress":
                                          controller.unitAddressController.text,
                                      "unitName":
                                          controller.tenantNameController.text,
                                      "inspectionType":
                                          controller.inspectionType,
                                    });
                              }
                            },
                            width: 171.px,
                            height: 44.px,
                            textColor: controller.getStartInspection()
                                ? controller.appColors.black
                                : controller.appColors.border1,
                            color: controller.getStartInspection()
                                ? controller.appColors.textPink
                                : controller.appColors.black
                                    .withOpacity(0.11999999731779099),
                          ),
                        ],
                      ).paddingOnly(top: 48.px),
                    ],
                  ).paddingSymmetric(horizontal: 32.px, vertical: 32.px),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
