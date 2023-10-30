import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';

import '../../commons/all.dart';
import '../home_screen/home_controller.dart';
import 'building_exterior_controller.dart';
import 'building_exterior_itemcard_widget.dart';

class BuildingExteriorScreen extends GetView<BuildingExteriorController> {
  const BuildingExteriorScreen({Key? key}) : super(key: key);
  static const routes = "/BuildingExteriorScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildingExteriorController>(
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: Column(
            children: [
              CommonAppBar(
                color: controller.appColors.transparent,
                radius: 0.px,
                onClickBack: () {
                  if (controller.sendImagesList.isNotEmpty && controller.change) {
                    controller.dialogSectionCompleted();
                  } else if (controller.change) {
                    controller.dialogSectionCompletedSave();
                  } else {
                    Get.back();
                  }
                },
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: MyTextView(
                            controller.item == null ? "" : "${controller.item!.massage}, ${controller.buildingTitle}",
                            textStyleNew: MyTextStyle(
                              textSize: Utils.isMediumScreen(context) ? 24.px : 20.px,
                              textWeight: FontWeight.w600,
                              textColor: controller.appColors.appColor,
                              textFamily: fontFamilyBold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.px,
                        ),
                        controller.item != null
                            ? CommonButton(
                                title: controller.item!.check == false ? Strings.annualInspection : Strings.tenant,
                                textSize: 14.px,
                                isSmall: false,
                                isBig: true,
                                radius: 24.px,
                                textWeight: FontWeight.w500,
                                color: controller.appColors.white,
                                textColor: controller.item!.check == false
                                    ? controller.appColors.textGreen
                                    : controller.appColors.textPink,
                                onTap: () {})
                            : Container(),
                      ],
                    ).paddingSymmetric(vertical: 32.px),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: MyTextView(
                                controller.item1!.title!.toString(),
                                isMaxLineWrap: true,
                                textStyleNew: MyTextStyle(
                                  textSize: 40.px,
                                  textWeight: FontWeight.w500,
                                  textColor: controller.appColors.appColor,
                                  textFamily: fontFamilyBold,
                                ),
                              ),
                            ),
                            !Utils.isLandScapeMode(context) || Utils.isSmallScreen(context)
                                ? CommonButton(
                                    title: Strings.sectionCompleted,
                                    textColor: controller.visibleBtn
                                        ? controller.appColors.black
                                        : controller.appColors.border1,
                                    color: controller.visibleBtn
                                        ? controller.appColors.buttonColor
                                        : controller.appColors.black.withOpacity(0.11999999731779099),
                                    radius: 100.px,
                                    textWeight: FontWeight.w600,
                                    textSize: 16.px,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24.px,
                                      vertical: 10.px,
                                    ),
                                    onTap: () {
                                      if (controller.visibleBtn) {
                                        Get.back(result: true);
                                      }
                                    })
                                : Container(),
                          ],
                        ).paddingOnly(bottom: 24.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: 250.px,
                                child: CommonTextField(
                                  height: 52.px,
                                  border: Border.all(color: controller.appColors.border1),
                                  borderRadius: 25.px,
                                  color: controller.appColors.white,
                                  controller: controller.searchController,
                                  prefixIcon: SvgPicture.string(
                                    icSearch,
                                    // color: controller.appColors.grey,
                                    // height: 15,
                                  ),
                                  hintText: "Search standards",
                                  hintTextStyle: MyTextStyle(
                                      textColor: controller.appColors.border,
                                      textSize: 16.px,
                                      textFamily: fontFamilyRegular,
                                      textWeight: FontWeight.w400),
                                  onChange: (str) {
                                    controller.searchItem(str);
                                  },
                                ),
                              ),
                            ),
                            Utils.isLandScapeMode(context) && !Utils.isSmallScreen(context)
                                ? CommonButton(
                                    title: Strings.sectionCompleted,
                                    textColor: controller.visibleBtn
                                        ? controller.appColors.black
                                        : controller.appColors.border1,
                                    color: controller.visibleBtn
                                        ? controller.appColors.buttonColor
                                        : controller.appColors.black.withOpacity(0.11999999731779099),
                                    radius: 100.px,
                                    textWeight: FontWeight.w600,
                                    textSize: 16.px,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24.px,
                                      vertical: 10.px,
                                    ),
                                    onTap: () {
                                      if (controller.visibleBtn) {
                                        Get.back(result: true);
                                      }
                                    }).paddingOnly(left: 16.px)
                                : Container(),
                            CommonButton(
                                title: Strings.collapseStandards,
                                textColor: controller.appColors.appColor,
                                color: controller.appColors.transparent,
                                radius: 100.px,
                                textWeight: FontWeight.w600,
                                padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                                textSize: 16.px,
                                border: Border.all(color: controller.appColors.border, width: 2),
                                onTap: () {
                                  controller.expansionTileController.isExpanded
                                      ? controller.expansionTileController.collapse()
                                      : controller.expansionTileController.expand();
                                  // controller.expansionTileController1.isExpanded
                                  //     ? controller.expansionTileController1.collapse()
                                  //     : controller.expansionTileController1.expand();
                                  controller.update();
                                }).paddingSymmetric(horizontal: 16.px),
                            SizedBox(
                              width: 207.px,
                              height: 45.px,
                              child: SegmentedButton<InspectionStatus>(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                                    return states.contains(MaterialState.selected)
                                        ? controller.appColors.pinkcolor
                                        : controller.appColors.transparent;
                                  }),
                                  foregroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                                    return states.contains(MaterialState.selected) ? Colors.black : Colors.grey;
                                  }),
                                  side: MaterialStateBorderSide.resolveWith((states) {
                                    return BorderSide(
                                        color: states.contains(MaterialState.selected) ? Colors.black : Colors.grey);
                                  }),
                                ),
                                segments: const <ButtonSegment<InspectionStatus>>[
                                  ButtonSegment<InspectionStatus>(
                                    value: InspectionStatus.all,
                                    label: Text(Strings.all),
                                  ),
                                  ButtonSegment<InspectionStatus>(
                                    value: InspectionStatus.completed,
                                    label: Text(Strings.failed),
                                  ),
                                ],
                                selected: <InspectionStatus>{controller.status},
                                onSelectionChanged: (Set<InspectionStatus> newSelection) {
                                  controller.status = newSelection.first;
                                  controller.searchTypeItem();
                                  controller.update();
                                },
                              ),
                            ),
                          ],
                        ).paddingOnly(bottom: 32.px),
                        Card(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.px),
                          ),
                          margin: EdgeInsets.zero,
                          color: AppColors().white,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            height: 200.px,
                            width: Get.width,
                            padding: EdgeInsets.all(32.px),
                            child: controller.sendImagesList.isNotEmpty
                                ? ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.sendImagesList.length,
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemBuilder: (BuildContext context, int index) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Stack(children: [
                                            SizedBox(
                                              height: 126.px,
                                              width: 126.px,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Image.file(
                                                  File(controller.sendImagesList[index]),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 4,
                                              top: 4,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    if (controller.sendImagesList.length == 1) {
                                                      controller.visibleBtn = false;
                                                    }
                                                    controller.sendImagesList.length == 1
                                                        ? controller.sendImagesList = []
                                                        : controller.sendImagesList.removeAt(index);

                                                    controller.update();
                                                  },
                                                  child: SvgPicture.string(icDelete)),
                                            )
                                          ]),
                                          if (controller.sendImagesList.length - 1 == index) ...[
                                            GestureDetector(
                                              onTap: () async {
                                                controller.imagePicker();
                                              },
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 80.px,
                                                    height: 80.px,
                                                    child: Center(
                                                      child: SvgPicture.string(
                                                        icAdd,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ).paddingOnly(bottom: 10.px),
                                                  MyTextView(
                                                    "Add picture",
                                                    textStyleNew: MyTextStyle(
                                                      textColor: controller.appColors.appColor,
                                                      textSize: 14.px,
                                                      textWeight: FontWeight.w500,
                                                      textFamily: fontFamilyRegular,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ).paddingSymmetric(horizontal: 32.px)
                                          ],
                                        ],
                                      );
                                    },
                                    separatorBuilder: (BuildContext context, int index) {
                                      return SizedBox(
                                        width: 32.px,
                                      );
                                    },
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      controller.imagePicker();
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.string(
                                          icImage,
                                          width: 80.px,
                                          height: 80.px,
                                        ).paddingOnly(bottom: 16.px),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Tap to Take or Upload",
                                                style: MyTextStyle(
                                                  textSize: 16.px,
                                                  textWeight: FontWeight.w600,
                                                  textColor: controller.appColors.appColor,
                                                  textFamily: fontFamilyBold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: " a photo of the ${controller.item1!.title!} to ",
                                                style: MyTextStyle(
                                                  textSize: 16.px,
                                                  textWeight: FontWeight.w400,
                                                  textColor: controller.appColors.black,
                                                  textFamily: fontFamilyRegular,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "Complete the Section",
                                                style: MyTextStyle(
                                                  textSize: 16.px,
                                                  textWeight: FontWeight.w600,
                                                  textColor: controller.appColors.appColor,
                                                  textFamily: fontFamilyBold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                        ListView.builder(
                            itemCount: controller.searchList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final item1 = controller.searchList[index];
                              return index == 0
                                  ? BuildingExteriorItemCardWidget(item1: item1)
                                  : (controller.searchList[index - 1].title!.toString().substring(0, 1).toLowerCase() !=
                                          item1.title!.toString().substring(0, 1).toLowerCase())
                                      ? BuildingExteriorItemCardWidget(item1: item1)
                                      : Container();
                            }).paddingSymmetric(vertical: 32.px),
                      ],
                    ).paddingSymmetric(horizontal: 32.px),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
