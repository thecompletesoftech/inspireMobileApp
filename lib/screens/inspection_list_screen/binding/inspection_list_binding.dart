import 'package:get/get.dart';
import 'package:public_housing/screens/inspection_list_screen/controller/inspection_list_controller.dart';

class InspectionListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InspectionListController>(InspectionListController());
  }
}
