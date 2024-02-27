import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/auth/signing_screen/signing_screen.dart';
import 'package:public_housing/screens/building_inspection_screen/models/certificate_model.dart';
import 'package:public_housing/screens/building_inspection_screen/repository/BudingInpection_repository.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/models/deficiency_inspections_req_model.dart';

class BuildingInspectionSummaryController extends BaseController {
  final GlobalKey<PopupMenuButtonState<int>> popupKey = GlobalKey();
  final GlobalKey<PopupMenuButtonState<int>> popupKey1 = GlobalKey();
  final GlobalKey<PopupMenuButtonState<int>> popupKey2 = GlobalKey();
  final GlobalKey<PopupMenuButtonState<int>> popupKey3 = GlobalKey();
  TextEditingController inspectorController = TextEditingController();
  TextEditingController inspectionDateController = TextEditingController();
  TextEditingController propertyNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController propertyIDController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController propertyAddressController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController yearConstructedController = TextEditingController();
  TextEditingController buildingTypeController = TextEditingController();
  List checked = [];
  List<String> propertyList = [];
  List<String> cityList = [];
  List<String> buildingList = [];
  List<String> buildingTypeList = [];
  bool? isData;
  String? buildingName = '';
  String inspectionName = '';
  var imagesList;
  List<DeficiencyArea> deficiencyArea = [];
  RxMap propertyInfo = {}.obs;
  RxMap buildingInfo = {}.obs;
  var certificatesInfo = [].obs;
  String inspectorName = '';
  String inspectorDate = '';

  List<Certificates>? certificates = [];

  @override
  void onInit() {
    if (Get.arguments != null) {
      print("certificate info" + Get.arguments['certificatesInfo'].toString());
      buildingName = Get.arguments['buildingName'];
      imagesList = Get.arguments['imagesList'];
      inspectionName = Get.arguments['inspectionName'];
      deficiencyArea = Get.arguments['deficiencyArea'];
      propertyInfo = Get.arguments['propertyInfo'];
      buildingInfo = Get.arguments['buildingInfo'];
      certificatesInfo = Get.arguments['certificatesInfo'];
      inspectorName = Get.arguments['inspectorName'];
      inspectorDate = Get.arguments['inspectorDate'];
      () async {
        await getCertificates();
      }();
      setControllerData(
          propertyInfo, buildingInfo, inspectorName, inspectorDate);
    }

    super.onInit();
  }

  getCertificatesJson() {
    certificatesInfo.clear();
    for (var i = 0; i < certificates!.length; i += 1) {
      if (checked[i]) {
        certificatesInfo.add({
          "id": certificates![i].id.toString(),
          "name": certificates![i].certificate.toString(),
        });
      }
    }
    update();
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
      Get.offAllNamed(SigningScreen.routes);
      getStorageData.removeData(getStorageData.isLogin);
    } else {
      message = 'Not implemented';
    }
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  bool? allSelected() {
    final data = checked.where((element) => element.isChecked == true);
    if (data.length == checked.length) {
      isData = true;
    } else if (data.length > 0) {
      isData = null;
    } else {
      isData = false;
    }
    update();
  }

  setControllerData(propertyInfo, buildingInfo, inspectorName, inspectorDate) {
    propertyNameController.text = propertyInfo['name'] ?? "";
    cityController.text = propertyInfo['city'] ?? "";
    propertyIDController.text = propertyInfo['id'] ?? "";
    stateController.text = propertyInfo['state'] ?? "";
    zipController.text = propertyInfo['zip'] ?? "";
    propertyAddressController.text = propertyInfo['address'] ?? "";
    buildingNameController.text = buildingInfo['name'] ?? "";
    yearConstructedController.text = propertyInfo['constructed_year'] ?? "";
    buildingTypeController.text = buildingInfo['building_type_id'] ?? "";
    inspectorController.text = inspectorName ?? "";
    inspectionDateController.text = inspectorDate ?? "";
    update();
  }

  getStartInspection() {
    return propertyNameController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        propertyIDController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        zipController.text.isNotEmpty &&
        propertyAddressController.text.isNotEmpty &&
        buildingNameController.text.isNotEmpty &&
        yearConstructedController.text.isNotEmpty &&
        buildingTypeController.text.isNotEmpty;
  }

  isAllSelected(value) {
    for (int i = 0; i < checked.length; i++) {
      checked[i].isChecked = value;
    }
    isData = value;
    update();
  }

  void actionPropertyNameSelected(value) {
    propertyNameController.text = propertyList[value];
  }

  void actionCitySelected(value) {
    cityController.text = cityList[value];
  }

  void buildingSelected(value) {
    buildingNameController.text = buildingList[value];
  }

  void buildingTypeSelected(value) {
    buildingTypeController.text = buildingTypeList[value];
  }

  getCertificates() async {
    var response = await BudingInpectionRepository().getcertificates();
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (CertificateModel r) {
      certificates = r.certificates;
      checked = List.filled(certificates!.length, false);

      for (int i = 0; i < certificates!.length; i++) {
        for (int j = 0; j < certificatesInfo.length; j++) {
          if (certificates![i].id.toString() ==
              certificatesInfo[j]['id'].toString()) {
            checked[i] = true;
          } else {
            checked[i] = false;
            // checked.add(false);
          }
        }
      }
    });
    update();
  }

  isDataUpdate(mainIndex, subIndex, deficiencyInspectionsReqModel) {
    deficiencyArea[mainIndex].deficiencyInspectionsReqModel?[subIndex] =
        deficiencyInspectionsReqModel[0];
    update();
  }
}

class CertificatesData {
  bool? isChecked;
  String? name;

  CertificatesData(this.isChecked, this.name);
}
