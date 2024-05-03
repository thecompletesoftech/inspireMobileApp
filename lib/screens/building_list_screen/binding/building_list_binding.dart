import 'package:get/get.dart';
import 'package:public_housing/screens/building_list_screen/controller/building_list_controller.dart';

class BuildingListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<BuildingListController>(BuildingListController());
  }
}
