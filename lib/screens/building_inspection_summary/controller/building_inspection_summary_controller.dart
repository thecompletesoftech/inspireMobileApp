import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/auth/model/Inspectormodel.dart';
import 'package:public_housing/screens/auth/repository/log_repo.dart';
import 'package:public_housing/screens/building_inspection_screen/controller/building_inspection_controller.dart';
import 'package:public_housing/screens/building_inspection_screen/models/certificate_model.dart';
import 'package:public_housing/screens/building_inspection_screen/repository/BudingInpection_repository.dart';
import 'package:public_housing/screens/building_inspection_summary/model/create_inspection_request_model.dart';
import 'package:public_housing/screens/building_inspection_summary/repository/building_inspection_summry_repo.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';

import '../../unit_Inpection_screen/screen/unit_inspection_screen.dart';

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
  String? buildingtype = '';
  String? propertyname = '';
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

  @override
  void onInit() {
    deficiencyArea = [];
    if (Get.arguments != null) {
      buildingName = Get.arguments['buildingName'];
      buildingtype = Get.arguments['buildingtype'];
      propertyname = Get.arguments['propertyInfo']['name'];
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

  cleardata() {
    deficiencyArea.clear();
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
    propertyIDController.text = propertyInfo['id'] ?? "";
    stateController.text = propertyInfo['state'] ?? "";
    zipController.text = propertyInfo['zip'] ?? "";
    propertyAddressController.text = propertyInfo['address'] ?? "";
    buildingNameController.text = buildingInfo['name'] ?? "";
    yearConstructedController.text = buildingInfo['constructed_year'] ?? "";
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
    var response = await loginRepository.createinspectorapi(inspectorName);
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
        List<DeficiencyProofPicture> listPicture = [];
        e.deficiencyProofPictures?.forEach((pictureString) {
          listPicture.add(DeficiencyProofPicture(picturePath: pictureString));
        });

        deficiencyInspections?.add(DeficiencyInspection(
            housingDeficiencyId: e.housingDeficiencyId,
            comment: e.comment,
            date: e.date,
            deficiencyProofPictures: listPicture));
      });
    });

    List<Certificate>? certificates = [];
    certificatesInfo.forEach((element) {
      certificates.add(Certificate(id: element['id']));
    });

    CreateInspectionRequestModel createInspectionRequestModel =
        CreateInspectionRequestModel(
      building: Building(
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
      property: Property(
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
        "buildingtype": buildingtype,
        "imagesList": imagesList,
        "inspectionName": inspectionName,
        "propertyInfo": propertyInfo,
        "buildingInfo": buildingInfo,
        "certificatesInfo": certificatesInfo,
        "inspectorName": inspectorName,
        "inspectorDate": inspectorDate
      });
    });
    update();
  }
}
