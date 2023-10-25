import 'package:get/get.dart';

import 'text_message_controller.dart';

class TextMessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TextMessageController>(TextMessageController());
  }
}
