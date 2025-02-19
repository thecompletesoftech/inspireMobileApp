import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/languages/language.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/Repository/deficiencies_inside_repository.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/models/deficiency_inspections_req_model.dart';
import 'package:speech_to_text/speech_to_text.dart';

enum ImageUploadStatus { initial, uploading, success }

class InspectionDeficienciesInsideController extends BaseController {
  String deficiencies = '';
  DeficiencyInspectionsReqModel successListOfDeficiencies =
      DeficiencyInspectionsReqModel();

  DeficienciesInsideRepository deficienciesInsideRepository =
      DeficienciesInsideRepository();
  var selectedItem = "null";
  bool visibleBtn = false;
  ImageUploadStatus imageUploadStatus = ImageUploadStatus.initial;
  final commentController = TextEditingController();
  final dateController = TextEditingController();
  bool change = true;
  List<String> imageList = [];
  List<DeficiencyInspectionsReqModel> deficiencyInspectionsReqModel = [];
  int? listIndex;
  var isListening = false.obs;
  var speechText = "".obs;
  SpeechToText speechToText = SpeechToText();
  bool isDeleted = false;
  String standard = '';
  DateTime? selectedDateTime;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      deficiencies = Get.arguments['deficiencies'] ?? "";
      listIndex = Get.arguments['listIndex'] ?? 0;
      standard = Get.arguments['standard'] ?? "";

