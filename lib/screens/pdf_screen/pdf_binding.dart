import 'package:get/get.dart';

import 'pdf_controller.dart';

class PdfBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PdfController>(PdfController());
  }
}
