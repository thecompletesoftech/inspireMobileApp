import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/inspection_list_screen/controller/inspection_list_controller.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_req_model.dart';
import 'package:public_housing/screens/inspection_unit_summary_screen/repository/inspection_unit_summary_repository.dart';

class InspectionUnitSummaryController extends BaseController {
  bool isSelected = false;
  var selectedItem = "null";
  var selectFindingList = [];
  List<DeficiencyArea> deficiencyArea = [];
  TextEditingController bedroomsController = TextEditingController();
  TextEditingController bathroomsController = TextEditingController();
  TextEditingController inspectionNotesController = TextEditingController();
  TextEditingController selectFindingTypeController = TextEditingController();
  InspectionUnitSummaryRepository inspectionUnitSummaryRepository =
      InspectionUnitSummaryRepository();
  List<List<dynamic>> findingTypeList = [];
  List<List<dynamic>> resultsList = [];
  List<DeficiencyInspection> deficiencyInspections = [];
  InspectionListController inspectionListController =
      Get.find<InspectionListController>();

  @override
  void onInit() {
    deficiencyArea = [];
    if (Get.arguments != null) {
      deficiencyArea = Get.arguments['deficiencyArea'];
    }
    getResults();
    getFindingType();
    super.onInit();
  }

  getFindingType() async {
    var response = await inspectionUnitSummaryRepository.getFindingType();
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (r) {
      if (r.findingTypes!.isNotEmpty) {
        r.findingTypes?.forEach((element) {
          findingTypeList.add(element);
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
          resultsList.add(element);
        });
      }
    });
    update();
  }

  createInspection() {
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
    inspectionListController.inspectionReqModel.deficiencyInspections =
        deficiencyInspections;
    update();
  }

  searchBuildingType({required String searchText}) {
    selectFindingList.clear();
    if (selectFindingTypeController.text.length > 0) {
      for (int i = 0; i < findingTypeList.length; i++) {
        if (findingTypeList[i]
            .last
            .toString()
            .toLowerCase()
            .contains(searchText.toString().toLowerCase())) {
          selectFindingList.add(findingTypeList[i].last);
          update();
        }
      }
    } else {
      selectFindingList.addAll(findingTypeList);
      update();
    }
  }

  void actionFindingType(value) {
    selectFindingTypeController.text = value.last.toString();
    inspectionListController.inspectionReqModel.inspection?.findingType =
        value.first;
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
                        onTap: () {},
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
                        onTap: () {},
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
}
