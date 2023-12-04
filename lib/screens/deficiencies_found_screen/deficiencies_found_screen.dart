import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/deficiencies_found_screen/deficiencies_found_controller.dart';

class DeficienciesFoundScreen extends GetView<DeficienciesFoundController> {
  const DeficienciesFoundScreen({Key? key}) : super(key: key);
  static const routes = "/DeficienciesFoundScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeficienciesFoundController>(
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: Column(
            children: [
              CommonAppBar(
                color: controller.appColors.transparent,
                radius: 0.px,
                onClickBack: () {
                  Get.back();
                },
              ),
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
                                : "${controller.item!.massage}, ${controller.buildingTitle}",
                            textStyleNew: MyTextStyle(
                              textSize:
                                  Utils.isMediumScreen(context) ? 24.px : 20.px,
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
                                title: controller.item!.check == false
                                    ? Strings.inSample
                                    : Strings.tenant,
                                textSize: 14.px,
                                isSmall: false,
                                isBig: true,
                                radius: 20.px,
                                textWeight: FontWeight.w500,
                                color: controller.appColors.white,
                                textColor: controller.item!.check == false
                                    ? controller.appColors.textGreen
                                    : controller.appColors.textPink,
                                onTap: () {})
                            : const SizedBox(),
                      ],
                    ).paddingOnly(
                      top: 32.px,
                    ),
                    Column(
                      children: [
                        Column(
                          children: [
                            MyTextView(
                              Strings.deficienciesFound,
                              maxLinesNew: 4,
                              textStyleNew: MyTextStyle(
                                textSize: 40.px,
                                textWeight: FontWeight.w700,
                                textColor: controller.appColors.appColor,
                                textFamily: fontFamilyBold,
                              ),
                            ),
                          ],
                        ).paddingSymmetric(vertical: 40.px),
                        Column(
                          children: [
                            MyTextView(
                              Strings.noDeficienciesFound,
                              maxLinesNew: 4,
                              textStyleNew: MyTextStyle(
                                textSize: 32.px,
                                textWeight: FontWeight.w400,
                                textColor: controller.appColors.border1,
                                textFamily: fontFamilyBold,
                              ),
                            ),
                          ],
                        ).paddingSymmetric(vertical: 375.px),
                      ],
                    ).paddingSymmetric(horizontal: 32.px)
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
