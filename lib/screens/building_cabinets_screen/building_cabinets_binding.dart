import 'package:get/get.dart';
import 'package:public_housing/screens/building_cabinets_screen/building_cabinets_controller.dart';

class BuildingCabinetsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<BuildingCabinetsController>(BuildingCabinetsController());
  }
}
