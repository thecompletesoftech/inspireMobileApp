import 'package:get/get.dart';
import 'package:public_housing/screens/manual_unit_inspection_screen/controller/manual_unit_inspection_controller.dart';

class ManualUnitInspectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ManualUnitInspectionController>(ManualUnitInspectionController());
  }
}
