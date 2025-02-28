import 'dart:io';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:public_housing/languages/language.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart';
import 'package:public_housing/screens/unit_inspection_summary_screen/repository/unit_inspection_repository.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart'
    as daily;
import 'package:public_housing/screens/unit_list_screen/screen/unit_list_screen.dart';
import 'package:share_plus/share_plus.dart';
import '../../../commons/all.dart';
import '../../building_inspection_screen/screen/building_inspection_screen.dart';

class UnitController extends BaseController {
  TextEditingController unitNumberName = TextEditingController();
  TextEditingController unitAddress = TextEditingController();
  TextEditingController bedrooms = TextEditingController();
  TextEditingController bathrooms = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController notesController =
      TextEditingController(text: 'Cabinets are broken');
  var switchButton = false.obs;
  String propertyAddress = '';
  var unitJson = {}.obs;
  var deficiencyArea = [];
  var inspectionInfo = {};
  var isLoading = false.obs;
  var deficiencyInfo = [].obs;
  var propertyInfo = {}.obs;
  var buildingInfo = {}.obs;
  var buildingType = "".obs;
  bool isManually = false;
  ScheduleInspection propertyData = ScheduleInspection();
  ScheduleInspectionBuilding externalBuilding = ScheduleInspectionBuilding();
  ScheduleInspectionUnit unitsData = ScheduleInspectionUnit();
  DateTime? selectedDateTime;
  String imageFile = "";
  daily.ScheduleInspectionBuilding scheduleInspectionBuilding =
      daily.ScheduleInspectionBuilding();

  void onInit() {
    if (Get.arguments['deficiencyArea'] != null) {
      deficiencyArea = Get.arguments['deficiencyArea'];
      propertyInfo = Get.arguments['propertyInfo'];
      buildingInfo = Get.arguments['buildingInfo'];
      buildingType.value = Get.arguments['buildingtype'];
      unitAddress.text = Get.arguments['propertyInfo']['address'].toString();
    }
    if (Get.arguments['isManually'] != null) {
      isManually = Get.arguments['isManually'];
    }
    if (Get.arguments['propertyData'] != null) {
      propertyData = Get.arguments['propertyData'];
    }
    if (Get.arguments['externalBuilding'] != null) {
      externalBuilding = Get.arguments['externalBuilding'];
    }
    if (Get.arguments['unitsData'] != null) {
      unitsData = Get.arguments['unitsData'];
      unitNumberName.text = unitsData.unit?.name ?? "";
      unitAddress.text = unitsData.unit?.address ?? "";
      bedrooms.text = '${unitsData.unit?.numberOfBedrooms ?? 0}';
      bathrooms.text = '${unitsData.unit?.numberOfBathrooms ?? 0}';
      switchButton.value = unitsData.unit?.occupied ?? false;
    }
    if (isManually == false) {
      switchButton.value = true;
    }

    if (Get.arguments['inspectorDate'] != null) {
      getInspectionInfoJson();
    }
    getDeficiencyJson();
    super.onInit();
  }

  getUnitInspection() {
    update();
    return unitNumberName.text.isNotEmpty && unitAddress.text.isNotEmpty;
  }

  getInspectionInfoJson() {
    inspectionInfo.addAll({
      "inspector_id":
          getStorageData.readString(getStorageData.inspectorId).toString(),
      "date": Get.arguments['inspectorDate'],
      "comment": commentController.text,
      "inspection_state_id": "2",
      "inspection_type_id": "1",
      "unit_house_keeping": "",
      "general_physical_condition": ""
    });
    print("inspection data" + inspectionInfo.toString());
  }

  getDeficiencyJson() async {
    deficiencyInfo.clear();
    if (deficiencyArea.length > 0) {
      for (var i = 0; i < deficiencyArea.length; i++) {
        for (var j = 0;
            j < deficiencyArea[i].deficiencyInspectionsReqModel!.length;
            j++) {
          deficiencyInfo.add({
            "housing_deficiency_id": deficiencyArea[i]
                .deficiencyInspectionsReqModel![j]
                .deficiencyItemHousingDeficiency!
                .id,
            "deficiency_proof_pictures": await getDeficiencyImage(),
            "comment":
                deficiencyArea[i].deficiencyInspectionsReqModel![j].comment,
            "date": deficiencyArea[i].deficiencyInspectionsReqModel![j].date
          });
        }
      }
      print("deficiency" + deficiencyInfo.toString());
    }
  }

