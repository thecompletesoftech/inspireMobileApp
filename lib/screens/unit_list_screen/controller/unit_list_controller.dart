import 'package:public_housing/commons/all.dart';

class UnitListController extends BaseController {
  bool isManually = false;
  bool isComplete = false;

  @override
  void onInit() {
    if (Get.arguments['isManually'] != null) {
      isManually = Get.arguments['isManually'];
    }
    if (Get.arguments['isComplete'] != null) {
      isComplete = Get.arguments['isComplete'];
    }
    super.onInit();
  }
}
