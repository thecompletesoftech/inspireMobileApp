import 'package:intl/intl.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_inspection_screen/screen/building_inspection_screen.dart';
import 'package:public_housing/screens/building_list_screen/controller/building_list_controller.dart';
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
                    // if (controller.isComplete) {
                    //   Get.toNamed(PropertiesListScreen.routes);
                    // } else {
                    // }
                    Get.back();
                    controller.update();
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
                      controller.propertyData.property?.name,
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
                    itemCount: controller.externalBuildings.length,
                    itemBuilder: (context, index) {
                      return CommonBuildingListView(
                        isComplete: controller.externalBuildings[index]
                                .inspectionStatus?.value !=
                            'Pending',
                        title:
                            "Building ${controller.externalBuildings[index].building?.name ?? ""}",
                        title1:
                            '${controller.externalBuildings[index].scheduleInspectionUnits?.length ?? ""} Units',
                        subTitle:
                            '${controller.externalBuildings[index].building?.constructedYear ?? ""}',
                        subTitle1:
                            '${controller.externalBuildings[index].building?.buildingType?.name ?? ""}',
                        onTap: () {
                          Get.toNamed(UnitListScreen.routes, arguments: {
                            "isManually": false,
                            "isComplete": true,
                            'externalBuilding':
                                controller.externalBuildings[index],
                            "propertyData": controller.propertyData,
                          });
                          controller.update();
                        },
                        dateTime: controller.propertyData.scheduleDate ??
                            DateTime.now(),
                        onTap1: () {
                          if ('${DateFormat('yyyy-MM-dd').format(controller.propertyData.scheduleDate!)}' ==
                                  '${DateFormat('yyyy-MM-dd').format(DateTime.now())}' &&
                              controller.externalBuildings[index]
                                      .inspectionStatus?.value ==
                                  'Pending') {
                            // '${DateFormat('yyyy-MM-dd').format(DateTime.parse('2025-01-16T00:00:00-05:00'))}') {
                            Get.toNamed(
                              BuildingInspectionScreen.routes,
                              arguments: {
                                "isManually": false,
                                'externalBuilding':
                                    controller.externalBuildings[index],
                                "propertyData": controller.propertyData,
                                "buildingId":
                                    controller.externalBuildings[index].id
                              },
                            );
                            controller.update();
                          }
                        },
                      ).paddingSymmetric(horizontal: 32.px);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 24.px);
                    },
                  ),
                ),
                // Expanded(
                //   child: SingleChildScrollView(
                //     child: Column(
                //       children: [
                //         ...List.generate(
                //           controller.remainBuildings.length,
                //               (index) {
                //             return CommonBuildingListView(
                //               isComplete: false,
                //               title:
                //               'Building ${controller.remainBuildings[index].building?.name ?? ""}',
                //               title1:
                //               '${controller.remainBuildings[index].scheduleInspectionUnits?.length ?? ""} Units',
                //               Subtitle:
                //               '${controller.remainBuildings[index].building?.constructedYear ?? ""}',
                //               Subtitle1:
                //               '${controller.remainBuildings[index].building?.buildingType?.name ?? ""}',
                //               onTap: () {
                //                 Get.toNamed(UnitListScreen.routes, arguments: {
                //                   "isManually": false,
                //                   "isComplete": true,
                //                   'externalBuilding':
                //                   controller.remainBuildings[index],
                //                   "propertyData": controller.propertyData,
                //                 });
                //                 controller.update();
                //               },
                //               dateTime: controller.propertyData.scheduleDate ??
                //                   DateTime.now(),
                //               onTap1: () {
                //                 if ('${DateFormat('yyyy-MM-dd').format(controller.propertyData.scheduleDate!)}' ==
                //                     // '${DateFormat('yyyy-MM-dd').format(DateTime.now())}') {
                //                     '${DateFormat('yyyy-MM-dd').format(DateTime.parse('2025-01-16T00:00:00-05:00'))}') {
                //                   Get.toNamed(
                //                     BuildingInspectionScreen.routes,
                //                     arguments: {
                //                       "isManually": false,
                //                       'externalBuilding':
                //                       controller.remainBuildings[index],
                //                       "propertyData": controller.propertyData,
                //                     },
                //                   );
                //                   controller.update();
                //                 }
                //               },
                //             ).paddingSymmetric(
                //                 horizontal: 32.px, vertical: 5.px);
                //           },
                //         ),
                //         if (controller.completeBuildings.isNotEmpty)
                //           Row(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               MyTextView(
                //                 Strings.completedBuildings,
                //                 textStyleNew: MyTextStyle(
                //                     textSize: 24.px,
                //                     textColor: AppColors().black,
                //                     textWeight: FontWeight.w400),
                //               ).paddingOnly(right: 10.px),
                //               Expanded(
                //                 child: Divider(
                //                   height: 10.px,
                //                   color: AppColors().divider,
                //                 ),
                //               ),
                //             ],
                //           ).paddingSymmetric(
                //               vertical: 31.px, horizontal: 32.px),
                //         ...List.generate(
                //           controller.completeBuildings.length,
                //               (index) {
                //             return CommonBuildingListView(
                //               isComplete: true,
                //               title:
                //               'Building ${controller.completeBuildings[index].building?.name ?? ""}',
                //               title1:
                //               '${controller.completeBuildings[index].scheduleInspectionUnits?.length ?? ""} Units',
                //               Subtitle:
                //               '${controller.completeBuildings[index].building?.constructedYear ?? ""}',
                //               Subtitle1:
                //               '${controller.completeBuildings[index].building?.buildingType?.name ?? ""}',
                //               onTap: () {
                //                 Get.toNamed(UnitListScreen.routes, arguments: {
                //                   "isManually": false,
                //                   "isComplete": true,
                //                   'externalBuilding':
                //                   controller.completeBuildings[index],
                //                   "propertyData": controller.propertyData,
                //                 });
                //                 controller.update();
                //               },
                //               dateTime: controller.propertyData.scheduleDate ??
                //                   DateTime.now(),
                //               onTap1: () {
                //                 if ('${DateFormat('yyyy-MM-dd').format(controller.propertyData.scheduleDate!)}' ==
                //                     // '${DateFormat('yyyy-MM-dd').format(DateTime.now())}') {
                //                     '${DateFormat('yyyy-MM-dd').format(DateTime.parse('2025-01-16T00:00:00-05:00'))}') {
                //                   controller.buildingInfo.addAll({
                //                     "id":
                //                     controller.completeBuildings[index].id,
                //                     "name": controller.completeBuildings[index]
                //                         .building?.name,
                //                     "constructed_year": controller
                //                         .completeBuildings[index]
                //                         .building
                //                         ?.constructedYear,
                //                     "building_type_id": controller
                //                         .completeBuildings[index]
                //                         .building
                //                         ?.buildingType
                //                         ?.id
                //                   });
                //                   Get.toNamed(BuildingStandardsScreen.routes,
                //                       arguments: {
                //                         "isManually": false,
                //                         "buildingName": controller
                //                             .completeBuildings[index]
                //                             .building
                //                             ?.name,
                //                         "propertyInfo": controller.propertyInfo,
                //                         "buildingInfo": controller.buildingInfo,
                //                         "buildingtype": controller
                //                             .completeBuildings[index]
                //                             .building
                //                             ?.buildingType
                //                             ?.name,
                //                         "certificatesInfo":
                //                         controller.certificatesInfo,
                //                         "inspectorName": controller
                //                             .propertyData.inspector?.name,
                //                         "inspectorDate": controller
                //                             .propertyData.scheduleDate
                //                             .toString()
                //                       });
                //                   controller.update();
                //                 }
                //               },
                //             ).paddingSymmetric(
                //                 horizontal: 32.px, vertical: 5.px);
                //           },
                //         ),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        );
      },
    );
  }
}
