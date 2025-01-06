import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/auth/model/inspector_model.dart';
import 'package:public_housing/screens/auth/repository/login_repository.dart';
import 'package:public_housing/screens/building_inspection_screen/controller/building_inspection_controller.dart';
import 'package:public_housing/screens/building_inspection_screen/models/certificate_model.dart';
import 'package:public_housing/screens/building_inspection_screen/repository/building_inspection_repository.dart';
import 'package:public_housing/screens/building_inspection_summary/model/create_inspection_request_model.dart';
import 'package:public_housing/screens/building_inspection_summary/repository/building_inspection_summry_repository.dart';
import 'package:public_housing/screens/building_list_screen/screen/building_list_screen.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart'
    as daily;
import 'package:public_housing/screens/unit_inspection_screen/screen/unit_inspection_screen.dart';
import 'package:public_housing/screens/unit_list_screen/screen/unit_list_screen.dart';

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
  bool? isData;
  String? buildingName = '';
  String? buildingType = '';
  String? propertyName = '';
  String inspectionName = '';
  var imagesList;
  List<DeficiencyArea> deficiencyArea = [];
  RxMap propertyInfo = {}.obs;
  RxMap buildingInfo = {}.obs;
  var certificatesInfo = [].obs;
  String inspectorName = '';
  String inspectorDate = '';
  BuildingInspectionController buildingInspectionController =
      Get.put(BuildingInspectionController());
  List<Certificates>? certificates = [];
  bool isManually = false;
  daily.ScheduleInspection propertyData = daily.ScheduleInspection();
  int buildingId = 0;
  daily.ScheduleInspectionBuilding scheduleInspectionBuilding =
      daily.ScheduleInspectionBuilding();

  @override
  void onInit() {
    deficiencyArea = [];
    if (Get.arguments['propertyData'] != null) {
      propertyData = Get.arguments['propertyData'];
    }

    if (Get.arguments['buildingId'] != null) {
      buildingId = Get.arguments['buildingId'];
      getUnitData();
    }

    if (Get.arguments['isManually'] != null) {
      isManually = Get.arguments['isManually'];
    }
    if (Get.arguments != null) {
      buildingName = Get.arguments['buildingName'];
      buildingType = Get.arguments['buildingtype'];
      propertyName = Get.arguments['propertyInfo']['name'];
      imagesList = Get.arguments['imagesList'];
      inspectionName = Get.arguments['inspectionName'];
      deficiencyArea = Get.arguments['deficiencyArea'];
      propertyInfo = Get.arguments['propertyInfo'];
      buildingInfo = Get.arguments['buildingInfo'];
      certificatesInfo = Get.arguments['certificatesInfo'];
      inspectorName = Get.arguments['inspectorName'];
      inspectorDate = Get.arguments['inspectorDate'];

      createInspector(
          inspectorName: buildingInspectionController.account?.userName ?? "");

      () async {
        Future.delayed(const Duration(milliseconds: 1), () async {
          await getCertificates();
          getCertificatesJson();
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

  getUnitData() {
    propertyData.scheduleInspectionBuildings?.forEach(
      (element) {
        if (element.id == buildingId) {
          scheduleInspectionBuilding.id = element.id;
          scheduleInspectionBuilding.scheduleInspectionUnits =
              element.scheduleInspectionUnits;
          scheduleInspectionBuilding.building = element.building;
          scheduleInspectionBuilding.isBuildingInspection =
              element.isBuildingInspection;
        }
      },
    );
    update();
  }

  getCertificatesJson() {
    certificatesInfo.clear();
    for (var i = 0; i < certificates!.length; i += 1) {
      if (checked[i]) {
        certificatesInfo.add({"id": certificates![i].id.toString()});
      }
    }
    update();
  }

  allSelected() {
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

  setControllerData(propertyInfo, buildingInfo, inspectorName, inspectorDate) {
    propertyNameController.text = propertyInfo['name'] ?? "";
    cityController.text = propertyInfo['city'] ?? "";
    propertyIDController.text = propertyInfo['id'].toString() ?? "";
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
    var response = await buildingInspectionRepository.getCertificates();
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (CertificateModel r) {
      certificates = r.certificates;
      checked = List.filled(certificates!.length, false);

      certificatesInfo.forEach((e) {
        int index = certificates!.indexWhere(
            (element) => element.id.toString() == e['id'].toString());
        checked[index] = true;
      });
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
      certificates.add(Certificate(id: element['id']));
    });

    CreateInspectionRequestModel createInspectionRequestModel =
        CreateInspectionRequestModel(
      building: Building(
        id: buildingInfo['id'].toString(),
        buildingTypeId: buildingInfo['building_type_id'].toString(),
        constructedYear: buildingInfo['constructed_year'].toString(),
        name: buildingInfo['name'],
      ),
      certificates: certificates,
      deficiencyInspections: deficiencyInspections,
      inspection: Inspection(
        date: DateTime.parse(inspectionDateController.text),
        comment: '',
        inspectionStateId: '1',
        inspectionTypeId: '1',
        inspectorId: inspectorInfo['id'].toString(),
      ),
      property: Property(
        name: propertyInfo['name'],
        id: propertyInfo['id'].toString(),
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
      if (isManually) {
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
          "inspectorDate": inspectorDate,
          "isManually": isManually
        });
      } else {
        Get.toNamed(UnitListScreen.routes, arguments: {
          'externalBuilding': scheduleInspectionBuilding,
          "propertyData": propertyData,
          "isManually": isManually
        });
      }
    });
    // update();
  }
}
