import 'package:get/get.dart';
import 'package:public_housing/screens/unit_list_screen/controller/unit_list_controller.dart';

class UnitListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UnitListController>(UnitListController());
  }
}
