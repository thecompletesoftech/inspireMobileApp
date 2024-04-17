import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/unitinspectionsummary_screen/repository/unitinspection_repository.dart';
import '../../commons/all.dart';
import '../building_inspection_screen/screen/building_inspection_screen.dart';
import '../unit_Inpection_screen/unitinspection_controller.dart';

class UnitInspectionSummaryController extends BaseController {
  TextEditingController unitNumberName = TextEditingController();
  TextEditingController unitAddress = TextEditingController();
  TextEditingController bathrooms = TextEditingController();
  TextEditingController bedrooms = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController unitHouseKeeping = TextEditingController();
  TextEditingController generalPhysicalCondition = TextEditingController();
  final GlobalKey<PopupMenuButtonState<int>> popupKey1 = GlobalKey();
  final GlobalKey<PopupMenuButtonState<int>> popupKey2 = GlobalKey();

  UnitController _unitController = Get.put(UnitController());
  List unitHouseKeepingList = [];
  List generalPhysicalConditionList = [];
  List<String> cityList = [];
  var isLoading = false.obs;
  String inspectionName = '';
  String buildingName = '';
  String propertyName = '';

  var switchButton = false.obs;
  List<DeficiencyArea> deficiencyArea = [];

  var inspectionInfo = {};
  var deficiencyInfo = [].obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      deficiencyArea = Get.arguments['deficiencyArea'];
    }
    setDataController();
    unitHouseKeepingList = [
      {
        "title": 'Poor',
        "value":
            "Damages to walls, hardware, doors, flooring, appliances beyond normal wear and tear."
      },
      {"title": 'Standards', "value": "No damage beyond normal wear and tear."},
      {"title": 'clean', "value": "No or minimal defect."}
    ];
    generalPhysicalConditionList = [
      {
        "title": 'Poor',
        "value":
            "Bad odor, greasy stove, food left out, infestation, or clutter."
      },
      {"title": 'Standards', "value": "Generally clean with no clutter"},
      {"title": 'clean', "value": "Very clean and neat."}
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

      await Get.offAllNamed(BuildingInspectionScreen.routes);

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
