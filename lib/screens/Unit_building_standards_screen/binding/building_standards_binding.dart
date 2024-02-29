import 'package:get/get.dart';
import 'package:public_housing/screens/Unit_building_standards_screen/controller/building_standards_controller.dart';

class UnitBuildingStandardsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UnitBuildingStandardsController>(UnitBuildingStandardsController());
  }
}
