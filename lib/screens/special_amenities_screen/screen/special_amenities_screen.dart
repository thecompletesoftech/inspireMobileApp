import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/special_amenities_screen/binding/special_amenities_binding.dart';
import 'package:public_housing/screens/special_amenities_screen/controller/special_amenities_controller.dart';

class SpecialAmenitiesScreen extends GetView<SpecialAmenitiesBinding> {
  const SpecialAmenitiesScreen({Key? key}) : super(key: key);

  static const routes = "/SpecialAmenitiesScreen";

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> otherController = [];
    return GetBuilder<SpecialAmenitiesController>(
      init: SpecialAmenitiesController(),
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
                    Get.back();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextView(
                      Strings.specialAmenities,
                      textStyleNew: MyTextStyle(
                        textColor: controller.appColors.appColor,
                        textWeight: FontWeight.w500,
                        textFamily: fontFamilyBold,
                        textSize: 40.px,
                      ),
                    ),
                    CommonButton(
                      title: Strings.inspectionSummary,
                      radius: 100.px,
                      width: 198.px,
                      height: 44.px,
                      textSize: 16.px,
                      textWeight: FontWeight.w500,
                      textFamily: fontFamilyRegular,
                      textColor: controller.appColors.white,
                      color: controller.appColors.appColor,
                      onTap: controller.inspectionSummaryOnTap,
                    )
                  ],
                ).paddingOnly(
                    top: 32.px, bottom: 48.px, right: 32.px, left: 32.px),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.separated(
                          itemCount: controller.specialAmenitiesDataList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var mainData =
                                controller.specialAmenitiesDataList[index];
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    MyTextView(
                                      "${index + 1}. ${mainData.type}",
                                      textStyleNew: MyTextStyle(
                                        textColor: controller.appColors.black,
                                        textWeight: FontWeight.w400,
                                        textFamily: fontFamilyBold,
                                        textSize: 24.px,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 2.px,
                                        color: AppColors().divider,
                                      ).paddingSymmetric(horizontal: 16.px),
                                    ),
                                  ],
                                ).paddingOnly(bottom: 20.px),
                                ListView.separated(
                                  itemCount:
                                      mainData.amenitiesList?.length ?? 0,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    otherController
                                        .add(TextEditingController());
                                    var subData = mainData.amenitiesList?[i];
                                    return subData?.titleType == 'switch'
                                        ? Column(
                                            children: [
                                              Row(
                                                children: [
                                                  MyTextView(
                                                    subData?.title ?? "",
                                                    textStyleNew: MyTextStyle(
                                                      textColor: controller
                                                          .appColors.black,
                                                      textWeight:
                                                          FontWeight.w400,
                                                      textFamily:
                                                          fontFamilyBold,
                                                      textSize: 20.px,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Switch(
                                                    activeTrackColor: controller
                                                        .appColors.appColor,
                                                    inactiveTrackColor:
                                                        controller.appColors
                                                            .inactiveColor,
                                                    inactiveThumbImage:
                                                        Image.asset(
                                                      ImagePath.uncheckmark,
                                                      height: 60,
                                                      width: 60,
                                                    ).image,
                                                    activeThumbImage:
                                                        Image.asset(
                                                      ImagePath.checkmark,
                                                      height: 60,
                                                      width: 60,
                                                    ).image,
                                                    // SvgPicture.string(icbathroom),
                                                    activeColor: controller
                                                        .appColors.white,
                                                    value:
                                                        subData?.isSelected ??
                                                            false,
                                                    onChanged: (value) {
                                                      controller.switchButton
                                                              .value =
                                                          !controller
                                                              .switchButton
                                                              .value;
                                                      subData?.isSelected =
                                                          !(subData
                                                                  .isSelected ??
                                                              false);
                                                      controller.update();
                                                    },
                                                  ),
                                                  MyTextView(
                                                    controller
                                                            .switchButton.value
                                                        ? Strings.yes
                                                        : Strings.no,
                                                    textStyleNew: MyTextStyle(
                                                      textColor: controller
                                                          .appColors.black,
                                                      textWeight:
                                                          FontWeight.w400,
                                                      textFamily:
                                                          fontFamilyBold,
                                                      textSize: 16.px,
                                                    ),
                                                  ).paddingOnly(left: 10.px),
                                                ],
                                              ),
                                              CommonTextField(
                                                readOnly:
                                                    subData?.isSelected == true
                                                        ? false
                                                        : true,
                                                controller: controller
                                                    .disabilityController,
                                                color: controller
                                                    .appColors.transparent,
                                                padding: EdgeInsets.zero,
                                                contentPadding: EdgeInsets.only(
                                                    left: 25.px),
                                                shadowColor: controller
                                                    .appColors.transparent,
                                                hintText: Strings.disability,
                                                hintColor: subData
                                                            ?.isSelected ==
                                                        true
                                                    ? controller.appColors.black
                                                    : controller.appColors.grey
                                                        .withOpacity(.5),
                                                border: Border.all(
                                                    color: subData
                                                                ?.isSelected ==
                                                            true
                                                        ? controller
                                                            .appColors.black
                                                        : controller
                                                            .appColors.grey
                                                            .withOpacity(.5)),
                                              ).paddingSymmetric(
                                                  vertical: 10.px),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              Checkbox(
                                                value: subData?.isSelected ??
                                                    false,
                                                onChanged: (value) {
                                                  subData?.isSelected =
                                                      !(subData.isSelected ??
                                                          false);
                                                  controller.update();
                                                },
                                              ),
                                              subData?.titleType == 'textfield'
                                                  ? Expanded(
                                                      child: CommonTextField(
                                                        readOnly:
                                                            subData?.isSelected ==
                                                                    true
                                                                ? false
                                                                : true,
                                                        controller:
                                                            otherController[i],
                                                        color: controller
                                                            .appColors
                                                            .transparent,
                                                        onChange: (value) {
                                                          otherController[i]
                                                                  .text =
                                                              value.toString();

                                                          subData?.title =
                                                              otherController[i]
                                                                  .text;
                                                        },
                                                        padding:
                                                            EdgeInsets.zero,
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 25.px),
                                                        shadowColor: controller
                                                            .appColors
                                                            .transparent,
                                                        hintText: Strings.other,
                                                        hintColor:
                                                            subData?.isSelected ==
                                                                    true
                                                                ? controller
                                                                    .appColors
                                                                    .black
                                                                : controller
                                                                    .appColors
                                                                    .grey
                                                                    .withOpacity(
                                                                        .5),
                                                        border: Border.all(
                                                            color: subData
                                                                        ?.isSelected ==
                                                                    true
                                                                ? controller
                                                                    .appColors
                                                                    .black
                                                                : controller
                                                                    .appColors
                                                                    .grey
                                                                    .withOpacity(
                                                                        .5)),
                                                      ),
                                                    )
                                                  : MyTextView(
                                                      subData?.title ?? "",
                                                      textStyleNew: MyTextStyle(
                                                        textColor: controller
                                                            .appColors.black,
                                                        textWeight:
                                                            FontWeight.w400,
                                                        textFamily:
                                                            fontFamilyBold,
                                                        textSize: 20.px,
                                                      ),
                                                    ),
                                            ],
                                          );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(height: 6.px);
                                  },
                                )
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 20.px);
                          },
                        ),
                        CommonButton(
                          title: Strings.inspectionSummary,
                          radius: 100.px,
                          width: 198.px,
                          height: 44.px,
                          textSize: 16.px,
                          textWeight: FontWeight.w500,
                          textFamily: fontFamilyRegular,
                          textColor: controller.appColors.white,
                          color: controller.appColors.appColor,
                          onTap: controller.inspectionSummaryOnTap,
                        ).paddingSymmetric(vertical: 32.px)
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
