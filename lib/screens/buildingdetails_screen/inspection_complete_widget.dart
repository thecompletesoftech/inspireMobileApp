import 'package:flutter_svg/flutter_svg.dart';

import '../../commons/all.dart';
import 'buildingdetails_controller.dart';
import 'deficienciesCard_widget.dart';

class InspectionCompleteWidget extends GetView<BuildingDetailsController> {
  const InspectionCompleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildingDetailsController>(
      init: BuildingDetailsController(),
      assignId: true,
      builder: (logic) {
        return Column(
          children: [
            MyTextView(
              Strings.inspectionSummary,
              textStyleNew: MyTextStyle(
                textSize: 40.px,
                textWeight: FontWeight.w700,
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
            ).paddingOnly(bottom: 16.px),
            Form(
              child: Row(
                children: [
                  Expanded(
                      child: DropdownButtonFormField<String>(
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
                  )),
                  SizedBox(
                    width: 16.px,
                  ),
                  Expanded(
                      child: CommonTextField(
                          isLable: true,
                          readOnly: true,
                          onTap: () {
                            controller.selectDate1();
                          },
                          controller: controller.date1Controller,
                          color: controller.appColors.transparent,
                          suffixIcon: SvgPicture.string(
                            icCalender2 ?? "",
                            color: controller.appColors.grey,
                          ),
                          padding: EdgeInsets.zero,
                          contentPadding: EdgeInsets.only(left: 15.px),
                          shadowColor: controller.appColors.transparent,
                          labelText: "${Strings.completedDate}*",
                          hintText: Strings.completedDate)),
                ],
              ),
            ),
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
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 2.px,
                    color: AppColors().divider,
                  ),
                ),
              ],
            ).paddingOnly(top: 24.px),
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
            ),
            /* Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyTextView(
                  Strings.tenantSignatures,
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
            SizedBox(
              height: 184.px,
              child: ShadowContainer(
                color: controller.appColors.white,
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
            ).paddingSymmetric(vertical: 32.px),*/
            /* Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonButton(
                    title: Strings.editInspection,
                    textColor: controller.visibleBtn ? controller.appColors.black : controller.appColors.border1,
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
                        Get.toNamed(HomeScreen.routes, arguments: controller.item);
                      }
                    }),
              ],
            ),*/
          ],
        );
      },
    );
  }
}
