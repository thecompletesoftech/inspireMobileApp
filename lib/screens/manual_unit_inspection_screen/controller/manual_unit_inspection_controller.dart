import 'package:permission_handler/permission_handler.dart';
import 'package:public_housing/commons/all.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ManualUnitInspectionController extends BaseController {
  bool isSelected = false;
  var speechText = "".obs;
  var selectFindingList = [];
  var isListening = false.obs;
  var switchButton = false.obs;
  SpeechToText speechToText = SpeechToText();
  TextEditingController inspectorController = TextEditingController();
  TextEditingController tenantNameController = TextEditingController();
  TextEditingController unitAddressController = TextEditingController();
  TextEditingController landlordNameController = TextEditingController();
  TextEditingController inspectionTypeController = TextEditingController();
  TextEditingController inspectionDateController = TextEditingController();
  TextEditingController inspectionNotesController = TextEditingController();

  List<String> findingTypeList = [
    '1st Time Fail',
    '24 Hour Fail',
    'Abatement',
    'Could Not Enter',
    'Full Inspection',
    'Lead Paint Violations',
    'Pass Abatement',
    'Refused',
    'Terminate',
    'Weather Deferred',
  ];

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

  searchBuildingType({required String searchText}) {
    selectFindingList.clear();
    if (inspectionTypeController.text.length > 0) {
      for (int i = 0; i < findingTypeList.length; i++) {
        if (findingTypeList[i]
            .toString()
            .toLowerCase()
            .contains(searchText.toString().toLowerCase())) {
          selectFindingList.add(findingTypeList[i]);
          update();
        }
      }
    } else {
      selectFindingList.addAll(findingTypeList);
      update();
    }
  }

  void actionBuildingType(value) {
    inspectionTypeController.text = value.toString();
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
