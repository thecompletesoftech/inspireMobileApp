import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_inspection_screen/models/certificate_model.dart';
import 'package:public_housing/screens/building_list_screen/model/property_data_model.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/building_standards_screen/repository/building_standards_repository.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/models/deficiency_inspections_req_model.dart';

class BuildingStandardsController extends BaseController {
  TextEditingController searchStandardsController = TextEditingController();
  BuildingStandardsRepository buildingStandardsRepository =
      BuildingStandardsRepository();

  // BuildingStandardsStatus status = BuildingStandardsStatus.all;
  bool isCollapseStandards = false;
  String buildingName = '';
  String buildingType = '';
  String propertyName = '';
  bool isSuccess = false;
  String inspectionName = '';
  List<BuildingDataModel> deficiencyAreas = [];
  RxList<BuildingDataModel> searchList = <BuildingDataModel>[].obs;
  RxList<BuildingDataModel> dataList = <BuildingDataModel>[].obs;
  RxMap propertyInfo = {}.obs;
  RxMap buildingInfo = {}.obs;
  List<Certificates> certificatesInfo = [];
  String inspectorName = '';
  String inspectorDate = '';
  bool isManually = false;
  BuildingsData buildingsData = BuildingsData();
  PropertyDataModel propertyDataModel = PropertyDataModel();

  void onInit() {
    super.onInit();
    () async {
      deficiencyAreas.clear();
      await getDeficiencyAreasData();
      searchList.addAll(deficiencyAreas);
    }();

    if (Get.arguments['isManually'] != null) {
      isManually = Get.arguments['isManually'];
    }
    if (Get.arguments['propertyName'] != null) {
      propertyName = Get.arguments['propertyName'];
    }
    if (Get.arguments['buildingName'] != null) {
      buildingName = Get.arguments['buildingName'];
    }
    if (Get.arguments['propertyDataModel'] != null) {
      propertyDataModel = Get.arguments['propertyDataModel'];
    }
    if (Get.arguments['buildingsData'] != null) {
      buildingsData = Get.arguments['buildingsData'];
    }
    if (Get.arguments['inspectorName'] != null) {
      inspectorName = Get.arguments['inspectorName'];
    }
    if (Get.arguments['inspectorDate'] != null) {
      inspectorDate = Get.arguments['inspectorDate'];
    } else {
      inspectorDate = propertyDataModel.date ?? '';
    }

    if (Get.arguments['buildingtype'] != null) {
      buildingType = Get.arguments['buildingtype'];
      buildingName = Get.arguments['buildingName'];
      propertyName = Get.arguments['propertyInfo']['name'];
      propertyInfo = Get.arguments['propertyInfo'];
      buildingInfo = Get.arguments['buildingInfo'];
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

  // isUpdateList({required String name}) {
  //   searchList.forEach((e) {
  //     e.buildingDataModel?.forEach((element) {
  //       if (element.name == name) {
  //         element.isSuccess = true;
  //       }
  //     });
  //   });
  // }

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
        for (int j = 0;
            j < deficiencyAreas[i].deficiencyAreaList!.length;
            j++) {
          if (deficiencyAreas[i]
              .deficiencyAreaList![j]
              .name
              .toString()
              .toLowerCase()
              .contains(searchText.toString().toLowerCase())) {
            int itemIndex =
                searchList.indexWhere((e) => e.type == deficiencyAreas[i].type);

            if (itemIndex != -1) {
              searchList[itemIndex]
                  .deficiencyAreaList
                  ?.add(deficiencyAreas[i].deficiencyAreaList![j]);
            } else {
              searchList.add(BuildingDataModel(
                  deficiencyAreas[i].type,
                  isExpand: true,
                  [deficiencyAreas[i].deficiencyAreaList![j]]));
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
    var response =
        await buildingStandardsRepository.getDeficiencyAreas(type: 'Building');

    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (r) {
      if (r.deficiencyAreas?.isNotEmpty ?? false) {
        List<DeficiencyArea> deficiencyAreaList = r.deficiencyAreas!;
        List<BuildingInspectionDataModel>? buildingInspectionDataModelList =
            buildingsData.buildingInspectionDataModelList;
        deficiencyAreaList = extractAndSetLocalDeficiencyAreaData(
            buildingInspectionDataModelList:
                buildingInspectionDataModelList ?? [],
            deficiencyAreaListData: deficiencyAreaList);

        deficiencyAreaList.forEach((element) {
          if (deficiencyAreas.indexWhere(
                  (element1) => element1.type == element.name.toString()[0]) ==
              -1) {
            deficiencyAreas.add(BuildingDataModel(
              element.name.toString()[0],
              [element],
              isExpand: false,
            ));
          } else {
            deficiencyAreas[deficiencyAreas.indexWhere(
                    (element2) => element2.type == element.name.toString()[0])]
                .deficiencyAreaList!
                .add(element);
          }
        });
      }
    });
    update();
  }

  isSuccessStandards1(successList, standardsId) {
    for (int i = 0; i < searchList.length; i++) {
      for (int j = 0; j < searchList[i].deficiencyAreaList!.length; j++) {
        if (searchList[i].deficiencyAreaList![j].id == standardsId) {
          var data = successList.where((e) => e.isSuccess == true);

          if (data.length > 0) {
            searchList[i].deficiencyAreaList![j].isArea = true;
          } else {
            searchList[i].deficiencyAreaList![j].isArea = false;
          }
          searchList[i].deficiencyAreaList![j].deficiencyInspectionsReqModel =
              [];
          successList.forEach((dataElement) {
            if (dataElement.isSuccess == true) {
              if (searchList[i]
                      .deficiencyAreaList![j]
                      .deficiencyInspectionsReqModel !=
                  null) {
                List<String> deficiencyProofPictures = [];
                if (dataElement.deficiencyProofPictures.isNotEmpty) {
                  deficiencyProofPictures = dataElement.deficiencyProofPictures;
                }
                searchList[i]
                    .deficiencyAreaList![j]
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
                    .deficiencyAreaList![j]
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

class BuildingDataModel {
  String? type;
  bool? isExpand = false;
  List<DeficiencyArea>? deficiencyAreaList;

  BuildingDataModel(this.type, this.deficiencyAreaList,
      {this.isExpand = false});
}
