import 'package:get/get.dart';

import 'areas_controller.dart';

class AreasBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AreasController>(AreasController());
  }
}
