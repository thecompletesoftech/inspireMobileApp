import 'package:get/get.dart';

import 'certificates_controller.dart';

class CertificatesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CertificatesController>(CertificatesController());
  }
}
