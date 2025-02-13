import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/Repository/deficiencies_inside_repository.dart';
import 'package:public_housing/screens/inspection_information_screen/controller/inspection_information_controller.dart';
import 'package:public_housing/screens/inspection_list_screen/controller/inspection_list_controller.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_req_model.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_res_model.dart';
import 'package:public_housing/screens/inspection_list_screen/screen/inspection_list_screen.dart';
import 'package:public_housing/screens/inspection_unit_summary_screen/model/filter_model.dart';
import 'package:public_housing/screens/inspection_unit_summary_screen/repository/inspection_unit_summary_repository.dart';
import 'package:public_housing/screens/manual_unit_inspection_screen/controller/manual_unit_inspection_controller.dart';
import 'package:public_housing/screens/special_amenities_screen/model/special_amenities_req_model.dart';

class InspectionUnitSummaryController extends BaseController {
  bool isSelected = false;
  var selectedItem = "null";
  List<FilterModel> selectFindingList = [];
  List<DeficiencyArea> deficiencyArea = [];
  TextEditingController bedroomsController = TextEditingController();
  TextEditingController bathroomsController = TextEditingController();
  TextEditingController inspectionNotesController = TextEditingController();
  TextEditingController selectFindingTypeController = TextEditingController();
  InspectionUnitSummaryRepository inspectionUnitSummaryRepository =
      InspectionUnitSummaryRepository();
  List<FilterModel> findingTypeList = [];
  List<FilterModel> resultsList = [];
  List<DeficiencyInspection> deficiencyInspections = [];
  String unitAddress = '';
  String unitName = '';
  InspectionType inspectionType = InspectionType();
  Units unitData = Units();
  List<String> healthList = [];
  bool isHealth = false;
  DeficienciesInsideRepository deficienciesInsideRepository =
      DeficienciesInsideRepository();

  @override
  void onInit() {
    deficiencyArea = [];
    if (Get.arguments != null) {
      deficiencyArea = Get.arguments['deficiencyArea'];
      unitAddress = Get.arguments['unitAddress'];
      unitName = Get.arguments['unitName'];
      inspectionType = Get.arguments['inspectionType'];
    }
    if (Get.arguments['unitData'] != null) {
      unitData = Get.arguments['unitData'];
      bedroomsController.text = unitData.numberOfBedrooms == null
          ? '0'
          : unitData.numberOfBedrooms.toString();
      bathroomsController.text = unitData.numberOfBathrooms == null
          ? '0'
          : unitData.numberOfBathrooms.toString();
    }
    if (Get.put(InspectionInformationController())
        .inspectionNotesController
        .text
        .isNotEmpty) {
      inspectionNotesController.text =
          Get.find<InspectionInformationController>()
              .inspectionNotesController
              .text;
    }
    if (Get.put(ManualUnitInspectionController())
        .inspectionNotesController
        .text
        .isNotEmpty) {
      inspectionNotesController.text =
          Get.find<ManualUnitInspectionController>()
              .inspectionNotesController
              .text;
    }
    getResults();
    getFindingType();
    filterHealthData();
    super.onInit();
  }

  filterHealthData() async {
    isHealth = false;
    healthList = [];
    deficiencyArea.forEach(
      (element) {
        element.deficiencyInspectionsReqModel?.forEach(
          (e) {
            healthList.add(e.deficiencyItemHousingDeficiency?.severity
                    ?.healthySafetyDesignation ??
                "");
          },
        );
      },
    );
    isHealth = healthList
        .where((element) => element == 'LT' || element == 'S' || element == 'M')
        .toList()
        .isNotEmpty;
  }

