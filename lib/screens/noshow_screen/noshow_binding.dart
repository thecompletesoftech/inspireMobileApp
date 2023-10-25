import 'package:get/get.dart';

import 'noshow_controller.dart';

class NoShowBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NoShowController>(NoShowController());
  }
}
