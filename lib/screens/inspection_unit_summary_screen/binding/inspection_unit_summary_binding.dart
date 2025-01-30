import 'package:get/get.dart';
import 'package:public_housing/screens/inspection_unit_summary_screen/controller/inspection_unit_summary_controller.dart';

class InspectionUnitSummaryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InspectionUnitSummaryController>(InspectionUnitSummaryController());
  }
}
