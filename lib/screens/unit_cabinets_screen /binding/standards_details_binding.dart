import 'package:get/get.dart';
import '../controller/standards_details_controller.dart';

class UnitStandardsDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UnitStandardsDetailsController>(UnitStandardsDetailsController());
  }
}
