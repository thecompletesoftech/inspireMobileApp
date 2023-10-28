import 'package:get/get.dart';

import 'buildingdetails_controller.dart';

class BuildingDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<BuildingDetailsController>(BuildingDetailsController());
  }
}
