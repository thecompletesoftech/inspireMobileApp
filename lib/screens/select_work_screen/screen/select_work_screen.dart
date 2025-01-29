import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/inspection_list_screen/screen/inspection_list_screen.dart';
import 'package:public_housing/screens/properties_list_screen/screen/properties_list_screen.dart';
import 'package:public_housing/screens/select_work_screen/controller/select_work_controller.dart';

class SelectWorkScreen extends GetView<SelectWorkController> {
  const SelectWorkScreen({Key? key}) : super(key: key);

  static const routes = "/SelectWorkScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectWorkController>(
      init: SelectWorkController(),
      autoRemove: true,
      assignId: true,
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.white,
          child: SafeArea(
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    ImagePath.gilsonLogo,
                    height: Utils.isLandScapeMode(context) ? 70.px : 10.h,
                  ),
                ).paddingOnly(top: 24.px),
                Expanded(
                  child: ShadowContainer(
                          elevation: 2,
                          radius: 16.px,
                          padding: EdgeInsets.all(38.px),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(ImagePath.appLogo, height: 54.px),
                                  Image.asset(ImagePath.logo, height: 54.px),
                                ],
                              ),
                              MyTextView(
                                '${Strings.welcome}, ${controller.account?.userName ?? ""}',
                                isMaxLineWrap: true,
                                textStyleNew: MyTextStyle(
                                    textSize: 32.px,
                                    textFamily: fontFamilyFutuHvtext,
                                    textColor: controller.appColors.black,
                                    textWeight: FontWeight.w500),
                              ).paddingSymmetric(vertical: 48.px),
                              MyTextView(
                                Strings.workToday,
                                textStyleNew: MyTextStyle(
                                    textSize: 24.px,
                                    textFamily: fontFamilyFutuHvtext,
                                    textColor: controller.appColors.black,
                                    textWeight: FontWeight.w400),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CommonButton(
                                      title: Strings.section,
                                      textWeight: FontWeight.w500,
                                      textSize: 16.px,
                                      onTap: () {
                                        Get.offAllNamed(
                                            InspectionListScreen.routes);
                                      },
                                      width: 92.px,
                                      height: 44.px,
                                      color: AppColors.primerColor,
                                    ),
                                  ),
                                  SizedBox(width: 48.px),
                                  Expanded(
                                    child: CommonButton(
                                      title: Strings.publicHousing,
                                      textWeight: FontWeight.w500,
                                      textSize: 16.px,
                                      onTap: () {
                                        Get.offAllNamed(
                                            PropertiesListScreen.routes);
                                      },
                                      width: 92.px,
                                      height: 44.px,
                                      color: AppColors.primerColor,
                                    ),
                                  ),
                                ],
                              ).paddingOnly(top: 48.px, bottom: 56.px)
                            ],
                          ))
                      .marginSymmetric(
                          horizontal:
                              Utils.isMediumScreen(context) ? 16.h : 7.h,
                          vertical: 14.h),
                ),
                Image.asset(
                  ImagePath.loginScreen,
                  height: 20.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
