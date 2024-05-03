import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_list_screen/screen/building_list_screen.dart';
import 'package:public_housing/screens/properties_list_screen/widget/common_properties_list_container.dart';
import 'package:public_housing/screens/building_inspection_screen/screen/building_inspection_screen.dart';
import 'package:public_housing/screens/properties_list_screen/controller/properties_list_controller.dart';

class PropertiesListScreen extends GetView<PropertiesListController> {
  const PropertiesListScreen({Key? key}) : super(key: key);

  static const routes = "/PropertiesListScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PropertiesListController>(
      init: PropertiesListController(),
      autoRemove: true,
      assignId: true,
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ShadowContainer(
                  radius: 0,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  elevation: 3.0,
                  child: Container(
                    color: AppColors().white,
                    height: 160.px,
                    child: Padding(
                      padding: EdgeInsets.all(32.px),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                ImagePath.logo,
                                width: 182.px,
                                height: 40.63.px,
                              ),
                              Spacer(),
                              MyTextView(
                                Strings.publicHousing,
                                textStyleNew: MyTextStyle(
                                  textColor: AppColors.primerColor,
                                  textWeight: FontWeight.w600,
                                  textFamily: fontFamilyBold,
                                  textSize: 32.px,
                                ),
                              )
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.popupKey.currentState
                                      ?.showButtonMenu();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                  flex: 1,
                                                  child: MyTextView(
                                                    controller.account
                                                            ?.userName ??
                                                        "",
                                                    textStyleNew: MyTextStyle(
                                                      textColor: controller
                                                          .appColors.lightText,
                                                      textWeight:
                                                          FontWeight.w600,
                                                      textFamily:
                                                          fontFamilyBold,
                                                      textSize: 16.px,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ).paddingOnly(bottom: 2.px),
                                            MyTextView(
                                              "${GetStorageData().readString(GetStorageData().clientName)}",
                                              isMaxLineWrap: true,
                                              textStyleNew: MyTextStyle(
                                                textColor: controller
                                                    .appColors.lightText,
                                                textWeight: FontWeight.w400,
                                                textFamily: fontFamilyMedium,
                                                textSize: 14.px,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        PopupMenuButton<int>(
                                          key: controller.popupKey,
                                          color: controller.appColors.white,
                                          icon: SvgPicture.string(
                                            icDownArrow,
                                            height: 24.px,
                                          ),
                                          onSelected: (int value) => controller
                                              .actionPopUpItemSelected(value),
                                          itemBuilder: (context) {
                                            return <PopupMenuEntry<int>>[
                                              PopupMenuItem(
                                                  value: 0,
                                                  child: ListTile(
                                                      leading:
                                                          SvgPicture.string(
                                                              icEdit),
                                                      title: MyTextView(
                                                        Strings.editProfile,
                                                        textStyleNew:
                                                            MyTextStyle(
                                                                textSize: 16.px,
                                                                textColor:
                                                                    AppColors()
                                                                        .black,
                                                                textWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ))),
                                              PopupMenuItem(
                                                  value: 1,
                                                  child: ListTile(
                                                      leading:
                                                          SvgPicture.string(
                                                              icCopy),
                                                      title: MyTextView(
                                                        Strings
                                                            .inspectionHistory,
                                                        textStyleNew:
                                                            MyTextStyle(
                                                                textSize: 16.px,
                                                                textColor:
                                                                    AppColors()
                                                                        .black,
                                                                textWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ))),
                                              PopupMenuItem(
                                                  value: 2,
                                                  child: ListTile(
                                                      leading:
                                                          SvgPicture.string(
                                                              icBook),
                                                      title: MyTextView(
                                                        Strings.nSPIREStandards,
                                                        textStyleNew:
                                                            MyTextStyle(
                                                                textSize: 16.px,
                                                                textColor:
                                                                    AppColors()
                                                                        .black,
                                                                textWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ))),
                                              PopupMenuItem(
                                                  value: 3,
                                                  child: ListTile(
                                                      leading: SvgPicture.string(
                                                          changeSectionIcon),
                                                      title: MyTextView(
                                                        Strings.changeSection,
                                                        textStyleNew:
                                                            MyTextStyle(
                                                                textSize: 16.px,
                                                                textColor:
                                                                    AppColors()
                                                                        .black,
                                                                textWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ))),
                                              PopupMenuItem(
                                                  value: 4,
                                                  child: ListTile(
                                                      leading:
                                                          SvgPicture.string(
                                                              icLogout),
                                                      title: MyTextView(
                                                        Strings.logOut,
                                                        textStyleNew:
                                                            MyTextStyle(
                                                                textSize: 16.px,
                                                                textColor:
                                                                    AppColors()
                                                                        .black,
                                                                textWeight:
                                                                    FontWeight
                                                                        .w400),
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
                              Spacer(),
                              CommonIconButton(
                                title: Strings.inspectManually,
                                radius: 100.px,
                                width: 191.px,
                                height: 44.px,
                                color: AppColors.primerColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.px,
                                ),
                                textSize: 16.px,
                                textWeight: FontWeight.w500,
                                textFamily: fontFamilyRegular,
                                onTap: () {
                                  Get.toNamed(BuildingInspectionScreen.routes);
                                },
                                iconColor: controller.appColors.white,
                                icon: inspectIcon,
                                iconheigth: 20.px,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ).paddingOnly(bottom: 4),
                Row(
                  children: [
                    CommonIconButton(
                      title: Strings.selectTimeframe,
                      radius: 100.px,
                      width: 191.px,
                      height: 44.px,
                      color: controller.appColors.transparent,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.px,
                      ),
                      textSize: 16.px,
                      border: Border.all(color: controller.appColors.black),
                      textColor: AppColors.primerColor,
                      textWeight: FontWeight.w500,
                      textFamily: fontFamilyRegular,
                      onTap: () {
                        controller.navigateToDateTime();
                      },
                      iconColor: AppColors.primerColor,
                      icon: icCalender1,
                      iconheigth: 20.px,
                    ),
                    Spacer(),
                    Expanded(
                      flex: 0,
                      child: SizedBox(
                        width: 250.px,
                        height: 48.px,
                        child: SegmentedButton<PropertyStatus>(
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
                          segments: const <ButtonSegment<PropertyStatus>>[
                            ButtonSegment<PropertyStatus>(
                              value: PropertyStatus.scheduled,
                              label: Text(Strings.scheduled),
                            ),
                            ButtonSegment<PropertyStatus>(
                              value: PropertyStatus.completed,
                              label: Text(Strings.completed),
                            ),
                          ],
                          selected: <PropertyStatus>{controller.status},
                          onSelectionChanged:
                              (Set<PropertyStatus> newSelection) {
                            controller.status = newSelection.first;
                            controller.update();
                          },
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(left: 32.px, right: 32.px, top: 38.px),
                Row(
                  children: [
                    controller.date == controller.todayDate
                        ? MyTextView(
                            Strings.todayInspections,
                            textStyleNew: MyTextStyle(
                              textSize: 24.px,
                              textWeight: FontWeight.w400,
                              textColor: controller.appColors.black,
                            ),
                          )
                        : Container(),
                    MyTextView(
                      controller.todayDate,
                      textStyleNew: MyTextStyle(
                        textSize: 24.px,
                        textWeight: FontWeight.w400,
                        textColor: controller.appColors.black,
                      ),
                    ).paddingOnly(right: 16.px),
                    Expanded(
                      child: Container(
                        height: 2.px,
                        color: AppColors().divider,
                      ),
                    ),
                  ],
                ).paddingAll(32.px),
                CommonPropertiesListView(
                  title: '[Property Name]',
                  Subtitle: '[City] - [Property Address]',
                  title1: '[Building Count]',
                  Subtitle1: '[Unit Count]',
                  onTap: () {
                    Get.toNamed(BuildingListScreen.routes);
                  },
                ).paddingSymmetric(horizontal: 32.px),
              ],
            ),
          ),
        );
      },
    );
  }
}
