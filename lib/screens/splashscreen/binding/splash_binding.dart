import 'package:get/get.dart';
import 'package:public_housing/screens/splashscreen/controller/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
