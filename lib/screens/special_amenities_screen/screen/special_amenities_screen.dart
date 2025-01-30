import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/special_amenities_screen/binding/special_amenities_binding.dart';
import 'package:public_housing/screens/special_amenities_screen/controller/special_amenities_controller.dart';
import 'package:public_housing/screens/inspection_unit_summary_screen/screen/inspection_unit_summary_screen.dart';

class SpecialAmenitiesScreen extends GetView<SpecialAmenitiesBinding> {
  const SpecialAmenitiesScreen({Key? key}) : super(key: key);

  static const routes = "/SpecialAmenitiesScreen";

  @override
  Widget build(BuildContext context) {
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyTextView(
                              'Special Amenities',
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
                              onTap: () {
                                Get.toNamed(InspectionUnitSummaryScreen.routes,
                                    arguments: {
                                      "deficiencyArea":
                                          controller.deficiencyArea
                                    });
                              },
                            )
                          ],
                        ).paddingOnly(top: 32.px, bottom: 48.px),
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
