import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/screens/kitchen_screen/kitchenitemcard_widget.dart';

import '../../commons/all.dart';
import '../home_screen/home_controller.dart';
import '../progress_screen/progress_screen.dart';
import 'kitchen_controller.dart';

class KitchenScreen extends GetView<KitchenController> {
  const KitchenScreen({Key? key}) : super(key: key);
  static const routes = "/KitchenScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KitchenController>(
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: Column(
            children: [
              CommonAppBar(
                color: controller.appColors.transparent,
                radius: 0.px,
                onClickBack: () {
                  if (controller.sendImagesList.isNotEmpty || controller.change) {
                    // controller.dialogSectionCompleted();
                    Get.back(result: true);
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
                            controller.item == null
                                ? ""
                                : "${controller.item!.massage}, ${controller.itemTitle} - ${controller.item!.title}",
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
                                radius: 100.px,
                                textWeight: FontWeight.w500,
                                color: controller.appColors.white,
                                textColor: controller.item!.check == false
                                    ? controller.appColors.textGreen
                                    : controller.appColors.textPink,
                                onTap: () {})
                            : const SizedBox(),
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
                          ],
                        ).paddingOnly(bottom: 24.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: 250.px,
                                child: CommonTextField(
                                  height: 56.px,
                                  border: Border.all(color: controller.appColors.border1),
                                  borderRadius: 100.px,
                                  color: controller.appColors.white,
                                  controller: controller.searchController,
                                  prefixIcon: SvgPicture.string(
                                    icSearch,
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
                        ),
                        ShadowContainer1(
                          color: controller.appColors.white,
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          radius: 8.px,
                          elevation: 1,
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
                                              child: Container(
                                                color: Colors.white,
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
                                    child: Container(
                                      color: Colors.white,
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
                        ).paddingSymmetric(vertical: 32.px),
                        ShadowContainer(
                          radius: 8.px,
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(ProgressScreen.routes, arguments: [
                                controller.item,
                                RxCommonModel(title: "${controller.item1!.title!} area is not present")
                              ]);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.px), bottomLeft: Radius.circular(8.px)),
                                    child: Image.asset(
                                      controller.item1!.image ?? "",
                                      fit: BoxFit.cover,
                                      width: 108.px,
                                    ).paddingOnly(
                                      left: 10.px,
                                      top: 10.px,
                                      bottom: 10.px,
                                    ),
                                  ).paddingOnly(right: 16.px),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: MyTextView(
                                              "${controller.item1!.title == "Kitchen" ? "${controller.item1!.title} Area" : controller.item1!.title} Present",
                                              textStyleNew: MyTextStyle(
                                                textSize: 20.px,
                                                textWeight: FontWeight.w400,
                                                textColor: controller.appColors.textBlack1,
                                                textFamily: fontFamilyRegular,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8.px,
                                          ),
                                          // if (controller.item1!.status == "true") ...[
                                          //   ClipOval(
                                          //       child: SvgPicture.string(
                                          //     icComplete,
                                          //   )),
                                          // ],
                                        ],
                                      ).paddingOnly(bottom: 8.px),
                                      MyTextView(
                                        controller.item1!.title == "Kitchen"
                                            ? 'A kitchen must contain an area to store, prepare, and cook food. A microwave is a substitute for a range, stove or oven to establish a kitchen; however, it’s not inspected and does not take the place of an inoperable range, stove, or oven.'
                                            : controller.item1!.subtitle!,
                                        maxLinesNew: 4,
                                        textStyleNew: MyTextStyle(
                                          textSize: 16.px,
                                          textColor: controller.appColors.textBlack2,
                                          textWeight: FontWeight.w400,
                                          textFamily: fontFamilyRegular,
                                        ),
                                      ),
                                    ],
                                  ).paddingSymmetric(horizontal: 8.px, vertical: 16.px),
                                ),
                              ],
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
                                  ? KitchenItemCardWidget(item1: item1)
                                  : (controller.searchList[index - 1].title!.toString().substring(0, 1).toLowerCase() !=
                                          item1.title!.toString().substring(0, 1).toLowerCase())
                                      ? KitchenItemCardWidget(item1: item1)
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
