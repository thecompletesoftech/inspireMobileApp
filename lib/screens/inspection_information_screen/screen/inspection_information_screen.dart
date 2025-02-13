import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/inspection_information_screen/controller/inspection_information_controller.dart';
import 'package:public_housing/screens/inspection_list_screen/controller/inspection_list_controller.dart';
import 'package:public_housing/screens/inspection_standards_screen/screen/inspection_standards_screen.dart';
import 'package:public_housing/screens/no_show_screen/screen/no_show_screen.dart';
import 'package:public_housing/screens/unit_list_screen/widget/common_unit_list_container.dart';

class InspectionInformationScreen
    extends GetView<InspectionInformationController> {
  const InspectionInformationScreen({Key? key}) : super(key: key);

  static const routes = "/InspectionInformationScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InspectionInformationController>(
      init: InspectionInformationController(),
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
                      Row(
                        children: [
                          MyTextView(
                            '${controller.unitAddress} - ${controller.unitName}',
                            textStyleNew: MyTextStyle(
                                textSize: 20.px,
                                textColor: AppColors().black,
                                textWeight: FontWeight.w600),
                          ),
                          controller.inspectionType.type != null
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.px, horizontal: 16.px),
                                  decoration: BoxDecoration(
                                      color: AppColors().white,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: MyTextView(
                                    controller.inspectionType.type ?? "",
                                    textStyleNew: MyTextStyle(
                                        textSize: 14.px,
                                        textColor: AppColors().black,
                                        textWeight: FontWeight.w500),
                                  ),
                                ).paddingOnly(left: 24.px)
                              : SizedBox(),
                        ],
                      ).paddingOnly(top: 31.px),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16.px),
                            decoration: BoxDecoration(color: AppColors().white),
                            child: CommonRow(
                              image: icCalenderColor,
                              imageName:
                                  '${DateFormat("MM/dd/yyyy").format(controller.scheduleDate!)}',
                              imageNameColor: AppColors().black,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(16.px),
                            decoration: BoxDecoration(color: AppColors().white),
                            child: CommonRow(
                              image: clockIcon,
                              imageName: '${controller.timeFrame}',
                              imageNameColor: AppColors().black,
                            ),
                          ).paddingOnly(left: 16.px),
                        ],
                      ).paddingOnly(top: 24.px),
                      Container(
                        height: 2.px,
                        color: AppColors().divider,
                      ).paddingSymmetric(vertical: 33.px),
                      ShadowContainer(
                        radius: 8.px,
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        elevation: 1.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                MyTextView(
                                  '${controller.unitData.tenant?.firstName ?? ""} ${controller.unitData.tenant?.lastName ?? ""}',
                                  textStyleNew: MyTextStyle(
                                      textSize: 20.px,
                                      textColor: AppColors().black,
                                      textWeight: FontWeight.w600),
                                ),
                                MyTextView(
                                  ' - ${controller.unitData.tenant?.tenantId ?? ""}',
                                  textStyleNew: MyTextStyle(
                                      textSize: 16.px,
                                      textColor: AppColors().black,
                                      textWeight: FontWeight.w400),
                                ).paddingOnly(top: 4.px),
                              ],
                            ),
                            MyTextView(
                              Strings.tenantNames,
                              textStyleNew: MyTextStyle(
                                  textSize: 16.px,
                                  textColor: AppColors().black,
                                  textWeight: FontWeight.w400),
                            ),
                          ],
                        ).paddingAll(16.px),
                      ),
                      ShadowContainer(
                        radius: 8.px,
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        elevation: 1.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                MyTextView(
                                  '${controller.unitData.landlord?.name ?? ""}',
                                  textStyleNew: MyTextStyle(
                                      textSize: 20.px,
                                      textColor: AppColors().black,
                                      textWeight: FontWeight.w600),
                                ),
                                MyTextView(
                                  ' - ${controller.unitData.landlord?.id ?? ""}',
                                  textStyleNew: MyTextStyle(
                                      textSize: 16.px,
                                      textColor: AppColors().black,
                                      textWeight: FontWeight.w400),
                                ).paddingOnly(top: 4.px),
                              ],
                            ),
                            MyTextView(
                              Strings.landlord,
                              textStyleNew: MyTextStyle(
                                  textSize: 16.px,
                                  textColor: AppColors().black,
                                  textWeight: FontWeight.w400),
                            ),
                          ],
                        ).paddingAll(16.px),
                      ).paddingOnly(top: 24.px),
                      Container(
                        height: 2.px,
                        color: AppColors().divider,
                      ).paddingSymmetric(vertical: 33.px),
                      MyTextView(
                        'Inspector Notes',
                        textStyleNew: MyTextStyle(
                            textSize: 24.px,
                            textColor: AppColors().black,
                            textWeight: FontWeight.w400),
                      ),
                      CommonTextField(
                        isLable: true,
                        controller: controller.inspectionNotesController,
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
                        hintText: Strings.commentHint,
                      ).paddingOnly(top: 16.px),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              isLable: true,
                              readOnly: false,
                              controller: controller.bedroomsController,
                              color: controller.appColors.transparent,
                              prefixIcon: SvgPicture.string(
                                icbedrooms,
                                color: controller.appColors.grey,
                              ).paddingOnly(left: 15.px, right: 15.px),
                              inputType: TextInputType.number,
                              padding: EdgeInsets.zero,
                              contentPadding: EdgeInsets.only(left: 25.px),
                              shadowColor: controller.appColors.transparent,
                              labelText: Strings.bedroom,
                              onChange: (value) {
                                if (value.isNotEmpty) {
                                  controller.unitData.numberOfBedrooms =
                                      int.parse(value);
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 16.px),
                          Expanded(
                            child: CommonTextField(
                              isLable: true,
                              readOnly: false,
                              controller: controller.bathroomsController,
                              color: controller.appColors.transparent,
                              prefixIcon: SvgPicture.string(
                                icbathroom,
                                color: controller.appColors.grey,
                              ).paddingOnly(left: 15.px, right: 15.px),
                              inputType: TextInputType.number,
                              padding: EdgeInsets.zero,
                              contentPadding: EdgeInsets.only(left: 25.px),
                              shadowColor: controller.appColors.transparent,
                              labelText: Strings.bathroom,
                              onChange: (value) {
                                if (value.isNotEmpty) {
                                  controller.unitData.numberOfBathrooms =
                                      int.parse(value);
                                }
                              },
                            ),
                          ),
                        ],
                      ).paddingOnly(top: 32.px),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonButton(
                            title: Strings.noShow,
                            textColor: AppColors().appColor,
                            textWeight: FontWeight.w600,
                            textSize: 16.px,
                            onTap: () {
                              inspectionReqModel.unit?.id =
                                  controller.unitData.id;
                              inspectionReqModel.unit?.numberOfBathrooms =
                                  int.parse(
                                      controller.bathroomsController.text);
                              inspectionReqModel.unit?.numberOfBedrooms =
                                  int.parse(controller.bedroomsController.text);
                              inspectionReqModel.unit?.name =
                                  controller.unitName;
                              inspectionReqModel.unit?.address =
                                  controller.unitAddress;
                              inspectionReqModel.unit?.occupied =
                                  controller.unitData.occupied;
                              Get.toNamed(
                                NoShowScreen.routes,
                                arguments: {
                                  "unitAddress": controller.unitAddress,
                                  "unitName": controller.unitName,
                                  "inspectionType": controller.inspectionType,
                                },
                              );
                            },
                            width: 115.px,
                            height: 44.px,
                            color: AppColors().transparent,
                            border: Border.all(color: AppColors().black),
                          ),
                          SizedBox(width: 24.px),
                          CommonButton(
                            title: Strings.startInspection,
                            textColor: AppColors().black,
                            textWeight: FontWeight.w600,
                            textSize: 16.px,
                            onTap: () {
                              inspectionReqModel.unit?.id =
                                  controller.unitData.id;
                              inspectionReqModel.unit?.numberOfBathrooms =
                                  int.parse(
                                      controller.bathroomsController.text);
                              inspectionReqModel.unit?.numberOfBedrooms =
                                  int.parse(controller.bedroomsController.text);
                              inspectionReqModel.unit?.name =
                                  controller.unitName;
                              inspectionReqModel.unit?.address =
                                  controller.unitAddress;
                              inspectionReqModel.unit?.occupied =
                                  controller.unitData.occupied;

                              Get.toNamed(
                                InspectionStandardsScreen.routes,
                                arguments: {
                                  "unitAddress": controller.unitAddress,
                                  "unitName": controller.unitName,
                                  "inspectionType": controller.inspectionType,
                                  "unitData": controller.unitData,
                                },
                              );
                            },
                            width: 171.px,
                            height: 44.px,
                            color: AppColors().textPink,
                          ),
                        ],
                      ).paddingOnly(top: 48.px)
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
