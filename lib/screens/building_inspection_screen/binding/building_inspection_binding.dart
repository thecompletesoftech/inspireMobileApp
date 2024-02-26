import 'package:get/get.dart';
import 'package:public_housing/screens/building_inspection_screen/controller/building_inspection_controller.dart';

class BuildingInspectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<BuildingInspectionController>(BuildingInspectionController());
  }
}
