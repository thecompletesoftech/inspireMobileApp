import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/inspection_screen/inspection_controller.dart';
import 'package:public_housing/screens/noshow_screen/noshow_controller.dart';

import '../home_screen/home_controller.dart';

class NoShowScreen extends GetView<NoShowController> {
  const NoShowScreen({Key? key}) : super(key: key);
  static const routes = "/NoShowScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoShowController>(
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: Column(
            children: [
              CommonAppBar(color: controller.appColors.transparent, radius: 0.px),
              Expanded(
                flex: 1,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    controller.imageFile.isNotEmpty
                        ? Stack(
                            children: [
                              Image.file(
                                File(controller.imageFile.toString()),
                                fit: BoxFit.cover,
                                height: 400.px,
                                width: Get.width,
                              ),
                              Positioned(
                                top: 10.0,
                                right: 10.0,
                                child: CommonButton(
                                  title: Strings.changePicture,
                                  textSize: 16.px,
                                  textWeight: FontWeight.w500,
                                  textColor: controller.appColors.lightText,
                                  color: controller.appColors.buttonColor,
                                  onTap: () {
                                    controller.imageFile.value = "";
                                    controller.visibleBtn = false;
                                    controller.update();
                                  },
                                  radius: 100.px,
                                  padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                                ),
                              ),
                            ],
                          )
                        : controller.item!.status == InspectionStatus.completed.toString() &&
                                controller.item != null &&
                                controller.item!.imgId != "" &&
                                controller.change
                            ? Stack(
                                children: [
                                  Image.asset(
                                    controller.item!.imgId ?? ImagePath.media1,
                                    fit: BoxFit.cover,
                                    height: 400.px,
                                    width: Get.width,
                                  ),
                                  Positioned(
                                    top: 10.0,
                                    right: 10.0,
                                    child: CommonButton(
                                      title: Strings.changePicture,
                                      textSize: 16.px,
                                      textWeight: FontWeight.w500,
                                      textColor: controller.appColors.lightText,
                                      color: controller.appColors.buttonColor,
                                      onTap: () {
                                        controller.change = false;
                                        controller.update();
                                      },
                                      radius: 100.px,
                                      padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                height: 400.px,
                                color: controller.appColors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                                textColor: controller.appColors.appColor,
                                                textFamily: fontFamilyBold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " of the unit to ",
                                              style: MyTextStyle(
                                                textSize: 24.px,
                                                textWeight: FontWeight.w400,
                                                textColor: controller.appColors.appColor,
                                                textFamily: fontFamilyRegular,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "Start the Inspection",
                                              style: MyTextStyle(
                                                textSize: 24.px,
                                                textWeight: FontWeight.w600,
                                                textColor: controller.appColors.appColor,
                                                textFamily: fontFamilyBold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CommonIconButton(
                                            icon: icUpload,
                                            iconheigth: 20.px,
                                            title: Strings.upload,
                                            radius: 100.px,
                                            border: Border.all(color: controller.appColors.border, width: 2),
                                            padding: EdgeInsets.fromLTRB(16.px, 10.px, 24.px, 10.px),
                                            color: controller.appColors.transparent,
                                            textColor: controller.appColors.appColor,
                                            textWeight: FontWeight.w600,
                                            textSize: 16.px,
                                            onTap: () {
                                              controller.getFromGallery();
                                            }),
                                        SizedBox(
                                          width: 16.px,
                                        ),
                                        CommonIconButton(
                                            icon: icCamera,
                                            iconheigth: 20.px,
                                            title: Strings.takeOne,
                                            radius: 100.px,
                                            border: Border.all(color: controller.appColors.border, width: 2),
                                            padding: EdgeInsets.fromLTRB(16.px, 10.px, 24.px, 10.px),
                                            color: controller.appColors.transparent,
                                            textColor: controller.appColors.appColor,
                                            textWeight: FontWeight.w600,
                                            textSize: 16.px,
                                            onTap: () {
                                              controller.getFromCamera();
                                            }),
                                      ],
                                    ).paddingOnly(top: 20.px),
                                  ],
                                ),
                              ),
                    Column(
                      children: [
                        SizedBox(
                          height: 8.px,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: MyTextView(
                                controller.item == null
                                    ? ""
                                    : "${controller.item!.massage}, ${controller.itemTitle} - ${controller.item!.title}",
                                textStyleNew: MyTextStyle(
                                  textSize: Utils.isMediumScreen(context) ? 24.px : 20.px,
                                  textWeight: FontWeight.w600,
                                  textColor: controller.appColors.appColor,
                                  textFamily: fontFamilyBold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16.px,
                            ),
                            controller.item != null
                                ? CommonButton(
                                    title: controller.item!.check == false ? Strings.annualInspection : Strings.tenant,
                                    textSize: 14.px,
                                    isSmall: false,
                                    isBig: true,
                                    radius: 20.px,
                                    textWeight: FontWeight.w500,
                                    color: controller.appColors.white,
                                    textColor: controller.item!.check == false
                                        ? controller.appColors.textGreen
                                        : controller.appColors.textPink,
                                    onTap: () {})
                                : Container(),
                          ],
                        ),
                        SizedBox(
                          height: 56.px,
                        ),
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
                        SizedBox(
                          height: 16.px,
                        ),
                        Row(
                          children: [
                            MyTextView(
                              Strings.addComment,
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
                                    controller: controller.commentController,
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
                                          controller.dateController.text.isNotEmpty &&
                                          (controller.imageFile.isNotEmpty || controller.change)) {
                                        controller.visibleBtn = true;
                                      } else {
                                        controller.visibleBtn = false;
                                      }
                                      controller.update();
                                    },
                                    labelText: Strings.comments,
                                    hintText: Strings.comments)),
                          ],
                        ),
                        SizedBox(
                          height: 24.px,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 0,
                                child: SizedBox(
                                  width: 200.px,
                                  child: CommonTextField(
                                      isLable: true,
                                      readOnly: true,
                                      isLableColor: controller.appColors.grey,
                                      onTap: () {
                                        controller.selectDate();
                                      },
                                      padding: EdgeInsets.zero,
                                      contentPadding: EdgeInsets.only(left: 16.px),
                                      controller: controller.dateController,
                                      color: controller.appColors.transparent,
                                      suffixIcon: SvgPicture.string(
                                        icCalender2,
                                        color: controller.appColors.lightText,
                                      ),
                                      shadowColor: controller.appColors.transparent,
                                      hintText: "mm/dd/yyyy",
                                      onChange: (str) {
                                        if (str.isNotEmpty && controller.commentController.text.isNotEmpty) {
                                          controller.visibleBtn = true;
                                          controller.update();
                                        }
                                      },
                                      labelText: Strings.completedDate),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 40.px,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonButton(
                                title: Strings.completedInspection,
                                textColor:
                                    controller.visibleBtn ? controller.appColors.black : controller.appColors.border1,
                                color: controller.visibleBtn
                                    ? controller.appColors.textPink
                                    : controller.appColors.black.withOpacity(0.11999999731779099),
                                radius: 35.px,
                                textWeight: FontWeight.w600,
                                textSize: 16.px,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.px,
                                  vertical: 10.px,
                                ),
                                onTap: () {
                                  if (controller.visibleBtn) {
                                    if (Get.isRegistered<InspectionController>()) {
                                      Get.find<InspectionController>().dataList.where((element) {
                                        if (element.id == controller.item!.id) {
                                          element.status = InspectionStatus.inCompleted.toString();
                                        }
                                        return element.id == controller.item!.id;
                                      });

                                      Get.back(result: true);
                                    }
                                  }
                                }),
                          ],
                        ),
                        SizedBox(
                          height: 15.px,
                        ),
                      ],
                    ).paddingAll(32.px),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
