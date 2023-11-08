import 'package:get/get.dart';

import 'authority_signature_controller.dart';

class AuthoritySignatureBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthoritySignatureController>(AuthoritySignatureController());
  }
}
