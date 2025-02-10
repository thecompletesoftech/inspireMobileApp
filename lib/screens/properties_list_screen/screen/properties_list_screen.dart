import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_list_screen/screen/building_list_screen.dart';
import 'package:public_housing/screens/building_list_screen/widget/common_building_list_container.dart';
import 'package:public_housing/screens/properties_list_screen/widget/common_properties_list_container.dart';
import 'package:public_housing/screens/building_inspection_screen/screen/building_inspection_screen.dart';
import 'package:public_housing/screens/properties_list_screen/controller/properties_list_controller.dart';
import 'package:public_housing/screens/unit_list_screen/screen/unit_list_screen.dart';
import 'package:public_housing/screens/unit_list_screen/widget/common_unit_list_container.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PropertiesListScreen extends GetView<PropertiesListController> {
  const PropertiesListScreen({Key? key}) : super(key: key);

  static const routes = "/PropertiesListScreen";

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          controller.hasMore) {
        controller.getDailySchedulesData(isLoadMore: true);
      } else if (_scrollController.position.pixels ==
              _scrollController.position.minScrollExtent &&
          controller.page > 1) {
        controller.getDailySchedulesData(isPrevious: true);
      }
    });

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
                                                      SvgPicture.string(icEdit),
                                                  title: MyTextView(
                                                    Strings.editProfile,
                                                    textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textColor:
                                                            AppColors().black,
                                                        textWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: 1,
                                                child: ListTile(
                                                  leading:
                                                      SvgPicture.string(icCopy),
                                                  title: MyTextView(
                                                    Strings.inspectionHistory,
                                                    textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textColor:
                                                            AppColors().black,
                                                        textWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: 2,
                                                child: ListTile(
                                                  leading:
                                                      SvgPicture.string(icBook),
                                                  title: MyTextView(
                                                    Strings.nSPIREStandards,
                                                    textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textColor:
                                                            AppColors().black,
                                                        textWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: 3,
                                                child: ListTile(
                                                  leading: SvgPicture.string(
                                                      changeSectionIcon),
                                                  title: MyTextView(
                                                    Strings.changeSection,
                                                    textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textColor:
                                                            AppColors().black,
                                                        textWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: 4,
                                                child: ListTile(
                                                  leading: SvgPicture.string(
                                                      icLogout),
                                                  title: MyTextView(
                                                    Strings.logOut,
                                                    textStyleNew: MyTextStyle(
                                                        textSize: 16.px,
                                                        textColor:
                                                            AppColors().black,
                                                        textWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: 24.px),
                                textSize: 16.px,
                                textWeight: FontWeight.w500,
                                textFamily: fontFamilyRegular,
                                onTap: () {
                                  Get.toNamed(BuildingInspectionScreen.routes,
                                      arguments: {'isManually': true});
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
                      padding: EdgeInsets.symmetric(horizontal: 24.px),
                      textSize: 16.px,
                      border: Border.all(
                          color: controller.status == PropertyStatus.scheduled
                              ? controller.appColors.black
                              : AppColors().border1),
                      textColor: controller.status == PropertyStatus.scheduled
                          ? AppColors.primerColor
                          : AppColors().border1,
                      textWeight: FontWeight.w500,
                      textFamily: fontFamilyRegular,
                      onTap: () {
                        if (controller.status == PropertyStatus.scheduled) {
                          navigateToDateTime();
                          controller.dateRange = PickerDateRange(null, null);
                          controller.startDate = '';
                          controller.endDate = '';
                          controller.confirmSelectedDates();
                        }
                      },
                      iconColor: controller.status == PropertyStatus.scheduled
                          ? AppColors.primerColor
                          : AppColors().border1,
                      icon: icCalender1,
                      iconheigth: 20.px,
                    ),
                    Spacer(),
                    Expanded(
                      flex: 0,
                      child: SizedBox(
                        // width: 250.px,
                        height: 48.px,
                        child: SegmentedButton<PropertyStatus>(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateColor.resolveWith(
                                (Set<WidgetState> states) {
                              return states.contains(WidgetState.selected)
                                  ? controller.appColors.pinkcolor
                                  : controller.appColors.transparent;
                            }),
                            foregroundColor: WidgetStateColor.resolveWith(
                                (Set<WidgetState> states) {
                              return states.contains(WidgetState.selected)
                                  ? Colors.black
                                  : controller.appColors.border1;
                            }),
                            side: WidgetStateBorderSide.resolveWith((states) {
                              return BorderSide(
                                  color: states.contains(WidgetState.selected)
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
                controller.status == PropertyStatus.scheduled
                    ? Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              controller.apiResponseStatus ==
                                      ApiResponseStatus.success
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          controller.scheduleDataList.length +
                                              (controller.hasMore ? 1 : 0),
                                      itemBuilder: (context, index) {
                                        if (index <
                                            controller
                                                .scheduleDataList.length) {
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  MyTextView(
                                                    '${controller.scheduleDataList[index].prefix}${controller.scheduleDataList[index].date}',
                                                    textStyleNew: MyTextStyle(
                                                      textSize: 24.px,
                                                      textWeight:
                                                          FontWeight.w400,
                                                      textColor: controller
                                                          .appColors.black,
                                                    ),
                                                  ).paddingOnly(right: 16.px),
                                                  Expanded(
                                                    child: Container(
                                                      height: 2.px,
                                                      color:
                                                          AppColors().divider,
                                                    ),
                                                  ),
                                                ],
                                              ).paddingAll(32.px),
                                              ListView.separated(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: controller
                                                    .scheduleDataList[index]
                                                    .scheduleDataList
                                                    .length,
                                                itemBuilder: (context, i) {
                                                  var propertyData = controller
                                                      .scheduleDataList[index]
                                                      .scheduleDataList[i];
                                                  return CommonPropertiesListView(
                                                    title: propertyData
                                                            .property?.name ??
                                                        "",
                                                    Subtitle:
                                                        '${propertyData.property?.city} - ${propertyData.property?.zip}',
                                                    title1:
                                                        '${propertyData.scheduleInspectionBuildings?.length ?? 0} Buildings',
                                                    Subtitle1:
                                                        '${controller.getUnitCount(propertyData.scheduleInspectionBuildings)} Units',
                                                    date:
                                                        '${DateFormat('yyyy-MM-dd').format(propertyData.scheduleDate!)}',
                                                    onTap: () {
                                                      Get.toNamed(
                                                          BuildingListScreen
                                                              .routes,
                                                          arguments: {
                                                            "isComplete": false,
                                                            "propertyData":
                                                                propertyData,
                                                            "externalBuildingData":
                                                                propertyData
                                                                    .scheduleInspectionBuildings,
                                                          });
                                                    },
                                                  ).paddingSymmetric(
                                                      horizontal: 32.px);
                                                },
                                                separatorBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return SizedBox(
                                                      height: 24.px);
                                                },
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    )
                                  : controller.apiResponseStatus ==
                                          ApiResponseStatus.loading
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : controller.apiResponseStatus ==
                                              ApiResponseStatus.failure
                                          ? Text('No Data Found')
                                          : SizedBox(),
                              if (controller.scheduleDataList.length == 1 &&
                                  controller.scheduleDataList.first.prefix
                                      .contains(Strings.todayInspections))
                                MyTextView(
                                  Strings.timeframe,
                                  textStyleNew: MyTextStyle(
                                    textSize: 20.px,
                                    textWeight: FontWeight.w400,
                                    textColor: controller.appColors.black,
                                  ),
                                ).paddingOnly(top: 40.px),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (controller.completedBuildings.isNotEmpty)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyTextView(
                                      Strings.completedBuildings,
                                      textStyleNew: MyTextStyle(
                                          textSize: 24.px,
                                          textColor: AppColors().black,
                                          textWeight: FontWeight.w400),
                                    ).paddingOnly(right: 10.px),
                                    Expanded(
                                      child: Divider(
                                        height: 10.px,
                                        color: AppColors().divider,
                                      ),
                                    ),
                                  ],
                                ).paddingSymmetric(
                                    vertical: 31.px, horizontal: 32.px),
                              ...List.generate(
                                controller.completedBuildings.length,
                                (index) {
                                  return CommonBuildingListView(
                                    title:
                                        "Building ${controller.completedBuildings[index].building?.name ?? ""}",
                                    title1:
                                        '${controller.completedBuildings[index].scheduleInspectionUnits?.length ?? ""} Units',
                                    subTitle:
                                        '${controller.completedBuildings[index].building?.constructedYear ?? ""}',
                                    subTitle1:
                                        '${controller.completedBuildings[index].building?.buildingType?.name ?? ""}',
                                    onTap: () {
                                      Get.toNamed(UnitListScreen.routes,
                                          arguments: {
                                            "isManually": false,
                                            "isComplete": true,
                                            'externalBuilding': controller
                                                .completedBuildings[index],
                                            "propertyData": controller
                                                .completedBuildings[index]
                                                .propertyData,
                                          });
                                      controller.update();
                                    },
                                    isComplete: controller
                                            .completedBuildings[index]
                                            .isBuildingInspection ??
                                        false,
                                    dateTime: controller
                                            .completedBuildings[index]
                                            .dateTime ??
                                        DateTime.now(),
                                    onTap1: () {},
                                  ).paddingSymmetric(
                                      horizontal: 32.px, vertical: 5.px);
                                },
                              ),
                              if (controller.completedBuildings.isNotEmpty)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyTextView(
                                      Strings.completedUnits,
                                      textStyleNew: MyTextStyle(
                                          textSize: 24.px,
                                          textColor: AppColors().black,
                                          textWeight: FontWeight.w400),
                                    ).paddingOnly(right: 10.px),
                                    Expanded(
                                      child: Divider(
                                        height: 10.px,
                                        color: AppColors().divider,
                                      ),
                                    ),
                                  ],
                                ).paddingSymmetric(
                                    vertical: 31.px, horizontal: 32.px),
                              ...List.generate(
                                controller.completedUnits.length,
                                (index) {
                                  return CommonUnitListView(
                                    isComplete: controller.completedUnits[index]
                                                .inspectionStatus?.value ==
                                            'Complete'
                                        ? true
                                        : false,
                                    title:
                                        'Unit ${controller.completedUnits[index].unit?.name ?? ""}',
                                    Subtitle:
                                        '${controller.completedUnits[index].unit?.address ?? ""}',
                                    onTap: () {},
                                    dateTime: controller
                                            .completedUnits[index].dateTime ??
                                        DateTime.now(),
                                  ).paddingSymmetric(
                                      horizontal: 32.px, vertical: 5.px);
                                },
                              ),
                            ],
                          ),
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  void navigateToDateTime() {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: controller.appColors.white,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28.px),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            color: controller.appColors.white,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.px),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyTextView(
                        Strings.selectDates,
                        textStyleNew: MyTextStyle(
                            textSize: 32.px,
                            textColor: controller.appColors.black,
                            textWeight: FontWeight.w400),
                      ),
                      Spacer(),
                      CommonButton(
                        title: Strings.today,
                        textColor: AppColors.primerColor,
                        textWeight: FontWeight.w500,
                        textSize: 16.px,
                        onTap: () {
                          controller.startDate =
                              controller.todayDateGet(DateTime.now());
                          controller.startDateTime = DateTime.now();
                          controller.endDateTime = DateTime.now();
                          controller.getDailySchedulesData();
                          Get.back();
                          controller.update();
                        },
                        width: 92.px,
                        height: 44.px,
                        color: controller.appColors.transparent,
                        border: Border.all(color: controller.appColors.black),
                      ),
                    ],
                  ).paddingAll(24.px),
                  Container(height: 2.px, color: controller.appColors.divider),
                  Flexible(
                    child: SfDateRangePicker(
                      rangeSelectionColor: controller.appColors.greyColor,
                      initialSelectedDate: DateTime.now(),
                      // minDate: DateTime.now(),
                      minDate: DateTime(2020),
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs args) {
                        setState(() {
                          if (args.value.startDate != null) {
                            controller.startDate =
                                controller.todayDateGet(args.value.startDate);
                            controller.startDateTime = args.value.startDate;
                          } else {
                            controller.startDate = '';
                            controller.confirmSelectedDates();
                          }

                          if (args.value.endDate != null) {
                            controller.endDate =
                                controller.todayDateGet(args.value.endDate);
                            controller.endDateTime = args.value.endDate;
                          } else {
                            controller.endDate = '';
                            controller.confirmSelectedDates();
                          }
                          if (args.value.startDate != null ||
                              args.value.endDate != null) {
                            controller.confirmSelectedDates();
                          }
                        });
                      },
                      selectionShape: DateRangePickerSelectionShape.rectangle,
                      selectionRadius: 50.0,
                      selectionMode: DateRangePickerSelectionMode.range,
                      initialSelectedRange: controller.dateRange,
                      selectionTextStyle: const TextStyle(color: Colors.white),
                      startRangeSelectionColor: AppColors.primerColor,
                      endRangeSelectionColor: AppColors.primerColor,
                    ),
                  ),
                  Container(height: 2.px, color: controller.appColors.divider),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTextView(
                            Strings.from,
                            textStyleNew: MyTextStyle(
                                textSize: 20.px,
                                textColor: controller.appColors.textcolor,
                                textWeight: FontWeight.w400),
                          ),
                          MyTextView(
                            controller.startDate,
                            textStyleNew: MyTextStyle(
                                textSize: 24.px,
                                textColor: controller.appColors.black,
                                textWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTextView(
                            controller.endDate == ''
                                ? Strings.selectDate
                                : Strings.to,
                            textStyleNew: MyTextStyle(
                                textSize: 20.px,
                                textColor: controller.appColors.textcolor,
                                textWeight: FontWeight.w400),
                          ),
                          MyTextView(
                            controller.endDate,
                            textStyleNew: MyTextStyle(
                                textSize: 24.px,
                                textColor: controller.appColors.black,
                                textWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      CommonButton(
                        title: Strings.confirmDates,
                        textColor: controller.isDateSelected
                            ? controller.appColors.white
                            : controller.appColors.border1,
                        textWeight: FontWeight.w500,
                        textSize: 16.px,
                        onTap: controller.isDateSelected
                            ? () {
                                controller.selectedDateFilterData();
                              }
                            : () {},
                        width: 152.px,
                        height: 44.px,
                        color: controller.isDateSelected
                            ? AppColors.primerColor
                            : controller.appColors.black.withOpacity(.12),
                      ),
                    ],
                  ).paddingAll(24.px)
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
