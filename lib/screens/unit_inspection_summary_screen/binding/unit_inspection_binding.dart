import '../../../commons/all.dart';
import '../controller/unit_inspection_controller.dart';

class UnitInspectionSummaryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UnitInspectionSummaryController>(UnitInspectionSummaryController());
  }
}
