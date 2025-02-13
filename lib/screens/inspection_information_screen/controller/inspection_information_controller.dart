import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_res_model.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';

enum PropertyStatus { completed, scheduled }

enum ApiResponseStatus { initial, loading, success, failure }

class InspectionInformationController extends BaseController {
  final GlobalKey<PopupMenuButtonState<int>> popupKey = GlobalKey();
  TextEditingController inspectionNotesController = TextEditingController();
  TextEditingController bedroomsController = TextEditingController();
  TextEditingController bathroomsController = TextEditingController();
  SpeechToText speechToText = SpeechToText();
  var isListening = false.obs;
  var speechText = "".obs;
  String unitAddress = '';
  String unitName = '';
  InspectionType inspectionType = InspectionType();
  String timeFrame = '';
  DateTime? scheduleDate;
  Units unitData = Units();

  @override
  void onInit() {
    if (Get.arguments != null) {
      unitAddress = Get.arguments['unitAddress'];
      unitName = Get.arguments['unitName'];
      inspectionType = Get.arguments['inspectionType'];
      scheduleDate = Get.arguments['scheduleDate'];
    }

    if (Get.arguments['timeFrame'] != null) {
      timeFrame = Get.arguments['timeFrame'];
    }

    if (Get.arguments['unitData'] != null) {
      unitData = Get.arguments['unitData'];
      bedroomsController.text = unitData.numberOfBedrooms == null
          ? "0"
          : unitData.numberOfBedrooms.toString();
      bathroomsController.text = unitData.numberOfBathrooms == null
          ? '0'
          : unitData.numberOfBathrooms.toString();
    }
    super.onInit();
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
}
