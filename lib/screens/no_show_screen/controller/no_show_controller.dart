import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/inspection_list_screen/controller/inspection_list_controller.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_req_model.dart';
import 'package:public_housing/screens/inspection_list_screen/screen/inspection_list_screen.dart';
import 'package:public_housing/screens/no_show_screen/model/no_show_req_model.dart';
import 'package:public_housing/screens/no_show_screen/repository/no_show_repository.dart';
import 'package:public_housing/screens/special_amenities_screen/model/special_amenities_req_model.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_res_model.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/Repository/deficiencies_inside_repository.dart';

enum ImageUploadStatus { initial, uploading, success }

class NoShowController extends BaseController {
  String imageFile = "";
  bool visibleBtn = false;
  bool change = true;
  SpeechToText speechToText = SpeechToText();
  TextEditingController textController = TextEditingController();
  var isListening = false.obs;
  var speechText = "".obs;
  DateTime? selectedDateTime;
  ImageUploadStatus imageUploadStatus = ImageUploadStatus.initial;
  String unitAddress = '';
  String unitName = '';
  InspectionType inspectionType = InspectionType();
  DeficienciesInsideRepository deficienciesInsideRepository =
      DeficienciesInsideRepository();
  NoShowRepository noShowRepository = NoShowRepository();

  @override
  void onInit() {
    if (Get.arguments != null) {
      unitAddress = Get.arguments['unitAddress'];
      unitName = Get.arguments['unitName'];
      inspectionType = Get.arguments['inspectionType'];
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
          File file = await Utils()
              .addTimestampToImage(File(pickedFile.path), selectedDateTime!);
          var response = await deficienciesInsideRepository.getImageUpload(
              filePath: file.path);

          response.fold((l) {
            imageUploadStatus = ImageUploadStatus.initial;
            return null;
          }, (r) {
            imageUploadStatus = ImageUploadStatus.success;
            imageFile = r.images?.image ?? '';
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
          File file = await Utils()
              .addTimestampToImage(File(pickedFile.path), selectedDateTime!);
          var response = await deficienciesInsideRepository.getImageUpload(
              filePath: file.path);

          response.fold((l) {
            imageUploadStatus = ImageUploadStatus.initial;
            return null;
          }, (r) {
            imageUploadStatus = ImageUploadStatus.success;
            imageFile = r.images?.image ?? '';
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

  createInspection() async {
    NoShowReqModel noShowReqModel =
        NoShowReqModel(inspection: InspectionsData(), unit: Unit());

    noShowReqModel.inspection?.inspectorId =
        inspectionReqModel.inspection?.inspectorId;
    noShowReqModel.inspection?.date = inspectionReqModel.inspection?.date;
    noShowReqModel.inspection?.startTime =
        inspectionReqModel.inspection?.startTime;
    noShowReqModel.inspection?.endTime = inspectionReqModel.inspection?.endTime;
    noShowReqModel.inspection?.comment = inspectionReqModel.inspection?.comment;
    noShowReqModel.inspection?.inspectionStateId =
        inspectionReqModel.inspection?.inspectionStateId;
    noShowReqModel.inspection?.inspectionTypeId =
        inspectionReqModel.inspection?.inspectionTypeId;
    noShowReqModel.inspection?.noShowImage =
        inspectionReqModel.inspection?.noShowImage;
    noShowReqModel.inspection?.findingType =
        inspectionReqModel.inspection?.findingType;
    noShowReqModel.inspection?.result = inspectionReqModel.inspection?.result;
    noShowReqModel.inspection?.scheduleInspectionId =
        inspectionReqModel.inspection?.scheduleInspectionId;

    noShowReqModel.unit = inspectionReqModel.unit;

    var response =
        await noShowRepository.noShowCreateInspection(dataReq: noShowReqModel);

    response.fold(
      (l) {},
      (r) {
        inspectionReqModel = InspectionReqModel(
          inspection: Inspection(
            specialAmenities: SpecialAmenities(
              bath: Amenities(),
              disabledAccessibility: Amenities(),
              kitchen: Amenities(),
              livingRoom: Amenities(),
              otherRoomsUsedForLiving: Amenities(),
              overallCharacteristics: Amenities(),
            ),
          ),
          unit: Unit(),
          deficiencyInspections: [],
        );

        Get.offAllNamed(InspectionListScreen.routes);
      },
    );
    update();
  }
}
