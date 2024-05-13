import 'dart:async';

import 'package:public_housing/screens/auth/signing_screen/screen/signing_screen.dart';
import 'package:public_housing/screens/building_inspection_screen/screen/building_inspection_screen.dart';
import 'package:public_housing/screens/properties_list_screen/screen/properties_list_screen.dart';
import 'package:public_housing/screens/select_work_screen/screen/select_work_screen.dart';

import '../../../commons/all.dart';
import '../../property_screen/property_screen.dart';

class SplashController extends BaseController {
  startTime() async {
    Timer(const Duration(seconds: 3), navigationPage);
  }

  void navigationPage() async {
    // utils.getAddressFromLatLng();

    if (getStorageData.containKey(getStorageData.isLogin)) {
      // LoginModel model = LoginModel.fromJson(getStorageData.readObject(getStorageData.loginData));
      // if (model.responseCode == 1) {
      //   if (model.data!.userType == Constants.owner) {
      //     Constants.userOrOwner = true;
      //   } else {
      //     Constants.userOrOwner = false;
      //   }
      //   Get.offAndToNamed(BottomScreen.routes);
      // } else {
      //   Get.offAllNamed(ChooseLanguageScreen.routes);
      // }
      // Get.offAllNamed(SelectWorkScreen.routes);
      Get.offAllNamed(PropertiesListScreen.routes);

      // Get.offAllNamed(BuildingInspectionScreen.routes);
    } else {
      Get.offAllNamed(SigningScreen.routes);
    }
    // Get.offAllNamed(SigningScreen.routes);
  }

  @override
  void onInit() {
    startTime();
    selectedLang = Constants.languageCodeEn;

    printAction("Language -=-=--> $selectedLang");
    super.onInit();
  }
}
