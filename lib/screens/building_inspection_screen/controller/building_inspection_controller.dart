import 'package:public_housing/screens/building_list_screen/model/property_data_model.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart';
import '../../properties_list_screen/controller/properties_list_controller.dart';
import '../models/certificate_model.dart';
import 'package:public_housing/commons/all.dart';
import '../../../Models/accountmodel/account_model.dart';
import 'package:public_housing/screens/auth/signing_screen/screen/signing_screen.dart';
import 'package:public_housing/screens/building_inspection_screen/models/property_model.dart';
import 'package:public_housing/screens/building_inspection_screen/models/building_model.dart';
import 'package:public_housing/screens/building_inspection_screen/models/create_building_request_model.dart';
import 'package:public_housing/screens/building_inspection_screen/repository/building_inspection_repository.dart';

class BuildingInspectionController extends BaseController {
  final GlobalKey<PopupMenuButtonState<int>> popupKey = GlobalKey();

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
  TextEditingController buildingIdController = TextEditingController();
  TextEditingController buildingTypeIdController = TextEditingController();
  List checked = [];
  BuildingInspectionRepository buildingInspectionRepository =
      BuildingInspectionRepository();
  BuildingsData buildingsData = BuildingsData();
  List<String> cityList = [];
  List<Building> buildingList = [];
  List<String> buildingTypeList = [];
  List<Properties>? propertyList = [];
  List<Certificates>? certificates = [];
  bool? isCheckAllCertificate;
  Account? account;
  var propertyInfo = {}.obs;
  var buildingInfo = {}.obs;
  RxList<Certificates> certificatesInfo = <Certificates>[].obs;
  List<BuildingType> buildingTypes = [];
  bool isSelected = false;
  bool isManually = false;
  PropertyDataModel propertyDataModel = PropertyDataModel();

  @override
  void onInit() {
    if (Get.arguments['isManually'] != null) {
      isManually = Get.arguments['isManually'];
    }
    if (Get.arguments['buildingsData'] != null) {
      buildingsData = Get.arguments['buildingsData'];
    }
    if (Get.arguments['propertyDataModel'] != null) {
      propertyDataModel = Get.arguments['propertyDataModel'];
    }

    clearAllData();
    getPropertyInfo();
    getCertificates();
    getBuildingType();
    getCurrentDate();
    () async {
      account = await getAccount();
    };
    update();
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
      getStorageData.removeData(getStorageData.isLogin);
      getStorageData.removeData(getStorageData.baseURL);
      Get.offAllNamed(SigningScreen.routes);
    } else {
      message = 'Not implemented';
    }
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  getCertificatesJson() {
    certificatesInfo.clear();
    for (var i = 0; i < certificates!.length; i += 1) {
      if (checked[i]) {
        certificatesInfo.add(Certificates(
            id: certificates![i].id,
            certificate: certificates![i].certificate.toString()));
        // certificatesInfo.add({"id": certificates![i].id.toString()});
        print(certificates![i].certificate.toString());
      }
    }
  }

  getPropertyJson() {
    propertyInfo.addAll({
      "id": propertyIDController.text,
      "name": propertyNameController.text,
      "city": cityController.text,
      "state": stateController.text,
      "zip": zipController.text,
      "address": propertyAddressController.text
    });
    print(propertyInfo.toString());
  }

  getBuildingJson() {
    buildingInfo.addAll({
      "id": buildingIdController.text,
      "name": buildingNameController.text,
      "constructed_year": yearConstructedController.text == "null" ||
              yearConstructedController.text == ""
          ? "0"
          : yearConstructedController.text,
      "building_type_id": buildingTypeIdController.text
    });
    print(buildingInfo.toString());
    print(propertyInfo.toString());
  }

  getCurrentDate() {
    inspectionDateController.text = Utils().currentTime();
  }

  // allSelected() {
  //   final data = checked.where((element) => element == true);
  //   if (data.length == checked.length) {
  //     isCheckAllCertificate = true;
  //   } else if (data.length > 0) {
  //     isCheckAllCertificate = null;
  //   } else {
  //     isCheckAllCertificate = false;
  //   }
  //   update();
  // }

