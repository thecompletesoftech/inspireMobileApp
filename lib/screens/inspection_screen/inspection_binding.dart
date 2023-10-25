import 'package:get/get.dart';

import 'inspection_controller.dart';

class InspectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InspectionController>(InspectionController());
  }
}
