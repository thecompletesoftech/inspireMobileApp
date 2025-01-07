import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/models/deficiency_inspections_req_model.dart';
import 'package:public_housing/screens/unit_building_standards_screen/repository/unit_building_standards_repository.dart';

// enum BuildingStandardsStatus { all, failed }

class UnitBuildingStandardsController extends BaseController {
  TextEditingController searchStandardsController = TextEditingController();
  UnitBuildingStandardsRepository buildingStandardsRepository =
      UnitBuildingStandardsRepository();

  // BuildingStandardsStatus status = BuildingStandardsStatus.all;
  bool isCollapseStandards = false;
  String buildingName = '';
  String buildingtype = '';
  String propertyname = '';

  bool isSuccess = false;
  String inspectionName = '';
  List<BuildingModel> deficiencyAreas = [];
  RxList<BuildingModel> searchList = <BuildingModel>[].obs;
  RxList<BuildingModel> dataList = <BuildingModel>[].obs;
  RxMap propertyInfo = {}.obs;
  RxMap unitinfo = {}.obs;
  RxMap buildingInfo = {}.obs;
  var certificatesInfo = [].obs;
  String inspectorName = '';
  String inspectorDate = '';
  String unitname = '';
  var switchbtn = false.obs;
  bool isManually = false;

  void onInit() {
    super.onInit();

    () async {
      searchList.clear();
      await getDeficiencyAreasData();
      searchList.addAll(deficiencyAreas);
    }();

    if (Get.arguments != null) {
      buildingtype = Get.arguments['buildingtype'];
      isManually = Get.arguments['isManually'];
      buildingName = Get.arguments['buildingInfo']['name'];
      propertyname = Get.arguments['propertyInfo']['name'];
      propertyInfo = Get.arguments['propertyInfo'];
      buildingInfo = Get.arguments['buildingInfo'];
      certificatesInfo.value = Get.arguments['certificatesInfo'];
      inspectorName = Get.arguments['inspectorName'];
      inspectorDate = Get.arguments['inspectorDate'].toString();
      unitinfo = Get.arguments['unitinfo'];
      unitname = Get.arguments['unitinfo']['name'];
      switchbtn.value = bool.parse(Get.arguments['switchvalue'].toString());
    }
    update();
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

  // isSuccessStandards1(successList, standardsId) {
  //   for (int i = 0; i < searchList.length; i++) {
  //     for (int j = 0; j < searchList[i].buildingDataModel!.length; j++) {
  //       if (searchList[i].buildingDataModel![j].id == standardsId) {
  //         var data = successList.where((e) => e['success'] == true);
  //         if (searchList[i].buildingDataModel?[j].deficiencyAreaItems?.length ==
  //             data.length) {
  //           searchList[i].buildingDataModel![j].isArea = true;
  //         }
  //         successList.forEach((dataElement) {
  //           if (searchList[i]
  //                   .buildingDataModel![j]
  //                   .deficiencyInspectionsReqModel !=
  //               null) {
  //             searchList[i]
  //                 .buildingDataModel![j]
  //                 .deficiencyInspectionsReqModel
  //                 ?.add(DeficiencyInspectionsReqModel(
  //                   isSuccess: dataElement['success'],
  //                   housingDeficiencyId:
  //                       dataElement['housingDeficiencyId'].toString(),
  //                   date: dataElement['date'],
  //                   deficiencyProofPictures:
  //                       dataElement['deficiencyProofPictures'],
  //                   comment: dataElement['comment'],
  //                 ));
  //           } else {
  //             searchList[i]
  //                 .buildingDataModel![j]
  //                 .deficiencyInspectionsReqModel = [
  //               DeficiencyInspectionsReqModel(
  //                 isSuccess: dataElement['success'],
  //                 housingDeficiencyId:
  //                     dataElement['housingDeficiencyId'].toString(),
  //                 date: dataElement['date'],
  //                 deficiencyProofPictures:
  //                     dataElement['deficiencyProofPictures'],
  //                 comment: dataElement['comment'],
  //               )
  //             ];
  //           }
  //         });
  //       }
  //     }
  //   }
  //   update();
  // }

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

// class BuildingDataModel {
//   String? image;
//   bool? isSuccess;
//   String? title;
//   String? description;
//   String? status = '';
//
//   BuildingDataModel(
//       this.image, this.title, this.description, this.status, this.isSuccess);
// }
