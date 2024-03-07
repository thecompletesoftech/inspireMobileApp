import '../../commons/all.dart';
import 'unitinspection_controller.dart';

class UnitInspectionSummaryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UnitInspectionSummaryController>(UnitInspectionSummaryController());
  }
}
