import 'package:get/get.dart';

import 'kitchen_controller.dart';

class ItemDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<KitchenController>(KitchenController());
  }
}
