import 'package:get/get.dart';

import 'inspection_summary_controller.dart';

class InspectionSummaryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InspectionSummaryController>(InspectionSummaryController());
  }
}
