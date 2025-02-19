import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/no_show_screen/controller/no_show_controller.dart';
import 'package:public_housing/screens/inspection_list_screen/controller/inspection_list_controller.dart';

class NoShowScreen extends GetView<NoShowController> {
  const NoShowScreen({Key? key}) : super(key: key);

  static const routes = "/NoShowScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoShowController>(
      init: NoShowController(),
      autoRemove: true,
      assignId: true,
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: SafeArea(
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
                  flex: 1,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      controller.imageUploadStatus == ImageUploadStatus.success
                          ? Stack(
                              children: [
                                Image.network(
                                  controller.imageFile.toString(),
                                  fit: BoxFit.contain,
                                  height: 433.px,
                                  width: Get.width,
                                ),
                                Positioned(
                                  top: 32.0,
                                  right: 32.0,
                                  child: CommonButton(
                                    title: Strings.changePicture,
                                    textSize: 16.px,
                                    textWeight: FontWeight.w500,
                                    textColor: AppColors().white,
                                    color: AppColors().appColor,
                                    onTap: () {
                                      controller.imageUploadStatus =
                                          ImageUploadStatus.initial;
                                      controller.imageFile = "";
                                      controller.visibleBtn = false;
                                      controller.update();
                                    },
                                    radius: 100.px,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24.px, vertical: 10.px),
                                  ),
                                ),
                                // Positioned(
                                //   bottom: 32.0,
                                //   left: 32.0,
                                //   child: CommonButton(
                                //     title:
                                //         '${DateFormat('MM-dd-yyyy HH:mm').format(controller.selectedDateTime!)}',
                                //     textSize: 16.px,
                                //     textWeight: FontWeight.w500,
                                //     textColor: AppColors().lightGreen,
                                //     color: AppColors().black.withOpacity(.5),
                                //     onTap: () {},
                                //     radius: 0.px,
                                //     padding: EdgeInsets.symmetric(
                                //         horizontal: 24.px, vertical: 10.px),
                                //   ),
                                // ),
                              ],
                            )
                          : controller.imageUploadStatus ==
                                  ImageUploadStatus.initial
                              ? Container(
                                  height: 433.px,
                                  color: controller.appColors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: SvgPicture.string(
                                          icImage,
                                          width: 138.px,
                                          height: 138.px,
                                        ),
                                      ).paddingOnly(bottom: 20.px),
                                      Flexible(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Take a picture",
                                                style: MyTextStyle(
                                                  textSize: 24.px,
                                                  textWeight: FontWeight.w600,
                                                  textColor: controller
                                                      .appColors.appColor,
                                                  textFamily: fontFamilyBold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: " of the unit to ",
                                                style: MyTextStyle(
                                                  textSize: 24.px,
                                                  textWeight: FontWeight.w400,
                                                  textColor: controller
                                                      .appColors.appColor,
                                                  textFamily: fontFamilyRegular,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "Complete the Inspection",
                                                style: MyTextStyle(
                                                  textSize: 24.px,
                                                  textWeight: FontWeight.w600,
                                                  textColor: controller
                                                      .appColors.appColor,
                                                  textFamily: fontFamilyBold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CommonIconButton(
                                              icon: icUpload,
                                              iconheigth: 20.px,
                                              title: Strings.upload,
                                              radius: 100.px,
                                              border: Border.all(
                                                  color: controller
                                                      .appColors.border,
                                                  width: 2),
                                              padding: EdgeInsets.fromLTRB(
                                                  16.px, 10.px, 24.px, 10.px),
                                              color: controller
                                                  .appColors.transparent,
                                              textColor:
                                                  controller.appColors.appColor,
                                              textWeight: FontWeight.w600,
                                              textSize: 16.px,
                                              onTap: () {
                                                controller.getFromGallery();
                                              }),
                                          SizedBox(width: 16.px),
                                          CommonIconButton(
                                              icon: icCamera,
                                              iconheigth: 20.px,
                                              title: Strings.takeOne,
                                              radius: 100.px,
                                              border: Border.all(
                                                  color: controller
                                                      .appColors.border,
                                                  width: 2),
                                              padding: EdgeInsets.fromLTRB(
                                                  16.px, 10.px, 24.px, 10.px),
                                              color: controller
                                                  .appColors.transparent,
                                              textColor:
                                                  controller.appColors.appColor,
                                              textWeight: FontWeight.w600,
                                              textSize: 16.px,
                                              onTap: () {
                                                controller.getFromCamera();
                                              }),
                                        ],
                                      ).paddingOnly(top: 20.px),
                                    ],
                                  ),
                                )
                              : Container(
                                  height: 433.px,
                                  color: controller.appColors.white,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                      Container(height: 1.px, color: AppColors().divider),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyTextView(
                                '${controller.unitAddress} - ${controller.unitName}',
                                textStyleNew: MyTextStyle(
                                  textColor: controller.appColors.appColor,
                                  textWeight: FontWeight.w600,
                                  textFamily: fontFamilyBold,
                                  textSize: 20.px,
                                ),
                              ),
                              controller.inspectionType.type != null
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.px, horizontal: 16.px),
                                      decoration: BoxDecoration(
                                          color: AppColors().white,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: MyTextView(
                                        controller.inspectionType.type,
                                        textStyleNew: MyTextStyle(
                                            textSize: 14.px,
                                            textColor: AppColors().black,
                                            textWeight: FontWeight.w500),
                                      ),
                                    ).paddingOnly(left: 24.px)
                                  : SizedBox(),
                            ],
                          ).paddingOnly(top: 40.px, bottom: 48.px),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyTextView(
                                Strings.noShow,
                                textStyleNew: MyTextStyle(
                                  textSize: 40.px,
                                  textWeight: FontWeight.w700,
                                  textColor: controller.appColors.appColor,
                                  textFamily: fontFamilyBold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.px),
                          Row(
                            children: [
                              MyTextView(
                                Strings.unitcannitbeinspected,
                                textStyleNew: MyTextStyle(
                                  textSize: 24.px,
                                  textWeight: FontWeight.w400,
                                  textColor: controller.appColors.black,
                                  textFamily: fontFamilyRegular,
                                ),
                              ),
                            ],
                          ).paddingSymmetric(vertical: 32.px),
                          Row(
                            children: [
                              Expanded(
                                child: CommonTextField(
                                  isLable: true,
                                  controller: controller.textController,
                                  color: controller.appColors.transparent,
                                  prefixIcon: SvgPicture.string(
                                    icMsg,
                                    color: controller.appColors.lightText,
                                    // height: 20,
                                  ).paddingOnly(left: 15.px),
                                  padding: EdgeInsets.zero,
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
                                  onChange: (str) {
                                    if (str.isNotEmpty &&
                                        (controller.imageFile.isNotEmpty ||
                                            controller.change)) {
                                      controller.visibleBtn = true;
                                    } else {
                                      controller.visibleBtn = false;
                                    }
                                    controller.update();
                                  },
                                  labelText: Strings.unitcannitbeinspected,
                                  hintText: Strings.reasonUninspectable,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40.px),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonButton(
                                  title: Strings.completedInspection,
                                  textColor: controller.visibleBtn &&
                                          controller.imageFile.isNotEmpty
                                      ? controller.appColors.black
                                      : controller.appColors.border1,
                                  color: controller.visibleBtn &&
                                          controller.imageFile.isNotEmpty
                                      ? controller.appColors.textPink
                                      : controller.appColors.black
                                          .withOpacity(0.11999999731779099),
                                  radius: 35.px,
                                  textWeight: FontWeight.w600,
                                  textSize: 16.px,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.px,
                                    vertical: 10.px,
                                  ),
                                  onTap: () async {
                                    if (controller.visibleBtn &&
                                        controller.imageFile.isNotEmpty) {
                                      inspectionReqModel.inspection
                                          ?.noShowImage = controller.imageFile;
                                      inspectionReqModel.inspection?.comment =
                                          controller.textController.text;
                                      await controller.createInspection();
                                    }
                                  }),
                            ],
                          ),
                        ],
                      ).paddingOnly(bottom: 32.px, left: 32.px, right: 32.px),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
