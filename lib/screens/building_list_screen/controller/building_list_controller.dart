import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart';

class BuildingListController extends BaseController {
  bool isComplete = false;
  List<ScheduleInspectionBuilding> externalBuildings = [];
  // List<ScheduleInspectionBuilding> completeBuildings = [];
  // List<ScheduleInspectionBuilding> remainBuildings = [];
  ScheduleInspection propertyData = ScheduleInspection();
  var propertyInfo = {}.obs;
  var buildingInfo = {}.obs;
  var certificatesInfo = {}.obs;

  @override
  void onInit() {
    if (Get.arguments['isComplete'] != null) {
      isComplete = Get.arguments['isComplete'];
    }
    if (Get.arguments['externalBuildingData'] != null) {
      externalBuildings = Get.arguments['externalBuildingData'];
    }
    if (Get.arguments['propertyData'] != null) {
      propertyData = Get.arguments['propertyData'];
      propertyInfo.addAll({
        "id": propertyData.property?.id,
        "name": propertyData.property?.name,
        "city": propertyData.property?.city,
        "state": propertyData.property?.state,
        "zip": propertyData.property?.zip,
        "address": propertyData.property?.address1
      });
    }
    // externalCompleteBuildings();
    update();
    super.onInit();
  }

  // externalCompleteBuildings() {
  //   externalBuildings.forEach(
  //     (element) {
  //       if (element.isBuildingInspection ?? false) {
  //         completeBuildings.add(element);
  //       } else {
  //         remainBuildings.add(element);
  //       }
  //     },
  //   );
  // }
}
