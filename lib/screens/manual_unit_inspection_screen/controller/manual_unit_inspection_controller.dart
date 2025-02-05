import 'dart:convert';
import 'package:public_housing/Models/accountmodel/account_model.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/properties_list_screen/controller/properties_list_controller.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_res_model.dart';
import 'package:public_housing/screens/manual_unit_inspection_screen/repository/manual_unit_inspection_repository.dart';

class ManualUnitInspectionController extends BaseController {
  bool isSelected = false;
  var speechText = "".obs;
  List<InspectionType> selectInspectionTypeList = [];
  var isListening = false.obs;
  var switchButton = false.obs;
  SpeechToText speechToText = SpeechToText();
  List<InspectionType> inspectionTypeList = [];
  TextEditingController inspectorController = TextEditingController();
  TextEditingController tenantNameController = TextEditingController();
  TextEditingController unitAddressController = TextEditingController();
  TextEditingController landlordNameController = TextEditingController();
  TextEditingController inspectionTypeController = TextEditingController();
  TextEditingController inspectionDateController = TextEditingController();
  TextEditingController inspectionNotesController = TextEditingController();
  ManualUnitInspectionRepository manualUnitInspectionRepository =
      ManualUnitInspectionRepository();
  InspectionType inspectionType = InspectionType();
  PropertiesListController propertiesListController =
      Get.put(PropertiesListController());
  Account? account;

  @override
  void onInit() {
    getAccount();
    getInspectionType();
    super.onInit();
  }

  getAccount() async {
    var accountData = await getStorageData.readString(getStorageData.account);
    account = Account.fromJson(jsonDecode(accountData.toString()));
    inspectorController.text = account!.userName.toString();
    inspectionDateController.text = DateTime.now().toString();
    update();
  }

  void listen() async {
    var microphoneStatus = await Permission.microphone.request();
    var storageStatus = await Permission.storage.request();

    if (!microphoneStatus.isGranted || !storageStatus.isGranted) {
      printAction("Permissions Denied");
      return;
    }

    if (await Permission.microphone.isGranted) {
      if (!isListening.value) {
        try {
          bool available = await speechToText.initialize(
            onStatus: (val) {
              printAction("onStatus: $val");
              if (val == "done") {
                isListening.value = false;
                speechToText.stop();
                update();
              }
            },
            onError: (val) {
              printAction("onError: $val");
            },
          );

          if (available) {
            isListening.value = true;
            update();
            speechToText.listen(onResult: (val) {
              inspectionNotesController.text = val.recognizedWords;
              update();
            });
          } else {
            printAction("Speech recognition not available.");
          }
        } catch (e) {
          printAction("Error initializing speech recognition: $e");
        }
      } else {
        isListening.value = false;
        speechToText.stop();
        update();
      }
    } else {
      printAction("Microphone permission denied.");
    }
  }

  getInspectionType() async {
    var response = await manualUnitInspectionRepository.getInspectionType();
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (r) {
      if (r.inspectionTypes!.isNotEmpty) {
        r.inspectionTypes?.forEach((element) {
          inspectionTypeList.add(InspectionType(
              id: element.id,
              type: element.type,
              description: element.description));
        });
      }
    });
    update();
  }

  searchInspectionType({required String searchText}) {
    selectInspectionTypeList.clear();
    if (inspectionTypeController.text.length > 0) {
      for (int i = 0; i < inspectionTypeList.length; i++) {
        if (inspectionTypeList[i]
            .type
            .toString()
            .toLowerCase()
            .contains(searchText.toString().toLowerCase())) {
          selectInspectionTypeList.add(inspectionTypeList[i]);
          update();
        }
      }
    } else {
      selectInspectionTypeList.addAll(inspectionTypeList);
      update();
    }
  }

  void actionBuildingType(value) {
    inspectionTypeController.text = value.type.toString();
    inspectionType = value;
    update();
  }

  getStartInspection() {
    return tenantNameController.text.isNotEmpty &&
            unitAddressController.text.isNotEmpty &&
            landlordNameController.text.isNotEmpty &&
            inspectionTypeController.text.isNotEmpty
        ? true
        : false;
  }
}
