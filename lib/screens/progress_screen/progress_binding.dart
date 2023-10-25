import 'package:get/get.dart';

import 'progress_controller.dart';

class ProgressBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ProgressController>(ProgressController());
  }
}
