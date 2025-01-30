import 'package:get/get.dart';
import 'package:public_housing/screens/inspection_deficiencies_inside_screen/controller/inspection_deficiencies_inside_controller.dart';

class InspectionDeficienciesInsideBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InspectionDeficienciesInsideController>(InspectionDeficienciesInsideController());
  }
}
