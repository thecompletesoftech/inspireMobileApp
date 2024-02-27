import 'package:public_housing/screens/unitinspectionsummary_screen/repository/unitinspection_repository.dart';
import '../../commons/all.dart';
import '../building_inspection_screen/building_inspection_screen.dart';

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
  List unithousekeepingList = [];
  List generalphysicalconditionList = [];
  List<String> cityList = [];
  String inspectionName = '';
  var dataList = [
    RxCommonModel(
      title: "D1. Cabinets are missing",
      status: "false",
      image: ImagePath.kitchen,
      imgId: ImagePath.cabinets,
    ),
    RxCommonModel(
      title: "D3. Refrigerator is missing",
      image: ImagePath.cooking,
      imgId: ImagePath.bedroom,
      status: "false",
    ),
  ];
  var switchbtn = false.obs;

  var inspectioninfo = {}.obs;
  @override
  void onInit() {
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
    super.onInit();
  }

  getinspectioninfojson() {
    inspectioninfo.value = {};
    inspectioninfo.addAll({
      "inspector_id":
          getStorageData.readString(getStorageData.inspectorId).toString(),
      "date": "2023-12-12",
      "comment": "A test inspection",
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
    unitnumberoRname.text = Get.arguments['unitinfo']['name'];
    unitAddress.text = Get.arguments['unitinfo']['address'];
    bathrooms.text = Get.arguments['unitinfo']['number_of_bathrooms'];
    bedrooms.text = Get.arguments['unitinfo']['number_of_bedrooms'];
    switchbtn.value = Get.arguments['switchvalue'];
  }

  createinspection() async {
    print("unit" + Get.arguments['unitinfo'].toString());
    print("buildinginfo" + Get.arguments['buildinginfo'].toString());
    print("property info" + Get.arguments['propertyinfo'].toString());
    print("building type info" + Get.arguments['buildingtype'].toString());
    print("certificate info" + Get.arguments['cerificateList'].toString());

    var response = await UnitsummaryRepository().createinspection(
        buildingjsons: Get.arguments['buildinginfo'],
        certificatelists: Get.arguments['cerificateList'],
        deficiencylists: [
          {
            "housing_deficiency_id": "1",
            "deficiency_proof_pictures": [
              {
                "picture_path":
                    "http://thor.gccs.local:8000/media/thor.gccs.gilsonsoftware.com/inspection/2024/02/10/images (2).jpeg",
                "comment": "pic comment 1"
              },
              {
                "picture_path":
                    "http://thor.gccs.local:8000/media/thor.gccs.gilsonsoftware.com/inspection/2024/02/10/images (2).jpeg",
                "comment": "pic comment 2"
              }
            ],
            "comment": "deficiency commet 1"
          }
        ],
        insepctionjsons: inspectioninfo.values,
        propertyjsons: Get.arguments['propertyinfo'],
        unitjsons: Get.arguments['unitinfo']);

    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (r) {
      Get.toNamed(BuildingInspectionScreen.routes);
    });
    update();
  }
}
