import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:public_housing/screens/inspection_list_screen/controller/inspection_list_controller.dart';
import 'package:public_housing/screens/signatures_screen/screen/signature_screen.dart';
import 'package:public_housing/screens/building_inspection_summary/screen/building_inspection_summary_screen.dart';
import 'package:public_housing/screens/inspection_unit_summary_screen/binding/inspection_unit_summary_binding.dart';
import 'package:public_housing/screens/inspection_unit_summary_screen/controller/inspection_unit_summary_controller.dart';
import 'package:public_housing/screens/inspection_deficiencies_inside_screen/screen/inspection_deficiencies_inside_screen.dart';

class InspectionUnitSummaryScreen
    extends GetView<InspectionUnitSummaryBinding> {
  const InspectionUnitSummaryScreen({Key? key}) : super(key: key);

  static const routes = "/InspectionUnitSummaryScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InspectionUnitSummaryController>(
      init: InspectionUnitSummaryController(),
      autoRemove: false,
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonAppBar(
                  color: controller.appColors.transparent,
                  radius: 0.px,
                  onClickBack: () {
                    Get.back();
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: MyTextView(
                                      controller.inspectionType.type ?? "",
                                      textStyleNew: MyTextStyle(
                                          textSize: 14.px,
                                          textColor: AppColors().black,
                                          textWeight: FontWeight.w500),
                                    ),
                                  ).paddingOnly(left: 24.px)
                                : SizedBox(),
                          ],
                        ).paddingOnly(top: 32.px),
                        Center(
                          child: MyTextView(
                            Strings.inspectionSummary,
                            textStyleNew: MyTextStyle(
                              textColor: controller.appColors.appColor,
                              textWeight: FontWeight.w700,
                              textFamily: fontFamilyBold,
                              textSize: 40.px,
                            ),
                          ).paddingSymmetric(vertical: 48.px),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyTextView(
                              Strings.summaryDecision,
                              textStyleNew: MyTextStyle(
                                textSize: 32.px,
                                textWeight: FontWeight.w400,
                                textColor: controller.appColors.black,
                                textFamily: fontFamilyRegular,
                              ),
                            ).paddingOnly(right: 16.px),
                            Expanded(
                              child: Container(
                                height: 2.px,
                                color: AppColors().divider,
                              ),
                            ),
                          ],
                        ).paddingOnly(bottom: 32.px),
                        ShadowContainer(
                          radius: 8.px,
                          padding: EdgeInsets.zero,
                          child: ListView.separated(
                            itemCount: controller.resultsList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var option = controller.resultsList[index];
                              return RadioListTile(
                                title: MyTextView(
                                  option.title,
                                  textStyleNew: MyTextStyle(
                                    textColor: controller.appColors.black,
                                    textSize: 16.px,
                                    textFamily: fontFamilyRegular,
                                    textWeight: FontWeight.w400,
                                  ),
                                ),
                                toggleable: true,
                                value: option.title.toLowerCase(),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.px),
                                groupValue: controller.selectedItem,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                activeColor: controller.selectedItem !=
                                        option.title.toLowerCase()
                                    ? controller.appColors.white
                                    : controller.appColors.textPink,
                                tileColor: controller.selectedItem !=
                                        option.title.toLowerCase()
                                    ? controller.appColors.white
                                    : controller.appColors.grey
                                        .withOpacity(0.2),
                                onChanged: (value) {
                                  controller.selectedItem = value.toString();
                                  if (value != null) {
                                    inspectionReqModel.inspection?.result =
                                        option.id;
                                  }
                                  controller.update();
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Container(
                                height: 2.px,
                                color: controller.appColors.divider,
                              );
                            },
                          ),
                        ),
                        CommonTextField(
                          isLable: true,
                          controller: controller.inspectionNotesController,
                          color: controller.appColors.transparent,
                          prefixIcon: SvgPicture.string(
                            icMsg,
                            color: controller.appColors.lightText,
                          ).paddingOnly(left: 15.px),
                          padding: EdgeInsets.zero,
                          labelText: Strings.inspectorNotes,
                          hintText: Strings.inspectorNotes,
                        ).paddingSymmetric(vertical: 32.px),
                        MyTextView(
                          Strings.selectFindingType,
                          textStyleNew: MyTextStyle(
                            textColor: Colors.black,
                            textSize: 20.px,
                            textFamily: fontFamilyRegular,
                            textWeight: FontWeight.w400,
                          ),
                        ).paddingOnly(bottom: 24.px),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TypeAheadField(
                                controller:
                                    controller.selectFindingTypeController,
                                suggestionsCallback: controller.isSelected
                                    ? (search) {
                                        return null;
                                      }
                                    : (search) async {
                                        await controller.searchFindingType(
                                            searchText: search);
                                        controller.update();
                                        return controller.selectFindingList;
                                      },
                                builder: (context, c, focusNode) {
                                  return CommonTextField(
                                    focusNode: focusNode,
                                    isLable: true,
                                    readOnly: false,
                                    controller: c,
                                    color: controller.appColors.transparent,
                                    suffixIcon: SvgPicture.string(
                                      icDownArrow,
                                      color: controller.appColors.black
                                          .withOpacity(1.0),
                                    ).paddingAll(10.px),
                                    padding: EdgeInsets.zero,
                                    isLableColor: controller.appColors.black
                                        .withOpacity(1.0),
                                    borderColor: controller.appColors.black
                                        .withOpacity(1.0),
                                    contentPadding:
                                        EdgeInsets.only(left: 15.px),
                                    shadowColor:
                                        controller.appColors.transparent,
                                    labelText: Strings.selectFindingType,
                                  );
                                },
                                itemBuilder: (context, i) {
                                  return ListTile(
                                    title: MyTextView(
                                      i.title.toString(),
                                      textStyleNew: MyTextStyle(
                                        textColor: controller.appColors.black,
                                        textWeight: FontWeight.w400,
                                        textFamily: fontFamilyBold,
                                        textSize: 16.px,
                                      ),
                                    ),
                                  );
                                },
                                onSelected: (value) {
                                  controller.actionFindingType(value);
                                  controller.update();
                                },
                              ),
                            ),
                            SizedBox(width: 16.px),
                            Expanded(
                              child: CommonTextField(
                                isLable: true,
                                readOnly: false,
                                controller: controller.bedroomsController,
                                color: controller.appColors.transparent,
                                prefixIcon: SvgPicture.string(
                                  icbedrooms,
                                  color: controller.appColors.grey,
                                ).paddingOnly(left: 15.px, right: 15.px),
                                padding: EdgeInsets.zero,
                                contentPadding: EdgeInsets.only(left: 25.px),
                                shadowColor: controller.appColors.transparent,
                                inputType: TextInputType.number,
                                labelText: Strings.bedroom,
                                onChange: (value) {
                                  if (value.isNotEmpty) {
                                    inspectionReqModel.unit?.numberOfBedrooms =
                                        int.parse(value);
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 16.px),
                            Expanded(
                              child: CommonTextField(
                                isLable: true,
                                readOnly: false,
                                controller: controller.bathroomsController,
                                color: controller.appColors.transparent,
                                inputType: TextInputType.number,
                                prefixIcon: SvgPicture.string(
                                  icbathroom,
                                  color: controller.appColors.grey,
                                ).paddingOnly(left: 15.px, right: 15.px),
                                padding: EdgeInsets.zero,
                                contentPadding: EdgeInsets.only(left: 25.px),
                                shadowColor: controller.appColors.transparent,
                                labelText: Strings.bathroom,
                                onChange: (value) {
                                  if (value.isNotEmpty) {
                                    inspectionReqModel.unit?.numberOfBathrooms =
                                        int.parse(value);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonButton(
                              radius: 100.px,
                              height: 44.px,
                              width: 182.px,
                              title: Strings.noOneIsPresent,
                              onTap: () {
                                if (controller.selectFindingTypeController.text
                                    .isNotEmpty) {
                                  if (controller.isHealth) {
                                    if (controller.selectedItem != 'null' &&
                                        controller.selectedItem != 'pass') {
                                      controller.noOnePresentDialog();
                                    } else {
                                      controller.passInspectionDialog();
                                    }
                                  }
                                }
                              },
                              textWeight: FontWeight.w600,
                              textSize: 16.px,
                              color: controller.appColors.transparent,
                              border: Border.all(
                                  color: controller.selectFindingTypeController
                                              .text.isNotEmpty &&
                                          controller.selectedItem != 'null'
                                      ? controller.appColors.appColor
                                      : controller.appColors.border1),
                              textColor: controller.selectFindingTypeController
                                          .text.isNotEmpty &&
                                      controller.selectedItem != 'null'
                                  ? controller.appColors.appColor
                                  : controller.appColors.border1,
                            ),
                            SizedBox(width: 24.px),
                            CommonButton(
                              radius: 100.px,
                              height: 44.px,
                              width: 130.px,
                              title: Strings.signatures,
                              onTap: () async {
                                if (controller.selectFindingTypeController.text
                                    .isNotEmpty) {
                                  if (controller.isHealth) {
                                    if (controller.selectedItem != 'null' &&
                                        controller.selectedItem != 'pass') {
                                      await controller.filterInspection();
                                      Get.toNamed(SignatureScreen.routes,
                                          arguments: {
                                            "unitAddress":
                                                controller.unitAddress,
                                            "unitName": controller.unitName,
                                            "inspectionType":
                                                controller.inspectionType,
                                          });
                                    } else {
                                      controller.passInspectionDialog();
                                    }
                                  } else {
                                    await controller.filterInspection();
                                    Get.toNamed(SignatureScreen.routes,
                                        arguments: {
                                          "unitAddress": controller.unitAddress,
                                          "unitName": controller.unitName,
                                          "inspectionType":
                                              controller.inspectionType,
                                        });
                                  }
                                }
                              },
                              textWeight: FontWeight.w600,
                              textSize: 16.px,
                              color: controller.selectFindingTypeController.text
                                          .isNotEmpty &&
                                      controller.selectedItem != 'null'
                                  ? controller.appColors.appColor
                                  : controller.appColors.black.withOpacity(.12),
                              border: Border.all(
                                  color: controller.selectFindingTypeController
                                              .text.isNotEmpty &&
                                          controller.selectedItem != 'null'
                                      ? controller.appColors.black
                                      : controller.appColors.transparent),
                              textColor: controller.selectFindingTypeController
                                          .text.isNotEmpty &&
                                      controller.selectedItem != 'null'
                                  ? controller.appColors.white
                                  : controller.appColors.border1,
                            ),
                          ],
                        ).paddingOnly(top: 48.px),
                        controller.deficiencyArea.isNotEmpty
                            ? Row(
                                children: [
                                  MyTextView(
                                    Strings.deficiencies,
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.appColors.black,
                                      textWeight: FontWeight.w400,
                                      textFamily: fontFamilyBold,
                                      textSize: 24.px,
                                    ),
                                  ).paddingOnly(right: 16.px),
                                  Expanded(
                                    child: Container(
                                      height: 2.px,
                                      color: AppColors().divider,
                                    ),
                                  ),
                                ],
                              ).paddingSymmetric(vertical: 30.px)
                            : SizedBox.shrink(),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.deficiencyArea.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final item = controller.deficiencyArea[index];
                            return ListView.separated(
                              itemCount: item.deficiencyInspectionsReqModel !=
                                      null
                                  ? item.deficiencyInspectionsReqModel!.length
                                  : 0,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                var data =
                                    item.deficiencyInspectionsReqModel?[i];
                                return ShadowContainer2(
                                  padding: EdgeInsets.zero,
                                  divider: controller.appColors.divider,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MyTextView(
                                            item.name,
                                            isMaxLineWrap: true,
                                            textStyleNew: MyTextStyle(
                                              textSize: 20.px,
                                              textWeight: FontWeight.w600,
                                              textColor: controller
                                                  .appColors.lightText,
                                              textFamily: fontFamilyRegular,
                                            ),
                                          ),
                                          CommonButton(
                                            radius: 100.px,
                                            title: data
                                                    ?.deficiencyItemHousingDeficiency
                                                    ?.housingItem
                                                    ?.item ??
                                                "",
                                            onTap: () {},
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 24.px,
                                              vertical: 10.px,
                                            ),
                                            textWeight: FontWeight.w500,
                                            textSize: 16.px,
                                            color:
                                                controller.appColors.appBGColor,
                                            textColor:
                                                controller.appColors.textGreen,
                                          ).paddingOnly(left: 24.px),
                                        ],
                                      ).paddingAll(18.px),
                                      ShadowContainer2(
                                        padding: EdgeInsets.zero,
                                        divider: controller.appColors.divider,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 184.px,
                                                child: ListView.separated(
                                                  itemCount: data
                                                          ?.deficiencyProofPictures
                                                          ?.length ??
                                                      0,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemBuilder: (context, iz) {
                                                    var subData = data!
                                                        .deficiencyProofPictures?[iz];

                                                    return Container(
                                                      height: 184.px,
                                                      width: 184.px,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      13.px),
                                                          image: DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                      subData ??
                                                                          ""),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return SizedBox(
                                                        width: 24.px);
                                                  },
                                                ),
                                              ).paddingAll(10.px),
                                            )
                                          ],
                                        ),
                                      ),
                                      MyTextView(
                                        item.deficiencyAreaItems![i]
                                            .description,
                                        isMaxLineWrap: true,
                                        textStyleNew: MyTextStyle(
                                          textSize: 20.px,
                                          textWeight: FontWeight.w400,
                                          textColor: controller.appColors.black,
                                          textFamily: fontFamilyRegular,
                                        ),
                                      ).paddingOnly(
                                          top: 18.px,
                                          left: 18.px,
                                          right: 18.px),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                dotIcons(
                                                    controller,
                                                    Strings.comments,
                                                    data?.comment ?? ""),
                                                dotIcons(controller, 'Date',
                                                    data?.date ?? ""),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              CommonIconButton(
                                                icon: icEditNotes,
                                                iconheigth: 24.px,
                                                title: 'Edit',
                                                radius: 100.px,
                                                padding: EdgeInsets.fromLTRB(
                                                    16.px, 16.px, 20.px, 16.px),
                                                color: controller
                                                    .appColors.transparent,
                                                textColor: controller
                                                    .appColors.appColor,
                                                textWeight: FontWeight.w500,
                                                textSize: 14.px,
                                                onTap: () {
                                                  int mainIndex = index;
                                                  int subIndex = i;
                                                  Get.toNamed(
                                                      InspectionDeficienciesInsideScreen
                                                          .routes,
                                                      arguments: {
                                                        "deficiencyAreaList": item
                                                            .deficiencyAreaItems,
                                                        "deficiencyInspectionsReqModel":
                                                            data,
                                                        "deficiencyArea":
                                                            controller
                                                                .deficiencyArea[0],
                                                        "successListOfStandards":
                                                            item.deficiencyInspectionsReqModel
                                                      })?.then((value) async {
                                                    if (value != null) {
                                                      if (value[
                                                              'deficiencyInspectionsReqModel'] !=
                                                          null) {
                                                        await controller
                                                            .isDataUpdate(
                                                                mainIndex,
                                                                subIndex,
                                                                value[
                                                                    'deficiencyInspectionsReqModel']);
                                                      } else if (value[
                                                              'isEdit'] ==
                                                          true) {
                                                        controller
                                                            .isDataUpdateSuccess(
                                                                mainIndex,
                                                                subIndex);
                                                      }
                                                      controller.update();
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ).paddingOnly(
                                          top: 15.px,
                                          left: 18.px,
                                          right: 18.px,
                                          bottom: 18.px)
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 24.px,
                                );
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 24.px);
                          },
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 32.px),
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
