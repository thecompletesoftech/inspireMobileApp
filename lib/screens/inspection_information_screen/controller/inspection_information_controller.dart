import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:public_housing/Models/accountmodel/account_model.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/auth/signing_screen/screen/signing_screen.dart';
import 'package:public_housing/screens/properties_list_screen/screen/properties_list_screen.dart';
import 'package:speech_to_text/speech_to_text.dart';

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
