import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/home_screen/home_controller.dart';

import '../../languages/language.dart';
import '../buildingdetails_screen/buildingdetails_controller.dart';

class BuildingExteriorController extends BaseController {
  RxCommonModel? item;
  RxCommonModel? item1;
  String? buildingTitle;
  bool visibleBtn = false;
  bool change = false;
  final searchController = TextEditingController();
  var sendImagesList = [];

  final ExpansionTileController expansionTileController = ExpansionTileController();
  final List<RxCommonModel> dataList = [
    RxCommonModel(
      title: "Address and Signage",
      subtitle: "Unique number and name identifiers assigned to the property.",
      image: ImagePath.address,
      status: "false",
    ),
    RxCommonModel(
      title: "Chimney",
      subtitle: "A vertical or near vertical passageway connected to a fireplace or wood-burning appliance.",
      image: ImagePath.chimney,
      status: "false",
    ),
    RxCommonModel(
      title: "Clothes Dryer Exhaust Ventilation",
      subtitle:
          "The system connected to the clothes dryer vent outlet that exhausts air from the dryer blower to a designated area.",
      image: ImagePath.clothes,
      status: "false",
    ),
  ];
  var searchList = [].obs;

  searchItem(str) {
    searchList.clear();
    if (utils.isValidationEmpty(str)) {
      if (status.toString() == InspectionStatus.all.toString()) {
        searchList.addAll(dataList);
      } else {
        for (int i = 0; i < dataList.length; i++) {
          if (dataList[i].status.toString() == "false") {
            searchList.addAll(dataList);
            update();
          }
        }
      }
    } else {
      if (status.toString() == InspectionStatus.all.toString()) {
        for (int i = 0; i < dataList.length; i++) {
          if (dataList[i].title.toString().toLowerCase().contains(str.toString().toLowerCase())) {
            searchList.add(dataList[i]);
            update();
          }
        }
      } else {
        for (int i = 0; i < dataList.length; i++) {
          if (dataList[i].title.toString().toLowerCase().contains(str.toString().toLowerCase()) &&
              dataList[i].status.toString() == "false") {
            searchList.add(dataList[i]);
            update();
          }
        }
      }
    }
  }

  searchTypeItem() {
    searchList.clear();
    if (status.toString() == InspectionStatus.all.toString()) {
      searchList.addAll(dataList);
    } else {
      for (int i = 0; i < dataList.length; i++) {
        if (dataList[i].status.toString() == "false") {
          searchList.add(dataList[i]);
        }
      }
    }
  }

  InspectionStatus status = InspectionStatus.all;

  @override
  void onInit() {
    if (Get.arguments != null) {
      item = Get.arguments[0];
      item1 = Get.arguments[1];
      if (Get.isRegistered<BuildingDetailsController>()) {
        buildingTitle = Get.find<BuildingDetailsController>().propertyTitle ?? "";
      }
      searchItem("");
    }
    update();
    super.onInit();
  }

  dialogSectionCompleted() {
    alertActionDialogApp(
        context: Get.context!,
        borderRadius: 28.px,
        widget: Column(
          children: [
            Container(
              width: 350.px,
              padding: EdgeInsets.only(top: 24.px, left: 24.px, right: 24.px),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 24.px, height: 24.px, child: SvgPicture.string(icOops)),
                  MyTextView(
                    "${Strings.sectionCompleted}?",
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
                            text: 'Before you leave this screen. Is the section completed?\n\nYou can enter to ',
                            style: MyTextStyle(
                              textColor: appColors.lightText,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: item1!.title,
                            style: MyTextStyle(
                              textColor: appColors.lightText,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: ' later to add, remove or edit items.',
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
              width: 350.px,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonButton(
                      title: 'Stay',
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
                      title: Strings.sectionCompleted,
                      textColor: appColors.white,
                      color: appColors.appColor,
                      textSize: 16.px,
                      textFamily: fontFamilyRegular,
                      textWeight: FontWeight.w500,
                      padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                      radius: 100.px,
                      onTap: () {
                        Get.back();
                        Get.back(result: true);
                      }),
                ],
              ).paddingOnly(
                top: 24.px,
                left: 8.px,
                right: 24.px,
                bottom: 24.px,
              ),
            )
          ],
        ));
  }

  dialogSectionCompletedSave() {
    alertActionDialogApp(
        context: Get.context!,
        borderRadius: 28.px,
        widget: Column(
          children: [
            Container(
              width: 312.px,
              padding: EdgeInsets.only(top: 24.px, left: 24.px, right: 24.px),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 24.px, height: 24.px, child: SvgPicture.string(icOops)),
                  MyTextView(
                    Strings.sectionCompleted,
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
                            text: 'In order to complete the section you must ',
                            style: MyTextStyle(
                              textColor: appColors.lightText,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'take a picture',
                            style: MyTextStyle(
                              textColor: appColors.appColor,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ' of the ',
                            style: MyTextStyle(
                              textColor: appColors.lightText,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: item1!.title,
                            style: MyTextStyle(
                              textColor: appColors.appColor,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: '.\n\nYou can enter to ',
                            style: MyTextStyle(
                              textColor: appColors.lightText,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: item1!.title,
                            style: MyTextStyle(
                              textColor: appColors.appColor,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: ' later to add, remove or edit items.',
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
              width: 312.px,
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
                          title: 'Stay',
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
                          title: 'Go back',
                          textColor: appColors.white,
                          color: appColors.appColor,
                          textSize: 16.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w500,
                          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                          radius: 100.px,
                          onTap: () {
                            Get.back();
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
                            height: 30.px,
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
            // if (change) {
            visibleBtn = true;
            // }
            update();
            utils.showToast(message: "Section Completed", context: Get.context!);
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
            // if (change) {
            visibleBtn = true;
            // }
            update();
            utils.showToast(message: "Section Completed", context: Get.context!);
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
