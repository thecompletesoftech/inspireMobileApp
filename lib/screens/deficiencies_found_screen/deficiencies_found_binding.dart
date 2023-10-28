import 'package:get/get.dart';

import 'deficiencies_found_controller.dart';

class DeficienciesFoundBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<DeficienciesFoundController>(DeficienciesFoundController());
  }
}
