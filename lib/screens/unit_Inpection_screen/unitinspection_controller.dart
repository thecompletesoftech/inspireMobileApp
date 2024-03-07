import 'package:flutter_svg/svg.dart';
import '../../commons/all.dart';
import '../building_inspection_screen/screen/building_inspection_screen.dart';
import '../unitinspectionsummary_screen/repository/unitinspection_repository.dart';

class UnitController extends BaseController {
  TextEditingController unitNumberName = TextEditingController();
  TextEditingController unitAddress = TextEditingController();
  TextEditingController bedrooms = TextEditingController();
  TextEditingController bathrooms = TextEditingController();
  TextEditingController commentController = TextEditingController();
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

  void onInit() {
    if (Get.arguments != null) {
      deficiencyArea = Get.arguments['deficiencyArea'];
      propertyInfo = Get.arguments['propertyInfo'];
      buildingInfo = Get.arguments['buildingInfo'];
      buildingType.value = Get.arguments['buildingtype'];
      unitAddress.text = Get.arguments['propertyInfo']['address'].toString();
    }
    getInspectionInfoJson();
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
      await Get.toNamed(BuildingInspectionScreen.routes);

      isLoading.value = false;
      update();
    });
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
    // Get.dialog(Dialog(
    //     elevation: 8,
    //     child: Container(
    //         decoration: BoxDecoration(
    //           border: Border.all(color: appColors.border),
    //           borderRadius: BorderRadius.circular(20),
    //           color: appColors.white,
    //         ),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             MyTextView(
    //               Strings.unitcannitbeinspected,
    //               textStyleNew: MyTextStyle(
    //                 textColor: appColors.textBlack,
    //                 textSize: 24.px,
    //                 textFamily: fontFamilyRegular,
    //                 textWeight: FontWeight.w400,
    //               ),
    //             ).paddingOnly(top: 24.px, left: 24.px, right: 24.px),
    //             CommonTextField(
    //                     isLable: true,
    //                     controller: commentController,
    //                     color: appColors.transparent,
    //                     onChange: ((value) {
    //                       update();
    //                     }),
    //                     prefixIcon: GestureDetector(
    //                       onTap: () {
    //                         //  listen();
    //                       },
    //                       child: SvgPicture.string(
    //                         icsubtrack,
    //                       ).paddingOnly(left: 10.px, right: 20.px),
    //                     ),
    //                     padding: EdgeInsets.zero,
    //                     contentPadding:
    //                         EdgeInsets.only(left: 20.px, right: 20.px),
    //                     labelText: Strings.reasonUninspectable,
    //                     hintText: Strings.Nokeyavailble)
    //                 .paddingOnly(top: 24.px, left: 24.px, right: 24.px),
    //             Divider().paddingOnly(bottom: 10.px, top: 10.px),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 CommonButton(
    //                     title: Strings.cancel,
    //                     textColor: appColors.appColor,
    //                     color: appColors.transparent,
    //                     textSize: 16.px,
    //                     textFamily: fontFamilyRegular,
    //                     textWeight: FontWeight.w500,
    //                     radius: 100.px,
    //                     onTap: () {
    //                       Get.back();
    //                     }),
    //                 Row(
    //                   children: [
    //                     GestureDetector(
    //                       onTap: (() {
    //                         if (commentController.text.isNotEmpty) {
    //                           saveCreateinspection();
    //                         }
    //                       }),
    //                       child: Container(
    //                           alignment: Alignment.center,
    //                           height: 44.px,
    //                           width: 181.px,
    //                           decoration: BoxDecoration(
    //                               borderRadius: BorderRadius.circular(100.px),
    //                               border: Border.all(
    //                                   color: commentController.text.isNotEmpty
    //                                       ? appColors.appColor
    //                                       : appColors.border1)),
    //                           child: MyTextView(
    //                             Strings.saveandunit,
    //                             textStyleNew: MyTextStyle(
    //                               textColor: commentController.text.isNotEmpty
    //                                   ? appColors.appColor
    //                                   : appColors.border1,
    //                               textWeight: FontWeight.w500,
    //                               textFamily: fontFamilyBold,
    //                               textSize: 16.px,
    //                             ),
    //                           )).paddingOnly(right: 16.px),
    //                     ),
    //                     CommonButton(
    //                       title: Strings.CompleteInspection,
    //                       radius: 100.px,
    //                       width: 198.px,
    //                       height: 44.px,
    //                       padding: EdgeInsets.symmetric(
    //                         vertical: 15.px,
    //                         horizontal: 24.px,
    //                       ),
    //                       textSize: 16.px,
    //                       textWeight: FontWeight.w500,
    //                       textFamily: fontFamilyRegular,
    //                       textColor: commentController.text.isNotEmpty
    //                           ? appColors.black
    //                           : appColors.border1,
    //                       color: commentController.text.isNotEmpty
    //                           ? appColors.textPink
    //                           : appColors.black
    //                               .withOpacity(0.11999999731779099),
    //                       onTap: () {
    //                         if (commentController.text.isNotEmpty) {
    //                           Get.back();
    //                           // createinspection(arg);
    //                         }
    //                       },
    //                     )
    //                   ],
    //                 ).paddingOnly(bottom: 20.px),
    //               ],
    //             ).paddingOnly(left: 24.px, right: 24.px),
    //           ],
    //         ))));

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
}