  getDeficiencyImage() {
    var result = [];
    for (var i = 0; i < deficiencyArea.length; i++) {
      for (var j = 0;
          j < deficiencyArea[i].deficiencyInspectionsReqModel!.length;
          j++) {
        for (var k = 0;
            k <
                deficiencyArea[i]
                    .deficiencyInspectionsReqModel![j]
                    .deficiencyProofPictures!
                    .length;
            k++) {
          result.add({
            "picture_path": deficiencyArea[i]
                .deficiencyInspectionsReqModel![j]
                .deficiencyProofPictures![k],
          });
        }
      }
    }
    print("result" + result.toString());
    return result;
  }

  createInspection(arg) async {
    print(arg.toString());
    await getUnitJson();
    await getInspectionInfoJson();
    isLoading.value = true;
    var response = await UnitSummaryRepository().createInspections(
        buildingJson: arg['buildingInfo'],
        certificateList: arg['certificatesInfo'],
        deficiencyList: [],
        inspectionJson: inspectionInfo,
        propertyJson: arg['propertyInfo'],
        unitJson: unitJson);

    await response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
      isLoading.value = false;
      update();
    }, (r) async {
      utils.showSnackBar(
          context: Get.context!,
          message: "Unit inspection Submitted Successfully!!",
          isOk: true);

      await Get.offAllNamed(BuildingInspectionScreen.routes);

      isLoading.value = false;
      update();
    });
  }

  createPassInspection() async {
    await getUnitJson();
    inspectionInfo.addAll({
      "inspector_id":
          getStorageData.readString(getStorageData.inspectorId).toString(),
      "date": propertyData.scheduleDate.toString(),
      "comment": commentController.text,
      "inspection_state_id": "2",
      "inspection_type_id": "1",
      "unit_house_keeping": "",
      "general_physical_condition": ""
    });

    buildingInfo.addAll({
      "id": externalBuilding.id,
      "name": externalBuilding.building?.name,
      "constructed_year": externalBuilding.building?.constructedYear,
      "building_type_id": externalBuilding.building?.buildingType?.id
    });

    propertyInfo.addAll({
      "id": propertyData.property?.id,
      "name": propertyData.property?.name,
      "city": propertyData.property?.city,
      "state": propertyData.property?.state,
      "zip": propertyData.property?.zip,
      "address": propertyData.property?.address1
    });

    isLoading.value = true;
    var response = await UnitSummaryRepository().createInspections(
        buildingJson: buildingInfo,
        certificateList: {},
        deficiencyList: [],
        inspectionJson: inspectionInfo,
        propertyJson: propertyInfo,
        unitJson: unitJson);

    await response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
      isLoading.value = false;
      update();
    }, (r) async {
      await getUnitData();
      await Get.toNamed(
        UnitListScreen.routes,
        arguments: {
          'externalBuilding': scheduleInspectionBuilding,
          "propertyData": propertyData,
          "isManually": isManually
        },
      );
      isLoading.value = false;
      update();
    });
  }

  getUnitData() {
    propertyData.scheduleInspectionBuildings?.forEach(
      (element) {
        if (element.id == externalBuilding.id) {
          scheduleInspectionBuilding.id = element.id;
          scheduleInspectionBuilding.scheduleInspectionUnits =
              element.scheduleInspectionUnits;
          scheduleInspectionBuilding.building = element.building;
          scheduleInspectionBuilding.isBuildingInspection =
              element.isBuildingInspection;
        }
      },
    );
    update();
  }

  saveCreateInspection(arg) async {
    isLoading.value = true;
    await getUnitJson();
    await getInspectionInfoJson();

    var response = await UnitSummaryRepository().createInspections(
        buildingJson: arg['buildingInfo'],
        certificateList: arg['certificatesInfo'],
        deficiencyList: [],
        inspectionJson: inspectionInfo,
        propertyJson: arg['propertyInfo'],
        unitJson: unitJson);

    await response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
      isLoading.value = false;
      update();
    }, (r) async {
      utils.showSnackBar(
          context: Get.context!,
          message: "Unit inspection Submitted Successfully!!",
          isOk: true);
      clearData();
      // getunitinspection();
      // Get.back(result: {
      //   "propertyInfo":
      //       Get.arguments == null ? "" : Get.arguments['propertyInfo'],
      //   "buildingInfo":
      //       Get.arguments == null ? "" : Get.arguments['buildingInfo'],
      //   "buildingtype":
      //       Get.arguments == null ? "" : Get.arguments['buildingtype'],
      //   "cerificateList": Get.arguments['certificatesInfo'],
      //   "deficiencyArea": Get.arguments['deficiencyArea'],
      //   "switchvalue": switchbtn.value,
      //   "inspectorDate": Get.arguments['inspectorDate']
      // });
      // Get.back();
      isLoading.value = false;
      update();
    });
  }

  clearData() {
    unitNumberName.clear();
    // unitAddress.clear();
    bedrooms.clear();
    bathrooms.clear();
    commentController.clear();
    unitJson.value = {};
    inspectionInfo = {};
    switchButton.value = false;
  }

  getUnitJson() {
    unitJson.addAll(bedrooms.text.isEmpty && bathrooms.text.isEmpty
        ? {
            "name": unitNumberName.text,
            "address": unitAddress.text,
            "occupied": switchButton.value
          }
        : bedrooms.text.isEmpty
            ? {
                "name": unitNumberName.text,
                "address": unitAddress.text,
                "number_of_bathrooms": bathrooms.text,
                "occupied": switchButton.value
              }
            : bathrooms.text.isEmpty
                ? {
                    "name": unitNumberName.text,
                    "address": unitAddress.text,
                    "occupied": switchButton.value,
                    "number_of_bedrooms": bedrooms.text,
                  }
                : {
                    "name": unitNumberName.text,
                    "address": unitAddress.text,
                    "occupied": switchButton.value,
                    "number_of_bathrooms": bathrooms.text,
                    "number_of_bedrooms": bedrooms.text,
                  });
    print(unitJson.toString());
  }

  unitCannotInspected(context, arg) {
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
                elevation: 8,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: appColors.border),
                      borderRadius: BorderRadius.circular(20),
                      color: appColors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextView(
                          Strings.unitcannitbeinspected,
                          textStyleNew: MyTextStyle(
                            textColor: appColors.textBlack,
                            textSize: 24.px,
                            textFamily: fontFamilyRegular,
                            textWeight: FontWeight.w400,
                          ),
                        ).paddingOnly(top: 24.px, left: 24.px, right: 24.px),
                        CommonTextField(
                                isLable: true,
                                controller: commentController,
                                color: appColors.transparent,
                                onChange: ((value) {
                                  update();
                                }),
                                prefixIcon: GestureDetector(
                                  onTap: () {
                                    //  listen();
                                  },
                                  child: SvgPicture.string(
                                    icsubtrack,
                                  ).paddingOnly(left: 10.px, right: 20.px),
                                ),
                                padding: EdgeInsets.zero,
                                contentPadding:
                                    EdgeInsets.only(left: 20.px, right: 20.px),
                                labelText: Strings.reasonUninspectable,
                                hintText: Strings.Nokeyavailble)
                            .paddingOnly(top: 24.px, left: 24.px, right: 24.px),
                        Divider().paddingOnly(bottom: 10.px, top: 10.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonButton(
                                title: Strings.cancel,
                                textColor: appColors.appColor,
                                color: appColors.transparent,
                                textSize: 16.px,
                                textFamily: fontFamilyRegular,
                                textWeight: FontWeight.w500,
                                radius: 100.px,
                                onTap: () {
                                  Get.back();
                                }),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (() {
                                    if (commentController.text.isNotEmpty) {
                                      Get.back();
                                      saveCreateInspection(arg);
                                    }
                                  }),
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 44.px,
                                      width: 181.px,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100.px),
                                          border: Border.all(
                                              color: commentController
                                                      .text.isNotEmpty
                                                  ? appColors.appColor
                                                  : appColors.border1)),
                                      child: MyTextView(
                                        Strings.saveandunit,
                                        textStyleNew: MyTextStyle(
                                          textColor:
                                              commentController.text.isNotEmpty
                                                  ? appColors.appColor
                                                  : appColors.border1,
                                          textWeight: FontWeight.w500,
                                          textFamily: fontFamilyBold,
                                          textSize: 16.px,
                                        ),
                                      )).paddingOnly(right: 16.px),
                                ),
                                CommonButton(
                                  title: Strings.CompleteInspection,
                                  radius: 100.px,
                                  width: 198.px,
                                  height: 44.px,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15.px,
                                    horizontal: 24.px,
                                  ),
                                  textSize: 16.px,
                                  textWeight: FontWeight.w500,
                                  textFamily: fontFamilyRegular,
                                  textColor: commentController.text.isNotEmpty
                                      ? appColors.black
                                      : appColors.border1,
                                  color: commentController.text.isNotEmpty
                                      ? appColors.textPink
                                      : appColors.black
                                          .withOpacity(0.11999999731779099),
                                  onTap: () {
                                    if (commentController.text.isNotEmpty) {
                                      Get.back();
                                      createInspection(arg);
                                    }
                                  },
                                )
                              ],
                            ).paddingOnly(bottom: 20.px),
                          ],
                        ).paddingOnly(left: 24.px, right: 24.px),
                      ],
                    )));
          });
        });
  }

  dialogPassInspection() {
    alertActionDialogApp(
        context: Get.context!,
        borderRadius: 28.px,
        widget: Column(
          children: [
            Container(
              width: 323.px,
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
                    Strings.passUnitInspection,
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
                            text: 'You will quick pass this inspection.',
                            style: MyTextStyle(
                              textColor: appColors.lightText,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '\n\nAre you sure?',
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
              width: 323.px,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          title: Strings.passInspection,
                          textColor: appColors.white,
                          color: appColors.appColor,
                          textSize: 16.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w500,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.px, vertical: 10.px),
                          radius: 100.px,
                          onTap: () async {
                            Get.back();
                            await createPassInspection();
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

  dialogIncompleteInspection() {
    imageFile = '';
    alertActionDialogApp(
      context: Get.context!,
      borderRadius: 28.px,
      widget: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: [
              Container(
                width: 422.px,
                padding: EdgeInsets.only(top: 24.px, left: 24.px, right: 24.px),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyTextView(
                      Strings.takeNotes,
                      textStyleNew: MyTextStyle(
                        textColor: appColors.textBlack,
                        textSize: 24.px,
                        textFamily: fontFamilyRegular,
                        textWeight: FontWeight.w400,
                      ),
                    ).paddingSymmetric(vertical: 16.px),
                    CommonTextField(
                      isLable: true,
                      controller: notesController,
                      color: appColors.transparent,
                      padding: EdgeInsets.zero,
                      labelText: Strings.notess,
                      hintText: Strings.notess,
                      contentPadding: EdgeInsets.all(15.px),
                    ).paddingOnly(bottom: 24.px),
                    imageFile.isNotEmpty
                        ? Text(imageFile)
                        : CommonIconButton(
                            icon: icCamera,
                            iconheigth: 20.px,
                            border:
                                Border.all(color: appColors.border, width: 2),
                            radius: 100.px,
                            title: Strings.takePicture,
                            onTap: () async {
                              await imagePicker(setState);
                            },
                            padding:
                                EdgeInsets.fromLTRB(16.px, 10.px, 24.px, 10.px),
                            textWeight: FontWeight.w600,
                            textSize: 16.px,
                            color: appColors.transparent,
                            textColor: appColors.appColor,
                          ),
                  ],
                ),
              ),
              SizedBox(
                width: 422.px,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          },
                        ).paddingOnly(right: 8.px),
                        CommonButton(
                          title: Strings.save,
                          textColor: appColors.white,
                          color: appColors.appColor,
                          textSize: 16.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w500,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.px, vertical: 10.px),
                          radius: 100.px,
                          onTap: () async {
                            final box =
                                context.findRenderObject() as RenderBox?;
                            String subData =
                                '''Date of inspection : ${DateFormat('yyyy-MM-dd').format(propertyData.scheduleDate!)} \nDate of this note : ${DateFormat('yyyy-MM-dd').format(DateTime.now())} \nProperty name : ${propertyData.property?.name ?? ""} \nBuilding name : ${externalBuilding.building?.name ?? ""} \nUnit : ${unitsData.unit?.name ?? ""} \nNotes : ${notesController.text}''';
                            await Share.shareXFiles([XFile(imageFile)],
                                    sharePositionOrigin:
                                        box!.localToGlobal(Offset.zero) &
                                            box.size,
                                    text: 'iPad notes',
                                    subject: subData)
                                /*   .then(
                              (value) async {
                                if (value == true) {
                                  await Get.offAllNamed(
                                      PropertiesListScreen.routes);
                                }
                              },
                            )*/
                                ;
                          },
                        ),
                      ],
                    ).paddingOnly(
                        top: 24.px, left: 8.px, right: 24.px, bottom: 24.px),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  getFromGallery(Function setState) async {
    bool checkPermission = await utils.checkPermissionOpenCamera();
    if (checkPermission) {
      try {
        XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 25,
        );
        if (pickedFile != null) {
          setState(() {});
          selectedDateTime = await pickedFile.lastModified();
          File file = await Utils()
              .addTimestampToImage(File(pickedFile.path), selectedDateTime!);
          setState(() {
            imageFile = file.path;
          });
        }
      } catch (e) {
        utils.showToast(message: e.toString(), context: Get.context!);
        printError(e.toString());
      }
    }
  }

  getFromCamera(Function setState) async {
    bool checkPermission = await utils.checkPermissionOpenCamera();
    if (checkPermission) {
      try {
        XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 25,
        );
        if (pickedFile != null) {
          setState(() {});
          selectedDateTime = await pickedFile.lastModified();
          File file = await Utils()
              .addTimestampToImage(File(pickedFile.path), selectedDateTime!);
          setState(() {
            imageFile = file.path;
          });
        }
      } catch (e) {
        utils.showToast(message: e.toString(), context: Get.context!);
        printError(e.toString());
      }
    }
  }

  imagePicker(Function setState) {
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
                      getFromGallery(setState);
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
                      getFromCamera(setState);
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
}
