import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/Repository/deficiencies_inside_repository.dart';
import 'package:speech_to_text/speech_to_text.dart';

enum ImageUploadStatus { initial, uploading, success }

class NoShowController extends BaseController {
  RxString imageFile = "".obs;
  bool visibleBtn = false;
  bool change = true;
  SpeechToText speechToText = SpeechToText();
  TextEditingController textController = TextEditingController();
  var isListening = false.obs;
  var speechText = "".obs;
  DateTime? selectedDateTime;
  ImageUploadStatus imageUploadStatus = ImageUploadStatus.initial;

  DeficienciesInsideRepository deficienciesInsideRepository =
      DeficienciesInsideRepository();

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
          imageQuality: 25,
        );
        if (pickedFile != null) {
          imageUploadStatus = ImageUploadStatus.uploading;
          update();
          selectedDateTime = await pickedFile.lastModified();

          var response = await deficienciesInsideRepository.getImageUpload(
              filePath: pickedFile.path);

          response.fold((l) {
            imageUploadStatus = ImageUploadStatus.initial;
            return null;
          }, (r) {
            imageUploadStatus = ImageUploadStatus.success;
            imageFile = (r.images?.image ?? '').obs;
            if (textController.text.isNotEmpty && imageFile.isNotEmpty) {
              visibleBtn = true;
            } else {
              visibleBtn = false;
            }
            update();
          });
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
          imageQuality: 25,
        );
        if (pickedFile != null) {
          imageUploadStatus = ImageUploadStatus.uploading;
          update();
          selectedDateTime = await pickedFile.lastModified();

          var response = await deficienciesInsideRepository.getImageUpload(
              filePath: pickedFile.path);

          response.fold((l) {
            imageUploadStatus = ImageUploadStatus.initial;
            return null;
          }, (r) {
            imageUploadStatus = ImageUploadStatus.success;
            imageFile = (r.images?.image ?? '').obs;
            if (textController.text.isNotEmpty && imageFile.isNotEmpty) {
              visibleBtn = true;
            } else {
              visibleBtn = false;
            }
            update();
          });
        }
      } catch (e) {
        utils.showToast(message: e.toString(), context: Get.context!);
        printError(e.toString());
      }
      update();
    }
  }
}