  getFindingType() async {
    var response = await inspectionUnitSummaryRepository.getFindingType();
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (r) {
      if (r.findingTypes!.isNotEmpty) {
        r.findingTypes?.forEach((element) {
          findingTypeList
              .add(FilterModel(id: element.first, title: element.last));
        });
      }
    });
    update();
  }

  getResults() async {
    var response = await inspectionUnitSummaryRepository.getResults();
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (r) {
      if (r.results!.isNotEmpty) {
        r.results?.forEach((element) {
          resultsList.add(FilterModel(id: element.first, title: element.last));
        });
      }
    });
    update();
  }

  filterInspection() {
    deficiencyArea.forEach((element) {
      element.deficiencyInspectionsReqModel?.forEach((e) {
        List<DeficiencyProofPicture> pictureList = [];
        e.deficiencyProofPictures?.forEach((pictureString) {
          pictureList.add(DeficiencyProofPicture(picturePath: pictureString));
        });

        deficiencyInspections.add(DeficiencyInspection(
          housingDeficiencyId: int.tryParse(
                  e.deficiencyItemHousingDeficiency?.id.toString() ?? "")
              .toString(),
          comment: e.comment,
          deficiencyProofPictures: pictureList,
        ));
      });
    });
    inspectionReqModel.deficiencyInspections = deficiencyInspections;
    update();
  }

  searchFindingType({required String searchText}) {
    selectFindingList.clear();
    if (selectFindingTypeController.text.length > 0) {
      for (int i = 0; i < findingTypeList.length; i++) {
        if (findingTypeList[i]
            .title
            .toString()
            .toLowerCase()
            .contains(searchText.toString().toLowerCase())) {
          selectFindingList.add(findingTypeList[i]);
          update();
        }
      }
    } else {
      selectFindingList.addAll(findingTypeList);
      update();
    }
  }

  void actionFindingType(value) {
    selectFindingTypeController.text = value.title.toString();
    inspectionReqModel.inspection?.findingType = value.id;
    update();
  }

  noOnePresentDialog() {
    alertActionDialogApp(
        context: Get.context!,
        borderRadius: 28.px,
        widget: GetBuilder<InspectionUnitSummaryController>(
          builder: (_) {
            return Column(
              children: [
                Container(
                  width: 420.px,
                  padding: EdgeInsets.all(24.px),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyTextView(
                        Strings.noOneIsPresent,
                        textStyleNew: MyTextStyle(
                          textColor: appColors.textBlack,
                          textSize: 24.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w400,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'You can complete the inspection if no one is present to make a signature.',
                              style: MyTextStyle(
                                textColor: appColors.textBlack2,
                                textSize: 16.px,
                                textFamily: fontFamilyRegular,
                                textWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ).paddingOnly(top: 16.px),
                    ],
                  ),
                ),
                Container(
                  width: 420.px,
                  height: 2.px,
                  color: appColors.grey.withOpacity(0.5),
                ),
                SizedBox(
                  width: 420.px,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                        title: Strings.completeInspection,
                        textColor: appColors.black,
                        color: appColors.textPink,
                        textSize: 16.px,
                        textFamily: fontFamilyRegular,
                        textWeight: FontWeight.w500,
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.px, vertical: 10.px),
                        radius: 100.px,
                        onTap: () async {
                          await filterInspection();
                          createInspections();
                        },
                      ),
                    ],
                  ).paddingOnly(top: 24.px, right: 24.px, bottom: 24.px),
                ),
              ],
            );
          },
        ));
  }

  isDataUpdate(mainIndex, subIndex, deficiencyInspectionsReqModel) {
    deficiencyArea[mainIndex].deficiencyInspectionsReqModel?[subIndex] =
        deficiencyInspectionsReqModel[0];
    deficiencyArea[mainIndex]
        .deficiencyInspectionsReqModel?[subIndex]
        .isSuccess = true;
    update();
  }

  isDataUpdateSuccess(mainIndex, subIndex) {
    deficiencyArea[mainIndex].deficiencyInspectionsReqModel?.removeAt(subIndex);
    if (deficiencyArea[mainIndex].deficiencyInspectionsReqModel!.isEmpty) {
      deficiencyArea[mainIndex].isArea = false;
    }
    update();
  }

  createInspections() async {
    inspectionReqModel.inspection?.comment = inspectionNotesController.text;
    var response = await deficienciesInsideRepository.createInspection(
        inspectionModel: inspectionReqModel);

    response.fold(
      (l) {
        utils.showSnackBar(context: Get.context!, message: l.errorMessage);
      },
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

  passInspectionDialog() {
    alertActionDialogApp(
        context: Get.context!,
        borderRadius: 28.px,
        widget: GetBuilder<InspectionUnitSummaryController>(
          builder: (_) {
            return Column(
              children: [
                SvgPicture.string(warningIcon)
                    .paddingSymmetric(vertical: 24.px),
                Container(
                  width: 350.px,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyTextView(
                        Strings.youInspectionHeading,
                        textStyleNew: MyTextStyle(
                          textColor: appColors.textBlack,
                          textSize: 24.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w400,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: Strings.youInspectionTitle,
                                style: MyTextStyle(
                                  textColor: appColors.textBlack2,
                                  textSize: 16.px,
                                  textFamily: fontFamilyRegular,
                                  textWeight: FontWeight.w400,
                                ),
                                children: [
                                  TextSpan(
                                    text: '\n\nDelete ',
                                    style: MyTextStyle(
                                      textColor: appColors.textBlack2,
                                      textSize: 16.px,
                                      textFamily: fontFamilyRegular,
                                      textWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: Strings.youInspectionSubTitle,
                                    style: MyTextStyle(
                                      textColor: appColors.textBlack2,
                                      textSize: 16.px,
                                      textFamily: fontFamilyRegular,
                                      textWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'fail ',
                                    style: MyTextStyle(
                                      textColor: appColors.textBlack2,
                                      textSize: 16.px,
                                      textFamily: fontFamilyRegular,
                                      textWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: Strings.youInspectionSubTitle1,
                                    style: MyTextStyle(
                                      textColor: appColors.textBlack2,
                                      textSize: 16.px,
                                      textFamily: fontFamilyRegular,
                                      textWeight: FontWeight.w400,
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      ).paddingOnly(top: 16.px),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 24.px),
                SizedBox(
                    width: 350.px,
                    child: CommonButton(
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
                      },
                    )).paddingSymmetric(vertical: 24.px),
              ],
            );
          },
        ));
  }
}
