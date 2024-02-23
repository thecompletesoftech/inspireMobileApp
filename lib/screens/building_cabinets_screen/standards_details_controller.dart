import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_standards_screen/controller/building_standards_controller.dart';

class StandardsDetailsController extends BaseController {
  String buildingName = '';
  BuildingDataModel? buildingDataModel;
  dynamic isSuccess;
  var imagesList;

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
