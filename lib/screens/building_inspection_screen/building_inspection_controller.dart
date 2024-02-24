import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/auth/signing_screen/signing_screen.dart';

import '../../Models/BuildingstypeModel/buildingtype_model.dart';
import '../../Models/CertificateModel/certificate_model.dart';
import '../../Models/buildingModel/building_model.dart';
import '../../Models/propertymodel/property_model.dart';

class BuildingInspectionController extends BaseController {
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
  List<Certificates> checked = [];
  List<String> propertyList = [];
  List<String> cityList = [];
  List<String> buildingList = [];
  List<String> buildingTypeList = [];
  bool? isData;
  var property = <Properties>[].obs;
  var buildings = <Buildings>[].obs;
  var certificatesdata = <Certificates>[].obs;
  var buildingTypes = <BuildingTypes>[].obs;
  @override
  void onInit() {
    checked.addAll([
      Certificates(true, 'Boiler Certificate'),
      Certificates(false, 'Elevator Certificate'),
      Certificates(true, 'Fire Alarm Inspection Report'),
      Certificates(false, 'Lead-Based Paint Disclosure Form'),
      Certificates(true, 'Lead-Based Paint Inspection Report'),
      Certificates(false, 'Sprinkler System Certificate'),
    ]);

    propertyList = ['DATA 1', 'DATA 2', 'DATA 3', 'DATA 4'];

    cityList = ['CITY 1', 'CITY 2', 'CITY 3', 'CITY 4'];

    buildingTypeList = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];

    buildingList = [
      'BUILDING 1',
      'BUILDING 2',
      'BUILDING 3',
      'BUILDING 4',
      'BUILDING 5'
    ];

    super.onInit();
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

  getpropertydata() async {
    final data = await GetAPIFunction().apiCall(
      context: Get.context!,
      apiName: Constants.propertylist,
      token: getStorageData.readObject(getStorageData.token),
    );

    PropertyModel model = PropertyModel.fromJson(data);
    if (model.type == "SUCCESS") {
      if (model.properties!.length > 0) {
        property.value = model.properties!;
        update();
      } else {}
      update();
    } else if (model.type == "FAILED") {
      // utils.showSnackBar(context: Get.context!, message: model.responseMsg!);
    }
  }

  getbuildingdata() async {
    final data = await GetAPIFunction().apiCall(
      context: Get.context!,
      apiName: Constants.buildingslist,
      token: getStorageData.readObject(getStorageData.token),
    );

    BuildingModel model = BuildingModel.fromJson(data);
    if (model.type == "SUCCESS") {
      if (model.buildings!.length > 0) {
        buildings.value = model.buildings!;
        update();
      } else {}
      update();
    } else if (model.type == "FAILED") {
      // utils.showSnackBar(context: Get.context!, message: model.responseMsg!);
    }
  }

  getCertificatesdata() async {
    final data = await GetAPIFunction().apiCall(
      context: Get.context!,
      apiName: Constants.certificatesList,
      token: getStorageData.readObject(getStorageData.token),
    );

    CertificateModel model = CertificateModel.fromJson(data);
    if (model.type == "SUCCESS") {
      if (model.certificates!.length > 0) {
        certificatesdata.value = model.certificates!.cast<Certificates>();
        update();
      } else {}
      update();
    } else if (model.type == "FAILED") {
      // utils.showSnackBar(context: Get.context!, message: model.responseMsg!);
    }
  }

  getBuildingTypedata() async {
    final data = await GetAPIFunction().apiCall(
      context: Get.context!,
      apiName: Constants.certificatesList,
      token: getStorageData.readObject(getStorageData.token),
    );

    BuildingTypesModel model = BuildingTypesModel.fromJson(data);
    if (model.type == "SUCCESS") {
      if (model.type!.length > 0) {
        buildingTypes.value = model.buildingTypes!;
        update();
      } else {}
      update();
    } else if (model.type == "FAILED") {
      // utils.showSnackBar(context: Get.context!, message: model.responseMsg!);
    }
  }
}

class Certificates {
  bool? isChecked;
  String? name;

  Certificates(this.isChecked, this.name);
}
