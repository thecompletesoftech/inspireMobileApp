import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/models/deficiency_inspections_req_model.dart';
import 'package:public_housing/screens/inspection_standards_screen/repository/inspection_standards_repository.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_res_model.dart';

class InspectionStandardsController extends BaseController {
  TextEditingController searchStandardsController = TextEditingController();
  InspectionStandardsRepository inspectionStandardsRepository =
      InspectionStandardsRepository();
  bool isCollapseStandards = false;
  List<BuildingModel> deficiencyAreas = [];
  RxList<BuildingModel> searchList = <BuildingModel>[].obs;
  String unitAddress = '';
  String unitName = '';
  InspectionType inspectionType = InspectionType();
  Units unitData = Units();

  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      unitAddress = Get.arguments['unitAddress'];
      unitName = Get.arguments['unitName'];
      inspectionType = Get.arguments['inspectionType'];
    }
    if (Get.arguments['unitData'] != null) {
      unitData = Get.arguments['unitData'];
    }
    () async {
      searchList.clear();
      await getDeficiencyAreasData();
      searchList.addAll(deficiencyAreas);
    }();
    update();
  }

  searchStandards({required String searchText}) {
    searchList.clear();
    if (!utils.isValidationEmpty(searchText)) {
      for (int i = 0; i < deficiencyAreas.length; i++) {
        for (int j = 0; j < deficiencyAreas[i].buildingDataModel!.length; j++) {
          if (deficiencyAreas[i]
              .buildingDataModel![j]
              .name
              .toString()
              .toLowerCase()
              .contains(searchText.toString().toLowerCase())) {
            int itemIndex =
                searchList.indexWhere((e) => e.type == deficiencyAreas[i].type);

            if (itemIndex != -1) {
              searchList[itemIndex]
                  .buildingDataModel
                  ?.add(deficiencyAreas[i].buildingDataModel![j]);
            } else {
              searchList.add(BuildingModel(
                  deficiencyAreas[i].type,
                  isExpand: true,
                  [deficiencyAreas[i].buildingDataModel![j]]));
            }
          }
        }
      }
      update();
    } else {
      searchList.addAll(deficiencyAreas);
    }
    update();
  }

  isExpanded() {
    for (int i = 0; i < searchList.length; i++) {
      if (isCollapseStandards == false) {
        searchList[i].isExpand = true;
      } else {
        searchList[i].isExpand = false;
      }
    }
    if (isCollapseStandards == false) {
      isCollapseStandards = true;
    } else {
      isCollapseStandards = false;
    }
    update();
  }

  isItemExpanded(index) {
    searchList[index].isExpand = !(searchList[index].isExpand ?? false);
    isCollapseStandards = true;
    var data = searchList.where((e) => e.isExpand == false);
    if (data.length == searchList.length) {
      isCollapseStandards = false;
    }
    update();
  }

  getDeficiencyAreasData() async {
    var response =
        await inspectionStandardsRepository.getInspectionDeficiencyAreas();

    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (r) {
      if (r.deficiencyAreas!.isNotEmpty) {
        r.deficiencyAreas?.forEach((element) {
          if (deficiencyAreas.indexWhere(
                  (element1) => element1.type == element.name.toString()[0]) ==
              -1) {
            deficiencyAreas.add(BuildingModel(
              element.name.toString()[0],
              [element],
              isExpand: false,
            ));
          } else {
            deficiencyAreas[deficiencyAreas.indexWhere(
                    (element2) => element2.type == element.name.toString()[0])]
                .buildingDataModel!
                .add(element);
          }
        });
      }
    });
    update();
  }

  isSuccessStandards1(successList, standardsId) {
    for (int i = 0; i < searchList.length; i++) {
      for (int j = 0; j < searchList[i].buildingDataModel!.length; j++) {
        if (searchList[i].buildingDataModel![j].id == standardsId) {
          var data = successList.where((e) => e.isSuccess == true);

          if (data.length > 0) {
            searchList[i].buildingDataModel![j].isArea = true;
          } else {
            searchList[i].buildingDataModel![j].isArea = false;
          }
          searchList[i].buildingDataModel![j].deficiencyInspectionsReqModel =
              [];
          successList.forEach((dataElement) {
            if (dataElement.isSuccess == true) {
              if (searchList[i]
                      .buildingDataModel![j]
                      .deficiencyInspectionsReqModel !=
                  null) {
                List<String> deficiencyProofPictures = [];
                if (dataElement.deficiencyProofPictures.isNotEmpty) {
                  deficiencyProofPictures = dataElement.deficiencyProofPictures;
                }
                searchList[i]
                    .buildingDataModel![j]
                    .deficiencyInspectionsReqModel
                    ?.add(DeficiencyInspectionsReqModel(
                      isSuccess: dataElement.isSuccess,
                      housingDeficiencyId:
                          dataElement.housingDeficiencyId.toString(),
                      date: dataElement.date,
                      deficiencyProofPictures: deficiencyProofPictures,
                      comment: dataElement.comment,
                      definition: dataElement.definition,
                      criteria: dataElement.criteria,
                      deficiencyItemHousingDeficiency:
                          dataElement.deficiencyItemHousingDeficiency,
                    ));
              } else {
                List<String> deficiencyProofPictures = [];
                if (dataElement.deficiencyProofPictures.isNotEmpty) {
                  deficiencyProofPictures = dataElement.deficiencyProofPictures;
                }
                searchList[i]
                    .buildingDataModel![j]
                    .deficiencyInspectionsReqModel = [
                  DeficiencyInspectionsReqModel(
                    isSuccess: dataElement.isSuccess,
                    housingDeficiencyId:
                        dataElement.housingDeficiencyId.toString(),
                    date: dataElement.date,
                    deficiencyProofPictures: deficiencyProofPictures,
                    comment: dataElement.comment,
                    definition: dataElement.definition,
                    criteria: dataElement.criteria,
                    deficiencyItemHousingDeficiency:
                        dataElement.deficiencyItemHousingDeficiency,
                  )
                ];
              }
            }
          });
        }
      }
    }
    update();
  }
}

class BuildingModel {
  String? type;
  bool? isExpand = false;
  List<DeficiencyArea>? buildingDataModel;

  BuildingModel(this.type, this.buildingDataModel, {this.isExpand = false});
}
