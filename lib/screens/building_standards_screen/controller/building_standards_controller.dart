import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/building_standards_screen/repository/building_standards_repository.dart';

enum BuildingStandardsStatus { all, failed }

class BuildingStandardsController extends BaseController {
  TextEditingController searchStandardsController = TextEditingController();
  BuildingStandardsRepository buildingStandardsRepository =
      BuildingStandardsRepository();
  BuildingStandardsStatus status = BuildingStandardsStatus.all;
  bool isCollapseStandards = false;
  String buildingName = '';
  bool isSuccess = false;
  var imagesList;
  String inspectionName = '';
  List<BuildingModel> deficiencyAreas = [];

  RxList<BuildingModel> searchList = <BuildingModel>[].obs;

  void onInit() {
    super.onInit();
    getDeficiencyAreasData();
    if (Get.arguments != null) {
      buildingName = Get.arguments['buildingName'];
    }
    searchList.addAll(deficiencyAreas);
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
      if (status.toString() == BuildingStandardsStatus.all.toString()) {
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
      update();
    } else {
      // searchTypeItem();
    }
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
              isExpand: true,
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
}

class BuildingModel {
  String? type;
  bool? isExpand = false;
  List<DeficiencyArea>? buildingDataModel;

  BuildingModel(this.type, this.buildingDataModel, {this.isExpand = false});
}

class BuildingDataModel {
  String? image;
  bool? isSuccess;
  String? title;
  String? description;
  String? status = '';

  BuildingDataModel(
      this.image, this.title, this.description, this.status, this.isSuccess);
}