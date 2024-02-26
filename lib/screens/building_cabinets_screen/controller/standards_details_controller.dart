import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';

class StandardsDetailsController extends BaseController {
  String buildingName = '';
  DeficiencyArea buildingDataModel = DeficiencyArea();
  dynamic isSuccess;
  var imagesList;
  var successlistofdeficiencies = [].obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      buildingName = Get.arguments['buildingName'];
      buildingDataModel = Get.arguments['deficiencyArea'];
      getsuccesslist();
    }
    update();
  }

  getsuccesslist() {
    for (var i = 0; i < buildingDataModel.deficiencyAreaItems!.length; i++) {
      successlistofdeficiencies.add({
        "id": buildingDataModel.deficiencyAreaItems![i].id,
        "success": false,
        "imagelist": []
      });
    }
  }

  Setsuccesdeficiencies(id, imagelist) {
    for (var j = 0; j < successlistofdeficiencies.length; j++) {
      if (successlistofdeficiencies[j]['id'].toString() == id.toString()) {
        successlistofdeficiencies[j]['success'] = true;
        successlistofdeficiencies[j]['imagelist'] = imagelist;
      }
    }
    update();
    print("succeslist" + successlistofdeficiencies.toString());
  }
}
