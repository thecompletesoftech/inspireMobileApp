import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/inspection_screen/deficienciesCard_widget.dart';

import '../signatures_screen/screen/signature_screen.dart';
import 'inspection_summary_controller.dart';

class InspectionSummaryScreen extends GetView<InspectionSummaryController> {
  const InspectionSummaryScreen({Key? key}) : super(key: key);
  static const routes = "/InspectionSummaryScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InspectionSummaryController>(
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
                                radius: 100.px,
                                textWeight: FontWeight.w500,
                                color: controller.appColors.white,
                                textColor: controller.item!.check == false
                                    ? controller.appColors.textGreen
                                    : controller.appColors.textPink,
                                onTap: () {})
                            : const SizedBox(),
                      ],
                    ).paddingOnly(top: 32.px),
                    Column(
                      children: [
                        MyTextView(
                          Strings.inspectionSummary,
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
                        Form(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyTextView(
                                    Strings.selectFindingType,
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
                              )),
                              SizedBox(
                                width: 16.px,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyTextView(
                                    Strings.selectCompletedDate,
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
                                  CommonTextField(
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
                                      labelText: "${Strings.completedDate}*",
                                      hintText: Strings.completedDate)
                                ],
                              )),
                            ],
                          ),
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
                                    Get.toNamed(SignatureScreen.routes, arguments: controller.item);
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
