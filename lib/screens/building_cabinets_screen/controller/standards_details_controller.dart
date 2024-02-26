import 'package:get_storage/get_storage.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/models/deficiency_inspections_req_model.dart';

class StandardsDetailsController extends BaseController {
  String buildingName = '';
  DeficiencyArea buildingDataModel = DeficiencyArea();
  dynamic isSuccess;
  var imagesList;
  var successListOfDeficiencies = [].obs;
  var data = [].obs;

  @override
  void dispose() {
    // TODO: implement dispose
    // super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      buildingName = Get.arguments['buildingName'];
      buildingDataModel = Get.arguments['deficiencyArea'];
      if (Get.arguments['successListOfStandards'].value != 0) {
        data.addAll(Get.arguments['successListOfStandards'].value);
        successListOfDeficiencies.forEach((element) {
          if (element['housingDeficiencyId'] ==
              Get.arguments['successListOfStandards']['housingDeficiencyId']) {
            successListOfDeficiencies[
                    successListOfDeficiencies.indexOf(element)]['success'] =
                Get.arguments['successListOfStandards']['success'];

            successListOfDeficiencies[successListOfDeficiencies
                    .indexOf(element)]['housingDeficiencyId'] =
                Get.arguments['successListOfStandards']['housingDeficiencyId'];

            successListOfDeficiencies[successListOfDeficiencies
                    .indexOf(element)]['deficiencyProofPictures'] =
                Get.arguments['successListOfStandards']
                    ['deficiencyProofPictures'];

            successListOfDeficiencies[
                    successListOfDeficiencies.indexOf(element)]['comment'] =
                Get.arguments['successListOfStandards']['comment'];

            successListOfDeficiencies[
                    successListOfDeficiencies.indexOf(element)]['date'] =
                Get.arguments['successListOfStandards']['date'];
          }
        });
      }
      if (Get.arguments['successListOfStandards'].value != 0) {
        getSuccessList();
      }
    }
    update();
  }

  getSuccessList() {
    for (var i = 0; i < buildingDataModel.deficiencyAreaItems!.length; i++) {
      successListOfDeficiencies.add({
        "housingDeficiencyId": buildingDataModel.deficiencyAreaItems![i].id,
        "success": false,
        "deficiencyProofPictures": <String>[],
        "comment": '',
        'date': '',
      });
    }
  }

  Setsuccesdeficiencies(id, imagelist) {
    for (var j = 0; j < successListOfDeficiencies.length; j++) {
      if (successListOfDeficiencies[j]['id'].toString() == id.toString()) {
        successListOfDeficiencies[j]['success'] = true;
        successListOfDeficiencies[j]['imagelist'] = imagelist;
      }
    }
    update();
    print("succeslist" + successListOfDeficiencies.toString());
  }

  setSuccessDeficiencies(
      List<DeficiencyInspectionsReqModel> deficiencyInspectionsReqModel) {
    successListOfDeficiencies.forEach((element) {
      deficiencyInspectionsReqModel.forEach((element1) {
        if (element['housingDeficiencyId'].toString() ==
            element1.housingDeficiencyId) {
          successListOfDeficiencies[successListOfDeficiencies.indexOf(element)]
              ['success'] = true;
          successListOfDeficiencies[successListOfDeficiencies.indexOf(element)]
              ['deficiencyProofPictures'] = element1.deficiencyProofPictures;
          successListOfDeficiencies[successListOfDeficiencies.indexOf(element)]
              ['comment'] = element1.comment;
          successListOfDeficiencies[successListOfDeficiencies.indexOf(element)]
              ['date'] = element1.date;
        }
      });
    });

    update();
    print("succeslist" + successListOfDeficiencies.toString());
  }
}
