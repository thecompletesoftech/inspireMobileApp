import 'package:get/get.dart';
import 'package:public_housing/screens/unit_building_standards_screen/controller/unit_building_standards_controller.dart';

class UnitBuildingStandardsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UnitBuildingStandardsController>(UnitBuildingStandardsController());
  }
}
