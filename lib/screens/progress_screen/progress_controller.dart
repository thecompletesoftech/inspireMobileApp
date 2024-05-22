import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:public_housing/commons/all.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../languages/language.dart';
import '../home_screen/home_controller.dart';

class ProgressController extends BaseController {
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
  RxCommonModel? item1;
  String? itemTitle;

  bool visibleBtn = false;
  bool change = true;
  final searchController = TextEditingController();
  final commentController = TextEditingController();
  final dateController = TextEditingController();

  var dataList = [
    RxCommonModel(
      title: "D1. Cabinets are missing",
      status: "false",
    ),
    RxCommonModel(
      title: "D2. Cabinet components are damaged or missing - Unit",
      status: "false",
    ),
    RxCommonModel(
      title: "D2. Cabinet components are damaged or missing - Inside",
      status: "false",
    ),
  ].obs;
  var selectedItem = "null";
  var selectedItem1 = "null";

  var sendImagesList = [];

  SpeechToText speechToText = SpeechToText();

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

  @override
  void onInit() {
    if (Get.arguments != null) {
      item = Get.arguments[0];
      item1 = Get.arguments[1];
      if (Get.isRegistered<HomeController>()) {
        itemTitle = Get.find<HomeController>().item!.massage!;
      }
    }
    update();
    // TODO: implement onInit
    super.onInit();
  }