      if (Get.arguments['deficiencyInspectionsReqModel'] != null) {
        successListOfDeficiencies =
            Get.arguments['deficiencyInspectionsReqModel'];
        deficiencyInspectionsReqModel = [
          DeficiencyInspectionsReqModel(
            housingDeficiencyId: Get
                .arguments['deficiencyInspectionsReqModel'].housingDeficiencyId
                .toString(),
            deficiencyProofPictures: Get
                .arguments['deficiencyInspectionsReqModel']
                .deficiencyProofPictures,
            date: Get.arguments['deficiencyInspectionsReqModel'].date ?? "",
            comment:
                Get.arguments['deficiencyInspectionsReqModel'].comment ?? "",
            definition:
                Get.arguments['deficiencyInspectionsReqModel'].definition ?? "",
            deficiencyItemHousingDeficiency: Get
                    .arguments['deficiencyInspectionsReqModel']
                    .deficiencyItemHousingDeficiency ??
                DeficiencyItemHousingDeficiency(),
            criteria:
                Get.arguments['deficiencyInspectionsReqModel'].criteria ?? "",
          )
        ];
      } else {
        List<String> deficiencyProofPictures = [];
        if (Get.arguments['successListOfDeficiencies'].deficiencyProofPictures
            .isNotEmpty) {
          deficiencyProofPictures = Get
              .arguments['successListOfDeficiencies'].deficiencyProofPictures;
        }
        successListOfDeficiencies.isSuccess =
            Get.arguments['deficiencyAreaItem'].isSuccess;
        successListOfDeficiencies.housingDeficiencyId =
            Get.arguments['deficiencyAreaItem'].housingDeficiencyId.toString();
        successListOfDeficiencies.deficiencyItemHousingDeficiency =
            Get.arguments['deficiencyAreaItem'].deficiencyItemHousingDeficiency;
        successListOfDeficiencies.definition =
            Get.arguments['deficiencyAreaItem'].definition;
        successListOfDeficiencies.criteria =
            Get.arguments['deficiencyAreaItem'].criteria;
        successListOfDeficiencies.comment =
            Get.arguments['deficiencyAreaItem'].comment;
        successListOfDeficiencies.date =
            Get.arguments['deficiencyAreaItem'].date;
        successListOfDeficiencies.deficiencyProofPictures =
            Get.arguments['deficiencyAreaItem'].deficiencyProofPictures;

        deficiencyInspectionsReqModel = [
          DeficiencyInspectionsReqModel(
              housingDeficiencyId: Get
                  .arguments['successListOfDeficiencies'].housingDeficiencyId
                  .toString(),
              deficiencyProofPictures: deficiencyProofPictures,
              date: Get.arguments['successListOfDeficiencies'].date == ""
                  ? DateFormat("MM/dd/yyyy").format(DateTime.now())
                  : Get.arguments['successListOfDeficiencies'].date,
              comment: Get.arguments['successListOfDeficiencies'].comment ?? "",
              definition:
                  Get.arguments['successListOfDeficiencies'].definition ?? "",
              deficiencyItemHousingDeficiency: Get
                      .arguments['successListOfDeficiencies']
                      .deficiencyItemHousingDeficiency ??
                  DeficiencyItemHousingDeficiency(),
              criteria:
                  Get.arguments['successListOfDeficiencies'].criteria ?? "",
              isSuccess:
                  Get.arguments['successListOfDeficiencies'].isSuccess ?? false)
        ];
      }
      dataFill();
    }
    update();
  }

  final Rx<DateTime> _selectedDate = DateTime.now().obs;

  Rx<DateTime> get selectedDate => _selectedDate;

  dataFill() {
    deficiencyInspectionsReqModel.forEach((element) {
      element.deficiencyProofPictures?.forEach((element1) {
        imageList.add(element1);
      });
      commentController.text = element.comment ?? "";
      dateController.text = element.date ?? "";
    });
    if (imageList.isNotEmpty || dateController.text.isNotEmpty) {
      imageUploadStatus = imageList.isNotEmpty
          ? ImageUploadStatus.success
          : ImageUploadStatus.initial;
      visibleBtn = true;
      selectedItem = 'present';
    }
    update();
  }

  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      initialDate: _selectedDate.value,
      firstDate: DateTime(1985),
      lastDate: DateTime(2050),
      context: Get.context!,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      var date = DateFormat("MM/dd/yyyy").format(selectedDate.value);
      dateController.text = date;
      if (!utils.isValidationEmpty(commentController.text) &&
          !utils.isValidationEmpty(dateController.text)) {
        visibleBtn = true;
      } else {
        visibleBtn = false;
      }
    }
    update();
  }

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

  removeImage(index) {
    imageList.removeAt(index);
    imageUploadStatus = ImageUploadStatus.initial;
    update();
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
                  SizedBox(
                      width: 24.px,
                      height: 24.px,
                      child: SvgPicture.string(icOops)),
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
                            text:
                                ' made in this section. Do you want to continue?',
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.px, vertical: 10.px),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.px, vertical: 10.px),
                          radius: 100.px,
                          onTap: () {
                            selectedItem = "null";
                            visibleBtn = false;
                            // if (standard == 'standard') {
                            //   deficiencyInspectionsReqModel[0]
                            //       .deficiencyProofPictures = <String>[];
                            //   deficiencyInspectionsReqModel[0].isSuccess =
                            //       false;
                            //   deficiencyInspectionsReqModel[0].comment = "";
                            //   deficiencyInspectionsReqModel[0].date = "";
                            // } else {
                            deficiencyInspectionsReqModel[0]
                                .deficiencyProofPictures = <String>[];
                            deficiencyInspectionsReqModel[0].isSuccess = false;
                            deficiencyInspectionsReqModel[0].comment = "";
                            deficiencyInspectionsReqModel[0].date = "";
                            isDeleted = true;
                            // }
                            commentController.clear();
                            dateController.clear();
                            imageList = [];
                            imageUploadStatus = ImageUploadStatus.initial;
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

  confirmDialog() {
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
                  SizedBox(
                      width: 24.px,
                      height: 24.px,
                      child: SvgPicture.string(icOops)),
                  MyTextView(
                    Strings.fieldsMissing,
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
                            text: Strings.changesNotSaved,
                            style: MyTextStyle(
                              textColor: appColors.lightText,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: Strings.notSaved,
                            style: MyTextStyle(
                              textColor: appColors.delete,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w600,
                              // textHeight: 1.50,
                              // textLetterSpacing: 0.50,
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.px, vertical: 10.px),
                          radius: 100.px,
                          onTap: () {
                            Get.back();
                          }).paddingOnly(right: 8.px),
                      CommonButton(
                          title: Strings.dontSave,
                          textColor: appColors.white,
                          color: appColors.delete,
                          textSize: 16.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w500,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.px, vertical: 10.px),
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
        XFile? pickedFile = await ImagePicker()
            .pickImage(source: ImageSource.camera, imageQuality: 25);

        if (pickedFile != null) {
          var tempDir = await getTemporaryDirectory();
          final editedImage = await Navigator.push(
            Get.context!,
            MaterialPageRoute(
              builder: (context) => ImageEditor(
                image:
                    Uint8List.fromList(File(pickedFile.path).readAsBytesSync()),
                savePath: tempDir.path, // <-- Uint8List of image
              ),
            ),
          );
          if (editedImage != null) {
            File file = await File(
                    '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png')
                .create();
            file.writeAsBytesSync(editedImage);
            imageUploadStatus = ImageUploadStatus.uploading;
            update();
            selectedDateTime = await pickedFile.lastModified();
            File files = await Utils()
                .addTimestampToImage(File(file.path), selectedDateTime!);

            var response = await deficienciesInsideRepository.getImageUpload(
                filePath: files.path);

            response.fold((l) {
              imageUploadStatus = ImageUploadStatus.initial;
            }, (r) {
              imageUploadStatus = ImageUploadStatus.success;
              imageList.add(r.images?.image ?? '');
              // if (!utils.isValidationEmpty(commentController.text) &&
              //     !utils.isValidationEmpty(dateController.text)) {
              //   visibleBtn = true;
              // } else {
              //   visibleBtn = false;
              // }
              update();
            });

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: 32.px,
                  height: 32.px,
                  child: SvgPicture.string(icGlass),
                ),
              ),
              Center(
                child: MyTextView(
                  Strings.inspectionProcess,
                  textStyleNew: MyTextStyle(
                    textColor: appColors.appColor,
                    textSize: 24.px,
                    textFamily: fontFamilyRegular,
                    textWeight: FontWeight.w400,
                  ),
                ).paddingSymmetric(vertical: 24.px),
              ),
              MyTextView(
                '1. Observation',
                textStyleNew: MyTextStyle(
                  textColor: AppColors().black,
                  textWeight: FontWeight.w600,
                  textFamily: fontFamilyBold,
                  textSize: 20.px,
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 20.px),
                  Expanded(
                    child: MyTextView(
                      '• Visually determine if food storage space is \n   present.',
                      textStyleNew: MyTextStyle(
                        textColor: AppColors().black,
                        textWeight: FontWeight.w400,
                        textFamily: fontFamilyBold,
                        textSize: 16.px,
                      ),
                      isMaxLineWrap: true,
                    ),
                  ),
                ],
              ),
              MyTextView(
                '2. Request for help: ',
                textStyleNew: MyTextStyle(
                  textColor: AppColors().black,
                  textWeight: FontWeight.w600,
                  textFamily: fontFamilyBold,
                  textSize: 20.px,
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 20.px),
                  Expanded(
                    child: MyTextView(
                      '• None.',
                      textStyleNew: MyTextStyle(
                        textColor: AppColors().black,
                        textWeight: FontWeight.w400,
                        textFamily: fontFamilyBold,
                        textSize: 16.px,
                      ),
                      isMaxLineWrap: true,
                    ),
                  ),
                ],
              ),
              MyTextView(
                '3. Action:',
                textStyleNew: MyTextStyle(
                  textColor: AppColors().black,
                  textWeight: FontWeight.w600,
                  textFamily: fontFamilyBold,
                  textSize: 20.px,
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 20.px),
                  Expanded(
                    child: MyTextView(
                      '• None.',
                      textStyleNew: MyTextStyle(
                        textColor: AppColors().black,
                        textWeight: FontWeight.w400,
                        textFamily: fontFamilyBold,
                        textSize: 16.px,
                      ),
                      isMaxLineWrap: true,
                    ),
                  ),
                ],
              ),
              MyTextView(
                '4. More Information:',
                textStyleNew: MyTextStyle(
                  textColor: AppColors().black,
                  textWeight: FontWeight.w600,
                  textFamily: fontFamilyBold,
                  textSize: 20.px,
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 20.px),
                  Expanded(
                    child: MyTextView(
                      '• The presence of cold food storage should be \n   evaluated under the Refrigerator standard.',
                      textStyleNew: MyTextStyle(
                        textColor: AppColors().black,
                        textWeight: FontWeight.w400,
                        textFamily: fontFamilyBold,
                        textSize: 16.px,
                      ),
                      isMaxLineWrap: true,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CommonButton(
                      title: Strings.close,
                      textColor: appColors.appColor,
                      color: appColors.transparent,
                      textSize: 16.px,
                      textFamily: fontFamilyRegular,
                      textWeight: FontWeight.w500,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.px, vertical: 10.px),
                      radius: 100.px,
                      onTap: () {
                        Get.back();
                      }).paddingSymmetric(vertical: 24.px),
                ],
              ),
            ],
          ).paddingOnly(top: 24.px, left: 24.px, right: 24.px),
        ));
  }

  getFromGallery({int? index}) async {
    bool checkPermission = await utils.checkPermissionOpenCamera();

    if (checkPermission) {
      try {
        XFile? pickedFile = await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 25);
        if (pickedFile != null) {
          var tempDir;
          if (Platform.isIOS) {
            tempDir = await getApplicationDocumentsDirectory();
          } else {
            tempDir = await getTemporaryDirectory();
          }
          print("temp file" + tempDir.toString());
          final editedImage = await Navigator.push(
            Get.context!,
            MaterialPageRoute(
              builder: (context) => ImageEditor(
                image:
                    Uint8List.fromList(File(pickedFile.path).readAsBytesSync()),
                savePath: tempDir.path, // <-- Uint8List of image
              ),
            ),
          );

          if (editedImage != null) {
            File file = await File(
                    '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png')
                .create();
            file.writeAsBytesSync(editedImage);
            imageUploadStatus = ImageUploadStatus.uploading;
            update();
            selectedDateTime = await pickedFile.lastModified();
            File files = await Utils()
                .addTimestampToImage(File(file.path), selectedDateTime!);
            var response = await deficienciesInsideRepository.getImageUpload(
                filePath: files.path);

            response.fold((l) {
              imageUploadStatus = ImageUploadStatus.initial;

              return null;
            }, (r) {
              imageUploadStatus = ImageUploadStatus.success;
              imageList.add(r.images?.image ?? '');
              // if (!utils.isValidationEmpty(commentController.text) &&
              //     !utils.isValidationEmpty(dateController.text)) {
              //   visibleBtn = true;
              // } else {
              //   visibleBtn = false;
              // }
              update();
            });
          }
        }
      } catch (e) {
        utils.showToast(message: e.toString(), context: Get.context!);
        printError(e.toString());
      }
      update();
    }
  }

  saveChanges() {
    deficiencyInspectionsReqModel = [
      DeficiencyInspectionsReqModel(
        comment: commentController.text,
        date: dateController.text,
        deficiencyProofPictures: imageList,
        housingDeficiencyId:
            successListOfDeficiencies.housingDeficiencyId.toString(),
        definition: successListOfDeficiencies.definition.toString(),
        deficiencyItemHousingDeficiency:
            successListOfDeficiencies.deficiencyItemHousingDeficiency,
        criteria: successListOfDeficiencies.criteria,
        isSuccess: true,
      )
    ];
    update();
  }

  isCheck() {
    Function deepEq = const DeepCollectionEquality().equals;
    return deepEq(
            imageList, successListOfDeficiencies.deficiencyProofPictures) &&
        successListOfDeficiencies.comment == commentController.text &&
        successListOfDeficiencies.date == dateController.text;
  }
}
