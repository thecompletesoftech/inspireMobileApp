import 'package:get/get.dart';

import 'property_controller.dart';

class PropertyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PropertyController>(PropertyController());
  }
}
