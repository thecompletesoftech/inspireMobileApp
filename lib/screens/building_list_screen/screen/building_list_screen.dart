import 'package:intl/intl.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/unit_list_screen/screen/unit_list_screen.dart';
import 'package:public_housing/screens/building_list_screen/model/property_data_model.dart';
import 'package:public_housing/screens/building_list_screen/controller/building_list_controller.dart';
import 'package:public_housing/screens/building_list_screen/widget/common_building_list_container.dart';
import 'package:public_housing/screens/building_inspection_screen/screen/building_inspection_screen.dart';

import '../../building_standards_screen/screen/building_standards_screen.dart';

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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        controller.buildingList.isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.buildingList.length,
                                itemBuilder: (context, index) {
                                  var buildingsData =
                                      controller.buildingList[index];
                                  return CommonBuildingListView(
                                    isToday: controller.isToday,
                                    title:
                                        'Building ${buildingsData.buildingName}',
                                    title1:
                                        '${buildingsData.units?.length} Units',
                                    Subtitle: '${buildingsData.year}',
                                    Subtitle1: '${buildingsData.buildingType}',
                                    date:
                                        '${DateFormat('yyyy-MM-dd').format(controller.scheduleDatum.date!)}',
                                    isCompleted: (buildingsData.iscompleted ??
                                        'Completed'),
                                    onTap: () {
                                      Get.toNamed(UnitListScreen.routes,
                                          arguments: {
                                            "isManually": false,
                                            "isComplete": true,
                                            "unitsData": buildingsData.units,
                                            "date":
                                                controller.scheduleDatum.date,
                                            "buildingsData": buildingsData,
                                            "isToday": controller.isToday,
                                            "propertyData":
                                                controller.scheduleDatum,
                                          });
                                    },
                                    onTap1: controller.isToday == true
                                        ? () {
                                            Get.toNamed(
                                                BuildingInspectionScreen.routes,
                                                arguments: {
                                                  "isManually": false,
                                                  "buildingsData":
                                                      buildingsData,
                                                  "propertyDataModel":
                                                      PropertyDataModel(
                                                          id: controller
                                                              .scheduleDatum
                                                              .property,
                                                          name: controller
                                                              .scheduleDatum
                                                              .propertyName,
                                                          address: '',
                                                          city: controller
                                                              .scheduleDatum
                                                              .city,
                                                          state: controller
                                                              .scheduleDatum
                                                              .state,
                                                          zip: controller
                                                              .scheduleDatum
                                                              .zip,
                                                          date:
                                                              '${DateFormat('yyyy-MM-dd').format(controller.scheduleDatum.date!)}'),
                                                });
                                          }
                                        : () {},
                                  ).paddingSymmetric(horizontal: 32.px);
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(height: 24.px);
                                },
                              )
                            : SizedBox.shrink(),
                        controller.completedBuildingList.isNotEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 16.px,
                                  ),
                                  Row(
                                    children: [
                                      MyTextView(
                                        Strings.completedBuildings,
                                        textStyleNew: MyTextStyle(
                                          textColor: controller.appColors.black,
                                          textWeight: FontWeight.w400,
                                          textFamily: fontFamilyBold,
                                          textSize: 24.px,
                                        ),
                                      ).paddingOnly(right: 10.px),
                                      Expanded(
                                        child: Container(
                                          height: 2.px,
                                          color: AppColors().divider,
                                        ),
                                      ),
                                    ],
                                  ).paddingSymmetric(horizontal: 32.px),
                                  SizedBox(
                                    height: 16.px,
                                  ),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        controller.completedBuildingList.length,
                                    itemBuilder: (context, index) {
                                      var buildingsData = controller
                                          .completedBuildingList[index];

                                      return CommonBuildingListView(
                                        isToday: controller.isToday,
                                        title:
                                            'Building ${buildingsData.buildingName}',
                                        title1:
                                            '${buildingsData.units?.length} Units',
                                        Subtitle: '${buildingsData.year}',
                                        Subtitle1:
                                            '${buildingsData.buildingType}',
                                        date:
                                            '${DateFormat('yyyy-MM-dd').format(controller.scheduleDatum.date!)}',
                                        isCompleted:
                                            (buildingsData.iscompleted ??
                                                'Completed'),
                                        onTap: () {
                                          Get.toNamed(UnitListScreen.routes,
                                              arguments: {
                                                "isManually": false,
                                                "isComplete": true,
                                                "unitsData":
                                                    buildingsData.units,
                                                "date": controller
                                                    .scheduleDatum.date,
                                                "buildingsData": buildingsData,
                                                "isToday": controller.isToday,
                                                "propertyData":
                                                    controller.scheduleDatum,
                                              });
                                        },
                                        onTap1: controller.isToday == true
                                            ? () {
                                                Get.toNamed(
                                                    BuildingStandardsScreen
                                                        .routes,
                                                    arguments: {
                                                      "buildingInspectionDataModelList":
                                                          buildingsData
                                                              .buildingInspectionDataModelList,
                                                      "isManually": false,
                                                      "buildingsData":
                                                          buildingsData,
                                                      "buildingName":
                                                          buildingsData
                                                              .buildingName,
                                                      "propertyName": controller
                                                          .scheduleDatum
                                                          .propertyName,
                                                      "propertyDataModel": PropertyDataModel(
                                                          id: controller
                                                              .scheduleDatum
                                                              .property,
                                                          name: controller
                                                              .scheduleDatum
                                                              .propertyName,
                                                          address: controller
                                                              .scheduleDatum
                                                              .propertyAddress,
                                                          city: controller
                                                              .scheduleDatum
                                                              .city,
                                                          state: controller
                                                              .scheduleDatum
                                                              .state,
                                                          zip: controller
                                                              .scheduleDatum
                                                              .zip,
                                                          date:
                                                              '${DateFormat('yyyy-MM-dd').format(controller.scheduleDatum.date!)}'),
                                                      "certificatesInfo":
                                                          buildingsData
                                                              .certificateList,
                                                    });
                                              }
                                            : () {},
                                      ).paddingSymmetric(horizontal: 32.px);
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(height: 24.px);
                                    },
                                  ).paddingOnly(bottom: 20.px),
                                ],
                              )
                            : SizedBox(
                                height: 20.px,
                              ),
                      ],
                    ),
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
