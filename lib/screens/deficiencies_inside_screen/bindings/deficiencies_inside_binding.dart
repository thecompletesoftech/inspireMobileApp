import 'package:get/get.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/controller/deficiencies_inside_controller.dart';

class DeficienciesInsideBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<DeficienciesInsideController>(DeficienciesInsideController());
  }
}
