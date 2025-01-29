import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/inspection_information_screen/controller/inspection_information_controller.dart';
import 'package:public_housing/screens/inspection_standards_screen/screen/inspection_standards_screen.dart';
import 'package:public_housing/screens/no_show_screen/screen/no_show_screen.dart';
import 'package:public_housing/screens/unit_list_screen/widget/common_unit_list_container.dart';

class InspectionInformationScreen
    extends GetView<InspectionInformationController> {
  const InspectionInformationScreen({Key? key}) : super(key: key);

  static const routes = "/InspectionInformationScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InspectionInformationController>(
      init: InspectionInformationController(),
      autoRemove: true,
      assignId: true,
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonAppBar(
                  color: controller.appColors.transparent,
                  radius: 0.px,
                  onClickBack: () {
                    Get.back();
                  },
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MyTextView(
                          '2113 Kendall Street',
                          textStyleNew: MyTextStyle(
                              textSize: 20.px,
                              textColor: AppColors().black,
                              textWeight: FontWeight.w600),
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
                                textColor:
                                    'Annual Inspection' == 'Annual Inspection'
                                        ? AppColors().textGreen
                                        : 'Re-Inspection' == 'Re-Inspection'
                                            ? AppColors().textPink
                                            : AppColors().black,
                                textWeight: FontWeight.w500),
                          ),
                        ).paddingOnly(left: 24.px),
                      ],
                    ).paddingOnly(top: 31.px),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.px),
                          decoration: BoxDecoration(color: AppColors().white),
                          child: CommonRow(
                            image: icCalenderColor,
                            imageName: '06/22/2023',
                            imageNameColor: AppColors().black,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16.px),
                          decoration: BoxDecoration(color: AppColors().white),
                          child: CommonRow(
                            image: clockIcon,
                            imageName: '08:00 - 10:00',
                            imageNameColor: AppColors().black,
                          ),
                        ).paddingOnly(left: 16.px),
                      ],
                    ).paddingOnly(top: 24.px),
                    Container(
                      height: 2.px,
                      color: AppColors().divider,
                    ).paddingSymmetric(vertical: 33.px),
                    ShadowContainer(
                      radius: 8.px,
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      elevation: 1.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              MyTextView(
                                'Tenant_name',
                                textStyleNew: MyTextStyle(
                                    textSize: 20.px,
                                    textColor: AppColors().black,
                                    textWeight: FontWeight.w600),
                              ),
                              MyTextView(
                                ' - [Tenant ID]',
                                textStyleNew: MyTextStyle(
                                    textSize: 16.px,
                                    textColor: AppColors().black,
                                    textWeight: FontWeight.w400),
                              ).paddingOnly(top: 4.px),
                            ],
                          ),
                          MyTextView(
                            'Tenant',
                            textStyleNew: MyTextStyle(
                                textSize: 16.px,
                                textColor: AppColors().black,
                                textWeight: FontWeight.w400),
                          ),
                        ],
                      ).paddingAll(16.px),
                    ),
                    ShadowContainer(
                      radius: 8.px,
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      elevation: 1.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              MyTextView(
                                '[Landlord Name]',
                                textStyleNew: MyTextStyle(
                                    textSize: 20.px,
                                    textColor: AppColors().black,
                                    textWeight: FontWeight.w600),
                              ),
                              MyTextView(
                                ' - [Landlord ID]',
                                textStyleNew: MyTextStyle(
                                    textSize: 16.px,
                                    textColor: AppColors().black,
                                    textWeight: FontWeight.w400),
                              ).paddingOnly(top: 4.px),
                            ],
                          ),
                          MyTextView(
                            'Landlord',
                            textStyleNew: MyTextStyle(
                                textSize: 16.px,
                                textColor: AppColors().black,
                                textWeight: FontWeight.w400),
                          ),
                        ],
                      ).paddingAll(16.px),
                    ).paddingOnly(top: 24.px),
                    Container(
                      height: 2.px,
                      color: AppColors().divider,
                    ).paddingSymmetric(vertical: 33.px),
                    MyTextView(
                      'Inspector Notes',
                      textStyleNew: MyTextStyle(
                          textSize: 24.px,
                          textColor: AppColors().black,
                          textWeight: FontWeight.w400),
                    ),
                    CommonTextField(
                      isLable: true,
                      controller: controller.inspectionNotesController,
                      color: controller.appColors.transparent,
                      prefixIcon: SvgPicture.string(
                        icMsg,
                        color: controller.appColors.lightText,
                      ).paddingOnly(left: 15.px),
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
                      labelText: Strings.inspectorNotes,
                      hintText: Strings.commentHint,
                    ).paddingOnly(top: 16.px),
                    Row(
                      children: [
                        Expanded(
                          child: CommonTextField(
                            isLable: true,
                            readOnly: false,
                            controller: controller.bedroomsController,
                            color: controller.appColors.transparent,
                            prefixIcon: SvgPicture.string(
                              icbedrooms,
                              color: controller.appColors.grey,
                            ).paddingOnly(left: 15.px, right: 15.px),
                            padding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.only(left: 25.px),
                            shadowColor: controller.appColors.transparent,
                            labelText: Strings.bedroom,
                          ),
                        ),
                        SizedBox(width: 16.px),
                        Expanded(
                          child: CommonTextField(
                            isLable: true,
                            readOnly: false,
                            controller: controller.bathroomsController,
                            color: controller.appColors.transparent,
                            prefixIcon: SvgPicture.string(
                              icbathroom,
                              color: controller.appColors.grey,
                            ).paddingOnly(left: 15.px, right: 15.px),
                            padding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.only(left: 25.px),
                            shadowColor: controller.appColors.transparent,
                            labelText: Strings.bathroom,
                          ),
                        ),
                      ],
                    ).paddingOnly(top: 32.px),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonButton(
                          title: Strings.noShow,
                          textColor: AppColors().appColor,
                          textWeight: FontWeight.w600,
                          textSize: 16.px,
                          onTap: () {
                            Get.toNamed(NoShowScreen.routes);
                          },
                          width: 115.px,
                          height: 44.px,
                          color: AppColors().transparent,
                          border: Border.all(color: AppColors().black),
                        ),
                        SizedBox(width: 24.px),
                        CommonButton(
                          title: Strings.startInspection,
                          textColor: AppColors().black,
                          textWeight: FontWeight.w600,
                          textSize: 16.px,
                          onTap: () {
                            Get.toNamed(InspectionStandardsScreen.routes);
                          },
                          width: 171.px,
                          height: 44.px,
                          color: AppColors().textPink,
                        ),
                      ],
                    ).paddingOnly(top: 48.px)
                  ],
                ).paddingSymmetric(horizontal: 32.px, vertical: 32.px))
              ],
            ),
          ),
        );
      },
    );
  }
}
