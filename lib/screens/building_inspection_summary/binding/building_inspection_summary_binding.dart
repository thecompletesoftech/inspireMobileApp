import 'package:get/get.dart';
import 'package:public_housing/screens/building_inspection_summary/controller/building_inspection_summary_controller.dart';

class BuildingInspectionSummaryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<BuildingInspectionSummaryController>(
        BuildingInspectionSummaryController());
  }
}
