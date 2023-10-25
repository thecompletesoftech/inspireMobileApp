import 'package:get/get.dart';

import 'propertydetails_controller.dart';

class PropertyDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PropertyDetailsController>(PropertyDetailsController());
  }
}
