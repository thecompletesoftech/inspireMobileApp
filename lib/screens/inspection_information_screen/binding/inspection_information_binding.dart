import 'package:get/get.dart';
import 'package:public_housing/screens/inspection_information_screen/controller/inspection_information_controller.dart';

class InspectionInformationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InspectionInformationController>(InspectionInformationController());
  }
}
