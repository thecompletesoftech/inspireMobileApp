import 'package:get/get.dart';

import 'buildings_controller.dart';

class BuildingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<BuildingsController>(BuildingsController());
  }
}
