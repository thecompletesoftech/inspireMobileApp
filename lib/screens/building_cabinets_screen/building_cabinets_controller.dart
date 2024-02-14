import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_standards_screen/building_standards_controller.dart';

class BuildingCabinetsController extends BaseController {
  String buildingName = '';
  BuildingDataModel? buildingDataModel;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      buildingName = Get.arguments['buildingName'];
      buildingDataModel = Get.arguments['buildingDataList'];
    }
    update();
  }
}
