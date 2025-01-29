import 'package:get/get.dart';
import 'package:public_housing/screens/no_show_screen/controller/no_show_controller.dart';

class NoShowBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NoShowController>(NoShowController());
  }
}
