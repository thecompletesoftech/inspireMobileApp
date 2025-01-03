import 'package:intl/intl.dart';
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
                      'Building ${controller.externalBuilding.name}',
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
                    itemCount: controller.externalBuilding.units?.length ?? 0,
                    itemBuilder: (context, index) {
                      return CommonUnitListView(
                        title: 'Building ${controller.externalBuilding.name}',
                        Subtitle:
                            '${controller.externalBuilding.constructedYear ?? 0}',
                        onTap: () {
                          if ('${DateFormat('yyyy-MM-dd').format(controller.propertyData.date!)}' ==
                              '${DateFormat('yyyy-MM-dd').format(DateTime.now())}') {
                            Get.toNamed(
                              UnitInspection.routes,
                              arguments: {
                                "isManually": false,
                                "propertyData": controller.propertyData,
                                "externalBuilding": controller.externalBuilding,
                                "unitsData":
                                    controller.externalBuilding.units?[index]
                              },
                            );
                          }
                        },
                        dateTime:
                            controller.propertyData.date ?? DateTime.now(),
                      ).paddingSymmetric(horizontal: 32.px);
                    },
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
