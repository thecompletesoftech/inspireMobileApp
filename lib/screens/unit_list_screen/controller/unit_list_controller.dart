import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart';

class UnitListController extends BaseController {
  bool isManually = false;
  bool isComplete = false;
  ExternalBuilding externalBuilding = ExternalBuilding();
  ScheduleDatum propertyData = ScheduleDatum();

  @override
  void onInit() {
    if (Get.arguments['isManually'] != null) {
      isManually = Get.arguments['isManually'];
    }
    if (Get.arguments['propertyData'] != null) {
      propertyData = Get.arguments['propertyData'];
    }
    if (Get.arguments['externalBuilding'] != null) {
      externalBuilding = Get.arguments['externalBuilding'];
    }
    if (Get.arguments['isComplete'] != null) {
      isComplete = Get.arguments['isComplete'];
    }
    super.onInit();
  }
}
