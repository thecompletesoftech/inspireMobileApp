import 'dart:io';

import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/screens/propertydetails_screen/propertydetails_controller.dart';

import '../../commons/all.dart';
import '../areas_screen/areas_screen.dart';
import '../main_screen/main_controller.dart';
import 'generalNotesCard_widget.dart';

class PropertyDetailsScreen extends GetView<PropertyDetailsController> {
  const PropertyDetailsScreen({Key? key}) : super(key: key);
  static const routes = "/PropertyDetailsScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PropertyDetailsController>(
      assignId: true,
      builder: (_) {
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
                                // scale: ScalingQuery(context).scale(0.2.px),
                              ),
                              Positioned(
                                top: 10.0,
                                right: 10.0,
                                child: CommonButton(
                                  title: Strings.changePicture,
                                  textSize: 16.px,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.px,
                                    vertical: 12.0,
                                  ),
                                  textWeight: FontWeight.w500,
                                  textColor: controller.appColors.lightText,
                                  color: controller.appColors.buttonColor,
                                  onTap: () {
                                    controller.imageFile.value = "";
                                    controller.update();
                                  },
                                  radius: 25.px,
                                ),
                              ),
                            ],
                          )
                        : (controller.item!.status == InspectionStatus.completed.toString() ||
                                    controller.item!.status == InspectionStatus.inCompleted.toString()) &&
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
                                        controller.visibleBtn = false;
                                        controller.update();
                                      },
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24.px,
                                        vertical: 12.0,
                                      ),
                                      radius: 25.px,
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
                                                textFamily: fontFamilyRegular,
                                                textColor: controller.appColors.appColor,
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
                                            }).paddingOnly(right: 16.px),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Utils.isTabletScreen(context)
                                    ? Flexible(
                                        child: MyTextView(
                                          "${controller.item!.title}",
                                          textStyleNew: MyTextStyle(
                                            textSize: Utils.isMediumScreen(context) ? 24.px : 20.px,
                                            textWeight: FontWeight.w600,
                                            textColor: controller.appColors.black,
                                            textFamily: fontFamilyBold,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Utils.isTabletScreen(context)
                                    ? SizedBox(
                                        width: 24.px,
                                      )
                                    : Container(),
                                controller.item != null
                                    ? CommonButton(
                                        title: controller.item!.check == false ? Strings.inSample : Strings.tenant,
                                        textSize: 14.px,
                                        isSmall: false,
                                        isBig: true,
                                        radius: 100.px,
                                        textWeight: FontWeight.w500,
                                        color: controller.appColors.white,
                                        textColor: controller.item!.check == false
                                            ? controller.appColors.textGreen
                                            : controller.appColors.textPink,
                                        onTap: () {})
                                    : Container(),
                                // if ((Utils.isMediumScreen(context) ||
                                //     Utils.isLandScapeMode(context) && !Utils.isTabletScreen1(context))) ...[
                                controller.item!.status == InspectionStatus.completed.toString() ||
                                        controller.item!.status == InspectionStatus.inCompleted.toString()
                                    ? SizedBox(
                                        width: 16.px,
                                      )
                                    : Container(),
                                controller.item!.status == InspectionStatus.completed.toString() ||
                                        controller.item!.status == InspectionStatus.inCompleted.toString()
                                    ? CommonButton(
                                        title: controller.item!.status!.contains("completed")
                                            ? Strings.completed
                                            : Strings.inComplete,
                                        textSize: 14.px,
                                        isSmall: false,
                                        isBig: true,
                                        radius: 100.px,
                                        textWeight: FontWeight.w500,
                                        color: controller.item!.status!.contains("completed")
                                            ? controller.appColors.updateGreen
                                            : controller.appColors.updateYellow,
                                        textColor: controller.appColors.black,
                                        onTap: () {})
                                    : Container(),
                                // ]
                              ],
                            ),
                          ],
                        ).paddingOnly(bottom: 24.px),
                        Row(
                          mainAxisAlignment:
                              Utils.isTabletScreen(context) ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                          children: [
                            Utils.isTabletScreen(context)
                                ? Container()
                                : Flexible(
                                    child: MyTextView(
                                      "${controller.item!.title}",
                                      isMaxLineWrap: true,
                                      textStyleNew: MyTextStyle(
                                        textSize: Utils.isMediumScreen(context) ? 24.px : 20.px,
                                        textWeight: FontWeight.w600,
                                        textColor: controller.appColors.black,
                                        textFamily: fontFamilyBold,
                                      ),
                                    ),
                                  ),
                            Row(
                              children: [
                                ShadowContainer(
                                  radius: 4.px,
                                  padding: EdgeInsets.all(16.px),
                                  child: CommonIconButton(
                                      icon: icCalender1,
                                      iconheigth: 20.px,
                                      space: 8.px,
                                      title: "06/22/2023",
                                      padding: EdgeInsets.zero,
                                      color: controller.appColors.white,
                                      textColor: controller.appColors.black,
                                      textWeight: FontWeight.w400,
                                      textSize: 20.px,
                                      onTap: () {}),
                                ),
                                ShadowContainer(
                                  radius: 4.px,
                                  padding: EdgeInsets.all(16.px),
                                  margin: EdgeInsets.zero,
                                  child: CommonIconButton(
                                      icon: icTimeColor,
                                      iconheigth: 20.px,
                                      title: "08:00",
                                      padding: EdgeInsets.zero,
                                      color: controller.appColors.white,
                                      textColor: controller.appColors.black,
                                      textWeight: FontWeight.w400,
                                      textSize: 20.px,
                                      onTap: () {}),
                                ).paddingSymmetric(horizontal: 24.px),
                                ShadowContainer(
                                  radius: 4.px,
                                  padding: EdgeInsets.all(16.px),
                                  child: CommonIconButton(
                                      icon: icHome,
                                      iconheigth: 20.px,
                                      title: controller.item!.title,
                                      padding: EdgeInsets.zero,
                                      color: controller.appColors.white,
                                      textColor: controller.appColors.black,
                                      textWeight: FontWeight.w400,
                                      textSize: 20.px,
                                      onTap: () {}),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 2.px,
                          color: AppColors().divider,
                        ).paddingSymmetric(vertical: 32.px),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ShadowContainer(
                                radius: 8.px,
                                padding: EdgeInsets.zero,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                        child: Image.asset(
                                      ImagePath.pic2,
                                      width: 52.px,
                                      height: 52.px,
                                      fit: BoxFit.cover,
                                    )).paddingOnly(right: 10.px),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text.rich(
                                            maxLines: 1,
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Zahir Mays ",
                                                  style: MyTextStyle(
                                                    textSize: 20.px,
                                                    textWeight: FontWeight.w600,
                                                    textColor: controller.appColors.black,
                                                    textFamily: fontFamilyBold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "- Tel: 5743861818",
                                                  style: MyTextStyle(
                                                    textSize: 16.px,
                                                    textWeight: FontWeight.w400,
                                                    textColor: controller.appColors.black,
                                                    textFamily: fontFamilyBold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ).paddingOnly(bottom: 5.px),
                                          MyTextView(
                                            "Management - RL Relty Management, LLC",
                                            textStyleNew: MyTextStyle(
                                              textSize: 16.px,
                                              textWeight: FontWeight.w400,
                                              textColor: controller.appColors.lightText,
                                              textFamily: fontFamilyRegular,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ).paddingAll(18.px),
                              ),
                            ),
                            SizedBox(
                              width: 16.px,
                            ),
                            Expanded(
                              flex: 1,
                              child: ShadowContainer(
                                radius: 8.px,
                                padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 16.px),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyTextView(
                                          Strings.occupancyPercentage,
                                          textStyleNew: MyTextStyle(
                                            textSize: 16.px,
                                            textWeight: FontWeight.w600,
                                            textColor: controller.appColors.appColor,
                                            textFamily: fontFamilyRegular,
                                          ),
                                        ),
                                        MyTextView(
                                          "75 %",
                                          textStyleNew: MyTextStyle(
                                            textSize: 16.px,
                                            textWeight: FontWeight.w600,
                                            textColor: controller.appColors.appColor,
                                            textFamily: fontFamilyRegular,
                                          ),
                                        ),
                                      ],
                                    ).paddingOnly(bottom: 20.px),
                                    const LinearProgressIndicator(
                                      value: 15,
                                      semanticsLabel: 'Linear progress indicator',
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyTextView(
                                          "0 Unit",
                                          textStyleNew: MyTextStyle(
                                            textSize: 12.px,
                                            textWeight: FontWeight.w400,
                                            textColor: controller.appColors.black,
                                            textFamily: fontFamilyRegular,
                                          ),
                                        ),
                                        MyTextView(
                                          "20 Unit",
                                          textStyleNew: MyTextStyle(
                                            textSize: 12.px,
                                            textWeight: FontWeight.w400,
                                            textColor: controller.appColors.black,
                                            textFamily: fontFamilyRegular,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 2.px,
                          color: AppColors().divider,
                        ).paddingSymmetric(vertical: 32.px),
                        Row(
                          children: [
                            MyTextView(
                              Strings.generalNotes,
                              textStyleNew: MyTextStyle(
                                textSize: 24.px,
                                textWeight: FontWeight.w400,
                                textColor: controller.appColors.black,
                                textFamily: fontFamilyRegular,
                              ),
                            ),
                          ],
                        ).paddingOnly(bottom: 16.px),
                        ListView.builder(
                            itemCount: controller.itemCount.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              RxCommonModel item = controller.itemCount[index];
                              return GeneralNotesCardWidget(item: item);
                            }),
                        Divider(
                          thickness: 2.px,
                          color: AppColors().divider,
                        ).paddingSymmetric(vertical: 32.px),
                        Row(
                          children: [
                            MyTextView(
                              Strings.escort,
                              textStyleNew: MyTextStyle(
                                textSize: 24.px,
                                textWeight: FontWeight.w400,
                                textColor: controller.appColors.black,
                                textFamily: fontFamilyRegular,
                              ),
                            ),
                          ],
                        ),
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
                                    labelText: Strings.escortName,
                                    hintText: Strings.escortNameHint)),
                            SizedBox(
                              width: 24.px,
                            ),
                            Expanded(
                                child: CommonTextField(
                                    isLable: true,
                                    controller: controller.commentController,
                                    color: controller.appColors.transparent,
                                    contentPadding: EdgeInsets.only(left: 24.px),
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
                                    labelText: Strings.escortEmailAddresss,
                                    hintText: Strings.escortHint)),
                          ],
                        ).paddingSymmetric(vertical: 24.px),
                        Row(
                          children: [
                            MyTextView(
                              Strings.presentDuringInspection,
                              textStyleNew: MyTextStyle(
                                  textColor: controller.appColors.black,
                                  textSize: 20.px,
                                  textFamily: fontFamilyRegular,
                                  textWeight: FontWeight.w400),
                            ).paddingOnly(right: 24.px),
                            AdvancedSwitch(
                              controller: controller.switcheleController,
                              activeColor: controller.appColors.appColor,
                              inactiveColor: controller.appColors.grey,
                            ),
                          ],
                        ),
                        controller.item!.status != InspectionStatus.completed.toString()
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonButton(
                                      title: Strings.goToBuildings,
                                      textColor: controller.appColors.appColor,
                                      color: controller.appColors.transparent,
                                      radius: 35.px,
                                      height: 55.px,
                                      textWeight: FontWeight.w600,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.px,
                                        vertical: 12.px,
                                      ),
                                      textSize: 16.px,
                                      border: Border.all(color: controller.appColors.border, width: 2),
                                      onTap: () {
                                        Get.back();
                                      }),
                                  SizedBox(
                                    width: 24.px,
                                  ),
                                  CommonButton(
                                      title:
                                          // controller.item!.status!.contains("inCompleted")
                                          //     ? Strings.resumeInspection
                                          //     :
                                          Strings.HSAcknowledgment,
                                      textColor: controller.visibleBtn
                                          ? controller.appColors.black
                                          : controller.appColors.border1,
                                      color: controller.visibleBtn
                                          ? controller.appColors.textPink
                                          : controller.appColors.black.withOpacity(0.11999999731779099),
                                      radius: 35.px,
                                      textWeight: FontWeight.w600,
                                      textSize: 16.px,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24.px,
                                        vertical: 12.px,
                                      ),
                                      height: 55.px,
                                      onTap: () {
                                        if (controller.visibleBtn) {
                                          Get.toNamed(AresScreen.routes, arguments: controller.item);
                                        }
                                      }),
                                ],
                              ).paddingSymmetric(vertical: 32.px)
                            // : controller.item!.status == InspectionStatus.completed.toString()
                            //     ? InspectionCompleteWidget()
                            : const SizedBox()
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
