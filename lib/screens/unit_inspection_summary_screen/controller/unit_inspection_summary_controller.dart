import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart';
import 'package:public_housing/screens/properties_list_screen/screen/properties_list_screen.dart';
import 'package:public_housing/screens/unit_inspection_screen/controller/unit_inspection_controller.dart';
import 'package:public_housing/screens/unit_inspection_summary_screen/repository/unit_inspection_repository.dart';
import '../../../commons/all.dart';

class UnitInspectionSummaryController extends BaseController {
  TextEditingController unitNumberName = TextEditingController();
  TextEditingController unitAddress = TextEditingController();
  TextEditingController bathrooms = TextEditingController();
  TextEditingController bedrooms = TextEditingController();
  TextEditingController unitHouseKeeping = TextEditingController();
  TextEditingController generalPhysicalCondition = TextEditingController();

  UnitController _unitController = Get.put(UnitController());
  List unitHouseKeepingList = [];
  List generalPhysicalConditionList = [];
  List<String> cityList = [];
  var isLoading = false.obs;
  String inspectionName = '';
  String buildingName = '';
  String propertyName = '';
  bool isManually = false;
  var switchButton = false.obs;
  List<DeficiencyArea> deficiencyArea = [];
  var inspectionInfo = {};
  var deficiencyInfo = [].obs;
  ScheduleInspection propertyData = ScheduleInspection();
  ScheduleInspectionBuilding externalBuilding = ScheduleInspectionBuilding();
  ScheduleInspectionUnit unitsData = ScheduleInspectionUnit();
  var propertyInfo = {}.obs;
  var buildingInfo = {}.obs;

  @override
  void onInit() {
    if (Get.arguments['deficiencyArea'] != null) {
      deficiencyArea = Get.arguments['deficiencyArea'];
      setDataController();
    }
    if (Get.arguments['isManually'] != null) {
      isManually = Get.arguments['isManually'];
    }
    if (Get.arguments['propertyInfo'] != null) {
      propertyInfo = Get.arguments['propertyInfo'];
    }
    if (Get.arguments['buildingInfo'] != null) {
      buildingInfo = Get.arguments['buildingInfo'];
    }
    if (Get.arguments['propertyData'] != null) {
      propertyData = Get.arguments['propertyData'];
      propertyName = propertyData.property?.name ?? "";
    }
    if (Get.arguments['externalBuilding'] != null) {
      externalBuilding = Get.arguments['externalBuilding'];
      buildingName = externalBuilding.building?.name ?? "";
    }
    if (Get.arguments['unitsData'] != null) {
      unitsData = Get.arguments['unitsData'];
      unitNumberName.text = unitsData.unit?.name ?? "";
      unitAddress.text = unitsData.unit?.address ?? "";
      bedrooms.text = '${unitsData.unit?.numberOfBedrooms ?? 0}';
      bathrooms.text = '${unitsData.unit?.numberOfBathrooms ?? 0}';
      switchButton.value = unitsData.unit?.occupied ?? false;
    }

    unitHouseKeepingList = [
      {
        "title": 'Poor',
        "value":
            "Damages to walls, hardware, doors, flooring, appliances beyond normal wear and tear."
      },
      {"title": 'Standard', "value": "No damage beyond normal wear and tear."},
      {"title": 'Clean', "value": "No or minimal defect."}
    ];
    generalPhysicalConditionList = [
      {
        "title": 'Poor',
        "value":
            "Bad odor, greasy stove, food left out, infestation, or clutter."
      },
      {"title": 'Standard', "value": "Generally clean with no clutter"},
      {"title": 'Clean', "value": "Very clean and neat."}
    ];
    getDeficiencyJson();
    update();

    super.onInit();
  }

  getInspectionInfoJson() {
    inspectionInfo.addAll({
      "inspector_id":
          getStorageData.readString(getStorageData.inspectorId).toString(),
      "date": Get.arguments['inspectorDate'],
      "comment": "",
      "inspection_state_id": "1",
      "inspection_type_id": "1",
      "unit_house_keeping": unitHouseKeeping.text,
      "general_physical_condition": generalPhysicalCondition.text
    });
    print("inspection data" + inspectionInfo.toString());
  }

