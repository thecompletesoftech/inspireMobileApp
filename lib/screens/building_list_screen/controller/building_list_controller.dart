import 'package:public_housing/commons/all.dart';

import '../../properties_list_screen/model/daily_schedules_res_model.dart';

class BuildingListController extends BaseController {
  bool isComplete = false;
  ScheduleDatum scheduleDatum = ScheduleDatum();
  List<BuildingsData> buildingList = <BuildingsData>[];
  List<BuildingsData> completedBuildingList = <BuildingsData>[];
  bool isToday = false;

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments['isComplete'] != null) {
        isComplete = Get.arguments['isComplete'];
      }
      if (Get.arguments['building'] != null) {
        scheduleDatum = Get.arguments['building'];
      }
      if (Get.arguments['isToday'] != null) {
        isToday = Get.arguments['isToday'];
      }
    }
    filterCompletedBuildingInspection();
    super.onInit();
  }

  void filterCompletedBuildingInspection() {
    buildingList.clear();
    completedBuildingList.clear();
    if (scheduleDatum.buildings?.isNotEmpty ?? false) {
      scheduleDatum.buildings?.forEach((buildingData) {
        if (buildingData.iscompleted == "Completed") {
          completedBuildingList.add(buildingData);
        } else {
          buildingList.add(buildingData);
        }
      });
    }
    update();
  }
}
