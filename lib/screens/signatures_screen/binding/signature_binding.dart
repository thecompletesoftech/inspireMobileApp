import 'package:get/get.dart';
import 'package:public_housing/screens/signatures_screen/controller/signature_controller.dart';

class SignatureBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SignatureController>(SignatureController());
  }
}
