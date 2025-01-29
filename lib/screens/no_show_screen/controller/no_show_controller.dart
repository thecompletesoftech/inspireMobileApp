import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:public_housing/commons/all.dart';
import 'package:speech_to_text/speech_to_text.dart';

class NoShowController extends BaseController {
  RxString imageFile = "".obs;
  bool visibleBtn = false;
  bool change = true;
  SpeechToText speechToText = SpeechToText();
  TextEditingController textController = TextEditingController();
  var isListening = false.obs;
  var speechText = "".obs;
  DateTime? selectedDateTime;

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
              textController.text = val.recognizedWords;
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

  getFromCamera({int? index}) async {
    bool checkPermission = await utils.checkPermissionOpenCamera();
    if (checkPermission) {
      try {
        XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxWidth: 1800,
          maxHeight: 1800,
        );
        if (pickedFile != null) {
          selectedDateTime = await pickedFile.lastModified();
          imageFile = (pickedFile.path.obs);
          if (textController.text.isNotEmpty && imageFile.isNotEmpty) {
            visibleBtn = true;
            update();
          } else {
            visibleBtn = false;
          }
        }
      } catch (e) {
        utils.showToast(message: e.toString(), context: Get.context!);
        printError(e.toString());
      }
      update();
    }
  }

  getFromGallery({int? index}) async {
    bool checkPermission = await utils.checkPermissionOpenCamera();

    if (checkPermission) {
      try {
        XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxWidth: 1800,
          maxHeight: 1800,
        );
        if (pickedFile != null) {
          selectedDateTime = await pickedFile.lastModified();
          imageFile = (pickedFile.path.obs);
          if (textController.text.isNotEmpty && imageFile.isNotEmpty) {
            visibleBtn = true;
            update();
          }
        }
      } catch (e) {
        utils.showToast(message: e.toString(), context: Get.context!);
        printError(e.toString());
      }
      update();
    }
  }
}
