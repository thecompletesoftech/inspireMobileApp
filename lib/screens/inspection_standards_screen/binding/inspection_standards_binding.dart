import 'package:get/get.dart';
import 'package:public_housing/screens/inspection_standards_screen/controller/inspection_standards_controller.dart';

class InspectionStandardsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InspectionStandardsController>(InspectionStandardsController());
  }
}
