import 'package:get/get.dart';
import 'package:public_housing/screens/special_amenities_screen/controller/special_amenities_controller.dart';

class SpecialAmenitiesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SpecialAmenitiesController>(SpecialAmenitiesController());
  }
}
