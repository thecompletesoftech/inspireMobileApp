import 'package:get/get.dart';
import 'package:public_housing/screens/properties_list_screen/controller/properties_list_controller.dart';

class PropertiesListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PropertiesListController>(PropertiesListController());
  }
}
