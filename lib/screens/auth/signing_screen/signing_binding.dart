import 'package:get/get.dart';
import 'package:public_housing/screens/auth/signing_screen/signing_controller.dart';

class SigningBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SigningController>(SigningController());
  }
}
