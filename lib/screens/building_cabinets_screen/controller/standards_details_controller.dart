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
  List<DeficiencyInspectionsReqModel> deficiencyInspectionsReqModel = [];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      buildingName = Get.arguments['buildingName'];
      buildingDataModel = Get.arguments['deficiencyArea'];
      getSuccessList();
      Get.arguments['successListOfStandards'];

      Get.arguments['successListOfStandards'].forEach((e) {
        deficiencyInspectionsReqModel.add(DeficiencyInspectionsReqModel(
          isSuccess: e.isSuccess,
          comment: e.comment,
          date: e.date,
          deficiencyProofPictures: e.deficiencyProofPictures,
          housingDeficiencyId: e.housingDeficiencyId.toString(),
        ));
      });

      for (var i = 0; i < buildingDataModel.deficiencyAreaItems!.length; i++) {
        for (var j = 0; j < deficiencyInspectionsReqModel.length; j++) {
          if (buildingDataModel.deficiencyAreaItems![i].id.toString() ==
              deficiencyInspectionsReqModel[j].housingDeficiencyId.toString()) {
            int itemIndex = successListOfDeficiencies.indexWhere((element) =>
                element['housingDeficiencyId'].toString() ==
                deficiencyInspectionsReqModel[j]
                    .housingDeficiencyId
                    .toString());

            if (itemIndex != -1) {
              successListOfDeficiencies[itemIndex]['housingDeficiencyId'] =
                  deficiencyInspectionsReqModel[j].housingDeficiencyId;
              successListOfDeficiencies[itemIndex]['success'] =
                  deficiencyInspectionsReqModel[j].isSuccess;
              successListOfDeficiencies[itemIndex]['deficiencyProofPictures'] =
                  deficiencyInspectionsReqModel[j].deficiencyProofPictures;
              successListOfDeficiencies[itemIndex]['comment'] =
                  deficiencyInspectionsReqModel[j].comment;
              successListOfDeficiencies[itemIndex]['date'] =
                  deficiencyInspectionsReqModel[j].date;
            }
          }
        }
      }

      print("fkjhbkfdsj ${successListOfDeficiencies}");
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
