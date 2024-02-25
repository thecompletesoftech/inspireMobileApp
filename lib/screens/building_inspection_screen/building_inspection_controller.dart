import 'dart:convert';

import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/auth/signing_screen/signing_screen.dart';
import 'package:public_housing/screens/building_inspection_screen/models/building_model.dart';
import 'package:public_housing/screens/building_inspection_screen/models/property_model.dart';
import 'package:public_housing/screens/building_inspection_screen/repository/BudingInpection_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/accountmodel/account_model.dart';
import 'models/certificate_model.dart';

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
  TextEditingController buildingidController = TextEditingController();
  TextEditingController buildingTypeidController = TextEditingController();
  List checked = [];
  // List<String> propertyList = [];
  List<String> cityList = [];
  // List<String> buildingList = [];
  List<Building> buildingList = [];
  List<String> buildingTypeList = [];
  List<Properties>? propertyList = [];
  List<Certificates>? certificates = [];
  bool? isData;
  Account? account;
  var propertyinfo = {}.obs;
  var buildinginfo = {}.obs;
  var certificatesinfo = [].obs;
  @override
  void onInit() {
    // searchPropertyNameList == propertyList;
    // searchBuildingList == buildingList;
    getpropertyinfo();
    getcertificates();
    getaccount();
    getcurrentdate();
    // checked.addAll([
    //   Certificates(true, 'Boiler Certificate'),
    //   Certificates(false, 'Elevator Certificate'),
    //   Certificates(true, 'Fire Alarm Inspection Report'),
    //   Certificates(false, 'Lead-Based Paint Disclosure Form'),
    //   Certificates(true, 'Lead-Based Paint Inspection Report'),
    //   Certificates(false, 'Sprinkler System Certificate'),
    // ]);

    // propertyList = ['DATA 1', 'DATA 2', 'DATA 3', 'DATA 4'];

    cityList = ['CITY 1', 'CITY 2', 'CITY 3', 'CITY 4'];

    buildingTypeList = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];

    // buildingList = [
    //   'BUILDING 1',
    //   'BUILDING 2',
    //   'BUILDING 3',
    //   'BUILDING 4',
    //   'BUILDING 5'
    // ];

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

  getaccount() async {
    var accountdata = await getStorageData.readString(getStorageData.account);
    account = Account.fromJson(jsonDecode(accountdata.toString()));
    inspectorController.text = await account!.userName;
    update();
  }

  getcertificatesjson() {
    certificatesinfo.clear();
    for (var i = 0; i < certificates!.length; i += 1) {
      if (checked[i]) {
        certificatesinfo.add({"id": certificates![i].id.toString()});
        print(certificates![i].certificate.toString());
      }
    }
    print(certificatesinfo.toJson());
    update();
  }

  getpropertyjson() {
    propertyinfo.addAll({
      "id": propertyIDController.text,
      "name": propertyNameController.text,
      "city": cityController.text,
      "state": stateController.text,
      "zip": zipController.text,
      "address": propertyAddressController.text
    });
    print(propertyinfo.toString());
  }

  getbuildingjson() {
    buildinginfo.addAll({
      "id": buildingidController.text,
      "name": buildingNameController.text,
      "constructed_year": yearConstructedController.text,
      "building_type_id": buildingTypeidController.text
    });
    print(buildinginfo.toString());
    print(propertyinfo.toString());
  }

  getcurrentdate() {
    inspectionDateController.text = Utils().currentTime();
  }

  bool? allSelected() {
    final data = checked.where((element) => element == true);
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
            certificatesinfo.length > 0
        ? true
        : false;
    //  &&
    // buildingNameController.text.isNotEmpty;
    // &&
    // yearConstructedController.text.isNotEmpty &&
    // buildingTypeController.text.isNotEmpty;
  }

  isAllSelected(value) {
    for (int i = 0; i < checked.length; i++) {
      checked[i] = value;
    }
    isData = value;
    update();
  }

  void actionPropertyNameSelected(value) {
    propertyNameController.text = propertyList![value].name!;
  }

  void actionCitySelected(value) {
    cityController.text = cityList[value];
  }

  void buildingSelected(value) {
    buildingNameController.text = buildingList[value].name!;
  }

  void buildingTypeSelected(value) {
    buildingTypeController.text = buildingTypeList[value];
  }

  void actionProperty(Properties value) {
    propertyNameController.text = value.name!;
    cityController.text = value.city!;
    propertyIDController.text = value.id.toString();
    stateController.text = value.state!;
    zipController.text = value.zip!;
    propertyAddressController.text = value.address1!;
    update();
  }

  void actionBuilding(Building value) {
    buildingNameController.text = value.name;
    yearConstructedController.text = value.constructedYear.toString();
    buildingTypeController.text = value.buildingType.name.toString();
    buildingTypeidController.text = value.buildingType.id.toString();
    buildingidController.text = value.id.toString();
    update();
  }

  var searchPropertyNameList = [].obs;
  var searchBuildingList = [].obs;

  searchProperty({required String searchText}) async {
    searchPropertyNameList.clear();
    if (!utils.isValidationEmpty(searchText)) {
      for (int i = 0; i < propertyList!.length; i++) {
        if (propertyList![i]
            .name
            .toString()
            .toLowerCase()
            .contains(searchText.toString().toLowerCase())) {
          searchPropertyNameList.add(propertyList![i]);
          update();
        }
      }
    } else {
      searchPropertyNameList.addAll(propertyList!);
      update();
    }
  }

  searchBuilding({required String searchText}) async {
    await getpropertyinfo();
    update();
    searchBuildingList.clear();
    if (!utils.isValidationEmpty(searchText)) {
      for (int i = 0; i < buildingList.length; i++) {
        if (buildingList[i]
            .name
            .toString()
            .toLowerCase()
            .contains(searchText.toString().toLowerCase())) {
          searchBuildingList.add(buildingList[i]);
          update();
        }
      }
    } else {
      searchBuildingList.addAll(buildingList);
      update();
    }
  }

  getpropertyinfo() async {
    var response = await BudingInpectionRepository().getpropetyinfoapi();
    await response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (PropertyModel r) {
      propertyList = r.properties;
    });
    update();
  }

  getcertificates() async {
    var response = await BudingInpectionRepository().getcertificates();
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (CertificateModel r) {
      certificates = r.certificates;
      checked = List.filled(certificates!.length, false);
    });
    update();
  }

  getbuildingapi(id) async {
    var response = await BudingInpectionRepository().getbuilding(id);
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (BuildingModel r) {
      buildingList = r.buildings;
      searchBuildingList.value = buildingList;
      print("building" + searchBuildingList.toString());
      // buildingList = r;
    });
    update();
  }
}

// class Certificates {
//   bool? isChecked;
//   String? name;

//   Certificates(this.isChecked, this.name);
// }
