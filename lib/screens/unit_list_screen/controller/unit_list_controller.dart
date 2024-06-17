import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart';

class UnitListController extends BaseController {
  bool isManually = false;
  bool isComplete = false;
  List<UnitsData> unitsData = [];
  DateTime? date;
  String? buildingName;
  bool isToday = false;

  @override
  void onInit() {
    unitsData = [];
    if (Get.arguments['isManually'] != null) {
      isManually = Get.arguments['isManually'];

      if (Get.arguments['isComplete'] != null) {
        isComplete = Get.arguments['isComplete'];
      }
      if (Get.arguments['unitsData'] != null) {
        unitsData = Get.arguments['unitsData'];
      }
      if (Get.arguments['date'] != null) {
        date = Get.arguments['date'];
      }
      if (Get.arguments['buildingName'] != null) {
        buildingName = Get.arguments['buildingName'];
      }
      if (Get.arguments['isToday'] != null) {
        isToday = Get.arguments['isToday'];
      }
      update();
      super.onInit();
    }
  }
}
