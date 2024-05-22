import 'package:get/get.dart';
import 'package:public_housing/screens/unit_deficiencies_inside_screen/controller/deficiencies_inside_controller.dart';

class UntiDeficienciesInsideBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UnitDeficienciesInsideController>(
        UnitDeficienciesInsideController());
  }
}
