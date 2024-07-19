import 'package:public_housing/Models/accountmodel/account_model.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/auth/model/inspector_model.dart';
import 'package:public_housing/screens/auth/repository/login_repository.dart';
import 'package:public_housing/screens/building_inspection_screen/models/certificate_model.dart';
import 'package:public_housing/screens/building_inspection_screen/repository/building_inspection_repository.dart';
import 'package:public_housing/screens/building_inspection_summary/model/create_inspection_request_model.dart';
import 'package:public_housing/screens/building_inspection_summary/repository/building_inspection_summry_repository.dart';
import 'package:public_housing/screens/building_list_screen/model/property_data_model.dart';
import 'package:public_housing/screens/building_standards_screen/controller/building_standards_controller.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart';
import 'package:public_housing/screens/unit_inspection_screen/screen/unit_inspection_screen.dart';
import '../../properties_list_screen/controller/properties_list_controller.dart';

class BuildingInspectionSummaryController extends BaseController {
  final GlobalKey<PopupMenuButtonState<int>> popupKey1 = GlobalKey();
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
  BuildingInspectionSummaryRepository buildingInspectionSummaryRepository =
      BuildingInspectionSummaryRepository();
  LoginRepository loginRepository = LoginRepository();
  RxMap inspectorInfo = {}.obs;
  bool isSuccess = false;
  BuildingInspectionRepository buildingInspectionRepository =
      BuildingInspectionRepository();

  List<DeficiencyInspection>? deficiencyInspections = [];
  List checked = [];
  List<String> propertyList = [];
  List<String> cityList = [];
  List<String> buildingList = [];
  List<String> buildingTypeList = [];
  bool? isCheckAllCertificate;
  String? buildingName = '';
  String? buildingType = '';
  String? propertyName = '';
  String inspectionName = '';
  var imagesList;
  List<DeficiencyArea> deficiencyArea = [];
  RxMap propertyInfo = {}.obs;
  RxMap buildingInfo = {}.obs;
  List<Certificates> certificatesInfo = [];
  String inspectorName = '';
  String inspectorDate = '';
  List<Certificates>? certificates = [];
  bool isManually = false;
  BuildingsData buildingsData = BuildingsData();
  PropertyDataModel propertyDataModel = PropertyDataModel();
  Account? account;

  @override
  void onInit() {
    deficiencyArea.clear();
    if (Get.arguments['propertyDataModel'] != null) {
      propertyDataModel = Get.arguments['propertyDataModel'];
    }
    if (Get.arguments['buildingsData'] != null) {
      buildingsData = Get.arguments['buildingsData'];
    }
    if (Get.arguments['inspectorName'] != null) {
      inspectorName = Get.arguments['inspectorName'];
    }
    if (Get.arguments['inspectorDate'] != null) {
      inspectorDate = Get.arguments['inspectorDate'];
    }
    if (Get.arguments['buildingDataModelList'] != null) {
      // buildingsModelList = Get.arguments['buildingsModelList'];
      // deficiencyArea = getSelectedDeficiencyAreaList(
      //     buildingDataModelList: Get.arguments['buildingDataModelList']);
    }

    if (Get.arguments != null) {
      isManually = Get.arguments['isManually'];
      buildingName = Get.arguments['buildingName'];
      buildingType = Get.arguments['buildingtype'];
      propertyName = Get.arguments['propertyInfo']['name'];
      imagesList = Get.arguments['imagesList'];
      inspectionName = Get.arguments['inspectionName'];
      deficiencyArea = Get.arguments['deficiencyArea'];
      propertyInfo = Get.arguments['propertyInfo'];
      buildingInfo = Get.arguments['buildingInfo'];
      certificatesInfo = Get.arguments['certificatesInfo'] ?? [];

      () async {
        Future.delayed(const Duration(milliseconds: 1), () async {
          await getCertificates();
          getCertificatesJson();
          account = await getAccount();
          createInspector(inspectorName: account?.userName ?? "");
        });
      }();

      setControllerData(
          propertyInfo, buildingInfo, inspectorName, inspectorDate);
    }
    super.onInit();
  }

  clearData() {
    deficiencyArea.clear();
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
    update();
  }

