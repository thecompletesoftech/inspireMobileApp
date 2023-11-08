import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:public_housing/commons/all.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../home_screen/home_controller.dart';

class NoShowController extends BaseController {
  /// ---- Get Inspection APi ----------->>>
  // getHome({var lat, lng}) async {
  //   FormData formData = FormData.fromMap({
  //     'user_id': getStorageData.readObject(getStorageData.userId),
  //     'curLat': lat ?? userLocationLat!,
  //     'curLng': lng ?? userLocationLng!,
  //   });
  //   if (filterBool.value && categorySelect.value != -1) {
  //     formData.fields.add(MapEntry(
  //         "cat_ids", categoryList[categorySelect.value].categories!.id!));
  //   }
  //   final data = await APIFunction().apiCall(
  //     context: Get.context!,
  //     apiName: Constants.getHome,
  //     params: formData,
  //     token: getStorageData.readObject(getStorageData.token),
  //   );
  //
  //   HomeModel model = HomeModel.fromJson(data);
  //   if (model.responseCode == 1) {
  //     if (model.data!.isNotEmpty) {
  //       homeModel = model.data!;
  //
  //       update();
  //     } else {}
  //     markerClass(lat: lat, lng: lng);
  //
  //     // utils.showSnackBar(context: Get.context!, message: model.responseMsg!,isOk: true);
  //
  //     update();
  //   } else if (model.responseCode == 0) {
  //     utils.showSnackBar(context: Get.context!, message: model.responseMsg!);
  //   }
  // }
  RxCommonModel? item;
  String? itemTitle;
  RxString imageFile = "".obs;
  bool visibleBtn = false;
  bool change = true;
  SpeechToText speechToText = SpeechToText();
  final commentController = TextEditingController();
  final dateController = TextEditingController();
  @override
  void onInit() {
    if (Get.arguments != null) {
      item = Get.arguments;
      if (Get.isRegistered<HomeController>()) {
        itemTitle = Get.find<HomeController>().item!.massage!;
      }
      if (item!.status == InspectionStatus.completed.toString()) {
        visibleBtn = true;
      } else {
        visibleBtn = false;
      }
      update();
    }
    update();
    // TODO: implement onInit
    super.onInit();
  }

  var isListening = false.obs;
  var speechText = "".obs;
  void listen() async {
    var microphoneStatus = await Permission.microphone.status;
    var storageStatus = await Permission.storage.status;
    if (!microphoneStatus.isGranted) await Permission.microphone.request();
    if (!storageStatus.isGranted) await Permission.storage.request();
    if (await Permission.microphone.isGranted) {
      if (!isListening.value) {
        bool available = await speechToText.initialize(
          onStatus: (val) {
            printAction("Permission onStatus $val");
            if (val == "done") {
              isListening.value = false;
              speechToText.stop();
              update();
            }
          },
          onError: (val) {
            printAction("Permission onError $val");
          },
        );
        if (available) {
          isListening.value = true;
          update();

          speechToText.listen(onResult: (val) {
            commentController.text = val.recognizedWords;
            update();
          });
        }
      } else {
        isListening.value = false;
        speechToText.stop();
        update();
      }
    } else {
      printAction("Permission Denied");
    }
  }

  late final Rx<DateTime> _selectedDate = DateTime.now().obs;
  var formattedDate = ''.obs;
  Rx<DateTime> get selectedDate => _selectedDate;
  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      initialDate: _selectedDate.value,
      firstDate: DateTime(1985),
      lastDate: DateTime.now(),
      context: Get.context!,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      var date = DateFormat("MM/dd/yyyy").format(selectedDate.value);
      formattedDate.value = date;
      dateController.text = date;
      if (commentController.text.isNotEmpty && dateController.text.isNotEmpty && imageFile.isNotEmpty) {
        visibleBtn = true;
        update();
      } else {
        visibleBtn = false;
      }
    }
    update();
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
          imageFile = (pickedFile.path.obs);
          if (commentController.text.isNotEmpty && dateController.text.isNotEmpty && imageFile.isNotEmpty) {
            visibleBtn = true;
            update();
          } else {
            visibleBtn = false;
          }
        }
      } catch (e) {
        printAction(e.toString());
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
          imageFile = (pickedFile.path.obs);
          if (commentController.text.isNotEmpty && dateController.text.isNotEmpty && imageFile.isNotEmpty) {
            visibleBtn = true;
            update();
          }
        }
      } catch (e) {
        printAction(e.toString());
      }
      update();
    }
  }
}
