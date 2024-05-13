import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_list_screen/screen/building_list_screen.dart';
import 'package:public_housing/screens/unit_inspection_screen/screen/unit_inspection_screen.dart';
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
                  onClickBack: () {
                    if (controller.isComplete) {
                      Get.toNamed(
                        BuildingListScreen.routes,
                        arguments: {"isComplete": controller.isComplete},
                      );
                    } else {
                      Get.back();
                    }
                  },
                ),
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
                Expanded(
                  child: ListView.separated(
                    itemCount: 5,
                    itemBuilder: (context, index) => CommonUnitListView(
                      title: 'Building [Building Name]',
                      Subtitle: '[Year Constructed]',
                      onTap: () {
                        Get.toNamed(
                          UnitInspection.routes,
                          arguments: {"isManually": false},
                        );
                      },
                    ).paddingSymmetric(horizontal: 32.px),
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 24.px);
                    },
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
