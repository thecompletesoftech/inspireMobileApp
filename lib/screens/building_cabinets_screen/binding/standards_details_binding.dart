import 'package:get/get.dart';
import 'package:public_housing/screens/building_cabinets_screen/controller/standards_details_controller.dart';

class StandardsDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<StandardsDetailsController>(StandardsDetailsController());
  }
}
