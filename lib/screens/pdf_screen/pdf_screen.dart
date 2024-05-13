import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/languages/language.dart';
import 'package:public_housing/screens/pdf_screen/pdf_controller.dart';
import 'package:screenshot/screenshot.dart';

class PdfScreen extends GetView<PdfController> {
  const PdfScreen({Key? key}) : super(key: key);
  static const routes = "/PdfScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PdfController>(
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
                  padding: EdgeInsets.symmetric(horizontal: 32.px),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 48.px,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          ImagePath.gilsonLogo,
                          height: 72.px,
                          width: 198.px,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32.px,
                    ),
                    MyTextView(
                      'Inspection Report for ${controller.item == null ? "" : controller.item!.title}',
                      textStyleNew: MyTextStyle(
                          textFamily: fontFamilyRegular,
                          textSize: 24.px,
                          textWeight: FontWeight.w600,
                          textColor: controller.appColors.appColor),
                    ),
                    SizedBox(
                      height: 32.px,
                    ),
                    ShadowContainer1(
                        color: controller.appColors.white,
                        radius: 8.px,
                        divider: controller.appColors.textField,
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MyTextView(
                                        "Inspection ID",
                                        textStyleNew: MyTextStyle(
                                            textFamily: fontFamilyRegular,
                                            textSize: 12.px,
                                            textWeight: FontWeight.w400,
                                            textColor: controller.appColors.black),
                                      ),
                                      MyTextView(
                                        "INSP-02942",
                                        textStyleNew: MyTextStyle(
                                            textFamily: fontFamilyRegular,
                                            textSize: 14.px,
                                            textWeight: FontWeight.w600,
                                            textColor: controller.appColors.black),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: controller.appColors.white,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            MyTextView(
                                              "Start Date",
                                              textStyleNew: MyTextStyle(
                                                  textFamily: fontFamilyRegular,
                                                  textSize: 12.px,
                                                  textWeight: FontWeight.w400,
                                                  textColor: controller.appColors.black),
                                            ).paddingOnly(bottom: 4.px),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CommonIconButton(
                                                  icon: icCalenderColor,
                                                  color: controller.appColors.transparent,
                                                  iconheigth: 20.px,
                                                  space: 4.px,
                                                  title: "06/18/2023",
                                                  padding: EdgeInsets.zero,
                                                  textSize: 14.px,
                                                  textWeight: FontWeight.w500,
                                                  textColor: controller.appColors.black,
                                                  onTap: () {},
                                                ).paddingOnly(right: 8.px),
                                                CommonIconButton(
                                                  icon: icTimeColor,
                                                  color: controller.appColors.transparent,
                                                  iconheigth: 20.px,
                                                  space: 4.px,
                                                  title: "08:02",
                                                  textSize: 14.px,
                                                  textWeight: FontWeight.w500,
                                                  padding: EdgeInsets.zero,
                                                  textColor: controller.appColors.black,
                                                  onTap: () {},
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 1.px,
                                        height: 62.px,
                                        color: controller.appColors.divider,
                                      ).paddingSymmetric(horizontal: 24.px),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MyTextView(
                                            "End Date",
                                            textStyleNew: MyTextStyle(
                                                textFamily: fontFamilyRegular,
                                                textSize: 12.px,
                                                textWeight: FontWeight.w400,
                                                textColor: controller.appColors.black),
                                          ).paddingOnly(bottom: 4.px),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CommonIconButton(
                                                icon: icCalenderColor,
                                                     color: controller.appColors.transparent,
                                                iconheigth: 20.px,
                                                space: 4.px,
                                                padding: EdgeInsets.zero,
                                                title: "06/18/2023",
                                                textSize: 14.px,
                                                textWeight: FontWeight.w500,
                                                textColor: controller.appColors.black,
                                                onTap: () {},
                                              ).paddingOnly(right: 8.px),
                                              CommonIconButton(
                                                icon: icTimeColor,
                                                color: controller.appColors.transparent,
                                                space: 4.px,
                                                iconheigth: 20.px,
                                                title: "16:04",
                                                padding: EdgeInsets.zero,
                                                textSize: 14.px,
                                                textWeight: FontWeight.w500,
                                                textColor: controller.appColors.black,
                                                onTap: () {},
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ]).paddingSymmetric(horizontal: 24.px),
                            Container(
                              height: 1.px,
                              color: controller.appColors.divider,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MyTextView(
                                        'Inspector',
                                        textStyleNew: MyTextStyle(
                                            textFamily: fontFamilyRegular,
                                            textSize: 12.px,
                                            textWeight: FontWeight.w400,
                                            textColor: controller.appColors.black),
                                      ).paddingOnly(bottom: 4.px),
                                      MyTextView(
                                        Strings.userName,
                                        textStyleNew: MyTextStyle(
                                            textFamily: fontFamilyRegular,
                                            textSize: 24.px,
                                            textWeight: FontWeight.w600,
                                            textColor: controller.appColors.black),
                                      ).paddingOnly(bottom: 8.px),
                                      MyTextView(
                                        Languages.of(context)!.email,
                                        textStyleNew: MyTextStyle(
                                            textFamily: fontFamilyRegular,
                                            textSize: 12.px,
                                            textWeight: FontWeight.w400,
                                            textColor: controller.appColors.black),
                                      ).paddingOnly(bottom: 4.px),
                                      MyTextView(
                                        "nickJ@hotmail.com",
                                        textStyleNew: MyTextStyle(
                                            textFamily: fontFamilyRegular,
                                            textSize: 24.px,
                                            textWeight: FontWeight.w600,
                                            textColor: controller.appColors.black),
                                      ),
                                      Container(
                                        height: 1.px,
                                        color: controller.appColors.divider,
                                      ).paddingSymmetric(vertical: 24.px),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          MyTextView(
                                            'Escort',
                                            textStyleNew: MyTextStyle(
                                                textFamily: fontFamilyRegular,
                                                textSize: 16.px,
                                                textWeight: FontWeight.w600,
                                                textColor: controller.appColors.lightText),
                                          ).paddingOnly(bottom: 4.px, right: 4.px),
                                          Row(
                                            children: [
                                              MyTextView(
                                                'Present During Inspection',
                                                textStyleNew: MyTextStyle(
                                                    textFamily: fontFamilyRegular,
                                                    textSize: 12.px,
                                                    textWeight: FontWeight.w600,
                                                    textColor: controller.appColors.black),
                                              ).paddingOnly(right: 8.px),
                                              SvgPicture.string(icComplete, height: 16.px),
                                            ],
                                          ),
                                        ],
                                      ),
                                      MyTextView(
                                        "Marc Nicholson",
                                        textStyleNew: MyTextStyle(
                                            textFamily: fontFamilyRegular,
                                            textSize: 24.px,
                                            textWeight: FontWeight.w600,
                                            textColor: controller.appColors.black),
                                      ).paddingOnly(bottom: 8.px),
                                      MyTextView(
                                        Languages.of(context)!.email,
                                        textStyleNew: MyTextStyle(
                                            textFamily: fontFamilyRegular,
                                            textSize: 16.px,
                                            textWeight: FontWeight.w600,
                                            textColor: controller.appColors.lightText),
                                      ).paddingOnly(bottom: 4.px),
                                      MyTextView(
                                        "m@hud.gov",
                                        textStyleNew: MyTextStyle(
                                            textFamily: fontFamilyRegular,
                                            textSize: 24.px,
                                            textWeight: FontWeight.w600,
                                            textColor: controller.appColors.black),
                                      ),
                                      Container(
                                        height: 1.px,
                                        color: controller.appColors.divider,
                                      ).paddingSymmetric(vertical: 24.px),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              MyTextView(
                                                "Point of Contact",
                                                textStyleNew: MyTextStyle(
                                                    textFamily: fontFamilyRegular,
                                                    textSize: 16.px,
                                                    textWeight: FontWeight.w600,
                                                    textColor: controller.appColors.lightText),
                                              ).paddingOnly(bottom: 4.px),
                                              MyTextView(
                                                "John Smith",
                                                textStyleNew: MyTextStyle(
                                                    textFamily: fontFamilyRegular,
                                                    textSize: 24.px,
                                                    textWeight: FontWeight.w600,
                                                    textColor: controller.appColors.black),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              MyTextView(
                                                "Date of Signature",
                                                textStyleNew: MyTextStyle(
                                                    textFamily: fontFamilyRegular,
                                                    textSize: 16.px,
                                                    textWeight: FontWeight.w600,
                                                    textColor: controller.appColors.lightText),
                                              ).paddingOnly(bottom: 4.px),
                                              MyTextView(
                                                "06/18/2023",
                                                textStyleNew: MyTextStyle(
                                                    textFamily: fontFamilyRegular,
                                                    textSize: 24.px,
                                                    textWeight: FontWeight.w600,
                                                    textColor: controller.appColors.black),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 24.px,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      ShadowContainer1(
                                          radius: 8.px,
                                          padding: EdgeInsets.all(16.px),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  MyTextView(
                                                    Strings.buildings,
                                                    textStyleNew: MyTextStyle(
                                                        textSize: 32.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.appColors.black),
                                                  ).paddingOnly(right: 16.px),
                                                  CommonButton(
                                                    title: "12",
                                                    textSize: 20.px,
                                                    textWeight: FontWeight.w600,
                                                    radius: 8.px,
                                                    padding: EdgeInsets.all(8.px),
                                                    onTap: () {},
                                                    color: controller.appColors.buttonColor,
                                                    textColor: controller.appColors.black,
                                                  ),
                                                ],
                                              ).paddingOnly(bottom: 24.px),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  MyTextView(
                                                    Strings.inSample,
                                                    textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.appColors.lightText),
                                                  ).paddingOnly(right: 16.px),
                                                  MyTextView(
                                                    "12",
                                                    textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.appColors.lightText),
                                                  ),
                                                ],
                                              ),
                                              LinearProgressIndicator(
                                                value: 1,
                                                minHeight: 4.px,
                                                color: controller.appColors.textPink,
                                                backgroundColor: controller.appColors.buttonColor,
                                              ).paddingOnly(top: 10.px, bottom: 16.px),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  MyTextView(
                                                    "Inspected",
                                                    textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.appColors.lightText),
                                                  ).paddingOnly(right: 16.px),
                                                  MyTextView(
                                                    "12",
                                                    textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.appColors.lightText),
                                                  ),
                                                ],
                                              ),
                                              LinearProgressIndicator(
                                                value: 1,
                                                minHeight: 4.px,
                                                color: controller.appColors.appColor,
                                                backgroundColor: controller.appColors.buttonColor,
                                              ).paddingOnly(top: 10.px),
                                            ],
                                          )).paddingOnly(bottom: 24.px),
                                      ShadowContainer1(
                                          radius: 8.px,
                                          padding: EdgeInsets.all(16.px),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  MyTextView(
                                                    "Units",
                                                    textStyleNew: MyTextStyle(
                                                        textSize: 32.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.appColors.black),
                                                  ).paddingOnly(right: 16.px),
                                                  CommonButton(
                                                    title: "15",
                                                    textSize: 20.px,
                                                    textWeight: FontWeight.w600,
                                                    radius: 8.px,
                                                    padding: EdgeInsets.all(8.px),
                                                    onTap: () {},
                                                    color: controller.appColors.buttonColor,
                                                    textColor: controller.appColors.black,
                                                  ),
                                                ],
                                              ).paddingOnly(bottom: 24.px),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  MyTextView(
                                                    Strings.inSample,
                                                    textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.appColors.lightText),
                                                  ).paddingOnly(right: 16.px),
                                                  MyTextView(
                                                    "15",
                                                    textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.appColors.lightText),
                                                  ),
                                                ],
                                              ),
                                              LinearProgressIndicator(
                                                value: 0.85,
                                                minHeight: 4.px,
                                                color: controller.appColors.textPink,
                                                backgroundColor: controller.appColors.buttonColor,
                                              ).paddingOnly(top: 10.px, bottom: 16.px),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  MyTextView(
                                                    "Inspected",
                                                    textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.appColors.lightText),
                                                  ).paddingOnly(right: 16.px),
                                                  MyTextView(
                                                    "15",
                                                    textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textWeight: FontWeight.w600,
                                                        textColor: controller.appColors.lightText),
                                                  ),
                                                ],
                                              ),
                                              LinearProgressIndicator(
                                                value: 0.85,
                                                minHeight: 4.px,
                                                color: controller.appColors.appColor,
                                                backgroundColor: controller.appColors.buttonColor,
                                              ).paddingOnly(top: 10.px),
                                            ],
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ).paddingAll(24.px),
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyTextView(
                          'Point of Contact Signature',
                          textStyleNew: MyTextStyle(
                            textSize: 24.px,
                            textWeight: FontWeight.w400,
                            textColor: controller.appColors.black,
                            textFamily: fontFamilyRegular,
                          ),
                        ).paddingOnly(right: 16.px),
                        Expanded(
                          child: Container(
                            height: 2.px,
                            color: AppColors().divider,
                          ),
                        ),
                      ],
                    ).paddingSymmetric(vertical: 32.px),
                    ShadowContainer1(
                      color: controller.appColors.white,
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      radius: 8.px,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.px),
                        child: Screenshot(
                          controller: controller.tenantSignController,
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: Container(
                              constraints: const BoxConstraints.expand(),
                              color: Colors.white,
                              child: Image.asset(
                                ImagePath.icSign,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyTextView(
                          'Unit Deficiencies',
                          textStyleNew: MyTextStyle(
                            textSize: 24.px,
                            textWeight: FontWeight.w400,
                            textColor: controller.appColors.black,
                            textFamily: fontFamilyRegular,
                          ),
                        ).paddingOnly(right: 16.px),
                        Expanded(
                          child: Container(
                            height: 2.px,
                            color: AppColors().divider,
                          ),
                        ),
                      ],
                    ).paddingSymmetric(vertical: 32.px),
                    ShadowContainer1(
                      color: controller.appColors.white,
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      radius: 8.px,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyTextView(
                                    "Building 1 - A-1 - Kitchen",
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.appColors.black,
                                      textWeight: FontWeight.w500,
                                      textFamily: fontFamilyRegular,
                                      textSize: 20.px,
                                    ),
                                  ).paddingOnly(bottom: 4.px),
                                  MyTextView(
                                    "Cabinet and Storage",
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.appColors.black,
                                      textWeight: FontWeight.w400,
                                      textFamily: fontFamilyRegular,
                                      textSize: 20.px,
                                    ),
                                  )
                                ],
                              ).paddingOnly(right: 16.px),
                              CommonButton(
                                  title: Strings.inSample,
                                  textSize: 14.px,
                                  isSmall: false,
                                  isBig: true,
                                  radius: 20.px,
                                  textWeight: FontWeight.w500,
                                  color: controller.appColors.white,
                                  textColor: controller.appColors.textGreen,
                                  onTap: () {})
                            ],
                          ).paddingSymmetric(horizontal: 16.px, vertical: 12.px),
                          ShadowContainer2(
                            color: controller.appColors.white,
                            padding: EdgeInsets.symmetric(vertical: 24.px, horizontal: 32.px),
                            radius: 8.px,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.9.px),
                                  child: Image.asset(
                                    ImagePath.kitchenImg,
                                    height: 203.56.px,
                                    width: 203.56.px,
                                  ),
                                ).paddingOnly(right: 32.px),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.9.px),
                                  child: Image.asset(
                                    ImagePath.kitchenImg1,
                                    height: 203.56.px,
                                    width: 203.56.px,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyTextView(
                                "D1. Food storage space is not present",
                                textStyleNew: MyTextStyle(
                                  textColor: controller.appColors.black,
                                  textWeight: FontWeight.w400,
                                  textFamily: fontFamilyRegular,
                                  textSize: 20.px,
                                ),
                              ),
                              MyTextView(
                                "Correction Timeframe: 30 days",
                                textStyleNew: MyTextStyle(
                                  textColor: controller.appColors.black,
                                  textWeight: FontWeight.w400,
                                  textFamily: fontFamilyRegular,
                                  textSize: 14.px,
                                ),
                              ).paddingOnly(bottom: 32.px),
                              SizedBox(
                                width: double.infinity,
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Comments',
                                        style: MyTextStyle(
                                          textColor: Colors.black,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ': “6 of 10 cabinets are missing -NJ”\n',
                                        style: MyTextStyle(
                                          textColor: controller.appColors.lightText,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Date',
                                        style: MyTextStyle(
                                          textColor: Colors.black,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ': 06/18/2023',
                                        style: MyTextStyle(
                                          textColor: controller.appColors.lightText,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ).paddingAll(16.px),
                        ],
                      ),
                    ),
                    ShadowContainer1(
                      color: controller.appColors.white,
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      radius: 8.px,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyTextView(
                                    "Building 1 - A-1 - Kitchen",
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.appColors.black,
                                      textWeight: FontWeight.w500,
                                      textFamily: fontFamilyRegular,
                                      textSize: 20.px,
                                    ),
                                  ).paddingOnly(bottom: 4.px),
                                  MyTextView(
                                    "Refrigerator",
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.appColors.black,
                                      textWeight: FontWeight.w400,
                                      textFamily: fontFamilyRegular,
                                      textSize: 20.px,
                                    ),
                                  )
                                ],
                              ).paddingOnly(right: 16.px),
                              CommonButton(
                                  title: Strings.inSample,
                                  textSize: 14.px,
                                  isSmall: false,
                                  isBig: true,
                                  radius: 20.px,
                                  textWeight: FontWeight.w500,
                                  color: controller.appColors.white,
                                  textColor: controller.appColors.textGreen,
                                  onTap: () {})
                            ],
                          ).paddingSymmetric(horizontal: 16.px, vertical: 12.px),
                          ShadowContainer2(
                            color: controller.appColors.white,
                            padding: EdgeInsets.symmetric(vertical: 24.px, horizontal: 32.px),
                            radius: 8.px,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.9.px),
                                  child: Image.asset(
                                    ImagePath.kitchenImg,
                                    height: 203.56.px,
                                    width: 203.56.px,
                                  ),
                                ).paddingOnly(right: 32.px),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.9.px),
                                  child: Image.asset(
                                    ImagePath.kitchenImg1,
                                    height: 203.56.px,
                                    width: 203.56.px,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyTextView(
                                "D3. Refrigerator is missing",
                                textStyleNew: MyTextStyle(
                                  textColor: controller.appColors.black,
                                  textWeight: FontWeight.w400,
                                  textFamily: fontFamilyRegular,
                                  textSize: 20.px,
                                ),
                              ),
                              MyTextView(
                                "Correction Timeframe: 30 days",
                                textStyleNew: MyTextStyle(
                                  textColor: controller.appColors.black,
                                  textWeight: FontWeight.w400,
                                  textFamily: fontFamilyRegular,
                                  textSize: 14.px,
                                ),
                              ).paddingOnly(bottom: 32.px),
                              SizedBox(
                                width: double.infinity,
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Comments',
                                        style: MyTextStyle(
                                          textColor: Colors.black,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ': “Refrigerator is missing -NJ”\n',
                                        style: MyTextStyle(
                                          textColor: controller.appColors.lightText,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Date',
                                        style: MyTextStyle(
                                          textColor: Colors.black,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ': 06/18/2023',
                                        style: MyTextStyle(
                                          textColor: controller.appColors.lightText,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ).paddingAll(16.px),
                        ],
                      ),
                    ).paddingSymmetric(vertical: 32.px),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonIconButton(
                                icon: icUpload,
                                iconheigth: 20.px,
                                title: Strings.share,
                                radius: 100.px,
                                border: Border.all(color: controller.appColors.border, width: 2),
                                padding: EdgeInsets.fromLTRB(16.px, 10.px, 24.px, 10.px),
                                color: controller.appColors.transparent,
                                textColor: controller.appColors.appColor,
                                textWeight: FontWeight.w600,
                                textSize: 16.px,
                                onTap: () {})
                            .paddingOnly(right: 16.px),
                        CommonIconButton(
                            icon: icDownload,
                            iconheigth: 20.px,
                            title: Strings.download,
                            radius: 100.px,
                            border: Border.all(color: controller.appColors.border, width: 2),
                            padding: EdgeInsets.fromLTRB(16.px, 10.px, 24.px, 10.px),
                            color: controller.appColors.transparent,
                            textColor: controller.appColors.appColor,
                            textWeight: FontWeight.w600,
                            textSize: 16.px,
                            onTap: () {}),
                      ],
                    ).paddingOnly(bottom: 20.px),
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
