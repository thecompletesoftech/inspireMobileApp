import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';

class StandardsDetailsController extends BaseController {
  String buildingName = '';
  DeficiencyArea buildingDataModel = DeficiencyArea();
  dynamic isSuccess;
  var imagesList;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      buildingName = Get.arguments['buildingName'];
      buildingDataModel = Get.arguments['deficiencyArea'];
    }
    update();
  }
}
