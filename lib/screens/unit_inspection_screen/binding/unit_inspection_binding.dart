import '../../../commons/all.dart';
import '../controller/unit_inspection_controller.dart';

class UnitInspectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UnitController>(UnitController());
  }
}
