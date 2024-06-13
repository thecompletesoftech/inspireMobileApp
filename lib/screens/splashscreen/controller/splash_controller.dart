import 'dart:async';
import 'package:public_housing/screens/auth/signing_screen/screen/signing_screen.dart';
import 'package:public_housing/screens/properties_list_screen/screen/properties_list_screen.dart';
import '../../../commons/all.dart';

class SplashController extends BaseController {

  @override
  void onInit() {
    startTime();
    selectedLang = Constants.languageCodeEn;
    super.onInit();
  }

  startTime() async {
    Timer(const Duration(seconds: 3), navigationPage);
  }

  void navigationPage() async {
    if (getStorageData.containKey(getStorageData.isLogin)) {
      Get.offAllNamed(PropertiesListScreen.routes);
    } else {
      Get.offAllNamed(SigningScreen.routes);
    }
  }
}
