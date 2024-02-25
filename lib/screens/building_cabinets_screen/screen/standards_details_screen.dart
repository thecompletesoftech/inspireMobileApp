import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/commons/common_widgets/common_container.dart';
import 'package:public_housing/screens/building_cabinets_screen/binding/standards_details_binding.dart';
import 'package:public_housing/screens/building_cabinets_screen/controller/standards_details_controller.dart';
import 'package:public_housing/screens/building_cabinets_screen/widgets/building_text_common_widget.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/screen/deficiencies_inside_screen.dart';

class StandardsDetailsScreen extends GetView<StandardsDetailsBinding> {
  const StandardsDetailsScreen({Key? key}) : super(key: key);

  static const routes = "/StandardsDetailsScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StandardsDetailsController>(
      init: StandardsDetailsController(),
      autoRemove: false,
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonAppBar(
                    color: controller.appColors.transparent,
                    radius: 0.px,
                    onClickBack: () {
                      Get.back(result: {
                        "isSuccess": controller.isSuccess,
                        "imagesList": controller.imagesList,
                        "buildingName":
                            "${controller.buildingDataModel.name ?? ""}",
                      });
                    },
                  ),
                  Column(
                    children: [
                      MyTextView(
                        '${Strings.propertyNames}${controller.buildingName}',
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
                                  description: (controller
                                          .buildingDataModel.commonComponents ??
                                      "")),
                              CommonText(
                                      title: Strings.moreInfo,
                                      description: (controller.buildingDataModel
                                              .moreInformation ??
                                          ""))
                                  .paddingSymmetric(vertical: 24.px),
                            ],
                          )),
                          SizedBox(width: 20.px),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /*Center(
                                child: Image.asset(
                                  controller.buildingDataModel?.image ?? "",
                                  height: 248.px,
                                  width: 332.px,
                                  fit: BoxFit.cover,
                                ),
                              ),*/
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
                                    Strings.unit,
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.appColors.black,
                                      textWeight: FontWeight.w400,
                                      textFamily: fontFamilyBold,
                                      textSize: 20.px,
                                    ),
                                  ),
                                  MyTextView(
                                    Strings.laundry,
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.appColors.black,
                                      textWeight: FontWeight.w400,
                                      textFamily: fontFamilyBold,
                                      textSize: 20.px,
                                    ),
                                  ).paddingOnly(left: 20.px),
                                ],
                              ).paddingSymmetric(vertical: 24.px),
                              Row(
                                children: [
                                  MyTextView(
                                    Strings.inside,
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.appColors.black,
                                      textWeight: FontWeight.w400,
                                      textFamily: fontFamilyBold,
                                      textSize: 20.px,
                                    ),
                                  ),
                                  MyTextView(
                                    Strings.laundry,
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.appColors.black,
                                      textWeight: FontWeight.w400,
                                      textFamily: fontFamilyBold,
                                      textSize: 20.px,
                                    ),
                                  ).paddingOnly(left: 20.px),
                                ],
                              )
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
                      ),
                      Container(
                        height: 2.px,
                        color: controller.appColors.divider,
                      ),
                      ...List.generate(
                          controller.buildingDataModel.deficiencyAreaItems
                                  ?.length ??
                              0, (index) {
                        DeficiencyAreaItem? data = controller
                            .buildingDataModel.deficiencyAreaItems?[index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: MyTextView(
                                    '${data?.description ?? ""}',
                                    isMaxLineWrap: true,
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.appColors.black,
                                      textWeight: FontWeight.w400,
                                      textFamily: fontFamilyBold,
                                      textSize: 20.px,
                                    ),
                                  ),
                                ),
                                if (controller.isSuccess == true)
                                  ClipOval(
                                      child: SvgPicture.string(
                                    icComplete,
                                  )),
                                CommonButton(
                                  radius: 100.px,
                                  title: Strings.seeMore,
                                  onTap: () {
                                    Get.toNamed(DeficienciesInsideScreen.routes,
                                        arguments: {
                                          "buildingName":
                                              "${controller.buildingName}",
                                          "deficiencies":
                                              "${Strings.storageComponent}",
                                          "deficiencyAreaItem": data,
                                        }); /*?.then((value) {
                                    controller.isSuccess = value['isSuccess'];
                                    controller.imagesList = value['imagesList'];
                                    controller.update();
                                  });*/
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