  final Rx<DateTime> _selectedDate = DateTime.now().obs;
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
      dateController.text = date;
      if (!utils.isValidationEmpty(commentController.text) && !utils.isValidationEmpty(dateController.text)) {
        visibleBtn = true;
      } else {
        visibleBtn = false;
      }
    }
    update();
  }

  imagePicker() {
    alertActionDialogApp(
        context: Get.context!,
        borderRadius: 28.px,
        widget: SizedBox(
          width: 390.px,
          child: Column(
            children: [
              SizedBox(height: 30.px),
              MyTextView(
                Languages.of(Get.context!)!.upload,
                textStyleNew: MyTextStyle(
                  textSize: 25.px,
                  textColor: AppColors().black,
                  textWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20.px),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back(closeOverlays: true);
                      getFromGallery();
                    },
                    child: Container(
                      height: 129.px,
                      width: 157.px,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.px),
                        border: Border.all(
                          color: AppColors().grey.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.string(
                            icUpload,
                            height: 30,

                            // height: ScalingQuery(Get.context!).scale(0.2.px),
                          ),
                          MyTextView(
                            Languages.of(Get.context!)!.fromGallery,
                            textStyleNew: MyTextStyle(
                              textSize: 15.px,
                              textWeight: FontWeight.w700,
                              textColor: AppColors().lightText,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back(closeOverlays: true);
                      getFromCamera();
                    },
                    child: Container(
                      height: 129.px,
                      width: 157.px,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.px),
                        border: Border.all(
                          color: AppColors().grey.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.string(
                            icCamera,
                            height: 30,
                            // height: ScalingQuery(Get.context!).scale(0.2.px),
                          ),
                          MyTextView(
                            Languages.of(Get.context!)!.takePhoto,
                            textStyleNew: MyTextStyle(
                              textSize: 15.px,
                              textWeight: FontWeight.w700,
                              textColor: AppColors().lightText,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.px),
            ],
          ),
        ));
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
          var tempDir = await getTemporaryDirectory();
          final editedImage = await Navigator.push(
            Get.context!,
            MaterialPageRoute(
              builder: (context) => ImageEditor(
                image: Uint8List.fromList(File(pickedFile.path).readAsBytesSync()),
                savePath: tempDir.path, // <-- Uint8List of image
              ),
            ),
          );
          if (editedImage != null) {
            File file = await File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png').create();
            file.writeAsBytesSync(editedImage);

            sendImagesList.add(file.path);
            if (!utils.isValidationEmpty(commentController.text) && !utils.isValidationEmpty(dateController.text)) {
              visibleBtn = true;
            } else {
              visibleBtn = false;
            }
            update();
            // utils.showToast(message: "Section Completed", context: Get.context!);
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
          var tempDir = await getTemporaryDirectory();
          final editedImage = await Navigator.push(
            Get.context!,
            MaterialPageRoute(
              builder: (context) => ImageEditor(
                image: Uint8List.fromList(File(pickedFile.path).readAsBytesSync()),
                savePath: tempDir.path, // <-- Uint8List of image
              ),
            ),
          );
          if (editedImage != null) {
            File file = await File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png').create();
            file.writeAsBytesSync(editedImage);

            sendImagesList.add(file.path);
            if (!utils.isValidationEmpty(commentController.text) && !utils.isValidationEmpty(dateController.text)) {
              visibleBtn = true;
            } else {
              visibleBtn = false;
            }
            update();
            // utils.showToast(message: "Section Completed", context: Get.context!);
          }
        }
      } catch (e) {
        utils.showToast(message: e.toString(), context: Get.context!);
        printError(e.toString());
      }
      update();
    }
  }

  dialogChangesUnsaved() {
    alertActionDialogApp(
        context: Get.context!,
        borderRadius: 28.px,
        widget: Column(
          children: [
            Container(
              width: 322.px,
              // height: 184.px,
              padding: EdgeInsets.only(top: 24.px, left: 24.px, right: 24.px),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 24.px, height: 24.px, child: SvgPicture.string(icOops)),
                  MyTextView(
                    Strings.changesUnsaved,
                    textStyleNew: MyTextStyle(
                      textColor: appColors.textBlack,
                      textSize: 24.px,
                      textFamily: fontFamilyRegular,
                      textWeight: FontWeight.w400,
                    ),
                  ).paddingSymmetric(vertical: 16.px),
                  SizedBox(
                    width: double.infinity,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Changes were made. Do you want to save the changes?',
                            style: MyTextStyle(
                              textColor: appColors.lightText,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 322.px,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonButton(
                          title: Strings.undoAll,
                          textColor: appColors.appColor,
                          color: appColors.transparent,
                          textSize: 16.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w500,
                          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                          radius: 100.px,
                          onTap: () {
                            Get.back();
                            Get.back();
                          }).paddingOnly(right: 8.px),
                      CommonButton(
                          title: Strings.saveChanges,
                          textColor: appColors.white,
                          color: appColors.appColor,
                          textSize: 16.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w500,
                          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                          radius: 100.px,
                          onTap: () {
                            Get.back(result: true);
                            Get.back(result: true);
                          }),
                    ],
                  ).paddingOnly(
                    top: 24.px,
                    left: 8.px,
                    right: 24.px,
                    bottom: 24.px,
                  ),
                ],
              ),
            )
          ],
        ));
  }

  dialogSomeFieldsMissing() {
    alertActionDialogApp(
        context: Get.context!,
        borderRadius: 28.px,
        widget: Column(
          children: [
            Container(
              width: 320.px,
              height: 184.px,
              padding: EdgeInsets.only(top: 24.px, left: 24.px, right: 24.px),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 24.px, height: 24.px, child: SvgPicture.string(icOops)),
                  MyTextView(
                    "Some fields are missing",
                    textStyleNew: MyTextStyle(
                      textColor: appColors.textBlack,
                      textSize: 24.px,
                      textFamily: fontFamilyRegular,
                      textWeight: FontWeight.w400,
                    ),
                  ).paddingSymmetric(vertical: 16.px),
                  SizedBox(
                    width: double.infinity,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'You need to complete all the fields or the changes ',
                            style: MyTextStyle(
                              textColor: appColors.lightText,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'will not be saved.',
                            style: MyTextStyle(
                              textColor: appColors.delete,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 322.px,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonButton(
                          title: Strings.cancel,
                          textColor: appColors.appColor,
                          // border: Border.all(color: appColors.delete, width: 2),
                          color: appColors.transparent,
                          textSize: 16.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w500,
                          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                          radius: 100.px,
                          onTap: () {
                            Get.back();
                          }).paddingOnly(right: 8.px),
                      CommonButton(
                          title: 'Don\'t Save',
                          textColor: appColors.white,
                          color: appColors.delete,
                          textSize: 16.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w500,
                          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                          radius: 100.px,
                          onTap: () {
                            Get.back();
                            Get.back();
                          }),
                    ],
                  ).paddingOnly(
                    top: 24.px,
                    left: 8.px,
                    right: 24.px,
                    bottom: 24.px,
                  ),
                ],
              ),
            )
          ],
        ));
  }

  dialogInspectionProcess() {
    alertActionDialogApp(
        context: Get.context!,
        borderRadius: 28.px,
        widget: Container(
          width: 442.px,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.px),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 32.px,
                        height: 32.px,
                        child: SvgPicture.string(icGlass),
                      ),
                      MyTextView(
                        Strings.inspectionProcess,
                        textStyleNew: MyTextStyle(
                          textColor: appColors.appColor,
                          textSize: 24.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w400,
                        ),
                      ).paddingSymmetric(vertical: 24.px),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Observation: \n',
                              style: MyTextStyle(
                                textColor: appColors.textBlack,
                                textSize: 16.px,
                                textFamily: fontFamilyRegular,
                                textWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'Visually determine if food storage space is present.\n',
                              style: MyTextStyle(
                                textColor: appColors.lightText,
                                textSize: 16.px,
                                textFamily: fontFamilyRegular,
                                textWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Request for help: \n',
                              style: MyTextStyle(
                                textColor: appColors.textBlack,
                                textSize: 16.px,
                                textFamily: fontFamilyRegular,
                                textWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'None.\n',
                              style: MyTextStyle(
                                textColor: appColors.lightText,
                                textSize: 16.px,
                                textFamily: fontFamilyRegular,
                                textWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Action: \n',
                              style: MyTextStyle(
                                textColor: appColors.textBlack,
                                textSize: 16.px,
                                textFamily: fontFamilyRegular,
                                textWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'None.\n',
                              style: MyTextStyle(
                                textColor: appColors.lightText,
                                textSize: 16.px,
                                textFamily: fontFamilyRegular,
                                textWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'More Information: \n',
                              style: MyTextStyle(
                                textColor: appColors.textBlack,
                                textSize: 16.px,
                                textFamily: fontFamilyRegular,
                                textWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'The presence of cold food storage should be evaluated under the ',
                              style: MyTextStyle(
                                textColor: appColors.lightText,
                                textSize: 16.px,
                                textFamily: fontFamilyRegular,
                                textWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Refrigerator',
                              style: MyTextStyle(
                                textColor: appColors.appColor,
                                textSize: 16.px,
                                textFamily: fontFamilyRegular,
                                textWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: ' standard.',
                              style: MyTextStyle(
                                textColor: appColors.lightText,
                                textSize: 16.px,
                                textFamily: fontFamilyRegular,
                                textWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).paddingOnly(top: 24.px, left: 24.px, right: 24.px),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonButton(
                          title: Strings.close,
                          textColor: appColors.appColor,
                          color: appColors.transparent,
                          textSize: 16.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w500,
                          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                          radius: 100.px,
                          onTap: () {
                            Get.back();
                          }),
                    ],
                  ).paddingOnly(
                    top: 24.px,
                    left: 8.px,
                    right: 24.px,
                    bottom: 24.px,
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  dialogDelete() {
    alertActionDialogApp(
        context: Get.context!,
        borderRadius: 28.px,
        widget: Column(
          children: [
            Container(
              width: 322.px,
              // height: 184.px,
              padding: EdgeInsets.only(top: 24.px, left: 24.px, right: 24.px),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 24.px, height: 24.px, child: SvgPicture.string(icOops)),
                  MyTextView(
                    'Delete changes?',
                    textStyleNew: MyTextStyle(
                      textColor: appColors.textBlack,
                      textSize: 24.px,
                      textFamily: fontFamilyRegular,
                      textWeight: FontWeight.w400,
                    ),
                  ).paddingSymmetric(vertical: 16.px),
                  SizedBox(
                    width: double.infinity,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'You are about to ',
                            style: MyTextStyle(
                              textColor: appColors.lightText,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'delete all changes',
                            style: MyTextStyle(
                              textColor: appColors.delete,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w600,
                              // textHeight: 1.50,
                              // textLetterSpacing: 0.50,
                            ),
                          ),
                          TextSpan(
                            text: ' made in this section. Do you want to continue?',
                            style: MyTextStyle(
                              textColor: appColors.lightText,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 322.px,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonButton(
                          title: Strings.cancel,
                          textColor: appColors.appColor,
                          color: appColors.transparent,
                          textSize: 16.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w500,
                          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                          radius: 100.px,
                          onTap: () {
                            Get.back();
                          }).paddingOnly(right: 8.px),
                      CommonButton(
                          title: Strings.delete,
                          textColor: appColors.white,
                          color: appColors.delete,
                          textSize: 16.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w500,
                          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                          radius: 100.px,
                          onTap: () {
                            selectedItem1 = "null";
                            sendImagesList.clear();
                            visibleBtn = false;
                            update();
                            Get.back();
                          }),
                    ],
                  ).paddingOnly(
                    top: 24.px,
                    left: 8.px,
                    right: 24.px,
                    bottom: 24.px,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
