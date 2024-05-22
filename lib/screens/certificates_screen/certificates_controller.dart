import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:public_housing/commons/all.dart';

import '../../languages/language.dart';
import '../buildings_screen/buildings_controller.dart';

enum CertificateStatus { No, Na }

class CertificateController extends BaseController {
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
  String? propertyTitle;
  bool visibleBtn = false;
  bool change = true;
  final searchController = TextEditingController();
  final commentController = TextEditingController();
  final dateController = TextEditingController();
  CertificateStatus boilerStatus = CertificateStatus.Na;
  CertificateStatus elevatorStatus = CertificateStatus.Na;
  CertificateStatus fireStatus = CertificateStatus.Na;
  CertificateStatus paintStatus = CertificateStatus.Na;
  CertificateStatus sprinklerStatus = CertificateStatus.Na;

  var sendBoilerImagesList = [];
  var sendElevatorImagesList = [];
  var sendFireImagesList = [];
  var sendPaintImagesList = [];
  var sendSprinklerImagesList = [];

  @override
  void onInit() {
    if (Get.arguments != null) {
      item = Get.arguments;
      if (Get.isRegistered<BuildingsController>()) {
        propertyTitle = Get.find<BuildingsController>().item!.title ?? "";
      }
    }
    update();
    // TODO: implement onInit
    super.onInit();
  }

  imagePicker(int index) {
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
                      getFromGallery(index: index);
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
                      getFromCamera(index: index);
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

            if (index == 0) {
              sendBoilerImagesList.add(file.path);
            } else if (index == 1) {
              sendElevatorImagesList.add(file.path);
            } else if (index == 2) {
              sendFireImagesList.add(file.path);
            } else if (index == 3) {
              sendPaintImagesList.add(file.path);
            } else if (index == 4) {
              sendSprinklerImagesList.add(file.path);
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

            if (index == 0) {
              sendBoilerImagesList.add(file.path);
            } else if (index == 1) {
              sendElevatorImagesList.add(file.path);
            } else if (index == 2) {
              sendFireImagesList.add(file.path);
            } else if (index == 3) {
              sendPaintImagesList.add(file.path);
            } else if (index == 4) {
              sendSprinklerImagesList.add(file.path);
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
}
