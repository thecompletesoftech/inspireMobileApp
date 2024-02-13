import 'package:public_housing/commons/all.dart';

enum BuildingStandardsStatus { all, failed }

class BuildingStandardsController extends BaseController {
  TextEditingController searchStandardsController = TextEditingController();
  BuildingStandardsStatus status = BuildingStandardsStatus.all;
  bool isCollapseStandards = false;
  bool isType = true;
  RxList<BuildingDataModel> buildingDataList = [
    BuildingDataModel(
      ImagePath.cabinets,
      'Cabinet and Storage',
      'A dedicated space for food, goods, or other items.',
      BuildingStandardsStatus.all.toString(),
    ),
    BuildingDataModel(
      ImagePath.callaId,
      'Call for Aid System',
      'A call system used by a resident to summon aid during a medical emergency',
      BuildingStandardsStatus.all.toString(),
    ),
    BuildingDataModel(
      ImagePath.carbon,
      'Carbon Monoxide Alarm',
      'A single or multiple station alarm intended to detect carbon monoxide gas and alert occupants by a distinct audible signal, or if the unit is occupied by a person with a hearing impairment, a distinct visual alarm or combination of audible and visual alarms. It incorporates a sensor, control components and an alarm notification appliance in a single unit.',
      BuildingStandardsStatus.failed.toString(),
    ),
    BuildingDataModel(
      ImagePath.ceiling,
      'Ceiling',
      'The upper interior surface of a room that provides separation between rooms, spaces, and floors.',
      BuildingStandardsStatus.all.toString(),
    )
  ].obs;
  var searchList = [].obs;

  void onInit() {
    buildingDataList.addAll([]);
    super.onInit();
  }

  searchTypeItem() {
    searchList.clear();
    if (status.toString() == BuildingStandardsStatus.all.toString()) {
      searchList.addAll(buildingDataList);
    } else {
      for (int i = 0; i < buildingDataList.length; i++) {
        if (buildingDataList[i].status.toString() == status.toString()) {
          searchList.add(buildingDataList[i]);
        }
      }
    }
  }

  isExpanded() {
    if (isCollapseStandards == true) {
      isCollapseStandards = false;
    } else {
      isCollapseStandards = true;
    }
    update();
  }

  isTypeExpanded() {
    if (isType == true) {
      isType = false;
    } else {
      isType = true;
    }
    update();
  }
}

class BuildingDataModel {
  String? image;
  String? title;
  String? description;
  String? status = '';

  BuildingDataModel(this.image, this.title, this.description, this.status);
}
