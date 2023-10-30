import 'package:get/get.dart';

import 'building_exterior_controller.dart';

class BuildingExteriorBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<BuildingExteriorController>(BuildingExteriorController());
  }
}
