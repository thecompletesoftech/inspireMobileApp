import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/buildings_screen/grid_itemcard_widget.dart';
import 'package:public_housing/screens/buildings_screen/list_itemcard_widget.dart';
import '../../responsive/scaling_query.dart';
import '../hs_ack_screen/hs_ack_screen.dart';
import 'buildings_controller.dart';

class BuildingsScreen extends GetView<BuildingsController> {
  BuildingsScreen({Key? key}) : super(key: key);
  static const routes = "/BuildingsScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildingsController>(
      init: BuildingsController(),
      assignId: true,
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
                                    icDownArrow,
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
                                                icEdit,
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
                                                icCopy,
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
                                                icBook,
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
                                                icLogout,
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
                    // (Utils.isLandScapeMode(context) && !Utils.isTabletScreen1(context)) ||
                    //         !Utils.isTabletScreen1(context)
                    //     ? Expanded(
                    //         child: SizedBox(
                    //           width: 250.px,
                    //           child: CommonTextField(
                    //             height: 52.px,
                    //             border: Border.all(color: controller.appColors.border1),
                    //             borderRadius: 25.px,
                    //             color: controller.appColors.white,
                    //             controller: controller.searchController,
                    //             prefixIcon: Image.asset(
                    //               ImagePath.icSearch,
                    //               color: controller.appColors.black,
                    //             ),
                    //             hintText: "Search",
                    //             hintTextStyle: MyTextStyle(
                    //                 textColor: controller.appColors.border,
                    //                 textSize: 16.px,
                    //                 textFamily: fontFamilyRegular,
                    //                 textWeight: FontWeight.w400),
                    //             onChange: (str) {
                    //               controller.searchItem(str);
                    //               controller.update();
                    //             },
                    //           ),
                    //         ),
                    //       )
                    //     :
                    Expanded(
                        flex: 0,
                        child: CommonButton(
                            border: Border.all(
                                color: controller.appColors.border, width: 2),
                            radius: 100.px,
                            title: Strings.backToProperties,
                            onTap: () {
                              if (controller.inComplete == true) {
                                controller.dialogInspectionInCompleted();
                              } else {
                                Get.back(result: controller.visibleBtn ? 0 : 2);
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
                        child: SegmentedButton<BuildingStatus>(
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
                          segments: const <ButtonSegment<BuildingStatus>>[
                            ButtonSegment<BuildingStatus>(
                              value: BuildingStatus.all,
                              label: Text(
                                Strings.all,
                              ),
                            ),
                            ButtonSegment<BuildingStatus>(
                              value: BuildingStatus.completed,
                              label: Text(
                                Strings.completed,
                              ),
                            ),
                            ButtonSegment<BuildingStatus>(
                              value: BuildingStatus.scheduled,
                              label: Text(
                                Strings.scheduled,
                              ),
                            ),
                          ],
                          selected: <BuildingStatus>{controller.status},
                          onSelectionChanged:
                              (Set<BuildingStatus> newSelection) {
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
                    ).paddingOnly(left: 15.px),
                  ],
                ).paddingOnly(left: 32.px, right: 32.px, bottom: 24.px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (() {}),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${Strings.buildings} | ',
                              style: TextStyle(
                                color: controller.appColors.appColor,
                                fontSize: 32.px,
                                fontFamily: fontFamilyRegular,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: '${controller.item!.title}',
                              style: TextStyle(
                                color: controller.appColors.lightText,
                                fontSize: 24.px,
                                fontFamily: fontFamilyRegular,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    controller.visibleBtn
                        ? CommonButton(
                            title: Strings.HSAcknowledgment,
                            textColor: controller.visibleBtn
                                ? controller.appColors.black
                                : controller.appColors.border1,
                            color: controller.visibleBtn
                                ? controller.appColors.textPink
                                : controller.appColors.black
                                    .withOpacity(0.11999999731779099),
                            radius: 100.px,
                            textWeight: FontWeight.w600,
                            textSize: 16.px,
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.px,
                              vertical: 10.px,
                            ),
                            onTap: () {
                              Get.toNamed(HSAckScreen.routes,
                                  arguments: controller.item);
                            })
                        : const SizedBox(),
                  ],
                ).paddingOnly(
                    left: 24.px, right: 24.px, top: 8.px, bottom: 24.px),
                Expanded(
                  flex: 1,
                  child: controller.change
                      ? ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.px,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.searchList.length,
                          itemBuilder: (context, index) {
                            RxCommonModel item = controller.searchList[index];
                            return controller.status == BuildingStatus.all
                                ? ListItemCardWidget(item: item, index: index)
                                : controller.status == BuildingStatus.completed
                                    ? item.status ==
                                            BuildingStatus.completed.toString()
                                        ? ListItemCardWidget(
                                            item: item, index: index)
                                        : const SizedBox()
                                    : item.status !=
                                            BuildingStatus.completed.toString()
                                        ? ListItemCardWidget(
                                            item: item, index: index)
                                        : const SizedBox();
                          }).paddingOnly(bottom: 24.px)
                      : GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.px,
                          ),
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
                                                      0.5658189.px) //.....57151
                                      : Utils.isTabletScreen1(context)
                                          ? ScalingQuery(context).verticalScale(
                                              0.54146.px) //pro mini
                                          : Utils.isTabletScreen(context)
                                              ? ScalingQuery(context)
                                                  .verticalScale(
                                                      0.583442.px) //.....1
                                              : Utils.isMediumScreen(context)
                                                  ? ScalingQuery(context)
                                                      .verticalScale(
                                                          0.579.px) //.....2
                                                  : ScalingQuery(context)
                                                      .verticalScale(
                                                          0.49.px), //.....
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16),
                          itemCount: controller.searchList.length,
                          itemBuilder: (context, index) {
                            RxCommonModel item = controller.searchList[index];
                            return controller.status == BuildingStatus.all
                                ? GridItemCardWidget(item: item, index: index)
                                : controller.status == BuildingStatus.completed
                                    ? item.status ==
                                            BuildingStatus.completed.toString()
                                        ? GridItemCardWidget(
                                            item: item, index: index)
                                        : const SizedBox()
                                    : item.status !=
                                            BuildingStatus.completed.toString()
                                        ? GridItemCardWidget(
                                            item: item, index: index)
                                        : const SizedBox();
                          }).paddingOnly(bottom: 24.px),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
