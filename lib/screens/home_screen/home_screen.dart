import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/home_screen/grid_itemcard_widget.dart';
import 'package:public_housing/screens/home_screen/home_controller.dart';

import '../../responsive/scaling_query.dart';
import 'list_itemcard_widget.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  static const routes = "/HomeScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      assignId: true,
      init: HomeController(),
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: Utils.isTabletScreen(context) ? 1 : 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            ImagePath.logo,
                            width: 182.px,
                            height: 40.625.px,
                          ),
                          MyTextView(
                            Utils.isTabletScreen(context)
                                ? "${Strings.homeTitle}${controller.dataList.length}\n${Strings.homeTitle1}"
                                : "${Strings.homeTitle}${controller.dataList.length} - ${Strings.homeTitle1}",
                            isMaxLineWrap: true,
                            textStyleNew: MyTextStyle(
                              textColor: controller.appColors.lightText,
                              textWeight: FontWeight.w400,
                              textSize: 20.px,
                            ),
                          ).paddingOnly(top: 10.px)
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          controller.popupKey.currentState?.showButtonMenu();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              ImagePath.user,
                              width: 48.px,
                              height: 48.px,
                            ).paddingOnly(right: 8.px),
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: MyTextView(
                                          Strings.userName,
                                          textStyleNew: MyTextStyle(
                                            textColor:
                                                controller.appColors.lightText,
                                            textWeight: FontWeight.w600,
                                            textFamily: fontFamilyBold,
                                            textSize: 16.px,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ).paddingOnly(bottom: 4.px),
                                  MyTextView(
                                    Strings.userType,
                                    isMaxLineWrap: true,
                                    textStyleNew: MyTextStyle(
                                      textColor: controller.appColors.lightText,
                                      textWeight: FontWeight.w400,
                                      textFamily: fontFamilyMedium,
                                      textSize: 14.px,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PopupMenuButton<int>(
                                  key: controller.popupKey,
                                  icon: SvgPicture.string(
                                    icDownArrow ?? "",
                                    height: 24.px,
                                  ),
                                  onSelected: (int value) =>
                                      controller.actionPopUpItemSelected(value),
                                  itemBuilder: (context) {
                                    return <PopupMenuEntry<int>>[
                                      PopupMenuItem(
                                          value: 0,
                                          child: ListTile(
                                              leading: SvgPicture.string(
                                                icEdit ?? "",
                                              ),
                                              title: MyTextView(
                                                Strings.editProfile,
                                                textStyleNew: MyTextStyle(
                                                    textSize: 16.px,
                                                    textColor:
                                                        AppColors().black,
                                                    textWeight:
                                                        FontWeight.w400),
                                              ))),
                                      PopupMenuItem(
                                          value: 1,
                                          child: ListTile(
                                              leading: SvgPicture.string(
                                                icCopy ?? "",
                                              ),
                                              title: MyTextView(
                                                Strings.inspectionHistory,
                                                textStyleNew: MyTextStyle(
                                                    textSize: 16.px,
                                                    textColor:
                                                        AppColors().black,
                                                    textWeight:
                                                        FontWeight.w400),
                                              ))),
                                      PopupMenuItem(
                                          value: 2,
                                          child: ListTile(
                                              leading: SvgPicture.string(
                                                icBook ?? "",
                                              ),
                                              title: MyTextView(
                                                Strings.nSPIREStandards,
                                                textStyleNew: MyTextStyle(
                                                    textSize: 16.px,
                                                    textColor:
                                                        AppColors().black,
                                                    textWeight:
                                                        FontWeight.w400),
                                              ))),
                                      PopupMenuItem(
                                          value: 3,
                                          child: ListTile(
                                              leading: SvgPicture.string(
                                                icLogout ?? "",
                                              ),
                                              title: MyTextView(
                                                Strings.logOut,
                                                textStyleNew: MyTextStyle(
                                                    textSize: 16.px,
                                                    textColor:
                                                        AppColors().black,
                                                    textWeight:
                                                        FontWeight.w400),
                                              ))),
                                    ];
                                  },
                                ),
                                const SizedBox()
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ).paddingOnly(left: 32.px, right: 32.px, bottom: 20.px),
                Row(
                  children: [
                    Expanded(
                        flex: 0,
                        child: CommonButton(
                            border: Border.all(
                                color: controller.appColors.border, width: 2),
                            radius: 100.px,
                            title: Strings.backToBuildings,
                            onTap: () {
                              if (controller.inComplete == true) {
                                controller.dialogInspectionInCompleted();
                              } else {
                                Get.back(result: controller.visibleBtn);
                                Get.back(result: controller.visibleBtn);
                                Get.back(result: controller.visibleBtn);
                              }
                            },
                            height: 44.px,
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.px,
                              vertical: 10.px,
                            ),
                            textWeight: FontWeight.w600,
                            textSize: 16.px,
                            color: controller.appColors.transparent,
                            textColor: controller.appColors.appColor)),
                    Expanded(
                      flex: Utils.isLandScapeMode(context) ||
                              !Utils.isTabletScreen1(context)
                          ? 1
                          : Utils.isTabletScreen1(context)
                              ? 0
                              : 0,
                      child: SizedBox(
                        width: 14.px,
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: SizedBox(
                        width: 350.px,
                        height: 44.px,
                        child: SegmentedButton<InspectionStatus>(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                              return states.contains(MaterialState.selected)
                                  ? controller.appColors.pinkcolor
                                  : controller.appColors.transparent;
                            }),
                            foregroundColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                              return states.contains(MaterialState.selected)
                                  ? Colors.black
                                  : controller.appColors.border1;
                            }),
                            side: MaterialStateBorderSide.resolveWith((states) {
                              return BorderSide(
                                  color: states.contains(MaterialState.selected)
                                      ? Colors.black
                                      : Colors.grey);
                            }),
                          ),
                          segments: const <ButtonSegment<InspectionStatus>>[
                            ButtonSegment<InspectionStatus>(
                              value: InspectionStatus.all,
                              label: Text(
                                Strings.all,
                              ),
                            ),
                            ButtonSegment<InspectionStatus>(
                              value: InspectionStatus.completed,
                              label: Text(
                                Strings.completed,
                              ),
                            ),
                            ButtonSegment<InspectionStatus>(
                              value: InspectionStatus.scheduled,
                              label: Text(
                                Strings.scheduled,
                              ),
                            ),
                          ],
                          selected: <InspectionStatus>{controller.status},
                          onSelectionChanged:
                              (Set<InspectionStatus> newSelection) {
                            controller.status = newSelection.first;
                            controller.searchTypeItem();
                            controller.update();
                          },
                        ),
                      ),
                    ),
                    CommonIconButton(
                      textColor: controller.appColors.black,
                      title: controller.change ? "Grid View" : "List View",
                      onTap: () {
                        controller.change = !controller.change;
                        controller.update();
                      },
                      height: 44.px,
                      padding: EdgeInsets.only(
                          top: 10.px, bottom: 10.px, left: 16.px, right: 24.px),
                      iconheigth: 12.px,
                      textWeight: FontWeight.w500,
                      textSize: 16.px,
                      radius: 100.px,
                      icon: controller.change ? icGrid : icList,
                    ).paddingOnly(left: 20.px),
                  ],
                ).paddingOnly(left: 32.px, right: 32.px, bottom: 30.px),
                Expanded(
                  flex: 1,
                  child: controller.change
                      ? ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.px, vertical: 14.px),
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.searchList.length,
                          itemBuilder: (context, index) {
                            RxCommonModel item = controller.searchList[index];
                            return controller.status == InspectionStatus.all
                                ? ListItemCardWidget(
                                    item: item,
                                  )
                                : controller.status ==
                                        InspectionStatus.completed
                                    ? item.status ==
                                            InspectionStatus.completed
                                                .toString()
                                        ? ListItemCardWidget(
                                            item: item,
                                          )
                                        : const SizedBox()
                                    : item.status !=
                                            InspectionStatus.completed
                                                .toString()
                                        ? ListItemCardWidget(
                                            item: item,
                                          )
                                        : const SizedBox();
                          })
                      : GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              left: 32.px, right: 32.px, top: 24.0),
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent:
                                      Utils.isTabletScreen1(context)
                                          ? 400
                                          : 450,
                                  childAspectRatio: Utils.isLandScapeMode(
                                          context)
                                      ? Utils.isSmallScreen(context)
                                          ? ScalingQuery(context)
                                              .verticalScale(0.72.px) // iphone
                                          : Utils.isTabletScreen1(context)
                                              ? ScalingQuery(context)
                                                  .verticalScale(
                                                      0.52.px) // land mini
                                              : ScalingQuery(context)
                                                  .verticalScale(
                                                      0.5537.px) //.....55322938
                                      : Utils.isTabletScreen1(context)
                                          ? ScalingQuery(context).verticalScale(
                                              0.529943.px) //pro mini
                                          : Utils.isTabletScreen(context)
                                              ? ScalingQuery(context)
                                                  .verticalScale(
                                                      0.571028.px) //.....1
                                              : Utils.isMediumScreen(context)
                                                  ? ScalingQuery(context)
                                                      .verticalScale(
                                                          0.561.px) //.....2
                                                  : ScalingQuery(context)
                                                      .verticalScale(0.49.px), //.....
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16),
                          itemCount: controller.searchList.length,
                          itemBuilder: (context, index) {
                            RxCommonModel item = controller.searchList[index];
                            return controller.status == InspectionStatus.all
                                ? GridItemCardWidget(
                                    item: item,
                                  )
                                : controller.status ==
                                        InspectionStatus.completed
                                    ? item.status ==
                                            InspectionStatus.completed
                                                .toString()
                                        ? GridItemCardWidget(
                                            item: item,
                                          )
                                        : const SizedBox()
                                    : item.status !=
                                            InspectionStatus.completed
                                                .toString()
                                        ? GridItemCardWidget(
                                            item: item,
                                          )
                                        : const SizedBox();
                          }),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
