import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';

import '../../commons/all.dart';
import '../../screens/inspection_screen/inspection_controller.dart';
import '../areas_screen/areas_screen.dart';
import '../home_screen/home_controller.dart';
import '../text_message_screen/text_message_screen.dart';
import 'generalNotesCard_widget.dart';
import 'inspection_complete_widget.dart';

class InspectionScreen extends GetView<InspectionController> {
  const InspectionScreen({Key? key}) : super(key: key);
  static const routes = "/InspectionScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InspectionController>(
      init: InspectionController(),
      assignId: true,
      builder: (_) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: Column(
            children: [
              CommonAppBar(
                color: controller.appColors.transparent,
                radius: 0.px,
                onClickBack: () {
                  if (controller.item!.status == InspectionStatus.inCompleted.toString()) {
                    controller.dialogInspectionInCompleted();
                  } else {
                    Get.back(result: controller.visibleBtn);
                  }
                },
              ),
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
                                    vertical: 10.0,
                                  ),
                                  textWeight: FontWeight.w500,
                                  textColor: controller.appColors.lightText,
                                  color: controller.appColors.buttonColor,
                                  onTap: () {
                                    controller.imageFile.value = "";
                                    controller.update();
                                  },
                                  radius: 100.px,
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
                                        vertical: 10.0,
                                      ),
                                      radius: 100.px,
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
                    Container(
                      height: 1.px,
                      color: AppColors().divider,
                    ),
                    Column(
                      children: [
                        // if (Utils.isTabletScreen1(context)) ...[
                        //   Row(
                        //     children: [
                        //       controller.item!.status == InspectionStatus.completed.toString() ||
                        //               controller.item!.status == InspectionStatus.inCompleted.toString()
                        //           ? CommonButton(
                        //               title: controller.item!.status!.contains("completed")
                        //                   ? Strings.completed
                        //                   : Strings.inComplete,
                        //               textSize: 14.px,
                        //               isSmall: false,
                        //               isBig: true,
                        //               radius: 100.px,
                        //               textWeight: FontWeight.w500,
                        //               color: controller.item!.status!.contains("completed")
                        //                   ? controller.appColors.updateGreen
                        //                   : controller.appColors.updateYellow,
                        //               textColor: controller.appColors.black,
                        //               onTap: () {})
                        //           : const SizedBox(),
                        //     ],
                        //   ),
                        // ],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Utils.isTabletScreen(context)
                                    ? Flexible(
                                        child: MyTextView(
                                          "${controller.item!.massage}, ${controller.itemTitle}",
                                          textStyleNew: MyTextStyle(
                                            textSize: Utils.isMediumScreen(context) ? 24.px : 20.px,
                                            textWeight: FontWeight.w600,
                                            textColor: controller.appColors.black,
                                            textFamily: fontFamilyBold,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                Utils.isTabletScreen(context)
                                    ? SizedBox(
                                        width: 24.px,
                                      )
                                    : const SizedBox(),
                                controller.item != null
                                    ? CommonButton(
                                        title:
                                            controller.item!.check == false ? Strings.annualInspection : Strings.tenant,
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
                                    : const SizedBox(),
                                // if ((Utils.isMediumScreen(context) ||
                                //     Utils.isLandScapeMode(context) && !Utils.isTabletScreen1(context))) ...[
                                controller.item!.status == InspectionStatus.completed.toString() ||
                                        controller.item!.status == InspectionStatus.inCompleted.toString()
                                    ? SizedBox(
                                        width: 16.px,
                                      )
                                    : const SizedBox(),
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
                                    : const SizedBox(),
                                // ]
                              ],
                            ),
                            GestureDetector(
                                onTap: () {
                                  try {
                                    controller.navigateToMap();
                                  } catch (e) {
                                    printError(e.toString());
                                  }
                                },
                                child: SvgPicture.string(
                                  icLoc,
                                  height: 40.px,
                                )),
                          ],
                        ).paddingOnly(bottom: 24.px),
                        Row(
                          mainAxisAlignment:
                              Utils.isTabletScreen(context) ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                          children: [
                            Utils.isTabletScreen(context)
                                ? const SizedBox()
                                : Flexible(
                                    child: MyTextView(
                                      "${controller.item!.massage}, ${controller.itemTitle}",
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
                                      title: "08:00 - 10:00 AM",
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
                                      icon: icBedroom,
                                      iconheigth: 20.px,
                                      title: "2 Bedroom",
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
                              child: ShadowContainer(
                                radius: 8.px,
                                padding: EdgeInsets.zero,
                                margin: EdgeInsets.zero,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                        child: Image.asset(
                                      controller.item!.image ?? "",
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
                                                  text: controller.item!.title!,
                                                  style: MyTextStyle(
                                                    textSize: 20.px,
                                                    textWeight: FontWeight.w600,
                                                    textColor: controller.appColors.black,
                                                    textFamily: fontFamilyBold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.px,
                                          ),
                                          MyTextView(
                                            controller.item!.subtitle,
                                            isMaxLineWrap: true,
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
                                ).paddingAll(16.px),
                              ),
                            ),
                            SizedBox(width: 41.px),
                            Expanded(
                              flex: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CommonIconButton(
                                      icon: icEmail,
                                      iconheigth: 20.px,
                                      title: Utils.isTabletScreen(context) ? "Text" : Strings.txtMsg,
                                      radius: 100.px,
                                      border: Border.all(color: controller.appColors.border, width: 2),
                                      color: controller.appColors.white,
                                      textColor: controller.appColors.appColor,
                                      textWeight: FontWeight.w500,
                                      textSize: 20.px,
                                      padding: EdgeInsets.fromLTRB(16.px, 10.px, 24.px, 10.px),
                                      onTap: () {
                                        Get.toNamed(TextMessageScreen.routes, arguments: controller.item);
                                      }).paddingOnly(right: 24.px),
                                  CommonIconButton(
                                      icon: icPhone,
                                      iconheigth: 20.px,
                                      title: Utils.isTabletScreen(context) ? "Call" : Strings.makeCall,
                                      radius: 100.px,
                                      border: Border.all(color: controller.appColors.border, width: 2),
                                      padding: EdgeInsets.fromLTRB(16.px, 10.px, 24.px, 10.px),
                                      color: controller.appColors.white,
                                      textColor: controller.appColors.appColor,
                                      textWeight: FontWeight.w500,
                                      textSize: 20.px,
                                      onTap: () {
                                        controller.utils.makePhoneCall("+91 2310341546");
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ).paddingOnly(bottom: 24.px),
                        Row(
                          children: [
                            Expanded(
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
                                                  text: "Zahir Mays",
                                                  style: MyTextStyle(
                                                    textSize: 20.px,
                                                    textWeight: FontWeight.w600,
                                                    textColor: controller.appColors.black,
                                                    textFamily: fontFamilyBold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ).paddingOnly(bottom: 5.px),
                                          MyTextView(
                                            "Landlord - RL Relty Managment, LLC",
                                            isMaxLineWrap: true,
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
                              width: 41.px,
                            ),
                            Expanded(
                              flex: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CommonIconButton(
                                      icon: icEmail,
                                      iconheigth: 20.px,
                                      title: Utils.isTabletScreen(context) ? "Text" : Strings.txtMsg,
                                      // height: 44.px,
                                      radius: 100.px,
                                      border: Border.all(color: controller.appColors.border, width: 2),
                                      // width: 179.px,
                                      padding: EdgeInsets.fromLTRB(16.px, 10.px, 24.px, 10.px),
                                      color: controller.appColors.white,
                                      textColor: controller.appColors.appColor,
                                      textWeight: FontWeight.w500,
                                      textSize: 20.px,
                                      onTap: () {
                                        Get.toNamed(TextMessageScreen.routes, arguments: controller.item);
                                      }),
                                  SizedBox(
                                    width: 24.px,
                                  ),
                                  CommonIconButton(
                                      icon: icPhone,
                                      iconheigth: 20.px,
                                      title: Utils.isTabletScreen(context) ? "Call" : Strings.makeCall,
                                      radius: 100.px,
                                      padding: EdgeInsets.fromLTRB(16.px, 10.px, 24.px, 10.px),
                                      border: Border.all(color: controller.appColors.border, width: 2),
                                      color: controller.appColors.white,
                                      textColor: controller.appColors.appColor,
                                      textWeight: FontWeight.w500,
                                      textSize: 20.px,
                                      onTap: () {
                                        controller.utils.makePhoneCall("+91 2310341546");
                                      }),
                                ],
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
                        Row(
                          children: [
                            MyTextView(
                              Strings.inspectorNotes,
                              textStyleNew: MyTextStyle(
                                textSize: 24.px,
                                textWeight: FontWeight.w400,
                                textColor: controller.appColors.black,
                                textFamily: fontFamilyRegular,
                              ),
                            ),
                          ],
                        ).paddingOnly(top: 32.px, bottom: 16.px),
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
                                    labelText: Strings.inspectorNotes,
                                    hintText: Strings.commentHint)),
                            SizedBox(
                              width: 180.px,
                              child: CommonTextField(
                                  isLable: true,
                                  readOnly: true,
                                  onTap: () {
                                    controller.selectDate();
                                  },
                                  controller: controller.dateController,
                                  color: controller.appColors.transparent,
                                  suffixIcon: SvgPicture.string(
                                    icCalender2,
                                    color: controller.appColors.lightText,
                                  ),
                                  padding: EdgeInsets.zero,
                                  contentPadding: EdgeInsets.only(left: 16.px),
                                  shadowColor: controller.appColors.transparent,
                                  hintText: "mm/dd/yyyy",
                                  labelText: "Date"),
                            ).paddingOnly(left: 24.px),
                          ],
                        ),
                        controller.item!.status != InspectionStatus.completed.toString()
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // CommonButton(
                                  //     title: Strings.noShow,
                                  //     textColor: controller.appColors.appColor,
                                  //     color: controller.appColors.transparent,
                                  //     radius: 35.px,
                                  //     textWeight: FontWeight.w600,
                                  //     padding: EdgeInsets.symmetric(
                                  //       horizontal: 24.px,
                                  //       vertical: 10.px,
                                  //     ),
                                  //     textSize: 16.px,
                                  //     border: Border.all(color: controller.appColors.border, width: 2),
                                  //     onTap: () {
                                  //       Get.toNamed(NoShowScreen.routes, arguments: controller.item)!.then((value) {
                                  //         if (value != null) {
                                  //           controller.item!.status = InspectionStatus.completed.toString();
                                  //           controller.visibleBtn = true;
                                  //           controller.update();
                                  //           Get.back(result: true);
                                  //         }
                                  //       });
                                  //     }),
                                  SizedBox(
                                    width: 24.px,
                                  ),
                                  CommonButton(
                                      title: controller.item!.status!.contains("inCompleted")
                                          ? Strings.resumeInspection
                                          : Strings.startInspection,
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
                                        vertical: 10.px,
                                      ),
                                      onTap: () {
                                        if (controller.visibleBtn) {
                                          Get.toNamed(AresScreen.routes, arguments: controller.item)!.then((value) {
                                            if (value != null) {
                                              controller.item!.status = value
                                                  ? InspectionStatus.completed.toString()
                                                  : InspectionStatus.inCompleted.toString();
                                              controller.visibleBtn = true;
                                              controller.update();
                                            }
                                          });
                                        }
                                      }),
                                ],
                              ).paddingSymmetric(vertical: 32.px)
                            : controller.item!.status == InspectionStatus.completed.toString()
                                ? const InspectionCompleteWidget()
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
