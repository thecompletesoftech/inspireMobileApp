import 'package:public_housing/commons/all.dart';

enum BuildingStandardsStatus { all, failed }

class BuildingStandardsController extends BaseController {
  TextEditingController searchStandardsController = TextEditingController();
  BuildingStandardsStatus status = BuildingStandardsStatus.all;
  bool isCollapseStandards = false;
  String buildingName = '';
  bool isSuccess = false;
  var imagesList;
  String inspectionName = '';

  RxList<BuildingModel> buildingDataList = [
    BuildingModel('C', [
      BuildingDataModel(
          ImagePath.cabinets,
          'Cabinet and Storage',
          'A dedicated space for food, goods, or other items.',
          BuildingStandardsStatus.all.toString(),
          false),
      BuildingDataModel(
          ImagePath.callaId,
          'Call for Aid System',
          'A call system used by a resident to summon aid during a medical emergency',
          BuildingStandardsStatus.all.toString(),
          false),
      BuildingDataModel(
          ImagePath.carbon,
          'Carbon Monoxide Alarm',
          'A single or multiple station alarm intended to detect carbon monoxide gas and alert occupants by a distinct audible signal, or if the unit is occupied by a person with a hearing impairment, a distinct visual alarm or combination of audible and visual alarms. It incorporates a sensor, control components and an alarm notification appliance in a single unit.',
          BuildingStandardsStatus.failed.toString(),
          false),
      BuildingDataModel(
          ImagePath.ceiling,
          'Ceiling',
          'The upper interior surface of a room that provides separation between rooms, spaces, and floors.',
          BuildingStandardsStatus.all.toString(),
          false),
      BuildingDataModel(
          ImagePath.cooking,
          'Cooking Appliance',
          'Cooking range: An electric or gas stove with several burners and one or more connected ovens. Cooktop: Usually a standalone device that may be built into a counter and has one or more electric or gas burners. Oven: A thermally insulated chamber used for cooking, heating, and baking food. Microwave: A small oven that heats food with electromagnetic radiation.',
          BuildingStandardsStatus.failed.toString(),
          false)
    ]),
    BuildingModel('D', [
      BuildingDataModel(
          ImagePath.doorGeneral,
          'Door - General',
          'Panel that provides an opening in a building or room and provides separation (i.e., closes an opening)',
          BuildingStandardsStatus.all.toString(),
          false),
    ]),
    BuildingModel('E', [
      BuildingDataModel(
          ImagePath.electricalConductor,
          'Electrical - conductor, outlet, and switch',
          'Conductor: An object or type of material that carries electrical current. Outlet and Switch: Installations that connect to an electricity supply.',
          BuildingStandardsStatus.all.toString(),
          false),
      BuildingDataModel(
          ImagePath.electricalGFCI,
          'Electrical - GFCI or AFCI - outler or breaker',
          'Electrical protection devices',
          BuildingStandardsStatus.failed.toString(),
          false),
      BuildingDataModel(
          ImagePath.electricalService,
          'Electrical - service panel',
          'An enclosure, cabinet, box, or panelboard containing overcurrent protection devices for the control of light, heat, appliances and power circuits.',
          BuildingStandardsStatus.failed.toString(),
          false),
    ]),
    BuildingModel('F', [
      BuildingDataModel(
          ImagePath.fireExtinguisher,
          'Fire Extinguisher',
          'A portable fire safety device that discharges a jet of water, foam, gas, or other material to extinguish a fire.',
          BuildingStandardsStatus.all.toString(),
          false),
    ]),
  ].obs;

  RxList<BuildingModel> searchList = <BuildingModel>[].obs;

  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      buildingName = Get.arguments['buildingName'];
    }
    searchList.addAll(buildingDataList);
    update();
  }

  isUpdateList({required String name}) {
    searchList.forEach((e) {
      e.buildingDataModel?.forEach((element) {
        if (element.title == name) {
          element.isSuccess = true;
        }
      });
    });
  }

  searchTypeItem() {
    searchList.clear();
    if (status.toString() == BuildingStandardsStatus.all.toString()) {
      searchList.addAll(buildingDataList);
    } else {
      for (int i = 0; i < buildingDataList.length; i++) {
        for (int j = 0;
            j < buildingDataList[i].buildingDataModel!.length;
            j++) {
          if (buildingDataList[i].buildingDataModel![j].status.toString() ==
              status.toString()) {
            int itemIndex = searchList
                .indexWhere((e) => e.type == buildingDataList[i].type);

            if (itemIndex != -1) {
              searchList[itemIndex]
                  .buildingDataModel
                  ?.add(buildingDataList[i].buildingDataModel![j]);
            } else {
              searchList.add(BuildingModel(
                  buildingDataList[i].type,
                  isExpand: false,
                  [buildingDataList[i].buildingDataModel![j]]));
            }
          }
        }
      }
    }
    update();
  }

  searchStandards({required String searchText}) {
    searchList.clear();
    if (!utils.isValidationEmpty(searchText)) {
      if (status.toString() == BuildingStandardsStatus.all.toString()) {
        for (int i = 0; i < buildingDataList.length; i++) {
          for (int j = 0;
              j < buildingDataList[i].buildingDataModel!.length;
              j++) {
            if (buildingDataList[i]
                .buildingDataModel![j]
                .title
                .toString()
                .toLowerCase()
                .contains(searchText.toString().toLowerCase())) {
              int itemIndex = searchList
                  .indexWhere((e) => e.type == buildingDataList[i].type);

              if (itemIndex != -1) {
                searchList[itemIndex]
                    .buildingDataModel
                    ?.add(buildingDataList[i].buildingDataModel![j]);
              } else {
                searchList.add(BuildingModel(
                    buildingDataList[i].type,
                    isExpand: true,
                    [buildingDataList[i].buildingDataModel![j]]));
              }
            }
          }
        }
      } else {
        for (int i = 0; i < buildingDataList.length; i++) {
          for (int j = 0;
              j < buildingDataList[i].buildingDataModel!.length;
              j++) {
            if (buildingDataList[i].buildingDataModel![j].status.toString() ==
                status.toString()) {
              if (buildingDataList[i]
                  .buildingDataModel![j]
                  .title
                  .toString()
                  .toLowerCase()
                  .contains(searchText.toString().toLowerCase())) {
                int itemIndex = searchList
                    .indexWhere((e) => e.type == buildingDataList[i].type);

                if (itemIndex != -1) {
                  searchList[itemIndex]
                      .buildingDataModel
                      ?.add(buildingDataList[i].buildingDataModel![j]);
                } else {
                  searchList.add(BuildingModel(
                      buildingDataList[i].type,
                      isExpand: true,
                      [buildingDataList[i].buildingDataModel![j]]));
                }
              }
            }
          }
        }
      }
      update();
    } else {
      searchTypeItem();
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
}

class BuildingModel {
  String? type;
  bool? isExpand = false;
  List<BuildingDataModel>? buildingDataModel;

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
