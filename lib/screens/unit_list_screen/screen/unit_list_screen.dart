import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/unit_list_screen/controller/unit_list_controller.dart';
import 'package:public_housing/screens/unit_list_screen/widget/common_unit_list_container.dart';

class UnitListScreen extends GetView<UnitListController> {
  const UnitListScreen({Key? key}) : super(key: key);

  static const routes = "/UnitListScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnitListController>(
      init: UnitListController(),
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
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        MyTextView(
                          '${Strings.unit} | ',
                          textStyleNew: MyTextStyle(
                              textSize: 32.px,
                              textColor: AppColors.primerColor,
                              textWeight: FontWeight.w600),
                        ),
                        MyTextView(
                          'Building [Building Name]',
                          textStyleNew: MyTextStyle(
                              textSize: 24.px,
                              textColor: controller.appColors.textcolor,
                              textWeight: FontWeight.w400),
                        ),
                      ],
                    ).paddingOnly(
                        left: 32.px, right: 32.px, bottom: 32.px, top: 36.px),
                    CommonUnitListView(
                      title: 'Building [Building Name]',
                      Subtitle: '[Year Constructed]',
                    ).paddingSymmetric(horizontal: 32.px)
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
