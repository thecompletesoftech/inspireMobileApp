import 'package:flutter_svg/svg.dart';
import 'package:public_housing/screens/unit_Inpection_screen/screen/unit_inspection_screen.dart';

import '../../commons/all.dart';
import '../building_inspection_screen/screen/building_inspection_screen.dart';

class UnitController extends BaseController {
  TextEditingController unitnumberoRname = TextEditingController();
  TextEditingController unitAddress = TextEditingController();
  TextEditingController bedrooms = TextEditingController();
  TextEditingController bathrooms = TextEditingController();
  TextEditingController commentController = TextEditingController();
  var switchbtn = false.obs;
  String propertyaddress = '';
  var unitjson = {}.obs;

  void onInit() {
    unitAddress.text = Get.arguments['propertyInfo']['address'].toString();
    super.onInit();
  }

  getunitinspection() {
    return unitnumberoRname.text.isNotEmpty && unitAddress.text.isNotEmpty;
  }


  getinspectioninfojson() {
    inspectioninfo.addAll({
      "inspector_id":
          getStorageData.readString(getStorageData.inspectorId).toString(),
      "date": Get.arguments['inspectorDate'],
      "comment": commentController.text,
      "inspection_state_id": "2",
      "inspection_type_id": "1",
      "unit_house_keeping": "",
      "general_physical_condition": ""
    });
    print("inspection data" + inspectioninfo.toString());
  }

  getdeficienyjson() async {
    deficiencyinfo.clear();
    if (deficiencyArea.length > 0) {
      for (var i = 0; i < deficiencyArea.length; i++) {
        for (var j = 0;
            j < deficiencyArea[i].deficiencyInspectionsReqModel!.length;
            j++) {
          deficiencyinfo.add({
            "housing_deficiency_id": deficiencyArea[i]
                .deficiencyInspectionsReqModel![j]
                .deficiencyItemHousingDeficiency!
                .id,
            "deficiency_proof_pictures": await getdeficienyimage(),
            "comment":
                deficiencyArea[i].deficiencyInspectionsReqModel![j].comment,
            "date": deficiencyArea[i].deficiencyInspectionsReqModel![j].date
          });
        }
      }
      print("deficiency" + deficiencyinfo.toString());
    }
  }

  getdeficienyimage() {
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

  createinspection(arg) async {
    print(arg.toString());
    await getunitjson();
    await getinspectioninfojson();
    islaoding.value = true;
    var response = await UnitsummaryRepository().createinspection(
        buildingjsons: arg['buildingInfo'],
        certificatelists: arg['certificatesInfo'],
        deficiencylists: [],
        insepctionjsons: inspectioninfo,
        propertyjsons: arg['propertyInfo'],
        unitjsons: unitjson);

    await response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
      islaoding.value = false;
      update();
    }, (r) async {
      utils.showSnackBar(
          context: Get.context!,
          message: "Unit inspection Submitted Successfully!!",
          isOk: true);
      _buildingStandardsController.cleardata();
      _buildingInspectionController.clearAllData();
      _buildingInspectionSummaryController.cleardata();
      await _buildingInspectionController.getCertificates();
      await Get.toNamed(BuildingInspectionScreen.routes);

      islaoding.value = false;
      update();
    });
  }

  saveCreateinspection(arg) async {
    islaoding.value = true;
    await getunitjson();
    await getinspectioninfojson();
    // print("unit " + Get.arguments['unitinfo'].toString());
    // print("buildinginfo " + Get.arguments['buildingInfo'].toString());
    // print("property info " + Get.arguments['propertyInfo'].toString());
    // print("building type info " + Get.arguments['buildingtype'].toString());
    // print("certificate info " + Get.arguments['cerificateList'].toString());
    // print("certificate info " + Get.arguments['inspectorDate'].toString());
    var response = await UnitsummaryRepository().createinspection(
        buildingjsons: arg['buildingInfo'],
        certificatelists: arg['certificatesInfo'],
        deficiencylists: [],
        insepctionjsons: inspectioninfo,
        propertyjsons: arg['propertyInfo'],
        unitjsons: unitjson);

    await response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
      islaoding.value = false;
      update();
    }, (r) async {
      utils.showSnackBar(
          context: Get.context!,
          message: "Unit inspection Submitted Successfully!!",
          isOk: true);
      //  print("property info " + Get.arguments['propertyinfo'].toString());
      cleardata();
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
      islaoding.value = false;
      update();
    });
  }

  cleardata() {
    unitnumberoRname.clear();
    // unitAddress.clear();
    bedrooms.clear();
    bathrooms.clear();
    commentController.clear();
    unitjson.value = {};
    inspectioninfo = {};
    switchbtn.value = false;

  
  }

  getunitjson() {
    unitjson.addAll(bedrooms.text.isEmpty && bathrooms.text.isEmpty
        ? {
            "name": unitnumberoRname.text,
            "address": unitAddress.text,
            "occupied": switchbtn.value
          }
        : bedrooms.text.isEmpty
            ? {
                "name": unitnumberoRname.text,
                "address": unitAddress.text,
                "number_of_bathrooms": bathrooms.text,
                "occupied": switchbtn.value
              }
            : bathrooms.text.isEmpty
                ? {
                    "name": unitnumberoRname.text,
                    "address": unitAddress.text,
                    "occupied": switchbtn.value,
                    "number_of_bedrooms": bedrooms.text,
                  }
                : {
                    "name": unitnumberoRname.text,
                    "address": unitAddress.text,
                    "occupied": switchbtn.value,
                    "number_of_bathrooms": bathrooms.text,

                    "number_of_bedrooms": bedrooms.text,


                  });
    print(unitjson.toString());
  }

  unitCannotInspected(context) {
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
                                      saveCreateinspection(arg);
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
                                              color: appColors.appColor)),
                                      child: MyTextView(
                                        Strings.saveandunit,
                                        textStyleNew: MyTextStyle(
                                          textColor: appColors.appColor,
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
                                  textColor: getreasonunitinspection()
                                      ? appColors.black
                                      : appColors.border1,
                                  color: getreasonunitinspection()
                                      ? appColors.textPink
                                      : appColors.black
                                          .withOpacity(0.11999999731779099),
                                  onTap: () {
                                    if (getreasonunitinspection()) {
                                      Get.toNamed(
                                          BuildingInspectionScreen.routes);
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
