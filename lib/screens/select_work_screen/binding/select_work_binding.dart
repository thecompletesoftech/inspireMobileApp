import 'package:get/get.dart';
import 'package:public_housing/screens/select_work_screen/controller/select_work_controller.dart';

class SelectWorkBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SelectWorkController>(SelectWorkController());
  }
}
