import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/inspection_screen/deficienciesCard_widget.dart';

import '../authority_signatures_screen/authority_signature_screen.dart';
import 'hs_ack_controller.dart';

class HSAckScreen extends GetView<HSAckController> {
  const HSAckScreen({Key? key}) : super(key: key);
  static const routes = "/HSAckScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HSAckController>(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: MyTextView(
                            controller.item == null ? "" : "${controller.item!.title}, ${controller.item!.subtitle}",
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
                                radius: 100.px,
                                textWeight: FontWeight.w500,
                                color: controller.appColors.white,
                                textColor: controller.item!.check == false
                                    ? controller.appColors.textGreen
                                    : controller.appColors.textPink,
                                onTap: () {})
                            : Container(),
                      ],
                    ).paddingOnly(top: 32.px),
                    Column(
                      children: [
                        MyTextView(
                          Strings.hSAcknowledgment,
                          textStyleNew: MyTextStyle(
                            textSize: 32.px,
                            textWeight: FontWeight.w600,
                            textColor: controller.appColors.appColor,
                            textFamily: fontFamilyBold,
                          ),
                        ).paddingSymmetric(vertical: 56.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyTextView(
                              Strings.summaryDecision,
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
                        ).paddingOnly(bottom: 32.px),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyTextView(
                                    Strings.pointOfContact,
                                    textStyleNew: MyTextStyle(
                                      textColor: Colors.black,
                                      textSize: 20.px,
                                      textFamily: fontFamilyRegular,
                                      textWeight: FontWeight.w400,
                                    ),
                                  ).paddingOnly(bottom: 24.px),
                                  CommonTextField(
                                    isLable: true,
                                    padding: EdgeInsets.zero,
                                    contentPadding: EdgeInsets.only(left: 15.px),
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
                                    onChange: (str) {
                                      if (str.isNotEmpty &&
                                          controller.dateController.text.isNotEmpty &&
                                          (controller.change)) {
                                        controller.visibleBtn = true;
                                      } else {
                                        controller.visibleBtn = false;
                                      }
                                      controller.update();
                                    },
                                    labelText: "${Strings.pointOfContactName}*",
                                    hintText: Strings.pointOfContactName,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 16.px,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyTextView(
                                    Strings.selectInspectionEndDateTime,
                                    textStyleNew: MyTextStyle(
                                      textColor: Colors.black,
                                      textSize: 20.px,
                                      textFamily: fontFamilyRegular,
                                      textWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24.px,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
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
                                              color: controller.appColors.grey,
                                            ),
                                            padding: EdgeInsets.zero,
                                            contentPadding: EdgeInsets.only(left: 15.px),
                                            shadowColor: controller.appColors.transparent,
                                            labelText: "Date*",
                                            hintText: "Date"),
                                      ),
                                      SizedBox(
                                        width: 16.px,
                                      ),
                                      Expanded(
                                        child: CommonTextField(
                                            isLable: true,
                                            readOnly: true,
                                            onTap: () {
                                              controller.selectTime();
                                            },
                                            controller: controller.timeController,
                                            color: controller.appColors.transparent,
                                            suffixIcon: SvgPicture.string(
                                              icTime,
                                              color: controller.appColors.grey,
                                            ),
                                            padding: EdgeInsets.zero,
                                            contentPadding: EdgeInsets.only(left: 15.px),
                                            shadowColor: controller.appColors.transparent,
                                            labelText: "Hour*",
                                            hintText: "Hour"),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonButton(
                                title: Strings.noOneIsPresent,
                                textColor: controller.visibleBtn
                                    ? controller.appColors.appColor
                                    : controller.appColors.border1,
                                color: controller.appColors.transparent,
                                radius: 100.px,
                                textWeight: FontWeight.w600,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.px,
                                  vertical: 10.px,
                                ),
                                textSize: 16.px,
                                border: Border.all(
                                    color: controller.visibleBtn
                                        ? controller.appColors.grey
                                        : controller.appColors.lightText.withOpacity(0.2),
                                    width: 2),
                                onTap: () {
                                  if (controller.visibleBtn) {
                                    controller.dialogNoOnePresent();
                                  }
                                }),
                            SizedBox(
                              width: 16.px,
                            ),
                            CommonButton(
                                title: Strings.signatures,
                                textColor:
                                    controller.visibleBtn ? controller.appColors.black : controller.appColors.border1,
                                color: controller.visibleBtn
                                    ? controller.appColors.buttonColor
                                    : controller.appColors.black.withOpacity(0.11999999731779099),
                                radius: 100.px,
                                textWeight: FontWeight.w600,
                                textSize: 16.px,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.px,
                                  vertical: 10.px,
                                ),
                                // height: 55.px,
                                onTap: () {
                                  if (controller.visibleBtn) {
                                    Get.toNamed(AuthoritySignatureScreen.routes, arguments: controller.item);
                                  }
                                }),
                          ],
                        ).paddingSymmetric(vertical: 48.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyTextView(
                              Strings.deficienciesFound,
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
                        ),
                        Container(
                          height: 370.px,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(vertical: 32.px),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: controller.dataList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final item = controller.dataList[index];
                              return DeficienciesCardWidget(item: item);
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 24.px,
                              );
                            },
                          ),
                        )
                      ],
                    ).paddingSymmetric(horizontal: 32.px),
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
