import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_cabinets_screen/binding/standards_details_binding.dart';
import 'package:public_housing/screens/building_cabinets_screen/controller/standards_details_controller.dart';
import 'package:public_housing/screens/building_cabinets_screen/widgets/building_text_common_widget.dart';
import 'package:public_housing/screens/building_standards_screen/controller/building_standards_controller.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/controller/deficiencies_inside_controller.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/screen/deficiencies_inside_screen.dart';

class StandardsDetailsScreen extends GetView<StandardsDetailsBinding> {
  const StandardsDetailsScreen({Key? key}) : super(key: key);

  static const routes = "/StandardsDetailsScreen";

  @override
  Widget build(BuildContext context) {
    BuildingStandardsController buildingStandardsController =
        Get.put(BuildingStandardsController());

    return GetBuilder<StandardsDetailsController>(
      init: StandardsDetailsController(),
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
                    Get.back(result: {
                      "successList": controller.successListOfDeficiencies,
                      "standardsId": controller.buildingDataModel.id,
                      "buildingName":
                          "${controller.buildingDataModel.name ?? ""}",
                    });
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        MyTextView(
                          '${buildingStandardsController.propertyInfo['name'] ?? ""} - ${buildingStandardsController.buildingInfo['name'] ?? ""}',
                          textStyleNew: MyTextStyle(
                            textColor: controller.appColors.appColor,
                            textWeight: FontWeight.w600,
                            textFamily: fontFamilyBold,
                            textSize: 20.px,
                          ),
                        ).paddingOnly(top: 32.px, bottom: 48.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyTextView(
                              controller.buildingDataModel.name ?? "",
                              textStyleNew: MyTextStyle(
                                textColor: controller.appColors.appColor,
                                textWeight: FontWeight.w500,
                                textFamily: fontFamilyBold,
                                textSize: 40.px,
                              ),
                            ),
                          ],
                        ).paddingOnly(bottom: 24.px),
/*
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CommonContainer(
                              radius: 100.px,
                              height: 44.px,
                              width: 210.px,
                              color: controller.appColors.appColor,
                              child: Row(
                                children: [
                                  SvgPicture.string(
                                    icArrowRight,
                                    height: 24.px,
                                  ),
                                  MyTextView(
                                    Strings.callForAidSystem,
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.appColors.white,
                                      textWeight: FontWeight.w500,
                                      textFamily: fontFamilyBold,
                                      textSize: 16.px,
                                    ),
                                  ).paddingOnly(left: 8.px),
                                ],
                              ).paddingSymmetric(
                                  vertical: 2.px, horizontal: 20.px),
                            ),
                          ],
                        ),
*/
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonText(
                                    title: Strings.definition,
                                    description: (controller
                                            .buildingDataModel.definition ??
                                        "")),
                                CommonText(
                                  title: Strings.purpose,
                                  description:
                                      (controller.buildingDataModel.purpose ??
                                          ""),
                                ).paddingSymmetric(vertical: 24.px),
                                CommonText(
                                    title: Strings.commonComponents,
                                    description: (controller.buildingDataModel
                                            .commonComponents ??
                                        "")),
                              ],
                            )),
                            SizedBox(width: 20.px),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyTextView(
                                  Strings.location,
                                  isMaxLineWrap: true,
                                  textStyleNew: MyTextStyle(
                                    textColor: controller.appColors.black,
                                    textWeight: FontWeight.w400,
                                    textFamily: fontFamilyBold,
                                    textSize: 24.px,
                                  ),
                                ).paddingOnly(top: 24.px),
                                Row(
                                  children: [
                                    MyTextView(
                                      Strings.buildings,
                                      textStyleNew: MyTextStyle(
                                        textColor: controller.appColors.black,
                                        textWeight: FontWeight.w400,
                                        textFamily: fontFamilyBold,
                                        textSize: 20.px,
                                      ),
                                    ),
                                  ],
                                ).paddingSymmetric(vertical: 24.px),
                                Row(
                                  children: [
                                    MyTextView(
                                      '${controller.nameList.join(", ")} ',
                                      textStyleNew: MyTextStyle(
                                        textColor: controller.appColors.black,
                                        textWeight: FontWeight.w400,
                                        textFamily: fontFamilyBold,
                                        textSize: 20.px,
                                      ),
                                    )
                                  ],
                                ),
                                CommonText(
                                        title: Strings.moreInfo,
                                        description: (controller
                                                .buildingDataModel
                                                .moreInformation ??
                                            ""))
                                    .paddingSymmetric(vertical: 24.px),
                              ],
                            ))
                          ],
                        ).paddingSymmetric(vertical: 56.px),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTextView(
                              Strings.deficiencies,
                              textStyleNew: MyTextStyle(
                                textColor: controller.appColors.black,
                                textWeight: FontWeight.w400,
                                textFamily: fontFamilyBold,
                                textSize: 32.px,
                              ),
                            ),
                          ],
                        ).paddingOnly(bottom: 32.px),
                        Container(
                          height: 2.px,
                          color: controller.appColors.divider,
                        ),
                        ...List.generate(
                            controller.successListOfDeficiencies.length,
                            (index) {
                          var data =
                              controller.successListOfDeficiencies[index];
                          return Column(
                            children: [
                              Row(
                                children: [
                                  MyTextView(
                                    '${data.deficiencyItemHousingDeficiency.housingItem.item ?? ""}',
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.appColors.textGreen,
                                      textWeight: FontWeight.w500,
                                      textFamily: fontFamilyBold,
                                      textSize: 14.px,
                                    ),
                                  ).paddingOnly(right: 24.px),
                                  Expanded(
                                    child: MyTextView(
                                      '${data.definition}',
                                      isMaxLineWrap: true,
                                      textStyleNew: MyTextStyle(
                                        textColor: controller.appColors.black,
                                        textWeight: FontWeight.w400,
                                        textFamily: fontFamilyBold,
                                        textSize: 20.px,
                                      ),
                                    ),
                                  ),
                                  if (controller
                                          .successListOfDeficiencies[index]
                                          .isSuccess ==
                                      true)
                                    ClipOval(
                                        child: SvgPicture.string(
                                      icComplete,
                                    )),
                                  CommonButton(
                                    radius: 100.px,
                                    title: Strings.seeMore,
                                    onTap: () async {
                                      var result = await Get.toNamed(
                                          DeficienciesInsideScreen.routes,
                                          arguments: {
                                            "buildingName":
                                                "${controller.buildingName}",
                                            "deficiencies":
                                                "${Strings.storageComponent}",
                                            "deficiencyAreaItem": data,
                                            "successListOfDeficiencies": controller
                                                    .successListOfDeficiencies[
                                                index],
                                            "listIndex": index,
                                            "standard": 'standard',
                                          })?.then(
                                        (value) {
                                          if (value != null) {
                                            controller.setSuccessDeficiencies(Get
                                                    .find<
                                                        DeficienciesInsideController>()
                                                .deficiencyInspectionsReqModel);
                                          }
                                          controller.update();
                                        },
                                      );
                                    },
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24.px,
                                      vertical: 10.px,
                                    ),
                                    textWeight: FontWeight.w500,
                                    textSize: 16.px,
                                    color: controller.appColors.buttonColor,
                                    textColor: controller.appColors.black,
                                  ).paddingOnly(left: 24.px),
                                ],
                              ).paddingSymmetric(vertical: 16.px),
                              Container(
                                height: 2.px,
                                color: controller.appColors.divider,
                              ),
                            ],
                          );
                        }),
                    
                    
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
