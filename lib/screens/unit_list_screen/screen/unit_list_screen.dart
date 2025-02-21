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
                    //   Get.toNamed(
                    //     BuildingListScreen.routes,
                    //     arguments: {"isComplete": controller.isComplete},
                    //   );
                    // } else {
                    //   Get.back();
                    // }
                    Get.back();
                    controller.update();
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
                      'Building ${controller.externalBuilding.building?.name}',
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
                    itemCount: controller
                            .externalBuilding.scheduleInspectionUnits?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return CommonUnitListView(
                        isComplete: controller
                                    .externalBuilding
                                    .scheduleInspectionUnits?[index]
                                    .inspectionStatus
                                    ?.value ==
                                'Complete'
                            ? true
                            : false,
                        title:
                            'Unit ${controller.externalBuilding.scheduleInspectionUnits?[index].unit?.name ?? ""}',
                        Subtitle:
                            '${controller.externalBuilding.scheduleInspectionUnits?[index].unit?.address ?? ""}',
                        onTap: () {
                          if ('${DateFormat('yyyy-MM-dd').format(controller.propertyData.scheduleDate!)}' ==
                                  '${DateFormat('yyyy-MM-dd').format(DateTime.now())}' &&
                              controller
                                      .externalBuilding
                                      .scheduleInspectionUnits?[index]
                                      .inspectionStatus
                                      ?.value !=
                                  'Complete') {
                            Get.toNamed(
                              UnitInspection.routes,
                              arguments: {
                                "isManually": controller.isManually,
                                "propertyData": controller.propertyData,
                                "externalBuilding": controller.externalBuilding,
                                "unitsData": controller.externalBuilding
                                    .scheduleInspectionUnits?[index],
                                "deficiencyArea": [],
                                "buildingName":
                                    controller.externalBuilding.building?.name,
                                "buildingtype": controller.externalBuilding
                                    .building?.buildingType?.name,
                                "imagesList": [],
                                "inspectionName":
                                    controller.propertyData.property?.name,
                                "propertyInfo": controller.propertyInfo,
                                "buildingInfo": controller.buildingInfo,
                                "certificatesInfo": controller.certificatesInfo,
                                "inspectorName": controller.inspectorName,
                                "inspectorDate":
                                    controller.propertyData.scheduleDate!
                              },
                            );
                          }
                        },
                        dateTime: controller.propertyData.scheduleDate ??
                            DateTime.now(),
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
                //           controller.remainUnits.length ?? 0,
                //               (index) {
                //             return CommonUnitListView(
                //               title:
                //               'Building ${controller.externalBuilding.building?.name}',
                //               Subtitle:
                //               '${controller.externalBuilding.building?.constructedYear ?? 0}',
                //               onTap: () {
                //                 if ('${DateFormat('yyyy-MM-dd').format(controller.propertyData.scheduleDate!)}' ==
                //                     // '${DateFormat('yyyy-MM-dd').format(DateTime.now())}') {
                //                     '${DateFormat('yyyy-MM-dd').format(DateTime.parse('2025-01-16T00:00:00-05:00'))}') {
                //                   Get.toNamed(
                //                     UnitInspection.routes,
                //                     arguments: {
                //                       "isManually": false,
                //                       "propertyData": controller.propertyData,
                //                       "externalBuilding":
                //                       controller.externalBuilding,
                //                       "unitsData":
                //                       controller.remainUnits[index],
                //                       "deficiencyArea": [],
                //                       "buildingName": controller
                //                           .externalBuilding.building?.name,
                //                       "buildingtype": controller
                //                           .externalBuilding
                //                           .building
                //                           ?.buildingType
                //                           ?.name,
                //                       "imagesList": [],
                //                       "inspectionName": controller
                //                           .propertyData.property?.name,
                //                       "propertyInfo": controller.propertyInfo,
                //                       "buildingInfo": controller.buildingInfo,
                //                       "certificatesInfo":
                //                       controller.certificatesInfo,
                //                       "inspectorName": controller.inspectorName,
                //                       "inspectorDate":
                //                       controller.propertyData.scheduleDate!
                //                     },
                //                   );
                //                 }
                //               },
                //               dateTime: controller.propertyData.scheduleDate ??
                //                   DateTime.now(),
                //               isComplete: false,
                //             ).paddingSymmetric(
                //                 horizontal: 32.px, vertical: 5.px);
                //           },
                //         ),
                //         if (controller.completeUnits.isNotEmpty)
                //           Row(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               MyTextView(
                //                 Strings.completedUnits,
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
                //           controller.completeUnits.length ?? 0,
                //               (index) {
                //             return CommonUnitListView(
                //               title:
                //               'Building ${controller.externalBuilding.building?.name}',
                //               Subtitle:
                //               '${controller.externalBuilding.building?.constructedYear ?? 0}',
                //               onTap: () {
                //                 if ('${DateFormat('yyyy-MM-dd').format(controller.propertyData.scheduleDate!)}' ==
                //                     // '${DateFormat('yyyy-MM-dd').format(DateTime.now())}') {
                //                     '${DateFormat('yyyy-MM-dd').format(DateTime.parse('2025-01-16T00:00:00-05:00'))}') {
                //                   Get.toNamed(
                //                     UnitInspection.routes,
                //                     arguments: {
                //                       "isManually": false,
                //                       "propertyData": controller.propertyData,
                //                       "externalBuilding":
                //                       controller.externalBuilding,
                //                       "unitsData":
                //                       controller.completeUnits[index],
                //                       "deficiencyArea": [],
                //                       "buildingName": controller
                //                           .externalBuilding.building?.name,
                //                       "buildingtype": controller
                //                           .externalBuilding
                //                           .building
                //                           ?.buildingType
                //                           ?.name,
                //                       "imagesList": [],
                //                       "inspectionName": controller
                //                           .propertyData.property?.name,
                //                       "propertyInfo": controller.propertyInfo,
                //                       "buildingInfo": controller.buildingInfo,
                //                       "certificatesInfo":
                //                       controller.certificatesInfo,
                //                       "inspectorName": controller.inspectorName,
                //                       "inspectorDate":
                //                       controller.propertyData.scheduleDate!
                //                     },
                //                   );
                //                 }
                //               },
                //               dateTime: controller.propertyData.scheduleDate ??
                //                   DateTime.now(),
                //               isComplete: true,
                //             ).paddingSymmetric(
                //                 horizontal: 32.px, vertical: 5.px);
                //           },
                //         )
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
