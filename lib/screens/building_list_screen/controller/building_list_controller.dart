import 'package:public_housing/commons/all.dart';

class BuildingListController extends BaseController {
  bool isComplete = false;

  @override
  void onInit() {
    if (Get.arguments != null) {
      isComplete  =Get.arguments['isComplete'];
    }
    update();
    super.onInit();
  }
}
