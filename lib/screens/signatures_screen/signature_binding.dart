import 'package:get/get.dart';

import 'signature_controller.dart';

class SignatureBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SignatureController>(SignatureController());
  }
}
