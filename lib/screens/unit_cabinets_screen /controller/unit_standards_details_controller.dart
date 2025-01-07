import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/models/deficiency_inspections_req_model.dart';

class UnitStandardsDetailsController extends BaseController {
  String buildingName = '';
  DeficiencyArea buildingDataModel = DeficiencyArea();
  dynamic isSuccess;
  var imagesList;
  var successListOfDeficiencies = [].obs;
  List<DeficiencyInspectionsReqModel> deficiencyInspectionsReqModel = [];
  List<String> nameList = [];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      buildingName = Get.arguments['buildingName'] ?? "";
      buildingDataModel = Get.arguments['deficiencyArea'];
      getSuccessList();
      deficiencyInspectionsReqModel = [];
      Get.arguments['successListOfStandards'];

      Get.arguments['successListOfStandards'].forEach((e) {
        deficiencyInspectionsReqModel.add(DeficiencyInspectionsReqModel(
            isSuccess: e.isSuccess,
            comment: e.comment,
            date: e.date,
            deficiencyProofPictures: e.deficiencyProofPictures,
            definition: e.definition.toString(),
            housingDeficiencyId: e.housingDeficiencyId.toString(),
            criteria: e.criteria,
            deficiencyItemHousingDeficiency:
                e.deficiencyItemHousingDeficiency));
      });

      if (buildingDataModel.deficiencyInspectionsReqModel != null) {
        for (var i = 0;
            i < buildingDataModel.deficiencyInspectionsReqModel!.length;
            i++) {
          for (var j = 0; j < deficiencyInspectionsReqModel.length; j++) {
            if (buildingDataModel.deficiencyInspectionsReqModel![i]
                    .deficiencyItemHousingDeficiency?.id
                    .toString() ==
                deficiencyInspectionsReqModel[j]
                    .deficiencyItemHousingDeficiency
                    ?.id
                    .toString()) {
              int itemIndex = successListOfDeficiencies.indexWhere((element) =>
                  element.deficiencyItemHousingDeficiency!.id.toString() ==
                  deficiencyInspectionsReqModel[j]
                      .deficiencyItemHousingDeficiency!
                      .id
                      .toString());

              if (itemIndex != -1) {
                successListOfDeficiencies[itemIndex].housingDeficiencyId =
                    deficiencyInspectionsReqModel[j].housingDeficiencyId;
                successListOfDeficiencies[itemIndex].isSuccess =
                    deficiencyInspectionsReqModel[j].isSuccess;
                successListOfDeficiencies[itemIndex].deficiencyProofPictures =
                    deficiencyInspectionsReqModel[j].deficiencyProofPictures;
                successListOfDeficiencies[itemIndex].comment =
                    deficiencyInspectionsReqModel[j].comment;
                successListOfDeficiencies[itemIndex].date =
                    deficiencyInspectionsReqModel[j].date;
                successListOfDeficiencies[itemIndex].definition =
                    deficiencyInspectionsReqModel[j].definition;
                successListOfDeficiencies[itemIndex]
                        .deficiencyItemHousingDeficiency =
                    deficiencyInspectionsReqModel[j]
                        .deficiencyItemHousingDeficiency;
                successListOfDeficiencies[itemIndex].criteria =
                    deficiencyInspectionsReqModel[j].criteria;
              }
            }
          }
        }
      }
      print("successListOfDeficiencies-------> ${successListOfDeficiencies}");
    }
    update();
  }

  getSuccessList() {
    for (var i = 0; i < buildingDataModel.deficiencyAreaItems!.length; i++) {
      DeficiencyItemHousingDeficiency deficiencyItemHousingDeficiency =
          DeficiencyItemHousingDeficiency();

      for (var j = 0;
          j <
              buildingDataModel.deficiencyAreaItems![i]
                  .deficiencyItemHousingDeficiency!.length;
          j++) {
        deficiencyItemHousingDeficiency = buildingDataModel
            .deficiencyAreaItems![i].deficiencyItemHousingDeficiency![j];

        successListOfDeficiencies.add(
          DeficiencyInspectionsReqModel(
              deficiencyItemHousingDeficiency: deficiencyItemHousingDeficiency,
              definition: buildingDataModel.deficiencyAreaItems![i].description,
              isSuccess: false,
              criteria: buildingDataModel.deficiencyAreaItems![i].criteria,
              deficiencyProofPictures: [],
              comment: '',
              date: '',
              housingDeficiencyId:
                  buildingDataModel.deficiencyAreaItems![i].id.toString()),
        );
      }
    }
    successListOfDeficiencies.forEach((element) {
      nameList.add(element.deficiencyItemHousingDeficiency!.housingItem!.item);
    });
    nameList = nameList.toSet().toList();
  }

  setSuccessDeficiencies(
      List<DeficiencyInspectionsReqModel> deficiencyInspectionsReqModel) {
    successListOfDeficiencies.forEach((element) {
      deficiencyInspectionsReqModel.forEach((element1) {
        if (element.deficiencyItemHousingDeficiency!.id.toString() ==
            element1.deficiencyItemHousingDeficiency!.id.toString()) {
          successListOfDeficiencies[successListOfDeficiencies.indexOf(element)]
              .isSuccess = element1.isSuccess;
          successListOfDeficiencies[successListOfDeficiencies.indexOf(element)]
              .deficiencyProofPictures = element1.deficiencyProofPictures;
          successListOfDeficiencies[successListOfDeficiencies.indexOf(element)]
              .comment = element1.comment;
          successListOfDeficiencies[successListOfDeficiencies.indexOf(element)]
              .date = element1.date;
          successListOfDeficiencies[successListOfDeficiencies.indexOf(element)]
              .definition = element1.definition;
          successListOfDeficiencies[successListOfDeficiencies.indexOf(element)]
                  .deficiencyItemHousingDeficiency =
              element1.deficiencyItemHousingDeficiency;
          successListOfDeficiencies[successListOfDeficiencies.indexOf(element)]
              .criteria = element1.criteria;
        }
      });
    });
    update();
    print("successList-------->" + successListOfDeficiencies.toString());
  }
}
