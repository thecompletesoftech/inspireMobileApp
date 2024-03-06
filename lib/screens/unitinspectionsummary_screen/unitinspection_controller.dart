import 'package:public_housing/screens/Unit_building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/building_inspection_screen/models/property_model.dart';
import 'package:public_housing/screens/unitinspectionsummary_screen/repository/unitinspection_repository.dart';
import '../../commons/all.dart';
import '../building_inspection_screen/controller/building_inspection_controller.dart';
import '../building_inspection_screen/screen/building_inspection_screen.dart';
import '../building_inspection_summary/controller/building_inspection_summary_controller.dart';
import '../building_standards_screen/controller/building_standards_controller.dart';
import '../unit_Inpection_screen/screen/unit_inspection_screen.dart';
import '../unit_Inpection_screen/unitinspection_controller.dart';

class UnitInspectionsummaryController extends BaseController {
  TextEditingController unitnumberoRname = TextEditingController();
  TextEditingController unitAddress = TextEditingController();
  TextEditingController bathrooms = TextEditingController();
  TextEditingController bedrooms = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController unithousekeeping = TextEditingController();
  TextEditingController generalphysicalcondition = TextEditingController();
  final GlobalKey<PopupMenuButtonState<int>> popupKey1 = GlobalKey();
  final GlobalKey<PopupMenuButtonState<int>> popupKey2 = GlobalKey();
  BuildingStandardsController _buildingStandardsController =
      Get.put(BuildingStandardsController());
  BuildingInspectionController _buildingInspectionController =
      Get.put(BuildingInspectionController());
  BuildingInspectionSummaryController _buildingInspectionSummaryController =
      Get.put(BuildingInspectionSummaryController());

  UnitController _unitController = Get.put(UnitController());
  List unithousekeepingList = [];
  List generalphysicalconditionList = [];
  List<String> cityList = [];
  var islaoding = false.obs;
  String inspectionName = '';
  String buildingname = '';
  String propertyname = '';

  var switchbtn = false.obs;
  List<DeficiencyArea> deficiencyArea = [];

