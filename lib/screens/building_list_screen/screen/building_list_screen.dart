import 'package:intl/intl.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_inspection_screen/screen/building_inspection_screen.dart';
import 'package:public_housing/screens/building_list_screen/controller/building_list_controller.dart';
import 'package:public_housing/screens/building_list_screen/model/property_data_model.dart';
import 'package:public_housing/screens/building_list_screen/widget/common_building_list_container.dart';
import 'package:public_housing/screens/unit_list_screen/screen/unit_list_screen.dart';

class BuildingListScreen extends GetView<BuildingListController> {
  const BuildingListScreen({Key? key}) : super(key: key);

  static const routes = "/BuildingListScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildingListController>(
      init: BuildingListController(),
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
                Row(
                  children: [
                    MyTextView(
                      '${Strings.buildings} | ',
                      textStyleNew: MyTextStyle(
                          textSize: 32.px,
                          textColor: AppColors.primerColor,
                          textWeight: FontWeight.w600),
                    ),
                    MyTextView(
                      controller.scheduleDatum.property,
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
                    itemCount: controller.scheduleDatum.buildings?.length ?? 0,
                    itemBuilder: (context, index) {
                      var buildingsData =
                          controller.scheduleDatum.buildings?[index];

                      return CommonBuildingListView(
                        isToday: controller.isToday,
                        title: 'Building ${buildingsData?.buildingName}',
                        title1: '${buildingsData?.units?.length} Units',
                        Subtitle: '${buildingsData?.year}',
                        Subtitle1: '${buildingsData?.buildingType}',
                        date:
                            '${DateFormat('yyyy-MM-dd').format(controller.scheduleDatum.date!)}',
                        isCompleted: (buildingsData?.iscompleted ?? false),
                        onTap: () {
                          Get.toNamed(UnitListScreen.routes, arguments: {
                            "isManually": false,
                            "isComplete": true,
                            "unitsData": buildingsData?.units,
                            "date": controller.scheduleDatum.date,
                            "buildingName": buildingsData?.buildingName,
                            "isToday": controller.isToday
                          });
                        },
                        onTap1: controller.isToday == true
                            ? () {
                                Get.toNamed(BuildingInspectionScreen.routes,
                                    arguments: {
                                      "isManually": false,
                                      "buildingsData": buildingsData,
                                      "propertyDataModel": PropertyDataModel(
                                          id: controller.scheduleDatum.property,
                                          name: controller
                                              .scheduleDatum.propertyName,
                                          address: '',
                                          city: controller.scheduleDatum.city,
                                          state: controller.scheduleDatum.state,
                                          zip: controller.scheduleDatum.zip,
                                          date:
                                              '${DateFormat('yyyy-MM-dd').format(controller.scheduleDatum.date!)}'),
                                    });
                              }
                            : () {},
                      ).paddingSymmetric(horizontal: 32.px);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 24.px);
                    },
                  ).paddingOnly(bottom: 20.px),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
