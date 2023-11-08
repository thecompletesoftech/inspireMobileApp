import 'package:get/get.dart';

import 'hs_ack_controller.dart';

class HSAckBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HSAckController>(HSAckController());
  }
}