  void actionPopUpItemSelected(int value) {
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar;
    String message;
    if (value == 0) {
      message = 'You selected ${Strings.editProfile}';
    } else if (value == 1) {
      message = 'You selected ${Strings.inspectionHistory}';
    } else if (value == 2) {
      message = 'You selected ${Strings.nSPIREStandards}';
    } else if (value == 3) {
      message = 'You selected ${Strings.logOut}';
      // Get.offAllNamed(SigningScreen.routes);
      getStorageData.removeData(getStorageData.isLogin);
    } else {
      message = 'Not implemented';
    }
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  void actionUnitHousekeeping(value) {
    unitHouseKeeping.text = value;
  }

  void actionGeneralPhysical(value) {
    generalPhysicalCondition.text = value;
  }

  getUnitInspectionSummary() {
    update();
    return unitNumberName.text.isNotEmpty && unitAddress.text.isNotEmpty;
  }

  setDataController() {
    unitNumberName.text = Get.arguments['unitinfo']['name'] ?? "";
    unitAddress.text = Get.arguments['unitinfo']['address'];
    bathrooms.text = Get.arguments['unitinfo']['number_of_bathrooms'] ?? "";
    bedrooms.text = Get.arguments['unitinfo']['number_of_bedrooms'] ?? "";
    switchButton.value = Get.arguments['switchvalue'];
    buildingName = Get.arguments['buildingInfo']['name'];
    propertyName = Get.arguments['propertyInfo']['name'];
  }

  getDeficiencyJson() async {
    deficiencyInfo.clear();
    if (deficiencyArea.length > 0) {
      for (var i = 0; i < deficiencyArea.length; i++) {
        for (var j = 0;
            j < deficiencyArea[i].deficiencyInspectionsReqModel!.length;
            j++) {
          deficiencyInfo.add({
            "housing_deficiency_id": deficiencyArea[i]
                .deficiencyInspectionsReqModel![j]
                .deficiencyItemHousingDeficiency!
                .id,
            "deficiency_proof_pictures": await getDeficiencyImage(),
            "comment":
                deficiencyArea[i].deficiencyInspectionsReqModel![j].comment,
            "date": deficiencyArea[i].deficiencyInspectionsReqModel![j].date
          });
        }
      }
      print("deficiency" + deficiencyInfo.toString());
    }
  }

  getDeficiencyImage() {
    var result = [];
    for (var i = 0; i < deficiencyArea.length; i++) {
      for (var j = 0;
          j < deficiencyArea[i].deficiencyInspectionsReqModel!.length;
          j++) {
        for (var k = 0;
            k <
                deficiencyArea[i]
                    .deficiencyInspectionsReqModel![j]
                    .deficiencyProofPictures!
                    .length;
            k++) {
          result.add({
            "picture_path": deficiencyArea[i]
                .deficiencyInspectionsReqModel![j]
                .deficiencyProofPictures![k]
          });
        }
      }
    }
    print("result" + result.toString());
    return result;
  }

  createInspection() async {
    isLoading.value = true;

    var response = await UnitSummaryRepository().createInspections(
        buildingJson: Get.arguments['buildingInfo'],
        certificateList: Get.arguments['cerificateList'],
        deficiencyList: deficiencyInfo,
        inspectionJson: inspectionInfo,
        propertyJson: Get.arguments['propertyInfo'],
        unitJson: Get.arguments['unitinfo']);

    await response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
      isLoading.value = false;
      update();
    }, (r) async {
      utils.showSnackBar(
          context: Get.context!,
          message: "Unit inspection Submitted Successfully!!",
          isOk: true);

      await Get.offAllNamed(PropertiesListScreen.routes);

      isLoading.value = false;
      update();
    });
  }

  saveCreateInspection() async {
    isLoading.value = true;
    var response = await UnitSummaryRepository().createInspections(
        buildingJson: Get.arguments['buildingInfo'],
        certificateList: Get.arguments['cerificateList'],
        deficiencyList: deficiencyInfo,
        inspectionJson: inspectionInfo,
        propertyJson: Get.arguments['propertyInfo'],
        unitJson: Get.arguments['unitinfo']);

    await response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
      isLoading.value = false;
      update();
    }, (r) async {
      utils.showSnackBar(
          context: Get.context!,
          message: "Unit inspection Submitted Successfully!!",
          isOk: true);
      _unitController.clearData();
      _unitController..getUnitInspection();
      Get.back(result: {
        "propertyInfo":
            Get.arguments == null ? "" : Get.arguments['propertyInfo'],
        "buildingInfo":
            Get.arguments == null ? "" : Get.arguments['buildingInfo'],
        "buildingtype":
            Get.arguments == null ? "" : Get.arguments['buildingtype'],
        "cerificateList": Get.arguments['certificatesInfo'],
        "deficiencyArea": Get.arguments['deficiencyArea'],
        "switchvalue": switchButton.value,
        "inspectorDate": Get.arguments['inspectorDate']
      });
      Get.back();
      isLoading.value = false;
      update();
    });
  }

  isDataUpdate(mainIndex, subIndex, deficiencyInspectionsReqModel) {
    deficiencyArea[mainIndex].deficiencyInspectionsReqModel?[subIndex] =
        deficiencyInspectionsReqModel[0];
    deficiencyArea[mainIndex]
        .deficiencyInspectionsReqModel?[subIndex]
        .isSuccess = true;
    getDeficiencyJson();
    update();
  }

  isDataUpdateSuccess(mainIndex, subIndex) {
    deficiencyArea[mainIndex].deficiencyInspectionsReqModel?.removeAt(subIndex);
    if (deficiencyArea[mainIndex].deficiencyInspectionsReqModel!.isEmpty) {
      deficiencyArea[mainIndex].isArea = false;
    }
    getDeficiencyJson();
    update();
  }
}
