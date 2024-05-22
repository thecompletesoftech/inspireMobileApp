import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/home_screen/home_controller.dart';

import '../../languages/language.dart';

class KitchenController extends BaseController {
  /// ---- Get ItemDetails API ----------->>>
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
  bool change = false;
  final searchController = TextEditingController();
  var sendImagesList = [];

  final ExpansionTileController expansionTileController = ExpansionTileController();
  final List<RxCommonModel> dataList = [
    RxCommonModel(
      title: "Cabinets and Storage",
      subtitle: "A dedicated space for food, goods, or other items.",
      image: ImagePath.cabinets,
      status: "false",
    ),
    RxCommonModel(
      title: "Call for Aid System",
      subtitle: "A call system used by a resident to summon aid during a medical emergency",
      image: ImagePath.callaId,
      status: "false",
    ),
    RxCommonModel(
      title: "Carbon Monoxide Alarm",
      subtitle:
          "Device that detects elevated levels of carbon monoxide and signals via auditory or visual alarm in order to prevent carbon monoxide poisoning.",
      image: ImagePath.carbon,
      status: "false",
    ),
    RxCommonModel(
      title: "Ceiling",
      subtitle: "The upper interior surface of a room that provides separation between rooms, spaces, and floors.",
      image: ImagePath.ceiling,
      status: "false",
    ),
    RxCommonModel(
      title: "Cooking Appliance",
      subtitle:
          "Can be an electric or gas stove with several burners and one or more connected ovens; a standalone device that may be built into a counter and has one or more electric or gas burners; or a thermally insulated chamber used for cooking, heating, and baking food.",
      image: ImagePath.kitchen,
      status: "false",
    ),
    RxCommonModel(
      title: "Door - General",
      subtitle:
          "Panel that provides an opening in a building or room and provides separation (i.e., closes an opening)",
      image: ImagePath.doorGeneral,
      status: "false",
    ),
    RxCommonModel(
      title: "Electrical - conductor, outlet, and switch",
      subtitle:
          "Conductor: An object or type of material that carries electrical current. Outlet and Switch: Installations that connect to an electricity supply.",
      image: ImagePath.electricalConductor,
      status: "false",
    ),
    RxCommonModel(
      title: "Electrical - GFCI or AFCI - outler or breaker",
      subtitle: "Electrical protection devices",
      image: ImagePath.electricalGFCI,
      status: "false",
    ),
    RxCommonModel(
      title: "Electrical - service panel",
      subtitle:
          "An enclosure, cabinet, box, or panelboard containing overcurrent protection devices for the control of light, heat, appliances and power circuits",
      image: ImagePath.electricalService,
      status: "false",
    ),
    RxCommonModel(
      title: "Fire Extinguisher",
      subtitle:
          "A portable fire safety device that discharges a jet of water, foam, gas, or other material to extinguish a fire.",
      image: ImagePath.fireExtinguisher,
      status: "false",
    ),
    RxCommonModel(
      title: "Flammable and Combustible item",
      subtitle:
          "A combustible material is any material that, in the form in which it is used and under the conditions anticipated, will ignite and burn or will add appreciable heat to an ambient fire.",
      image: ImagePath.flammableCombustible,
      status: "false",
    ),
    RxCommonModel(
      title: "Floor",
      subtitle: "Lower surface of a room.",
      image: ImagePath.floorLower,
      status: "false",
    ),
    RxCommonModel(
      title: "Food Preparation Area",
      subtitle: "Flat surface installations in kitchens or food preparation spaces.",
      image: ImagePath.foodPreparation,
      status: "false",
    ),
    RxCommonModel(
      title: "Heating, ventilation, and air conditioning (HVAC)",
      subtitle:
          "Heating: A system consisting of a heat source and method of distribution designed to heat the surrounding air and area. Ventilation: A method of air distribution by air ducts to transfer air from one location to another. Air can be distributed passively or forced.Air Conditioning: A system consisting of a cooling source and method of distribution designed to cool the surrounding air and area.",
      image: ImagePath.heatingVentilation,
      status: "false",
    ),
    RxCommonModel(
      title: "Infestation",
      subtitle: "The presence of animals with potential impacts on resident health and safety.",
      image: ImagePath.infestation,
      status: "false",
    ),
    RxCommonModel(
      title: "Leak - gas or oil",
      subtitle:
          "A fuel or gas leak refers to an unintended leak of natural gas or another gaseous product from a pipeline or other containment into any area where the gas or fuel should not be present. Gas leaks can be hazardous to health and the environment.",
      image: ImagePath.leakGas,
      status: "false",
    ),
    RxCommonModel(
      title: "Leak - water",
      subtitle:
          "A water leak can be caused by damage; including a puncture, gash, rust or other corrosion hole, very tiny pinhole leak (possibly in imperfect welds), crack or microcrack, or inadequate sealing between components or parts joined together.",
      image: ImagePath.leakWater,
      status: "false",
    ),
    RxCommonModel(
      title: "Lighting - interior",
      subtitle: "Permanently installed light fixture.",
      image: ImagePath.lightingInterior,
      status: "false",
    ),
    RxCommonModel(
      title: "Minimum Electrical and Lighting",
      subtitle:
          "Lighting: Permanently installed light fixture. Outlet: Installations that connect to an electrical supply.",
      image: ImagePath.minimumElectrical,
      status: "false",
    ),
    RxCommonModel(
      title: "Mold-like Substance",
      subtitle:
          'A "Mold-like substance" can include regular or irregular patches or spots on surfaces that may be colored differently than the surface (coloration may be white, green, yellow, gray, brown, or black), and can be raised from the surface, and are generally composed of minute filaments. A "Mold-like substance" can appear "fuzzy" or "cottony" and a musty or earthy odor can be associated with it. "Mold-like substance" would also include what is often identified as "mildew," i.e., small patches, generally on non-porous surfaces, and dusty (friable) when dry; mildew is generally a thin surface growth that can be wiped off easily. Note that algae are not mold-like substances (algae are grass-green).',
      image: ImagePath.moldLikeSub,
      status: "false",
    ),
    RxCommonModel(
      title: "Potential Lead-Based Paint Hazzards",
      subtitle:
          "Lead-based paint (LBP) is paint or other surface coatings that contain lead equal to or exceeding federal regulatory levels, currently 1.0 milligram per square centimeter or 0.5 percent by weight. Deteriorated paint or surface coatings found in homes built before 1978 are LBP hazards if the paint is LBP. Visual Assessment is surface by surface determination of paint condition.",
      image: ImagePath.potentialLeadBased,
      status: "false",
    ),
    RxCommonModel(
      title: "Sharp Edges",
      subtitle:
          "Physical hazards within the built environment (i.e., human-made structures, features, and facilities) that can lacerate or puncture skin.",
      image: ImagePath.sharpEdges,
      status: "false",
    ),
    RxCommonModel(
      title: "Sink",
      subtitle:
          "A basin with hardware designed to dispense and hold clean water (hot and cold) and discharge wastewater.",
      image: ImagePath.sinkWasteWater,
      status: "false",
    ),
    RxCommonModel(
      title: "Smoke Alarm",
      subtitle:
          "A self-contained device that detects the presence of smoke, typically as an indicator of fire, and provides a visual or audio signal as an alert.",
      image: ImagePath.smokeAlarm,
      status: "false",
    ),
    RxCommonModel(
      title: "Sprinkler",
      subtitle:
          "Part of the fire protection (sprinkler) system that discharges water when activated once reaching a certain (predetermined) temperature.",
      image: ImagePath.sprinkler,
      status: "false",
    ),
    RxCommonModel(
      title: "Trip Hazard",
      subtitle:
          "Hazard caused by an abrupt change in vertical elevation or horizontal separation on any walking surface.",
      image: ImagePath.tripHazard,
      status: "false",
    ),
    RxCommonModel(
      title: "Ventilation",
      subtitle: "Means of supplying air to or removing air from a space.",
      image: ImagePath.ventilation,
      status: "false",
    ),
    RxCommonModel(
      title: "Wall - interior",
      subtitle: "A vertical surface that may define an area, and provide security, shelter, or sound proofing.",
      image: ImagePath.wallInterior,
      status: "false",
    ),
    RxCommonModel(
      title: "Water Heater",
      subtitle: "A device designed to generate and store hot water for domestic use.",
      image: ImagePath.waterHeater,
      status: "false",
    ),
    RxCommonModel(
      title: "Window",
      subtitle: "Opening in a wall or roof of a building that is fitted with glass or other material.",
      image: ImagePath.windowWall,
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
          if (dataList[i].status.toString() == "true") {
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
              dataList[i].status.toString() == "true") {
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
        if (dataList[i].status.toString() == "true") {
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
      if (Get.isRegistered<HomeController>()) {
        itemTitle = Get.find<HomeController>().item!.massage!;
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
              // height: 184.px,
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
