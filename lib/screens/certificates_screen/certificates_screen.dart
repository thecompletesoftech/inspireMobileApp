import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/certificates_screen/certificates_controller.dart';

class CertificatesScreen extends GetView<CertificateController> {
  const CertificatesScreen({Key? key}) : super(key: key);
  static const routes = "/CertificatesScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CertificateController>(
      init: CertificateController(),
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
                  // controller.selectedItem != "null"
                  //     ? controller.sendImagesList.isNotEmpty
                  //         ? controller.dialogChangesUnsaved()
                  //         : controller.dialogSomeFieldsMissing()
                  //     :
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: MyTextView(
                            controller.item == null ? "" : "${controller.item!.massage}, ${controller.propertyTitle}",
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
                                title: controller.item!.check == false ? Strings.inSample : Strings.tenant,
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
                            : const SizedBox(),
                      ],
                    ).paddingOnly(
                      top: 32.px,
                    ),
                    Column(
                      children: [
                        Column(
                          children: [
                            MyTextView(
                              Strings.certificates,
                              maxLinesNew: 4,
                              textStyleNew: MyTextStyle(
                                textSize: 40.px,
                                textWeight: FontWeight.w700,
                                textColor: controller.appColors.appColor,
                                textFamily: fontFamilyBold,
                              ),
                            ),
                          ],
                        ).paddingSymmetric(vertical: 40.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyTextView(
                              Strings.boilerCertificate,
                              textStyleNew: MyTextStyle(
                                  textFamily: fontFamilyRegular,
                                  textColor: AppColors().black,
                                  textSize: 24.px,
                                  textWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 207.px,
                              height: 45.px,
                              child: SegmentedButton<CertificateStatus>(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                                    return states.contains(MaterialState.selected)
                                        ? controller.appColors.pinkcolor
                                        : controller.appColors.transparent;
                                  }),
                                  foregroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                                    return states.contains(MaterialState.selected) ? Colors.black : Colors.grey;
                                  }),
                                  side: MaterialStateBorderSide.resolveWith((states) {
                                    return BorderSide(
                                        color: states.contains(MaterialState.selected) ? Colors.black : Colors.grey);
                                  }),
                                ),
                                segments: const <ButtonSegment<CertificateStatus>>[
                                  ButtonSegment<CertificateStatus>(
                                    value: CertificateStatus.No,
                                    label: Text(Strings.no),
                                  ),
                                  ButtonSegment<CertificateStatus>(
                                    value: CertificateStatus.Na,
                                    label: Text(Strings.na),
                                  ),
                                ],
                                selected: <CertificateStatus>{controller.boilerStatus},
                                onSelectionChanged: (Set<CertificateStatus> newSelection) {
                                  controller.boilerStatus = newSelection.first;
                                  controller.update();
                                },
                              ),
                            ),
                          ],
                        ).paddingOnly(bottom: 16.px),
                        AbsorbPointer(
                          absorbing: (controller.boilerStatus == CertificateStatus.No),
                          child: ShadowContainer1(
                            color: controller.appColors.white,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            radius: 8.px,
                            elevation: 1,
                            child: Container(
                              height: 200.px,
                              width: Get.width,
                              padding: EdgeInsets.all(32.px),
                              child: controller.sendBoilerImagesList.isNotEmpty
                                  ? ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.sendBoilerImagesList.length,
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index) {
                                        return Row(
                                          children: [
                                            Stack(children: [
                                              SizedBox(
                                                height: 126.px,
                                                width: 126.px,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.px),
                                                  child: Image.file(
                                                    File(controller.sendBoilerImagesList[index]),
                                                    fit: BoxFit.cover,
                                                    color: controller.boilerStatus == CertificateStatus.No
                                                        ? controller.appColors.black.withOpacity(0.07999999821186066)
                                                        : null,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 2,
                                                top: 2,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      if (controller.sendBoilerImagesList.length == 1) {
                                                        controller.sendBoilerImagesList = [];
                                                        controller.visibleBtn = false;
                                                      } else {
                                                        controller.sendBoilerImagesList.removeAt(index);
                                                      }
                                                      controller.update();
                                                    },
                                                    child: SvgPicture.string(
                                                      icDelete,
                                                      color: controller.boilerStatus == CertificateStatus.No
                                                          ? controller.appColors.black.withOpacity(0.07999999821186066)
                                                          : null,
                                                    )),
                                              )
                                            ]),
                                            if (controller.sendBoilerImagesList.length - 1 == index) ...[
                                              GestureDetector(
                                                onTap: () async {
                                                  controller.imagePicker(0);
                                                },
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        width: 80.px,
                                                        height: 80.px,
                                                        // decoration: BoxDecoration(
                                                        //     borderRadius: BorderRadius.circular(10.px),
                                                        //     border: Border.all(
                                                        //         color: controller.appColors.border1, width: 2)),
                                                        child: Center(
                                                          child: SvgPicture.string(icAdd,
                                                              // height: 45.px,
                                                              color: controller.boilerStatus == CertificateStatus.No
                                                                  ? controller.appColors.black
                                                                      .withOpacity(0.07999999821186066)
                                                                  : null
                                                              // fit: BoxFit.cover,
                                                              ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10.px),
                                                      MyTextView(
                                                        "Add picture",
                                                        textStyleNew: MyTextStyle(
                                                          textColor: controller.boilerStatus == CertificateStatus.No
                                                              ? controller.appColors.black
                                                                  .withOpacity(0.07999999821186066)
                                                              : controller.appColors.appColor,
                                                          textSize: 14.px,
                                                          textWeight: FontWeight.w500,
                                                          textFamily: fontFamilyRegular,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ).paddingSymmetric(horizontal: 32.px)
                                            ],
                                          ],
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) {
                                        return SizedBox(
                                          width: 32.px,
                                        );
                                      },
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        controller.imagePicker(0);
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            controller.boilerStatus == CertificateStatus.No
                                                ? Center(
                                                    child: SvgPicture.string(
                                                      icImage,
                                                      width: 80.px,
                                                      height: 80.px,
                                                      color:
                                                          controller.appColors.black.withOpacity(0.07999999821186066),
                                                    ),
                                                  )
                                                : Center(
                                                    child: SvgPicture.string(
                                                      icImage,
                                                      width: 80.px,
                                                      height: 80.px,
                                                    ),
                                                  ),
                                            SizedBox(
                                              height: 16.px,
                                            ),
                                            Flexible(
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Tap to Take or Upload",
                                                      style: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.boilerStatus == CertificateStatus.No
                                                            ? controller.appColors.black
                                                                .withOpacity(0.07999999821186066)
                                                            : controller.appColors.appColor,
                                                        textFamily: fontFamilyBold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: " a photo of the ",
                                                      style: MyTextStyle(
                                                        textSize: 16.px,
                                                        textColor: controller.boilerStatus == CertificateStatus.No
                                                            ? controller.appColors.black
                                                                .withOpacity(0.07999999821186066)
                                                            : controller.appColors.black,
                                                        textWeight: FontWeight.w400,
                                                        textFamily: fontFamilyRegular,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: Strings.boilerCertificate,
                                                      style: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.boilerStatus == CertificateStatus.No
                                                            ? controller.appColors.black
                                                                .withOpacity(0.07999999821186066)
                                                            : controller.appColors.appColor,
                                                        textFamily: fontFamilyBold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Container(
                          height: 1.px,
                          color: AppColors().divider,
                        ).paddingSymmetric(vertical: 24.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyTextView(
                              Strings.elevatorCertificate,
                              textStyleNew: MyTextStyle(
                                  textFamily: fontFamilyRegular,
                                  textColor: AppColors().black,
                                  textSize: 24.px,
                                  textWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 207.px,
                              height: 45.px,
                              child: SegmentedButton<CertificateStatus>(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                                    return states.contains(MaterialState.selected)
                                        ? controller.appColors.pinkcolor
                                        : controller.appColors.transparent;
                                  }),
                                  foregroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                                    return states.contains(MaterialState.selected) ? Colors.black : Colors.grey;
                                  }),
                                  side: MaterialStateBorderSide.resolveWith((states) {
                                    return BorderSide(
                                        color: states.contains(MaterialState.selected) ? Colors.black : Colors.grey);
                                  }),
                                ),
                                segments: const <ButtonSegment<CertificateStatus>>[
                                  ButtonSegment<CertificateStatus>(
                                    value: CertificateStatus.No,
                                    label: Text(Strings.no),
                                  ),
                                  ButtonSegment<CertificateStatus>(
                                    value: CertificateStatus.Na,
                                    label: Text(Strings.na),
                                  ),
                                ],
                                selected: <CertificateStatus>{controller.elevatorStatus},
                                onSelectionChanged: (Set<CertificateStatus> newSelection) {
                                  controller.elevatorStatus = newSelection.first;
                                  controller.update();
                                },
                              ),
                            ),
                          ],
                        ).paddingOnly(bottom: 16.px),
                        AbsorbPointer(
                          absorbing: (controller.elevatorStatus == CertificateStatus.No),
                          child: ShadowContainer1(
                            color: controller.appColors.white,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            radius: 8.px,
                            elevation: 1,
                            child: Container(
                              height: 200.px,
                              width: Get.width,
                              padding: EdgeInsets.all(32.px),
                              child: controller.sendElevatorImagesList.isNotEmpty
                                  ? ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.sendElevatorImagesList.length,
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index) {
                                        return Row(
                                          children: [
                                            Stack(children: [
                                              SizedBox(
                                                height: 126.px,
                                                width: 126.px,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.px),
                                                  child: Image.file(
                                                    File(controller.sendElevatorImagesList[index]),
                                                    fit: BoxFit.cover,
                                                    color: controller.elevatorStatus == CertificateStatus.No
                                                        ? controller.appColors.black.withOpacity(0.07999999821186066)
                                                        : null,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 2,
                                                top: 2,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      if (controller.sendElevatorImagesList.length == 1) {
                                                        controller.sendElevatorImagesList = [];
                                                        controller.visibleBtn = false;
                                                      } else {
                                                        controller.sendElevatorImagesList.removeAt(index);
                                                      }
                                                      controller.update();
                                                    },
                                                    child: SvgPicture.string(
                                                      icDelete,
                                                      color: controller.elevatorStatus == CertificateStatus.No
                                                          ? controller.appColors.black.withOpacity(0.07999999821186066)
                                                          : null,
                                                    )),
                                              )
                                            ]),
                                            if (controller.sendElevatorImagesList.length - 1 == index) ...[
                                              GestureDetector(
                                                onTap: () async {
                                                  controller.imagePicker(1);
                                                },
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        width: 80.px,
                                                        height: 80.px,
                                                        child: Center(
                                                          child: SvgPicture.string(icAdd,
                                                              // height: 45.px,
                                                              color: controller.elevatorStatus == CertificateStatus.No
                                                                  ? controller.appColors.black
                                                                      .withOpacity(0.07999999821186066)
                                                                  : null
                                                              // fit: BoxFit.cover,
                                                              ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10.px),
                                                      MyTextView(
                                                        "Add picture",
                                                        textStyleNew: MyTextStyle(
                                                          textColor: controller.elevatorStatus == CertificateStatus.No
                                                              ? controller.appColors.black
                                                                  .withOpacity(0.07999999821186066)
                                                              : controller.appColors.appColor,
                                                          textSize: 14.px,
                                                          textWeight: FontWeight.w500,
                                                          textFamily: fontFamilyRegular,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ).paddingSymmetric(horizontal: 32.px)
                                            ],
                                          ],
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) {
                                        return SizedBox(
                                          width: 32.px,
                                        );
                                      },
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        controller.imagePicker(1);
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            controller.elevatorStatus == CertificateStatus.No
                                                ? Center(
                                                    child: SvgPicture.string(
                                                      icImage,
                                                      width: 80.px,
                                                      height: 80.px,
                                                      color:
                                                          controller.appColors.black.withOpacity(0.07999999821186066),
                                                    ),
                                                  )
                                                : Center(
                                                    child: SvgPicture.string(
                                                      icImage,
                                                      width: 80.px,
                                                      height: 80.px,
                                                    ),
                                                  ),
                                            SizedBox(
                                              height: 16.px,
                                            ),
                                            Flexible(
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Tap to Take or Upload",
                                                      style: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.elevatorStatus == CertificateStatus.No
                                                            ? controller.appColors.black
                                                                .withOpacity(0.07999999821186066)
                                                            : controller.appColors.appColor,
                                                        textFamily: fontFamilyBold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: " a photo of the ",
                                                      style: MyTextStyle(
                                                        textSize: 16.px,
                                                        textColor: controller.elevatorStatus == CertificateStatus.No
                                                            ? controller.appColors.black
                                                                .withOpacity(0.07999999821186066)
                                                            : controller.appColors.black,
                                                        textWeight: FontWeight.w400,
                                                        textFamily: fontFamilyRegular,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: Strings.elevatorCertificate,
                                                      style: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.elevatorStatus == CertificateStatus.No
                                                            ? controller.appColors.black
                                                                .withOpacity(0.07999999821186066)
                                                            : controller.appColors.appColor,
                                                        textFamily: fontFamilyBold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Container(
                          height: 1.px,
                          color: AppColors().divider,
                        ).paddingSymmetric(vertical: 24.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyTextView(
                              Strings.fireAlarmInspectionReport,
                              textStyleNew: MyTextStyle(
                                  textFamily: fontFamilyRegular,
                                  textColor: AppColors().black,
                                  textSize: 24.px,
                                  textWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 207.px,
                              height: 45.px,
                              child: SegmentedButton<CertificateStatus>(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                                    return states.contains(MaterialState.selected)
                                        ? controller.appColors.pinkcolor
                                        : controller.appColors.transparent;
                                  }),
                                  foregroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                                    return states.contains(MaterialState.selected) ? Colors.black : Colors.grey;
                                  }),
                                  side: MaterialStateBorderSide.resolveWith((states) {
                                    return BorderSide(
                                        color: states.contains(MaterialState.selected) ? Colors.black : Colors.grey);
                                  }),
                                ),
                                segments: const <ButtonSegment<CertificateStatus>>[
                                  ButtonSegment<CertificateStatus>(
                                    value: CertificateStatus.No,
                                    label: Text(Strings.no),
                                  ),
                                  ButtonSegment<CertificateStatus>(
                                    value: CertificateStatus.Na,
                                    label: Text(Strings.na),
                                  ),
                                ],
                                selected: <CertificateStatus>{controller.fireStatus},
                                onSelectionChanged: (Set<CertificateStatus> newSelection) {
                                  controller.fireStatus = newSelection.first;
                                  controller.update();
                                },
                              ),
                            ),
                          ],
                        ).paddingOnly(bottom: 16.px),
                        AbsorbPointer(
                          absorbing: (controller.fireStatus == CertificateStatus.No),
                          child: ShadowContainer1(
                            color: controller.appColors.white,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            radius: 8.px,
                            elevation: 1,
                            child: Container(
                              height: 200.px,
                              width: Get.width,
                              padding: EdgeInsets.all(32.px),
                              child: controller.sendFireImagesList.isNotEmpty
                                  ? ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.sendFireImagesList.length,
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index) {
                                        return Row(
                                          children: [
                                            Stack(children: [
                                              SizedBox(
                                                height: 126.px,
                                                width: 126.px,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.px),
                                                  child: Image.file(
                                                    File(controller.sendFireImagesList[index]),
                                                    fit: BoxFit.cover,
                                                    color: controller.fireStatus == CertificateStatus.No
                                                        ? controller.appColors.black.withOpacity(0.07999999821186066)
                                                        : null,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 2,
                                                top: 2,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      if (controller.sendFireImagesList.length == 1) {
                                                        controller.sendFireImagesList = [];
                                                        controller.visibleBtn = false;
                                                      } else {
                                                        controller.sendFireImagesList.removeAt(index);
                                                      }
                                                      controller.update();
                                                    },
                                                    child: SvgPicture.string(
                                                      icDelete,
                                                      color: controller.fireStatus == CertificateStatus.No
                                                          ? controller.appColors.black.withOpacity(0.07999999821186066)
                                                          : null,
                                                    )),
                                              )
                                            ]),
                                            if (controller.sendFireImagesList.length - 1 == index) ...[
                                              GestureDetector(
                                                onTap: () async {
                                                  controller.imagePicker(2);
                                                },
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        width: 80.px,
                                                        height: 80.px,
                                                        child: Center(
                                                          child: SvgPicture.string(icAdd,
                                                              // height: 45.px,
                                                              color: controller.fireStatus == CertificateStatus.No
                                                                  ? controller.appColors.black
                                                                      .withOpacity(0.07999999821186066)
                                                                  : null
                                                              // fit: BoxFit.cover,
                                                              ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10.px),
                                                      MyTextView(
                                                        "Add picture",
                                                        textStyleNew: MyTextStyle(
                                                          textColor: controller.fireStatus == CertificateStatus.No
                                                              ? controller.appColors.black
                                                                  .withOpacity(0.07999999821186066)
                                                              : controller.appColors.appColor,
                                                          textSize: 14.px,
                                                          textWeight: FontWeight.w500,
                                                          textFamily: fontFamilyRegular,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ).paddingSymmetric(horizontal: 32.px)
                                            ],
                                          ],
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) {
                                        return SizedBox(
                                          width: 32.px,
                                        );
                                      },
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        controller.imagePicker(2);
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            controller.fireStatus == CertificateStatus.No
                                                ? Center(
                                                    child: SvgPicture.string(
                                                      icImage,
                                                      width: 80.px,
                                                      height: 80.px,
                                                      color:
                                                          controller.appColors.black.withOpacity(0.07999999821186066),
                                                    ),
                                                  )
                                                : Center(
                                                    child: SvgPicture.string(
                                                      icImage,
                                                      width: 80.px,
                                                      height: 80.px,
                                                    ),
                                                  ),
                                            SizedBox(
                                              height: 16.px,
                                            ),
                                            Flexible(
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Tap to Take or Upload",
                                                      style: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.fireStatus == CertificateStatus.No
                                                            ? controller.appColors.black
                                                                .withOpacity(0.07999999821186066)
                                                            : controller.appColors.appColor,
                                                        textFamily: fontFamilyBold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: " a photo of the ",
                                                      style: MyTextStyle(
                                                        textSize: 16.px,
                                                        textColor: controller.fireStatus == CertificateStatus.No
                                                            ? controller.appColors.black
                                                                .withOpacity(0.07999999821186066)
                                                            : controller.appColors.black,
                                                        textWeight: FontWeight.w400,
                                                        textFamily: fontFamilyRegular,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: Strings.fireAlarmInspectionReport,
                                                      style: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.fireStatus == CertificateStatus.No
                                                            ? controller.appColors.black
                                                                .withOpacity(0.07999999821186066)
                                                            : controller.appColors.appColor,
                                                        textFamily: fontFamilyBold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Container(
                          height: 1.px,
                          color: AppColors().divider,
                        ).paddingSymmetric(vertical: 24.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyTextView(
                              Strings.leadBasedPaintDisclosureForm,
                              textStyleNew: MyTextStyle(
                                  textFamily: fontFamilyRegular,
                                  textColor: AppColors().black,
                                  textSize: 24.px,
                                  textWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 207.px,
                              height: 45.px,
                              child: SegmentedButton<CertificateStatus>(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                                    return states.contains(MaterialState.selected)
                                        ? controller.appColors.pinkcolor
                                        : controller.appColors.transparent;
                                  }),
                                  foregroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                                    return states.contains(MaterialState.selected) ? Colors.black : Colors.grey;
                                  }),
                                  side: MaterialStateBorderSide.resolveWith((states) {
                                    return BorderSide(
                                        color: states.contains(MaterialState.selected) ? Colors.black : Colors.grey);
                                  }),
                                ),
                                segments: const <ButtonSegment<CertificateStatus>>[
                                  ButtonSegment<CertificateStatus>(
                                    value: CertificateStatus.No,
                                    label: Text(Strings.no),
                                  ),
                                  ButtonSegment<CertificateStatus>(
                                    value: CertificateStatus.Na,
                                    label: Text(Strings.na),
                                  ),
                                ],
                                selected: <CertificateStatus>{controller.paintStatus},
                                onSelectionChanged: (Set<CertificateStatus> newSelection) {
                                  controller.paintStatus = newSelection.first;
                                  controller.update();
                                },
                              ),
                            ),
                          ],
                        ).paddingOnly(bottom: 16.px),
                        AbsorbPointer(
                          absorbing: (controller.paintStatus == CertificateStatus.No),
                          child: ShadowContainer1(
                            color: controller.appColors.white,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            radius: 8.px,
                            elevation: 1,
                            child: Container(
                              height: 200.px,
                              width: Get.width,
                              padding: EdgeInsets.all(32.px),
                              child: controller.sendPaintImagesList.isNotEmpty
                                  ? ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.sendPaintImagesList.length,
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index) {
                                        return Row(
                                          children: [
                                            Stack(children: [
                                              SizedBox(
                                                height: 126.px,
                                                width: 126.px,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.px),
                                                  child: Image.file(
                                                    File(controller.sendPaintImagesList[index]),
                                                    fit: BoxFit.cover,
                                                    color: controller.paintStatus == CertificateStatus.No
                                                        ? controller.appColors.black.withOpacity(0.07999999821186066)
                                                        : null,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 2,
                                                top: 2,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      if (controller.sendPaintImagesList.length == 1) {
                                                        controller.sendPaintImagesList = [];
                                                        controller.visibleBtn = false;
                                                      } else {
                                                        controller.sendPaintImagesList.removeAt(index);
                                                      }
                                                      controller.update();
                                                    },
                                                    child: SvgPicture.string(
                                                      icDelete,
                                                      color: controller.paintStatus == CertificateStatus.No
                                                          ? controller.appColors.black.withOpacity(0.07999999821186066)
                                                          : null,
                                                    )),
                                              )
                                            ]),
                                            if (controller.sendPaintImagesList.length - 1 == index) ...[
                                              GestureDetector(
                                                onTap: () async {
                                                  controller.imagePicker(3);
                                                },
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        width: 80.px,
                                                        height: 80.px,
                                                        child: Center(
                                                          child: SvgPicture.string(icAdd,
                                                              // height: 45.px,
                                                              color: controller.paintStatus == CertificateStatus.No
                                                                  ? controller.appColors.black
                                                                      .withOpacity(0.07999999821186066)
                                                                  : null
                                                              // fit: BoxFit.cover,
                                                              ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10.px),
                                                      MyTextView(
                                                        "Add picture",
                                                        textStyleNew: MyTextStyle(
                                                          textColor: controller.paintStatus == CertificateStatus.No
                                                              ? controller.appColors.black
                                                                  .withOpacity(0.07999999821186066)
                                                              : controller.appColors.appColor,
                                                          textSize: 14.px,
                                                          textWeight: FontWeight.w500,
                                                          textFamily: fontFamilyRegular,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ).paddingSymmetric(horizontal: 32.px)
                                            ],
                                          ],
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) {
                                        return SizedBox(
                                          width: 32.px,
                                        );
                                      },
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        controller.imagePicker(3);
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            controller.paintStatus == CertificateStatus.No
                                                ? Center(
                                                    child: SvgPicture.string(
                                                      icImage,
                                                      width: 80.px,
                                                      height: 80.px,
                                                      color:
                                                          controller.appColors.black.withOpacity(0.07999999821186066),
                                                    ),
                                                  )
                                                : Center(
                                                    child: SvgPicture.string(
                                                      icImage,
                                                      width: 80.px,
                                                      height: 80.px,
                                                    ),
                                                  ),
                                            SizedBox(
                                              height: 16.px,
                                            ),
                                            Flexible(
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Tap to Take or Upload",
                                                      style: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.paintStatus == CertificateStatus.No
                                                            ? controller.appColors.black
                                                                .withOpacity(0.07999999821186066)
                                                            : controller.appColors.appColor,
                                                        textFamily: fontFamilyBold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: " a photo of the ",
                                                      style: MyTextStyle(
                                                        textSize: 16.px,
                                                        textColor: controller.paintStatus == CertificateStatus.No
                                                            ? controller.appColors.black
                                                                .withOpacity(0.07999999821186066)
                                                            : controller.appColors.black,
                                                        textWeight: FontWeight.w400,
                                                        textFamily: fontFamilyRegular,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: Strings.leadBasedPaintDisclosureForm,
                                                      style: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.paintStatus == CertificateStatus.No
                                                            ? controller.appColors.black
                                                                .withOpacity(0.07999999821186066)
                                                            : controller.appColors.appColor,
                                                        textFamily: fontFamilyBold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Container(
                          height: 1.px,
                          color: AppColors().divider,
                        ).paddingSymmetric(vertical: 24.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyTextView(
                              Strings.sprinklerSystemCertificate,
                              textStyleNew: MyTextStyle(
                                  textFamily: fontFamilyRegular,
                                  textColor: AppColors().black,
                                  textSize: 24.px,
                                  textWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 207.px,
                              height: 45.px,
                              child: SegmentedButton<CertificateStatus>(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                                    return states.contains(MaterialState.selected)
                                        ? controller.appColors.pinkcolor
                                        : controller.appColors.transparent;
                                  }),
                                  foregroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                                    return states.contains(MaterialState.selected) ? Colors.black : Colors.grey;
                                  }),
                                  side: MaterialStateBorderSide.resolveWith((states) {
                                    return BorderSide(
                                        color: states.contains(MaterialState.selected) ? Colors.black : Colors.grey);
                                  }),
                                ),
                                segments: const <ButtonSegment<CertificateStatus>>[
                                  ButtonSegment<CertificateStatus>(
                                    value: CertificateStatus.No,
                                    label: Text(Strings.no),
                                  ),
                                  ButtonSegment<CertificateStatus>(
                                    value: CertificateStatus.Na,
                                    label: Text(Strings.na),
                                  ),
                                ],
                                selected: <CertificateStatus>{controller.sprinklerStatus},
                                onSelectionChanged: (Set<CertificateStatus> newSelection) {
                                  controller.sprinklerStatus = newSelection.first;
                                  controller.update();
                                },
                              ),
                            ),
                          ],
                        ).paddingOnly(bottom: 16.px),
                        AbsorbPointer(
                          absorbing: (controller.sprinklerStatus == CertificateStatus.No),
                          child: ShadowContainer1(
                            color: controller.appColors.white,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            radius: 8.px,
                            elevation: 1,
                            child: Container(
                              height: 200.px,
                              width: Get.width,
                              padding: EdgeInsets.all(32.px),
                              child: controller.sendSprinklerImagesList.isNotEmpty
                                  ? ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.sendSprinklerImagesList.length,
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index) {
                                        return Row(
                                          children: [
                                            Stack(children: [
                                              SizedBox(
                                                height: 126.px,
                                                width: 126.px,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.px),
                                                  child: Image.file(
                                                    File(controller.sendSprinklerImagesList[index]),
                                                    fit: BoxFit.cover,
                                                    color: controller.paintStatus == CertificateStatus.No
                                                        ? controller.appColors.black.withOpacity(0.07999999821186066)
                                                        : null,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 2,
                                                top: 2,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      if (controller.sendSprinklerImagesList.length == 1) {
                                                        controller.sendSprinklerImagesList = [];
                                                        controller.visibleBtn = false;
                                                      } else {
                                                        controller.sendSprinklerImagesList.removeAt(index);
                                                      }
                                                      controller.update();
                                                    },
                                                    child: SvgPicture.string(
                                                      icDelete,
                                                      color: controller.paintStatus == CertificateStatus.No
                                                          ? controller.appColors.black.withOpacity(0.07999999821186066)
                                                          : null,
                                                    )),
                                              )
                                            ]),
                                            if (controller.sendSprinklerImagesList.length - 1 == index) ...[
                                              GestureDetector(
                                                onTap: () async {
                                                  controller.imagePicker(4);
                                                },
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        width: 80.px,
                                                        height: 80.px,
                                                        child: Center(
                                                          child: SvgPicture.string(icAdd,
                                                              // height: 45.px,
                                                              color: controller.paintStatus == CertificateStatus.No
                                                                  ? controller.appColors.black
                                                                      .withOpacity(0.07999999821186066)
                                                                  : null
                                                              // fit: BoxFit.cover,
                                                              ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10.px),
                                                      MyTextView(
                                                        "Add picture",
                                                        textStyleNew: MyTextStyle(
                                                          textColor: controller.paintStatus == CertificateStatus.No
                                                              ? controller.appColors.black
                                                                  .withOpacity(0.07999999821186066)
                                                              : controller.appColors.appColor,
                                                          textSize: 14.px,
                                                          textWeight: FontWeight.w500,
                                                          textFamily: fontFamilyRegular,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ).paddingSymmetric(horizontal: 32.px)
                                            ],
                                          ],
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) {
                                        return SizedBox(
                                          width: 32.px,
                                        );
                                      },
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        controller.imagePicker(4);
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            controller.sprinklerStatus == CertificateStatus.No
                                                ? Center(
                                                    child: SvgPicture.string(
                                                      icImage,
                                                      width: 80.px,
                                                      height: 80.px,
                                                      color:
                                                          controller.appColors.black.withOpacity(0.07999999821186066),
                                                    ),
                                                  )
                                                : Center(
                                                    child: SvgPicture.string(
                                                      icImage,
                                                      width: 80.px,
                                                      height: 80.px,
                                                    ),
                                                  ),
                                            SizedBox(
                                              height: 16.px,
                                            ),
                                            Flexible(
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Tap to Take or Upload",
                                                      style: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.sprinklerStatus == CertificateStatus.No
                                                            ? controller.appColors.black
                                                                .withOpacity(0.07999999821186066)
                                                            : controller.appColors.appColor,
                                                        textFamily: fontFamilyBold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: " a photo of the ",
                                                      style: MyTextStyle(
                                                        textSize: 16.px,
                                                        textColor: controller.sprinklerStatus == CertificateStatus.No
                                                            ? controller.appColors.black
                                                                .withOpacity(0.07999999821186066)
                                                            : controller.appColors.black,
                                                        textWeight: FontWeight.w400,
                                                        textFamily: fontFamilyRegular,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: Strings.sprinklerSystemCertificate,
                                                      style: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.sprinklerStatus == CertificateStatus.No
                                                            ? controller.appColors.black
                                                                .withOpacity(0.07999999821186066)
                                                            : controller.appColors.appColor,
                                                        textFamily: fontFamilyBold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ).paddingOnly(bottom: 40.px),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 32.px)
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
