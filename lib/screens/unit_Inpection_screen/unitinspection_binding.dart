import '../../commons/all.dart';
import 'unitinspection_controller.dart';

class UnitInspectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UnitController>(UnitController());
  }
}
