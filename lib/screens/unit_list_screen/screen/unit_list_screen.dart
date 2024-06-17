import 'package:intl/intl.dart';
import 'package:public_housing/commons/all.dart';
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
                Row(
                  children: [
                    MyTextView(
                      '${Strings.unit}s | ',
                      textStyleNew: MyTextStyle(
                          textSize: 32.px,
                          textColor: AppColors.primerColor,
                          textWeight: FontWeight.w600),
                    ),
                    MyTextView(
                      '${Strings.building} ${controller.buildingName}',
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
                    itemCount: controller.unitsData.length,
                    itemBuilder: (context, index) {
                      var unitsData = controller.unitsData[index];
                      return CommonUnitListView(
                        isToday: controller.isToday,
                        title: '${Strings.unit} ${unitsData.unitName}',
                        isComplete: (unitsData.iscompleted ?? false),
                        Subtitle: '[Unit Address]',
                        date:
                            '${DateFormat('yyyy-MM-dd').format(controller.date!)}',
                        onTap: controller.isToday == true
                            ? () {
                                Get.toNamed(
                                  UnitInspection.routes,
                                  arguments: {"isManually": false},
                                );
                              }
                            : () {},
                      ).paddingSymmetric(horizontal: 32.px);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 24.px);
                    },
                  ).paddingOnly(bottom: 20.px),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
