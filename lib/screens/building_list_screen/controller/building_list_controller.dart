import 'package:public_housing/commons/all.dart';

import '../../properties_list_screen/model/daily_schedules_res_model.dart';

class BuildingListController extends BaseController {
  bool isComplete = false;
  ScheduleDatum scheduleDatum = ScheduleDatum();
  bool isToday = false;

  @override
  void onInit() {
    if (Get.arguments != null) {
      isComplete = Get.arguments['isComplete'];
      scheduleDatum = Get.arguments['building'];
      isToday = Get.arguments['isToday'];
    }
    update();
    super.onInit();
  }
}
