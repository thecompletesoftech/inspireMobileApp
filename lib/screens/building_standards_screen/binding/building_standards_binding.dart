import 'package:get/get.dart';
import 'package:public_housing/screens/building_standards_screen/controller/building_standards_controller.dart';

class BuildingStandardsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<BuildingStandardsController>(BuildingStandardsController());
  }
}