  isCertificateSelection({int? index, bool isAllSelectionChange = false}) {
    if (index != null) {
      checked[index] = !checked[index];
      final data = checked.where((element) => element);
      if (data.length == checked.length) {
        isCheckAllCertificate = true;
      } else if (data.length > 0) {
        isCheckAllCertificate = null;
      } else {
        isCheckAllCertificate = false;
      }
    }
    if (isAllSelectionChange) {
      isCheckAllCertificate =
          isCheckAllCertificate != null ? !isCheckAllCertificate! : false;
      for (int i = 0; i < checked.length; i++) {
        checked[i] = isCheckAllCertificate;
      }
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
            buildingNameController.text.isNotEmpty &&
            yearConstructedController.text.isNotEmpty &&
            buildingTypeController
                .text.isNotEmpty /*&&
            certificatesInfo.length > 0*/
        ? true
        : false;
    //  &&
    // buildingNameController.text.isNotEmpty;
    // &&
    // yearConstructedController.text.isNotEmpty &&
    // buildingTypeController.text.isNotEmpty;
  }

// isAllSelected(value) {
//   for (int i = 0; i < checked.length; i++) {
//     checked[i] = value;
//   }
//   isCheckAllCertificate = value;
//   getCertificatesJson();
// }

  actionProperty(Properties value) async {
    buildingNameController.clear();
    yearConstructedController.clear();
    buildingTypeController.clear();
    buildingTypeIdController.clear();
    buildingIdController.clear();
    // await getbuildingapi(value.id.toString());
    propertyNameController.text = value.name!;
    cityController.text = value.city!;
    propertyIDController.text = value.id.toString();
    stateController.text = value.state!;
    zipController.text = value.zip!;
    propertyAddressController.text = value.address1!;
    certificatesInfo.value = [];
    update();
  }

  clearAllData() {
    buildingNameController.clear();
    yearConstructedController.clear();
    buildingTypeController.clear();
    buildingTypeIdController.clear();
    buildingIdController.clear();
    propertyNameController.clear();
    propertyAddressController.clear();
    cityController.clear();
    propertyIDController.clear();
    stateController.clear();
    zipController.clear();
  }

  void actionBuilding(Building value) {
    isSelected = true;
    buildingNameController.text = value.name;
    buildingIdController.text = value.id.toString();
    yearConstructedController.text = value.constructedYear.toString();
    buildingTypeController.text = value.buildingType.name.toString();
    buildingTypeIdController.text = value.buildingType.id.toString();
    update();
  }

  void actionBuildingType(BuildingType value) {
    buildingTypeController.text = value.name.toString();
    buildingTypeIdController.text = value.id.toString();
    update();
  }

  var searchPropertyNameList = [];
  var searchBuildingList = [];
  var searchBuildingTypeList = [];

  bool isEdited() {
    bool isData;

    if (isSelected == true) {
      isData = yearConstructedController.text == "null" ? false : true;
      return isData;
    } else {
      isData = false;
    }
    return isData;
  }

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

  searchBuilding({required String searchText}) {
    isSelected = false;
    searchBuildingList.clear();
    if (buildingNameController.text.length > 0) {
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

  searchBuildingType({required String searchText}) {
    searchBuildingTypeList.clear();
    if (buildingTypeController.text.length > 0) {
      for (int i = 0; i < buildingTypes.length; i++) {
        if (buildingTypes[i]
            .name
            .toString()
            .toLowerCase()
            .contains(searchText.toString().toLowerCase())) {
          searchBuildingTypeList.add(buildingTypes[i]);
          update();
        }
      }
    } else {
      searchBuildingTypeList.addAll(buildingTypes);
      update();
    }
  }

  getPropertyInfo() async {
    propertyList!.clear();
    var response = await buildingInspectionRepository.getPropertyInfoApi();
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (PropertyModel r) {
      propertyList = r.properties;
      searchProperty(searchText: "");
    });
    update();
  }

  getCertificates() async {
    var response = await buildingInspectionRepository.getCertificates();
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (CertificateModel r) {
      certificates = r.certificates;
      checked = List.filled(certificates!.length, false);
    });
    buildingsData.certificateList?.forEach((certificate) {
      if (certificate.id != null) {
        if (certificate.id! <= checked.length) {
          checked[certificate.id! - 1] = true;
        }
      }
    });
    certificatesInfo = buildingsData.certificateList?.isNotEmpty ?? false
        ? RxList(List<Certificates>.from(buildingsData.certificateList!
            .map<Certificates>((e) => Certificates.fromJson(e.toJson()))))
        : RxList([]);
    if (certificatesInfo.isEmpty) {
      isCheckAllCertificate = false;
    } else {
      if (certificatesInfo.length == certificates?.length) {
        isCheckAllCertificate = true;
      } else {
        isCheckAllCertificate = null;
      }
    }
    update();
  }

  getBuildingType() async {
    var response = await buildingInspectionRepository.getBuildingType();
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (r) {
      if (r.buildingTypes!.isNotEmpty) {
        r.buildingTypes?.forEach((element) {
          buildingTypes.add(BuildingType(
              id: element.id ?? 0,
              name: element.name ?? "",
              description: element.description));
        });
      }
    });
    update();
  }

  createBuilding() async {
    CreateBuildingRequestModel createBuildingRequestModel =
        CreateBuildingRequestModel(
      state: stateController.text,
      city: cityController.text,
      name: buildingNameController.text,
      constructedYear: yearConstructedController.text,
      buildingTypeId: buildingTypeIdController.text,
      address1: propertyAddressController.text,
      propertyId: int.tryParse(propertyIDController.text),
      zip: zipController.text,
    );

    var response = await buildingInspectionRepository.createBuildings(
        createBuildingRequestModel: createBuildingRequestModel);
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (r) {
      buildingInfo.addAll({
        "id": r.building?.id.toString(),
        "name": r.building?.name.toString(),
        "constructed_year": r.building?.constructedYear.toString(),
        "building_type_id": r.building?.buildingType?.id.toString(),
      });
    });
    update();
  }

  getBuildingApi(value) async {
    buildingList.clear();
    var response = await buildingInspectionRepository.getBuilding(value.id);
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (BuildingModel r) {
      buildingList = r.buildings;
      searchBuilding(searchText: "");
    });
    update();
  }

  setLocalCertificateData() async {
    getCertificatesJson();
    buildingsData.certificateList = certificatesInfo.isNotEmpty
        ? List.from(certificatesInfo
            .map<Certificates>((e) => Certificates.fromJson(e.toJson())))
        : [];
    await hiveMethodsProvider.setDailySchedulesData(DailySchedulesResponseModel(
            scheduleData:
                Get.find<PropertiesListController>().scheduleMainDataList)
        .toJson());
  }
}