  allSelected() {
    final data = checked.where((element) => element == true);
    if (data.length == checked.length) {
      isCheckAllCertificate = true;
    } else if (data.length > 0) {
      isCheckAllCertificate = null;
    } else {
      isCheckAllCertificate = false;
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
    buildingNameController.text = buildingInfo['name'].toString();
    yearConstructedController.text =
        buildingInfo['constructed_year'].toString();
    buildingTypeController.text = Get.arguments['buildingtype'] ?? "";
    inspectorController.text = inspectorName ?? "";
    inspectionDateController.text = inspectorDate ?? "";
    update();
  }

  isAllSelected(value) {
    for (int i = 0; i < checked.length; i++) {
      checked[i] = value;
    }
    isCheckAllCertificate = value;
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

  getCertificates() async {
    var response = await buildingInspectionRepository.getCertificates();
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (CertificateModel r) {
      certificates = r.certificates;
      checked = List.filled(certificates!.length, false);
      certificatesInfo.forEach((e) {
        int index = certificates!
            .indexWhere((element) => element.id.toString() == e.id.toString());
        checked[index] = true;
      });
      if (certificatesInfo.isEmpty) {
        isCheckAllCertificate = false;
      } else {
        if (certificatesInfo.length == certificates?.length) {
          isCheckAllCertificate = true;
        } else {
          isCheckAllCertificate = null;
        }
      }
    });
    update();
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

  createInspector({required String inspectorName}) async {
    var response = await loginRepository.createInspector(name: inspectorName);
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (InspectorModel r) {
      inspectorInfo.addAll({
        "id": r.inspector.id,
        "name": r.inspector.name,
        "externalPersonalId": r.inspector.externalPersonalId,
        "externalAccountId": r.inspector.externalAccountId
      });
      getStorageData.saveString(getStorageData.inspectorId, r.inspector.id);
    });
    update();
  }

  createInspection() async {
    deficiencyInspections = [];
    isSuccess = false;
    deficiencyArea.forEach((element) {
      element.deficiencyInspectionsReqModel?.forEach((e) {
        List<DeficiencyProofPicture> pictureList = [];
        e.deficiencyProofPictures?.forEach((pictureString) {
          pictureList.add(DeficiencyProofPicture(picturePath: pictureString));
        });

        deficiencyInspections?.add(DeficiencyInspection(
          housingDeficiencyId: int.tryParse(
                  e.deficiencyItemHousingDeficiency?.id.toString() ?? "")
              .toString(),
          comment: e.comment,
          date: e.date,
          deficiencyProofPictures: pictureList,
        ));
      });
    });
    print("defieciency" + deficiencyInspections.toString());
    List<Certificate>? certificates = [];
    certificatesInfo.forEach((element) {
      certificates.add(Certificate(id: element.id.toString()));
    });

    CreateInspectionRequestModel createInspectionRequestModel =
        CreateInspectionRequestModel(
      building: BuildingData(
        id: buildingInfo['id'],
        buildingTypeId: buildingInfo['building_type_id'],
        constructedYear: buildingInfo['constructed_year'],
        name: buildingInfo['name'],
      ),
      certificates: certificates,
      deficiencyInspections: deficiencyInspections,
      inspection: Inspection(
        date: DateTime.now(),
        comment: '',
        inspectionStateId: '1',
        inspectionTypeId: '1',
        inspectorId: inspectorInfo['id'].toString(),
      ),
      property: PropertyData(
        name: propertyInfo['name'],
        id: propertyInfo['id'],
        address: propertyInfo['address'],
        city: propertyInfo['city'],
        state: propertyInfo['state'],
        zip: propertyInfo['zip'],
      ),
    );

    var response = await buildingInspectionSummaryRepository.getDeficiencyAreas(
        createInspectionRequestModel: createInspectionRequestModel);

    response.fold((l) {
      isSuccess = false;
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (r) {
      utils.showSnackBar(
          context: Get.context!,
          message: "Building  inspection Submitted Successfully!!",
          isOk: true);
      isSuccess = true;
      Get.toNamed(UnitInspection.routes, arguments: {
        "deficiencyArea": deficiencyArea,
        "buildingName": buildingName,
        "buildingtype": buildingType,
        "imagesList": imagesList,
        "inspectionName": inspectionName,
        "propertyInfo": propertyInfo,
        "buildingInfo": buildingInfo,
        "certificatesInfo": certificatesInfo,
        "inspectorName": inspectorName,
        "inspectorDate": inspectorDate
      });
    });
    // update();
  }

  setLocalCertificateData() async {
    getCertificatesJson();
    buildingsData.certificateList = certificatesInfo.isNotEmpty
        ? List.from(certificatesInfo
            .map<Certificates>((e) => Certificates.fromJson(e.toJson())))
        : [];
    debugPrint(
        'scheduleMainDataList -------> ${Get.find<PropertiesListController>().scheduleMainDataList}');

    await hiveMethodsProvider.setDailySchedulesData(DailySchedulesResponseModel(
            scheduleData:
                Get.find<PropertiesListController>().scheduleMainDataList)
        .toJson());
  }

  List<DeficiencyArea> getSelectedDeficiencyAreaList(
      {required List<BuildingDataModel> buildingDataModelList}) {
    List<DeficiencyArea> deficiencyAreaList = [];
    buildingDataModelList.forEach((buildingDataModel) {
      buildingDataModel.deficiencyAreaList?.forEach((deficiencyArea) {
        if (deficiencyArea.isArea == true) {
          // DeficiencyArea copiedDeficiencyArea =
          //     DeficiencyArea.fromJson(deficiencyArea.toJson());
          // List<DeficiencyAreaItem> deficiencyAreaItemList = [];
          // copiedDeficiencyArea.deficiencyAreaItems
          //     ?.forEach((deficiencyAreaItem) {
          //   if (deficiencyAreaItem.isDeficiencyCheck) {
          //     DeficiencyAreaItem copiedDeficiencyAreaItem =
          //         DeficiencyAreaItem.fromJson(deficiencyAreaItem.toJson());
          //     deficiencyAreaItemList.add(copiedDeficiencyAreaItem);
          //   }
          // });
          // copiedDeficiencyArea.deficiencyAreaItems = deficiencyAreaItemList;
          deficiencyAreaList.add(deficiencyArea);
        }
      });
    });
    return deficiencyAreaList;
  }
}
