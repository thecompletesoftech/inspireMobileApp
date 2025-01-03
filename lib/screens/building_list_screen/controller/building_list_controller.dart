import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart';

class BuildingListController extends BaseController {
  bool isComplete = false;
  List<ExternalBuilding> externalBuildings = [];
  ScheduleDatum propertyData = ScheduleDatum();

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
    }
    update();
    super.onInit();
  }
}
