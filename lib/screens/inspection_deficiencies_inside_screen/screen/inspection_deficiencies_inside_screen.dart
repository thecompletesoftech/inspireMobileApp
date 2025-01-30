import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:public_housing/screens/inspection_deficiencies_inside_screen/bindings/inspection_deficiencies_inside_binding.dart';
import 'package:public_housing/screens/inspection_deficiencies_inside_screen/controller/inspection_deficiencies_inside_controller.dart';

class InspectionDeficienciesInsideScreen
    extends GetView<InspectionDeficienciesInsideBinding> {
  const InspectionDeficienciesInsideScreen({Key? key}) : super(key: key);

  static const routes = "/InspectionDeficienciesInsideScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InspectionDeficienciesInsideController>(
      init: InspectionDeficienciesInsideController(),
      autoRemove: false,
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonAppBar(
                  color: controller.appColors.transparent,
                  radius: 0.px,
                  onClickBack: () {
                    if (controller.isCheck() ||
                        controller.isDeleted ||
                        controller.commentController.text.isEmpty) {
                      Get.back(result: {"isEdit": controller.isDeleted});
                    } else {
                      controller.confirmDialog();
                    }
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyTextView(
                              '2113 Kendall Street - Fernando Devries',
                              textStyleNew: MyTextStyle(
                                textColor: controller.appColors.appColor,
                                textWeight: FontWeight.w600,
                                textFamily: fontFamilyBold,
                                textSize: 20.px,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.px, horizontal: 16.px),
                              decoration: BoxDecoration(
                                  color: AppColors().white,
                                  borderRadius: BorderRadius.circular(100)),
                              child: MyTextView(
                                'Annual Inspection',
                                textStyleNew: MyTextStyle(
                                    textSize: 14.px,
                                    textColor: 'Annual Inspection' ==
                                            'Annual Inspection'
                                        ? AppColors().textGreen
                                        : 'Re-Inspection' == 'Re-Inspection'
                                            ? AppColors().textPink
                                            : AppColors().black,
                                    textWeight: FontWeight.w500),
                              ),
                            ).paddingOnly(left: 24.px),
                          ],
                        ).paddingOnly(top: 32.px, bottom: 48.px),
                        MyTextView(
                          '${controller.successListOfDeficiencies.definition}',
                          isMaxLineWrap: true,
                          textStyleNew: MyTextStyle(
                            textColor: controller.appColors.appColor,
                            textWeight: FontWeight.w600,
                            textFamily: fontFamilyBold,
                            textSize: 32.px,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: CommonButton(
                            radius: 100.px,
                            height: 44.px,
                            width: 200.px,
                            title: Strings.inspectionProcess,
                            onTap: () {
                              controller.dialogInspectionProcess();
                            },
                            textWeight: FontWeight.w500,
                            textSize: 16.px,
                            color: controller.appColors.transparent,
                            border:
                                Border.all(color: controller.appColors.black),
                            textColor: controller.appColors.appColor,
                          ).paddingOnly(top: 24.px),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyTextView(
                                    Strings.deficiencyCriteria,
                                    isMaxLineWrap: true,
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.appColors.black,
                                      textWeight: FontWeight.w400,
                                      textFamily: fontFamilyBold,
                                      textSize: 24.px,
                                    ),
                                  ),
                                  MyTextView(
                                    '${controller.successListOfDeficiencies.criteria}',
                                    isMaxLineWrap: true,
                                    textStyleNew: MyTextStyle(
                                      textColor:
                                          controller.appColors.textBlack2,
                                      textWeight: FontWeight.w400,
                                      textFamily: fontFamilyBold,
                                      textSize: 16.px,
                                    ),
                                  ).paddingOnly(top: 16.px),
                                ],
                              ),
                            ),
                          ],
                        ).paddingSymmetric(vertical: 32.px),
                        Row(
                          children: [
                            Expanded(
                              child: ShadowContainer(
                                  radius: 8.px,
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    color: controller.appColors.white,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.string(icTimeColor),
                                            MyTextView(
                                              Strings.correctionTimeframe,
                                              isMaxLineWrap: true,
                                              textStyleNew: MyTextStyle(
                                                textColor:
                                                    controller.appColors.black,
                                                textWeight: FontWeight.w400,
                                                textFamily: fontFamilyBold,
                                                textSize: 16.px,
                                              ),
                                            ).paddingOnly(left: 20.px),
                                            Spacer(),
                                            MyTextView(
                                              '${controller.successListOfDeficiencies.deficiencyItemHousingDeficiency?.severity?.correctionTimeFrame ?? ""}',
                                              isMaxLineWrap: true,
                                              textStyleNew: MyTextStyle(
                                                textColor: controller
                                                    .appColors.appColor,
                                                textWeight: FontWeight.w600,
                                                textFamily: fontFamilyBold,
                                                textSize: 16.px,
                                              ),
                                            ).paddingOnly(left: 30.px),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.string(icLike),
                                            MyTextView(
                                              Strings.determination,
                                              isMaxLineWrap: true,
                                              textStyleNew: MyTextStyle(
                                                textColor:
                                                    controller.appColors.black,
                                                textWeight: FontWeight.w400,
                                                textFamily: fontFamilyBold,
                                                textSize: 16.px,
                                              ),
                                            ).paddingOnly(left: 20.px),
                                            Spacer(),
                                            MyTextView(
                                              '${controller.successListOfDeficiencies.deficiencyItemHousingDeficiency?.severity?.healthySafetyDesignation ?? ""}',
                                              isMaxLineWrap: true,
                                              textStyleNew: MyTextStyle(
                                                textColor: controller
                                                    .appColors.appColor,
                                                textWeight: FontWeight.w600,
                                                textFamily: fontFamilyBold,
                                                textSize: 16.px,
                                              ),
                                            ).paddingOnly(left: 30.px),
                                          ],
                                        ).paddingOnly(top: 16.px),
                                      ],
                                    ).paddingSymmetric(
                                        vertical: 25.px, horizontal: 20.px),
                                  )),
                            ),
                            SizedBox(width: 16.px),
                            Expanded(
                                child: ShadowContainer(
                              radius: 8.px,
                              padding: EdgeInsets.zero,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RadioListTile(
                                    title: MyTextView(
                                      "Deficiency Present",
                                      textStyleNew: MyTextStyle(
                                        textColor: controller.appColors.black,
                                        textSize: 16.px,
                                        textFamily: fontFamilyRegular,
                                        textWeight: FontWeight.w400,
                                      ),
                                    ),
                                    value: "present",
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16.px),
                                    groupValue: controller.selectedItem,
                                    toggleable: true,
                                    activeColor:
                                        controller.selectedItem != "present"
                                            ? controller.appColors.white
                                            : controller.appColors.textPink,
                                    tileColor:
                                        controller.selectedItem != "present"
                                            ? controller.appColors.white
                                            : controller.appColors.grey
                                                .withOpacity(0.2),
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    onChanged: (value) {
                                      controller.selectedItem =
                                          value.toString();
                                      if (controller.selectedItem == "null")
                                        controller.visibleBtn = false;
                                      controller.update();
                                    },
                                  ),
                                  Container(
                                    height: 2.px,
                                    color: controller.appColors.divider,
                                  ),
                                  RadioListTile(
                                    title: MyTextView(
                                      "Inconclusive",
                                      textStyleNew: MyTextStyle(
                                        textColor: controller.appColors.black,
                                        textSize: 16.px,
                                        textFamily: fontFamilyRegular,
                                        textWeight: FontWeight.w400,
                                      ),
                                    ),
                                    toggleable: true,
                                    value: "inconclusive",
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16.px),
                                    groupValue: controller.selectedItem,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    activeColor: controller.selectedItem !=
                                            "inconclusive"
                                        ? controller.appColors.white
                                        : controller.appColors.textPink,
                                    tileColor: controller.selectedItem !=
                                            "inconclusive"
                                        ? controller.appColors.white
                                        : controller.appColors.grey
                                            .withOpacity(0.2),
                                    onChanged: (value) {
                                      controller.selectedItem =
                                          value.toString();
                                      if (controller.selectedItem == "null")
                                        controller.visibleBtn = false;
                                      controller.update();
                                    },
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CommonIconButton(
                              textColor: controller.selectedItem !=
                                      "null" /*&&
                                              controller.imageList.isNotEmpty*/
                                  ? controller.appColors.delete
                                  : controller.appColors.border1,
                              title: Strings.delete,
                              onTap: () {
                                if (controller.selectedItem !=
                                        "null" /*&&
                                            controller.imageList.isNotEmpty*/
                                    ) {
                                  controller.dialogDelete();
                                }
                              },
                              padding: EdgeInsets.only(
                                  top: 10.px,
                                  bottom: 10.px,
                                  left: 16.px,
                                  right: 24.px),
                              iconheigth: 15.px,
                              textWeight: FontWeight.w500,
                              textSize: 16.px,
                              color: controller.appColors.transparent,
                              radius: Utils.isLandScapeMode(context)
                                  ? 35.px
                                  : Utils.isTabletScreen(context)
                                      ? 40.px
                                      : 24.px,
                              iconColor: controller.selectedItem !=
                                      "null" /*&&
                                              controller.imageList.isNotEmpty*/
                                  ? controller.appColors.delete
                                  : controller.appColors.border1,
                              icon: icDeleteGrey,
                            ),
                          ],
                        ).paddingOnly(top: 16.px, bottom: 32.px),
                        Container(height: 2.px, color: AppColors().divider),
                        AbsorbPointer(
                          absorbing: (controller.selectedItem == "null"),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  MyTextView(
                                    "Take a Photo",
                                    textStyleNew: MyTextStyle(
                                        textFamily: fontFamilyRegular,
                                        textColor: controller.selectedItem ==
                                                "null"
                                            ? controller.appColors.black
                                                .withOpacity(
                                                    0.07999999821186066)
                                            : AppColors().black,
                                        textSize: 24.px,
                                        textWeight: FontWeight.w400),
                                  ),
                                ],
                              ).paddingSymmetric(vertical: 32.px),
                              ShadowContainer1(
                                color: controller.appColors.white,
                                margin: EdgeInsets.zero,
                                padding: EdgeInsets.zero,
                                radius: 8.px,
                                elevation: 1,
                                child: Container(
                                  height: 200.px,
                                  width: Get.width,
                                  padding: EdgeInsets.all(32.px),
                                  child: controller.imageUploadStatus ==
                                          ImageUploadStatus.success
                                      ? ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              controller.imageList.length,
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Row(
                                              children: [
                                                Stack(children: [
                                                  SizedBox(
                                                    height: 126.px,
                                                    width: 126.px,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.px),
                                                      child: CachedNetworkImage(
                                                        imageUrl: controller
                                                            .imageList[index],
                                                        placeholder: (context,
                                                                url) =>
                                                            Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      ), /*Image.network(
                                                        controller
                                                            .imageList[index],
                                                        frameBuilder: (_,
                                                            image,
                                                            loadingBuilder,
                                                            __) {
                                                          if (loadingBuilder ==
                                                              null) {
                                                            return const SizedBox(
                                                              height: 100,
                                                              width: 100,
                                                              child: Center(
                                                                  child:
                                                                      CircularProgressIndicator()),
                                                            );
                                                          }
                                                          return image;
                                                        },
                                                        loadingBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Widget image,
                                                                ImageChunkEvent?
                                                                    loadingProgress) {
                                                          if (loadingProgress ==
                                                              null)
                                                            return image;
                                                          return SizedBox(
                                                            height: 100,
                                                            width: 100,
                                                            child: Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                value: loadingProgress
                                                                            .expectedTotalBytes !=
                                                                        null
                                                                    ? loadingProgress
                                                                            .cumulativeBytesLoaded /
                                                                        loadingProgress
                                                                            .expectedTotalBytes!
                                                                    : null,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        headers: {
                                                          "Host":
                                                              "${controller.getStorageData.readString(controller.getStorageData.baseURL)}"
                                                        },
                                                        fit: BoxFit.cover,
                                                        scale: 1.0,
                                                        color: controller
                                                                    .selectedItem ==
                                                                "null"
                                                            ? controller
                                                                .appColors.black
                                                                .withOpacity(
                                                                    0.07999999821186066)
                                                            : null,
                                                      ) */ /*Image.file(
                                                        File(controller
                                                                .sendImagesList[
                                                            index]),
                                                        fit: BoxFit.cover,
                                                        color: controller
                                                                    .selectedItem ==
                                                                "null"
                                                            ? controller
                                                                .appColors.black
                                                                .withOpacity(
                                                                    0.07999999821186066)
                                                            : null,
                                                      )*/
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 2,
                                                    top: 2,
                                                    child: GestureDetector(
                                                        onTap: () async {
                                                          if (controller
                                                                  .imageList
                                                                  .length >
                                                              1) {
                                                            controller.imageList
                                                                .removeAt(
                                                                    index);
                                                          } else {
                                                            await controller
                                                                .removeImage(
                                                                    index);
                                                          }
                                                          controller.update();
                                                        },
                                                        child:
                                                            SvgPicture.string(
                                                          icDelete,
                                                          color: controller
                                                                      .selectedItem ==
                                                                  "null"
                                                              ? controller
                                                                  .appColors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.07999999821186066)
                                                              : null,
                                                        )),
                                                  )
                                                ]),
                                                if (controller
                                                            .imageList.length -
                                                        1 ==
                                                    index) ...[
                                                  GestureDetector(
                                                    onTap: () async {
                                                      controller.imagePicker();
                                                    },
                                                    child: Container(
                                                      color: Colors.white,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: 80.px,
                                                            height: 80.px,
                                                            // decoration: BoxDecoration(
                                                            //     borderRadius: BorderRadius.circular(10.px),
                                                            //     border: Border.all(
                                                            //         color: controller.appColors.border1, width: 2)),
                                                            child: Center(
                                                              child: SvgPicture.string(
                                                                  icAdd,
                                                                  // height: 45.px,
                                                                  color: controller
                                                                              .selectedItem ==
                                                                          "null"
                                                                      ? controller
                                                                          .appColors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.07999999821186066)
                                                                      : null
                                                                  // fit: BoxFit.cover,
                                                                  ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 10.px),
                                                          MyTextView(
                                                            "Add picture",
                                                            textStyleNew:
                                                                MyTextStyle(
                                                              textColor: controller
                                                                          .selectedItem ==
                                                                      "null"
                                                                  ? controller
                                                                      .appColors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.07999999821186066)
                                                                  : controller
                                                                      .appColors
                                                                      .appColor,
                                                              textSize: 14.px,
                                                              textWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              textFamily:
                                                                  fontFamilyRegular,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ).paddingSymmetric(
                                                      horizontal: 32.px)
                                                ],
                                              ],
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return SizedBox(
                                              width: 32.px,
                                            );
                                          },
                                        )
                                      : controller.imageUploadStatus ==
                                              ImageUploadStatus.initial
                                          ? GestureDetector(
                                              onTap: () {
                                                controller.imagePicker();
                                              },
                                              child: Container(
                                                color: Colors.white,
                                                child: Column(
                                                  children: [
                                                    controller.selectedItem ==
                                                            "null"
                                                        ? Center(
                                                            child: SvgPicture
                                                                .string(
                                                              icImage,
                                                              width: 80.px,
                                                              height: 80.px,
                                                              color: controller
                                                                  .appColors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.07999999821186066),
                                                            ),
                                                          )
                                                        : Center(
                                                            child: SvgPicture
                                                                .string(
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
                                                              text:
                                                                  "Tap to Take or Upload",
                                                              style:
                                                                  MyTextStyle(
                                                                textSize: 16.px,
                                                                textWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                textColor: controller
                                                                            .selectedItem ==
                                                                        "null"
                                                                    ? controller
                                                                        .appColors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.07999999821186066)
                                                                    : controller
                                                                        .appColors
                                                                        .appColor,
                                                                textFamily:
                                                                    fontFamilyBold,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  " a photo of the",
                                                              style:
                                                                  MyTextStyle(
                                                                textSize: 16.px,
                                                                textColor: controller
                                                                            .selectedItem ==
                                                                        "null"
                                                                    ? controller
                                                                        .appColors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.07999999821186066)
                                                                    : controller
                                                                        .appColors
                                                                        .black,
                                                                textWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                textFamily:
                                                                    fontFamilyRegular,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  " Deficiency",
                                                              style:
                                                                  MyTextStyle(
                                                                textSize: 16.px,
                                                                textWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                textColor: controller
                                                                            .selectedItem ==
                                                                        "null"
                                                                    ? controller
                                                                        .appColors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.07999999821186066)
                                                                    : controller
                                                                        .appColors
                                                                        .appColor,
                                                                textFamily:
                                                                    fontFamilyBold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                ),
                              ),
                              Container(
                                height: 2.px,
                                color: controller.selectedItem == "null"
                                    ? controller.appColors.textField
                                    : AppColors().divider,
                              ).paddingSymmetric(vertical: 32.px),
                              Row(
                                children: [
                                  MyTextView(
                                    Strings.comments,
                                    textStyleNew: MyTextStyle(
                                      textSize: 24.px,
                                      textWeight: FontWeight.w400,
                                      textColor: controller.selectedItem ==
                                              "null"
                                          ? controller.appColors.black
                                              .withOpacity(0.07999999821186066)
                                          : controller.appColors.black,
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
                                    padding: EdgeInsets.zero,
                                    controller: controller.commentController,
                                    color: controller.appColors.transparent,
                                    prefixIcon: SvgPicture.string(
                                      icMsg,
                                      color: controller.selectedItem == "null"
                                          ? controller.appColors.border1
                                          : controller.appColors.lightText,
                                    ).paddingOnly(left: 15.px),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        controller.listen();
                                      },
                                      child: SvgPicture.string(
                                        icMike,
                                        color: controller.selectedItem == "null"
                                            ? controller.appColors.border1
                                            : controller.isListening.value
                                                ? controller.appColors.appColor
                                                : controller
                                                    .appColors.lightText,
                                      ),
                                    ),
                                    onChange: (str) {
                                      if (str.isNotEmpty &&
                                          controller
                                              .dateController.text.isNotEmpty &&
                                          (controller.imageList.isNotEmpty ||
                                              controller.change)) {
                                        controller.visibleBtn = true;
                                      } else {
                                        controller.visibleBtn = false;
                                      }
                                      controller.update();
                                    },
                                    labelText: "${Strings.comments}*",
                                    hintText: Strings.addComments,
                                    hintColor: controller.selectedItem == "null"
                                        ? controller.appColors.border1
                                        : null,
                                    textColor: controller.selectedItem == "null"
                                        ? controller.appColors.border1
                                        : null,
                                    isLableColor:
                                        controller.selectedItem == "null"
                                            ? controller.appColors.border1
                                            : null,
                                    borderColor:
                                        controller.selectedItem == "null"
                                            ? controller.appColors.border1
                                            : null,
                                  )),
                                  SizedBox(
                                    width: 180.px,
                                    child: CommonTextField(
                                        isLable: true,
                                        readOnly: true,
                                        onTap: () {
                                          controller.selectDate();
                                        },
                                        padding: EdgeInsets.zero,
                                        contentPadding:
                                            EdgeInsets.only(left: 16.px),
                                        controller: controller.dateController,
                                        color: controller.appColors.transparent,
                                        suffixIcon: SvgPicture.string(
                                          icCalender2,
                                          color: controller.selectedItem ==
                                                  "null"
                                              ? controller.appColors.border1
                                              : controller.appColors.lightText,
                                        ),
                                        shadowColor:
                                            controller.appColors.transparent,
                                        hintText: "mm/dd/yyyy*",
                                        hintColor:
                                            controller.selectedItem == "null"
                                                ? controller.appColors.border1
                                                : null,
                                        textColor:
                                            controller.selectedItem == "null"
                                                ? controller.appColors.border1
                                                : null,
                                        isLableColor:
                                            controller.selectedItem == "null"
                                                ? controller.appColors.border1
                                                : null,
                                        borderColor:
                                            controller.selectedItem == "null"
                                                ? controller.appColors.border1
                                                : null,
                                        onChange: (str) {
                                          if (str.isNotEmpty &&
                                              controller.commentController.text
                                                  .isNotEmpty) {
                                            controller.visibleBtn = true;
                                            controller.update();
                                          }
                                        },
                                        labelText: Strings.completedDate),
                                  ).paddingOnly(left: 16.px),
                                ],
                              ).paddingSymmetric(vertical: 32.px),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonButton(
                                      title: Strings.saveChanges,
                                      textColor:
                                          controller.selectedItem != "null" &&
                                                  controller.visibleBtn &&
                                                  controller.commentController
                                                      .text.isNotEmpty
                                              ? controller.appColors.white
                                              : controller.appColors.border1,
                                      color: controller.selectedItem !=
                                                  "null" &&
                                              controller.visibleBtn &&
                                              controller.commentController.text
                                                  .isNotEmpty
                                          ? controller.appColors.appColor
                                          : controller.appColors.black
                                              .withOpacity(0.11999999731779099),
                                      radius: 35.px,
                                      textWeight: FontWeight.w600,
                                      textSize: 16.px,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24.px,
                                        vertical: 12.px,
                                      ),
                                      onTap: () async {
                                        if (controller.visibleBtn &&
                                            controller.commentController.text
                                                .isNotEmpty) {
                                          await controller.saveChanges();
                                          Get.back(result: {
                                            "isSuccess": controller
                                                .successListOfDeficiencies
                                                .housingDeficiencyId,
                                            "imagesList": controller.imageList,
                                            "deficiencyInspectionsReqModel":
                                                controller
                                                    .deficiencyInspectionsReqModel
                                          });
                                        }
                                      }),
                                ],
                              ).paddingSymmetric(vertical: 48.px),
                            ],
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 32.px),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
