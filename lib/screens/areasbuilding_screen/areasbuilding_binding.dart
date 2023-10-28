import 'package:get/get.dart';

import 'areasbuilding_controller.dart';

class AreasBuildingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AreasBuildingController>(AreasBuildingController());
  }
}
