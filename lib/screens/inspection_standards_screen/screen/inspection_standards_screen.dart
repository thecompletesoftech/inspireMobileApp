import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/special_amenities_screen/screen/special_amenities_screen.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/inspection_cabinets_screen/screen/inspection_standards_details_screen.dart';
import 'package:public_housing/screens/inspection_standards_screen/controller/inspection_standards_controller.dart';

class InspectionStandardsScreen extends GetView<InspectionStandardsController> {
  const InspectionStandardsScreen({Key? key}) : super(key: key);

  static const routes = "/InspectionStandardsScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InspectionStandardsController>(
      init: InspectionStandardsController(),
      autoRemove: false,
      assignId: true,
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonAppBar(
                  color: controller.appColors.transparent,
                  radius: 0.px,
                  onClickBack: () {
                    List<DeficiencyArea> deficiencyArea = [];
                    controller.searchList.forEach((element) {
                      element.buildingDataModel?.forEach((e) {
                        if (e.isArea == true) {
                          deficiencyArea.add(e);
                        }
                      });
                    });
                    if (deficiencyArea.isNotEmpty) {
                      controller.dialogDelete();
                    } else {
                      Get.back();
                    }
                  },
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyTextView(
                          '${controller.unitAddress} - ${controller.unitName}',
                          textStyleNew: MyTextStyle(
                            textColor: controller.appColors.appColor,
                            textWeight: FontWeight.w600,
                            textFamily: fontFamilyBold,
                            textSize: 20.px,
                          ),
                        ),
                        controller.inspectionType.type != null
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.px, horizontal: 16.px),
                                decoration: BoxDecoration(
                                    color: AppColors().white,
                                    borderRadius: BorderRadius.circular(100)),
                                child: MyTextView(
                                  controller.inspectionType.type ?? "",
                                  textStyleNew: MyTextStyle(
                                    textSize: 14.px,
                                    textColor: AppColors().black,
                                    textWeight: FontWeight.w500,
                                  ),
                                ),
                              ).paddingOnly(left: 24.px)
                            : SizedBox(),
                      ],
                    ).paddingOnly(top: 32.px, bottom: 48.px),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyTextView(
                          Strings.unitinpection,
                          textStyleNew: MyTextStyle(
                            textColor: controller.appColors.appColor,
                            textWeight: FontWeight.w500,
                            textFamily: fontFamilyBold,
                            textSize: 40.px,
                          ),
                        ),
                        CommonButton(
                          title: Strings.specialAmenities,
                          radius: 100.px,
                          width: 198.px,
                          height: 44.px,
                          textSize: 16.px,
                          textWeight: FontWeight.w500,
                          textFamily: fontFamilyRegular,
                          textColor: controller.appColors.white,
                          color: controller.appColors.appColor,
                          onTap: () {
                            List<DeficiencyArea> deficiencyArea = [];
                            controller.searchList.forEach((element) {
                              element.buildingDataModel?.forEach((e) {
                                if (e.isArea == true) {
                                  deficiencyArea.add(e);
                                }
                              });
                            });
                            Get.toNamed(SpecialAmenitiesScreen.routes,
                                arguments: {
                                  "deficiencyArea": deficiencyArea,
                                  "unitAddress": controller.unitAddress,
                                  "unitName": controller.unitName,
                                  "inspectionType": controller.inspectionType,
                                  "unitData": controller.unitData,
                                })?.then((value) {
                              controller.update();
                            });
                          },
                        )
                      ],
                    ).paddingOnly(bottom: 40.px),
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: CommonTextField(
                            isLable: true,
                            onChange: (value) =>
                                controller.searchStandards(searchText: value),
                            controller: controller.searchStandardsController,
                            color: controller.appColors.transparent,
                            padding: EdgeInsets.zero,
                            prefixIcon: SvgPicture.string(
                              icSearch,
                              color: controller.appColors.grey,
                            ).paddingOnly(left: 15.px),
                            contentPadding: EdgeInsets.only(
                                left: 15.px, top: 16.px, bottom: 16.px),
                            shadowColor: controller.appColors.transparent,
                            labelText: Strings.searchStandards,
                          ),
                        ),
                        SizedBox(width: 16.px),
                        Expanded(
                          flex: 4,
                          child: GestureDetector(
                            onTap: controller.isExpanded,
                            child: Container(
                                padding: EdgeInsets.only(left: 10),
                                height: 55.px,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.px),
                                    border: Border.all(
                                        color: controller.appColors.appColor)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    controller.isCollapseStandards
                                        ? SvgPicture.string(
                                            icDownArrow,
                                            color:
                                                controller.appColors.appColor,
                                          )
                                        : SvgPicture.string(
                                            icUpArrow,
                                            color:
                                                controller.appColors.appColor,
                                          ),
                                    MyTextView(
                                      Strings.collapseStandards,
                                      textStyleNew: MyTextStyle(
                                        textColor:
                                            controller.appColors.appColor,
                                        textWeight: FontWeight.w500,
                                        textFamily: fontFamilyBold,
                                        textSize: 16.px,
                                      ),
                                    ).paddingOnly(left: 6.px)
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16.px),
                  ],
                ).paddingOnly(left: 32.px, right: 32.px, bottom: 20.px),
                controller.deficiencyAreas.isNotEmpty
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              controller.searchList.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: controller.searchList.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                MyTextView(
                                                  controller.searchList[index]
                                                          .type ??
                                                      "",
                                                  textStyleNew: MyTextStyle(
                                                    textColor: controller
                                                        .appColors.black,
                                                    textWeight: FontWeight.w600,
                                                    textFamily: fontFamilyBold,
                                                    textSize: 32.px,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 2.px,
                                                    color: AppColors().divider,
                                                  ).paddingSymmetric(
                                                      horizontal: 16.px),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .isItemExpanded(index);
                                                  },
                                                  child: SizedBox(
                                                    height: 24.px,
                                                    width: 24.px,
                                                    child: (controller
                                                                .searchList[
                                                                    index]
                                                                .isExpand ??
                                                            false)
                                                        ? SvgPicture.string(
                                                            icDownArrow,
                                                            color: controller
                                                                .appColors
                                                                .appColor,
                                                          )
                                                        : SvgPicture.string(
                                                            icUpArrow,
                                                            color: controller
                                                                .appColors
                                                                .appColor,
                                                          ).paddingAll(3.px),
                                                  ),
                                                )
                                              ],
                                            ),
                                            if (controller.searchList[index]
                                                    .isExpand ??
                                                false)
                                              ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: controller
                                                    .searchList[index]
                                                    .buildingDataModel
                                                    ?.length,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, i) {
                                                  var buildingDataList =
                                                      controller
                                                          .searchList[index]
                                                          .buildingDataModel?[i];
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      await Get.toNamed(
                                                          InspectionStandardsDetailsScreen
                                                              .routes,
                                                          arguments: {
                                                            "deficiencyArea":
                                                                buildingDataList,
                                                            "successListOfStandards":
                                                                buildingDataList
                                                                        .deficiencyInspectionsReqModel ??
                                                                    []
                                                          })?.then((value) {
                                                        if (value != null) {
                                                          controller.isSuccessStandards1(
                                                              value[
                                                                  'successList'],
                                                              value[
                                                                  'standardsId']);
                                                          controller.update();
                                                        }
                                                      });
                                                    },
                                                    child: ShadowContainer(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            child: Container(
                                                              color: controller
                                                                  .appColors
                                                                  .white,
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 5,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            MyTextView(
                                                                              buildingDataList?.name ?? "",
                                                                              isMaxLineWrap: true,
                                                                              textStyleNew: MyTextStyle(
                                                                                textColor: controller.appColors.black,
                                                                                textWeight: FontWeight.w400,
                                                                                textFamily: fontFamilyBold,
                                                                                textSize: 20.px,
                                                                              ),
                                                                            ),
                                                                            if (buildingDataList!.isArea ==
                                                                                true)
                                                                              ClipOval(
                                                                                  child: SvgPicture.string(
                                                                                icComplete,
                                                                              )).paddingOnly(left: 10.px),
                                                                          ],
                                                                        ),
                                                                        MyTextView(
                                                                          buildingDataList.definition ??
                                                                              "",
                                                                          isMaxLineWrap:
                                                                              true,
                                                                          textStyleNew:
                                                                              MyTextStyle(
                                                                            textColor:
                                                                                controller.appColors.black,
                                                                            textWeight:
                                                                                FontWeight.w400,
                                                                            textFamily:
                                                                                fontFamilyBold,
                                                                            textSize:
                                                                                16.px,
                                                                          ),
                                                                        ).paddingOnly(
                                                                            top:
                                                                                8.px),
                                                                      ],
                                                                    ).paddingSymmetric(
                                                                            horizontal:
                                                                                24.px,
                                                                            vertical: 16.px),
                                                                  )
                                                                ],
                                                              ),
                                                            ))
                                                        .marginSymmetric(
                                                            vertical: 12.px),
                                                  );
                                                },
                                              )
                                          ],
                                        );
                                      },
                                    ).paddingSymmetric(horizontal: 32.px)
                                  : Center(
                                      child: MyTextView(
                                        Strings.noDataFound,
                                        textStyleNew: MyTextStyle(
                                          textColor:
                                              controller.appColors.appColor,
                                          textWeight: FontWeight.w500,
                                          textFamily: fontFamilyBold,
                                          textSize: 16.px,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
