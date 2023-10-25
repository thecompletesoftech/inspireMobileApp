import 'package:get/get.dart';

import 'standard_controller.dart';

class StandardBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<StandardController>(StandardController());
  }
}
