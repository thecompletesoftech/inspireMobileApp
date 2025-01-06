import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/building_standards_screen/repository/building_standards_repository.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/models/deficiency_inspections_req_model.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart';

// enum BuildingStandardsStatus { all, failed }

class BuildingStandardsController extends BaseController {
  TextEditingController searchStandardsController = TextEditingController();
  BuildingStandardsRepository buildingStandardsRepository =
      BuildingStandardsRepository();
  ScheduleInspection propertyData = ScheduleInspection();

  // BuildingStandardsStatus status = BuildingStandardsStatus.all;
  bool isCollapseStandards = false;
  String buildingName = '';
  String buildingType = '';
  String propertyName = '';
  bool isSuccess = false;
  String inspectionName = '';
  List<BuildingModel> deficiencyAreas = [];
  RxList<BuildingModel> searchList = <BuildingModel>[].obs;
  RxList<BuildingModel> dataList = <BuildingModel>[].obs;
  RxMap propertyInfo = {}.obs;
  RxMap buildingInfo = {}.obs;
  var certificatesInfo = [].obs;
  String inspectorName = '';
  String inspectorDate = '';
  bool isManually = false;
  int buildingId = 0;

  void onInit() {
    super.onInit();
    () async {
      deficiencyAreas.clear();
      await getDeficiencyAreasData();
      searchList.addAll(deficiencyAreas);
    }();
    if (Get.arguments['buildingId'] != null) {
      buildingId = Get.arguments['buildingId'];
    }
    if (Get.arguments['isManually'] != null) {
      isManually = Get.arguments['isManually'];
    }
    if (Get.arguments['propertyData'] != null) {
      propertyData = Get.arguments['propertyData'];
    }

    if (Get.arguments['buildingtype'] != null) {
      buildingType = Get.arguments['buildingtype'];
      buildingName = Get.arguments['buildingName'];
      propertyName = Get.arguments['propertyInfo']['name'];
      propertyInfo = Get.arguments['propertyInfo'];
      buildingInfo = Get.arguments['buildingInfo'];
      inspectorName = Get.arguments['inspectorName'];
      inspectorDate = Get.arguments['inspectorDate'];
    }
    if (Get.arguments['certificatesInfo'] != null) {
      certificatesInfo = Get.arguments['certificatesInfo'];
    }

    update();
  }

  clearData() {
    deficiencyAreas.clear();
    searchList.clear();
    dataList.clear();
  }

  isUpdateList({required String name}) {
    searchList.forEach((e) {
      // e.buildingDataModel?.forEach((element) {
      //   if (element.name == name) {
      //     element.isSuccess = true;
      //   }
      // });
    });
  }

  // searchTypeItem() {
  //   searchList.clear();
  //   if (status.toString() == BuildingStandardsStatus.all.toString()) {
  //     searchList.addAll(deficiencyAreas);
  //   } else {
  //     for (int i = 0; i < deficiencyAreas.length; i++) {
  //       for (int j = 0;
  //           j < deficiencyAreas[i].buildingDataModel!.length;
  //           j++) {
  //         if (deficiencyAreas[i].buildingDataModel![j].status.toString() ==
  //             status.toString()) {
  //           int itemIndex = searchList
  //               .indexWhere((e) => e.type == buildingDataList[i].type);
  //
  //           if (itemIndex != -1) {
  //             searchList[itemIndex]
  //                 .buildingDataModel
  //                 ?.add(buildingDataList[i].buildingDataModel![j]);
  //           } else {
  //             searchList.add(BuildingModel(
  //                 buildingDataList[i].type,
  //                 isExpand: false,
  //                 [buildingDataList[i].buildingDataModel![j]]));
  //           }
  //         }
  //       }
  //     }
  //   }
  //   update();
  // }

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
      /* if (status.toString() == BuildingStandardsStatus.all.toString()) {
        for (int i = 0; i < deficiencyAreas.length; i++) {
          for (int j = 0;
              j < deficiencyAreas[i].buildingDataModel!.length;
              j++) {
            if (deficiencyAreas[i]
                .buildingDataModel![j]
                .name
                .toString()
                .toLowerCase()
                .contains(searchText.toString().toLowerCase())) {
              int itemIndex = searchList
                  .indexWhere((e) => e.type == deficiencyAreas[i].type);

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
      } else {
        // for (int i = 0; i < buildingDataList.length; i++) {
        //   for (int j = 0;
        //       j < buildingDataList[i].buildingDataModel!.length;
        //       j++) {
        //     if (buildingDataList[i].buildingDataModel![j].status.toString() ==
        //         status.toString()) {
        //       if (buildingDataList[i]
        //           .buildingDataModel![j]
        //           .title
        //           .toString()
        //           .toLowerCase()
        //           .contains(searchText.toString().toLowerCase())) {
        //         int itemIndex = searchList
        //             .indexWhere((e) => e.type == buildingDataList[i].type);
        //
        //         if (itemIndex != -1) {
        //           searchList[itemIndex]
        //               .buildingDataModel
        //               ?.add(buildingDataList[i].buildingDataModel![j]);
        //         } else {
        //           searchList.add(BuildingModel(
        //               buildingDataList[i].type,
        //               isExpand: true,
        //               [buildingDataList[i].buildingDataModel![j]]));
        //         }
        //       }
        //     }
        //   }
        // }
      }
      update();*/
    } else {
      searchList.addAll(deficiencyAreas);
      // searchTypeItem();
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
    var response = await buildingStandardsRepository.getDeficiencyAreas();

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
