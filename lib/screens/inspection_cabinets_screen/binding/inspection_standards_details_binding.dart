import 'package:get/get.dart';
import 'package:public_housing/screens/inspection_cabinets_screen/controller/inspection_standards_details_controller.dart';

class InspectionStandardsDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InspectionStandardsDetailsController>(
        InspectionStandardsDetailsController());
  }
}
