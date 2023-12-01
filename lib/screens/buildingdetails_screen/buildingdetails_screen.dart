import 'dart:io';

import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/screens/buildingdetails_screen/buildingdetails_controller.dart';
import 'package:public_housing/screens/buildingdetails_screen/inspection_complete_widget.dart';

import '../../commons/all.dart';
import '../areasbuilding_screen/areasbuilding_screen.dart';
import '../buildings_screen/buildings_controller.dart';
import 'generalNotesCard_widget.dart';

class BuildingDetailsScreen extends GetView<BuildingDetailsController> {
  const BuildingDetailsScreen({Key? key}) : super(key: key);
  static const routes = "/BuildingDetailsScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildingDetailsController>(
      assignId: true,
      init: BuildingDetailsController(),
      builder: (_) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: Column(
            children: [
              CommonAppBar(
                color: controller.appColors.transparent,
                radius: 0.px,
                onClickBack: () {
                  if (controller.item!.status == BuildingStatus.inCompleted.toString()) {
                    controller.dialogInspectionInCompleted();
                  } else {
                    Get.back();
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
                        : (controller.item!.status == BuildingStatus.completed.toString() ||
                                    controller.item!.status == BuildingStatus.inCompleted.toString()) &&
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
                                              text: " of the Building to ",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Utils.isTabletScreen(context)
                                    ? Flexible(
                                        child: MyTextView(
                                          "${controller.item!.massage}",
                                          textStyleNew: MyTextStyle(
                                            textSize: 24.px,
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
                                    : const SizedBox(),
                                controller.item!.status == BuildingStatus.completed.toString() ||
                                        controller.item!.status == BuildingStatus.inCompleted.toString()
                                    ? SizedBox(
                                        width: 16.px,
                                      )
                                    : const SizedBox(),
                                controller.item!.status == BuildingStatus.completed.toString() ||
                                        controller.item!.status == BuildingStatus.inCompleted.toString()
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
                                      "${controller.item!.massage}",
                                      isMaxLineWrap: true,
                                      textStyleNew: MyTextStyle(
                                        textSize: 24.px,
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
                                      iconheigth: 24.px,
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
                                      iconheigth: 24.px,
                                      space: 8.px,
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
                                      iconheigth: 24.px,
                                      space: 8.px,
                                      title: "4 Units",
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
                            Expanded(
                                child: ShadowContainer(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyTextView(
                                    Strings.disconnectedUtilities,
                                    textStyleNew: MyTextStyle(
                                      textSize: 24.px,
                                      textWeight: FontWeight.w400,
                                      textColor: controller.appColors.black,
                                      textFamily: fontFamilyRegular,
                                    ),
                                  ).paddingAll(16.px),
                                  ListTile(
                                      leading: SvgPicture.string(icElectric),
                                      title: MyTextView(
                                        Strings.disconnectedElectric,
                                        textStyleNew: MyTextStyle(
                                          textColor: controller.appColors.textBlack,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                      trailing: AdvancedSwitch(
                                        controller: controller.switcheleController,
                                        activeColor: controller.appColors.appColor,
                                        inactiveColor: controller.appColors.grey,
                                      )),
                                  Divider(
                                    thickness: 1.px,
                                    color: AppColors().divider,
                                  ),
                                  ListTile(
                                      leading: SvgPicture.string(icGas),
                                      contentPadding: EdgeInsets.zero,
                                      title: MyTextView(
                                        Strings.disconnectedGas,
                                        textStyleNew: MyTextStyle(
                                          textColor: controller.appColors.textBlack,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                      trailing: AdvancedSwitch(
                                        controller: controller.switchgasController,
                                        activeColor: controller.appColors.appColor,
                                        inactiveColor: controller.appColors.grey,
                                      )),
                                  Divider(
                                    thickness: 1.px,
                                    color: AppColors().divider,
                                  ),
                                  ListTile(
                                      leading: SvgPicture.string(icWater),
                                      contentPadding: EdgeInsets.zero,
                                      title: MyTextView(
                                        Strings.disconnectedWater,
                                        textStyleNew: MyTextStyle(
                                          textColor: controller.appColors.textBlack,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                      trailing: AdvancedSwitch(
                                        controller: controller.switchwatController,
                                        activeColor: controller.appColors.appColor,
                                        inactiveColor: controller.appColors.grey,
                                      )),
                                ],
                              ),
                            )),
                            SizedBox(
                              width: 16.px,
                            ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyTextView(
                                      Strings.selectRoofAccessIndicator,
                                      textStyleNew: MyTextStyle(
                                        textColor: Colors.black,
                                        textSize: 20.px,
                                        textFamily: fontFamilyRegular,
                                        textWeight: FontWeight.w400,
                                      ),
                                    ).paddingOnly(bottom: 24.px),
                                    DropdownButtonFormField<String>(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 20.px,
                                        color: controller.appColors.grey,
                                      ),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 15.px),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: controller.appColors.grey),
                                            borderRadius: BorderRadius.circular(25.px),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: controller.appColors.grey),
                                            borderRadius: BorderRadius.circular(25.px),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: controller.appColors.grey),
                                            borderRadius: BorderRadius.circular(25.px),
                                          ),
                                          filled: true,
                                          hintStyle: MyTextStyle(
                                            textWeight: FontWeight.w400,
                                            textSize: 15.px,
                                            textColor: controller.appColors.black,
                                          ),
                                          hintText: controller.dropDownValue,
                                          labelStyle: MyTextStyle(
                                            textWeight: FontWeight.w400,
                                            textSize: 15.px,
                                          ),
                                          fillColor: controller.appColors.transparent),
                                      onChanged: (String? value) {
                                        controller.dropDownValue = value!;
                                        controller.visibleBtn = true;
                                        controller.update();
                                      },
                                      items: controller.itemList
                                          .map((cityTitle) => DropdownMenuItem(
                                              value: cityTitle,
                                              child: MyTextView(
                                                cityTitle,
                                                textStyleNew: MyTextStyle(
                                                  textWeight: FontWeight.w400,
                                                  textSize: 15.px,
                                                  textColor: controller.appColors.black,
                                                ),
                                              )))
                                          .toList(),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyTextView(
                                      Strings.selectReasonUninspectable,
                                      textStyleNew: MyTextStyle(
                                        textColor: Colors.black,
                                        textSize: 20.px,
                                        textFamily: fontFamilyRegular,
                                        textWeight: FontWeight.w400,
                                      ),
                                    ).paddingOnly(top: 24.px, bottom: 24.px),
                                    CommonTextField(
                                        isLable: true,
                                        controller: controller.commentController,
                                        color: controller.appColors.transparent,
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
                                        contentPadding: EdgeInsets.only(left: 15.px),
                                        labelText: Strings.reasonUninspectable,
                                        hintText: Strings.addReasonUninspectable)
                                  ],
                                ),
                              ],
                            ))
                          ],
                        ),
                        controller.item!.status != BuildingStatus.completed.toString()
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonButton(
                                      title: Strings.uninspectable,
                                      textColor: controller.appColors.border1,
                                      color: controller.appColors.transparent,
                                      radius: 35.px,
                                      textWeight: FontWeight.w600,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24.px,
                                        vertical: 10.px,
                                      ),
                                      textSize: 16.px,
                                      border: Border.all(color: controller.appColors.textFiledBorderColor, width: 2),
                                      onTap: () {}),
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
                                          Get.toNamed(AresBuildingScreen.routes, arguments: controller.item)!
                                              .then((value) {
                                            if (value != null) {
                                              if (Get.isRegistered<BuildingsController>()) {
                                                Get.find<BuildingsController>().item!.status = value
                                                    ? BuildingStatus.completed.toString()
                                                    : BuildingStatus.inCompleted.toString();
                                              }
                                              controller.item!.status = value
                                                  ? BuildingStatus.completed.toString()
                                                  : BuildingStatus.inCompleted.toString();
                                              controller.update();
                                            }
                                          });
                                        }
                                      }),
                                ],
                              ).paddingSymmetric(vertical: 32.px)
                            : controller.item!.status == BuildingStatus.completed.toString()
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
