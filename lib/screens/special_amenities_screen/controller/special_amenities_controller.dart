import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';

class SpecialAmenitiesController extends BaseController {
  List<DeficiencyArea> deficiencyArea = [];

  @override
  void onInit() {
    deficiencyArea = [];
    if (Get.arguments != null) {
      deficiencyArea = Get.arguments['deficiencyArea'];
    }
    super.onInit();
  }
}