  var inspectioninfo = {};
  var deficiencyinfo = [].obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      deficiencyArea = Get.arguments['deficiencyArea'];
     
    }
    setdataController();
    unithousekeepingList = [
      {
        "title": 'Poor',
        "value":
            "Damages to walls, hardware, doors, flooring, appliances beyond normal wear and tear."
      },
      {"title": 'Standards', "value": "No damage beyond normal wear and tear."},
      {"title": 'clean', "value": "No or minimal defect."}
    ];
    generalphysicalconditionList = [
      {
        "title": 'Poor',
        "value":
            "Bad odor, greasy stove, food left out, infestation, or clutter."
      },
      {"title": 'Standards', "value": "Generally clean with no clutter"},
      {"title": 'clean', "value": "Very clean and neat."}
    ];
    getdeficienyjson();
    update();

    super.onInit();
  }

  getinspectioninfojson() {
    inspectioninfo.addAll({
      "inspector_id":
          getStorageData.readString(getStorageData.inspectorId).toString(),
      "date": Get.arguments['inspectorDate'],
      "comment": "",
      "inspection_state_id": "1",
      "inspection_type_id": "1",
      "unit_house_keeping": unithousekeeping.text,
      "general_physical_condition": generalphysicalcondition.text
    });
    print("inspection data" + inspectioninfo.toString());
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

  void actionunitHousekeeping(value) {
    unithousekeeping.text = value;
  }

  void actiongeneralphysical(value) {
    generalphysicalcondition.text = value;
  }

  getUnitInspectionSummary() {
    update();
    return unitnumberoRname.text.isNotEmpty && unitAddress.text.isNotEmpty;
  }

  setdataController() {
    unitnumberoRname.text = Get.arguments['unitinfo']['name'] ?? "";
    unitAddress.text = Get.arguments['unitinfo']['address'];
    bathrooms.text = Get.arguments['unitinfo']['number_of_bathrooms'];
    bedrooms.text = Get.arguments['unitinfo']['number_of_bedrooms'];
    switchbtn.value = Get.arguments['switchvalue'];
    buildingname = Get.arguments['buildingInfo']['name'];
    propertyname = Get.arguments['propertyInfo']['name'];
  }

  getdeficienyjson() async {
    deficiencyinfo.clear();
    if (deficiencyArea.length > 0) {
      for (var i = 0; i < deficiencyArea.length; i++) {
        for (var j = 0;
            j < deficiencyArea[i].deficiencyInspectionsReqModel!.length;
            j++) {
          deficiencyinfo.add({
            "housing_deficiency_id": deficiencyArea[i]
                .deficiencyInspectionsReqModel![j]
                .deficiencyItemHousingDeficiency!
                .id,
            "deficiency_proof_pictures": await getdeficienyimage(),
            "comment":
                deficiencyArea[i].deficiencyInspectionsReqModel![j].comment,
            "date": deficiencyArea[i].deficiencyInspectionsReqModel![j].date
          });
        }
      }
      print("deficiency" + deficiencyinfo.toString());
    }
  }

  getdeficienyimage() {
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

  createinspection() async {
    islaoding.value = true;

    print("unit" + Get.arguments['unitinfo'].toString());
    print("buildinginfo" + Get.arguments['buildingInfo'].toString());
    print("property info" + Get.arguments['propertyInfo'].toString());
    print("building type info" + Get.arguments['buildingtype'].toString());
    print("certificate info" + Get.arguments['cerificateList'].toString());
    print("certificate info" + Get.arguments['inspectorDate'].toString());

    var response = await UnitsummaryRepository().createinspection(
        buildingjsons: Get.arguments['buildingInfo'],
        certificatelists: Get.arguments['cerificateList'],
        deficiencylists: deficiencyinfo,
        insepctionjsons: inspectioninfo,
        propertyjsons: Get.arguments['propertyInfo'],
        unitjsons: Get.arguments['unitinfo']);

    await response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
      islaoding.value = false;
      update();
    }, (r) async {
      utils.showSnackBar(
          context: Get.context!,
          message: "Unit inspection Submitted Successfully!!",
          isOk: true);
      _buildingStandardsController.cleardata();
      _buildingInspectionController.clearAllData();
      _buildingInspectionSummaryController.cleardata();
      await _buildingInspectionController.getCertificates();
      await Get.toNamed(BuildingInspectionScreen.routes);

      islaoding.value = false;
      update();
    });
  }

  saveCreateinspection() async {
    islaoding.value = true;
    // print("unit " + Get.arguments['unitinfo'].toString());
    // print("buildinginfo " + Get.arguments['buildingInfo'].toString());
    // print("property info " + Get.arguments['propertyInfo'].toString());
    // print("building type info " + Get.arguments['buildingtype'].toString());
    // print("certificate info " + Get.arguments['cerificateList'].toString());
    // print("certificate info " + Get.arguments['inspectorDate'].toString());
    var response = await UnitsummaryRepository().createinspection(
        buildingjsons: Get.arguments['buildingInfo'],
        certificatelists: Get.arguments['cerificateList'],
        deficiencylists: deficiencyinfo,
        insepctionjsons: inspectioninfo,
        propertyjsons: Get.arguments['propertyInfo'],
        unitjsons: Get.arguments['unitinfo']);

    await response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
      islaoding.value = false;
      update();
    }, (r) async {
      utils.showSnackBar(
          context: Get.context!,
          message: "Unit inspection Submitted Successfully!!",
          isOk: true);
      //  print("property info " + Get.arguments['propertyinfo'].toString());
      _unitController.cleardata();
      _unitController..getunitinspection();
      Get.back(result: {
        "propertyInfo":
            Get.arguments == null ? "" : Get.arguments['propertyInfo'],
        "buildingInfo":
            Get.arguments == null ? "" : Get.arguments['buildingInfo'],
        "buildingtype":
            Get.arguments == null ? "" : Get.arguments['buildingtype'],
        "cerificateList": Get.arguments['certificatesInfo'],
        "deficiencyArea": Get.arguments['deficiencyArea'],
        "switchvalue": switchbtn.value,
        "inspectorDate": Get.arguments['inspectorDate']
      });
      Get.back();
      islaoding.value = false;
      update();
    });
  }

  isDataUpdate(mainIndex, subIndex, deficiencyInspectionsReqModel) {
    deficiencyArea[mainIndex].deficiencyInspectionsReqModel?[subIndex] =
        deficiencyInspectionsReqModel[0];
    deficiencyArea[mainIndex]
        .deficiencyInspectionsReqModel?[subIndex]
        .isSuccess = true;
    update();
  }

  isDataUpdateSuccess(mainIndex, subIndex) {
    deficiencyArea[mainIndex].deficiencyInspectionsReqModel?.removeAt(subIndex);
    if (deficiencyArea[mainIndex].deficiencyInspectionsReqModel!.isEmpty) {
      deficiencyArea[mainIndex].isArea = false;
    }
    update();
  }
}
