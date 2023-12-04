import '../commons/all.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loading {
  AppColors appColors = AppColors();
  Loading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..contentPadding = const EdgeInsets.all(18)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 40.0
      ..lineWidth = 2
      ..radius = 15
      ..progressColor = AppColors().white
      ..backgroundColor = AppColors().appColor.withOpacity(.3)
      ..indicatorColor = AppColors().white
      ..textColor = AppColors().white
      ..maskColor = AppColors().black.withOpacity(0.4)
      ..maskType = EasyLoadingMaskType.custom
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  static void show([String? text]) {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show();
  }

  static void toast(String text) {
    EasyLoading.showToast(text);
  }

  static void dismiss() {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.dismiss();
  }
}
