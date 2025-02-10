import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:public_housing/Models/accountmodel/account_model.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/auth/signing_screen/screen/signing_screen.dart';
import 'package:public_housing/screens/inspection_list_screen/model/complete_inspection_res_model.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_req_model.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_res_model.dart';
import 'package:public_housing/screens/inspection_list_screen/repository/inspection_list_repository.dart';
import 'package:public_housing/screens/properties_list_screen/screen/properties_list_screen.dart';
import 'package:public_housing/screens/special_amenities_screen/model/special_amenities_req_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum PropertyStatus { completed, scheduled }

enum ApiResponseStatus { initial, loading, success, failure }

InspectionReqModel inspectionReqModel = InspectionReqModel(
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

class InspectionListController extends BaseController {
  final GlobalKey<PopupMenuButtonState<int>> popupKey = GlobalKey();
  PropertyStatus status = PropertyStatus.scheduled;
  String todayDate = '';
  String startDate = '';
  String endDate = '';
  DateTime? startDateTime = DateTime.now();
  DateTime? endDateTime = DateTime.now();
  bool isDateSelected = false;
  Account? account;
  PickerDateRange? dateRange;
  InspectionListRepository inspectionListRepository =
      InspectionListRepository();
  List<ScheduleInspection> scheduleMainDataList = [];
  List<DataSorting> scheduleDataList = [];
  ApiResponseStatus apiResponseStatus = ApiResponseStatus.initial;
  int itemsPerPage = 30;
  int page = 1;
  bool hasMore = true;
  bool isLoading = false;
  int completeDataPage = 1;
  List<CompleteInspection> inspections = [];

  @override
  void onInit() {
    dateRange = PickerDateRange(DateTime.now(), DateTime(2025));
    todayDate = todayDateGet(DateTime.now());

    () async {
      await getAccount();
      await getDailySchedulesData();
      await getCompleteSchedulesData();
    }();
    super.onInit();
  }

  getAccount() async {
    var accountData = await getStorageData.readString(getStorageData.account);
    account = Account.fromJson(jsonDecode(accountData.toString()));
    update();
  }

  bool confirmSelectedDates() {
    if (startDate != '' && endDate != '') {
      isDateSelected = true;
    } else {
      isDateSelected = false;
    }
    return isDateSelected;
  }

  Future<void> getDailySchedulesData(
      {bool isLoadMore = false, bool isPrevious = false}) async {
    try {
      if (!isLoadMore && !isPrevious) {
        page = 1;
        hasMore = true;
        scheduleMainDataList.clear();
        apiResponseStatus = ApiResponseStatus.loading;
        update();
      } else if (isLoadMore && hasMore) {
        page++;
      } else if (isPrevious && page > 1) {
        page--;
      } else {
        return;
      }

      var response = await inspectionListRepository.getInspectionSchedules(
        type: 1,
        page: page,
        itemsPerPage: itemsPerPage,
        endDate: formatDateWithTimeZone(endDateTime!),
        startDate: formatDateWithTimeZone(startDateTime!),
      );

      response.fold((l) {
        if (!isLoadMore && !isPrevious) {
          apiResponseStatus = ApiResponseStatus.failure;
          scheduleMainDataList.clear();
        }
        hasMore = false;
      }, (r) async {
        if (r.scheduleInspections != null &&
            r.scheduleInspections!.isNotEmpty) {
          final uniqueItems = r.scheduleInspections!
              .where((newItem) => !scheduleMainDataList
                  .any((existing) => existing.id == newItem.id))
              .toList();

          if (isLoadMore) {
            scheduleMainDataList.addAll(uniqueItems);
          } else if (isPrevious) {
            scheduleMainDataList.insertAll(0, uniqueItems);
          } else {
            scheduleMainDataList = r.scheduleInspections!;
          }
          await getTodayData();
          hasMore = r.scheduleInspections!.length == itemsPerPage;
        } else {
          scheduleMainDataList.clear();
          hasMore = false;
          await getTodayData();
        }
        apiResponseStatus = ApiResponseStatus.success;
        update();
      });
    } catch (e) {
      apiResponseStatus = ApiResponseStatus.failure;
      scheduleMainDataList.clear();
      hasMore = false;
      update();
    } finally {
      update();
    }
  }

  Future<void> getCompleteSchedulesData() async {
    if (isLoading) return;
    isLoading = true;
    update();

    var response =
        await inspectionListRepository.getCompleteInspectionSchedules(
      type: 1,
      page: completeDataPage,
      itemsPerPage: itemsPerPage,
    );

    response.fold((l) {
      isLoading = false;
      update();
    }, (r) {
      if (r.inspections?.isNotEmpty == true) {
        if (completeDataPage == 1) {
          inspections = r.inspections!;
        } else {
          inspections.addAll(r.inspections!);
        }
        completeDataPage++;
        if (r.inspections!.length < itemsPerPage) {
          isLoading = false;
          update();
          return;
        }
      }
      isLoading = false;
      update();
    });
  }

  getTodayData() {
    scheduleDataList = [];
    scheduleMainDataList.forEach((e) {
      if (scheduleDataList.isEmpty) {
        scheduleDataList.add(DataSorting(
          date: todayDateGet(e.scheduleDate!),
          scheduleDataList: [e],
          prefix: DateFormat('yyyy-MM-dd').format(e.scheduleDate!) ==
                  DateFormat('yyyy-MM-dd').format(DateTime.now())
              ? Strings.todayInspections
              : '',
        ));
      } else {
        var matchingItem = scheduleDataList
            .where(
              (element) => element.date == todayDateGet(e.scheduleDate!),
            )
            .toList();

        if (matchingItem.isNotEmpty) {
          matchingItem.first.scheduleDataList.add(e);
        } else {
          scheduleDataList.add(DataSorting(
            date: todayDateGet(e.scheduleDate!),
            scheduleDataList: [e],
            prefix: DateFormat('yyyy-MM-dd').format(e.scheduleDate!) ==
                    DateFormat('yyyy-MM-dd').format(DateTime.now())
                ? Strings.todayInspections
                : '',
          ));
        }
      }
    });
  }

  ScheduleInspectionUnit filterData(
      {required ScheduleInspection scheduleInspection}) {
    ScheduleInspectionUnit unitData = ScheduleInspectionUnit();
    if (scheduleInspection.scheduleInspectionBuildings!.isNotEmpty) {
      scheduleInspection.scheduleInspectionBuildings?.forEach(
        (building) {
          if (building.scheduleInspectionUnits!.isNotEmpty) {
            building.scheduleInspectionUnits?.forEach(
              (unit) {
                unitData = unit;
              },
            );
          }
        },
      );
    }
    return unitData;
  }

  actionPopUpItemSelected(int value) {
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar;
    String message;
    if (value == 0) {
      message = 'You selected ${Strings.editProfile}';
    } else if (value == 1) {
      message = 'You selected ${Strings.inspectionHistory}';
    } else if (value == 2) {
      message = 'You selected ${Strings.nSPIREStandards}';
    } else if (value == 3) {
      message = 'You selected ${Strings.changeSection1}';
      Get.offAllNamed(PropertiesListScreen.routes);
    } else if (value == 4) {
      message = 'You selected ${Strings.logOut}';
      Get.offAllNamed(SigningScreen.routes);
      getStorageData.removeData(getStorageData.isLogin);
      getStorageData.removeData(getStorageData.baseURL);
    } else {
      message = 'Not implemented';
    }
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  String todayDateGet(DateTime date) {
    final DateFormat format2 = DateFormat('MMMM dd');
    return format2.format(date);
  }

  String getDateFormat({required DateTime date}) {
    final DateFormat format2 = DateFormat('yyyy-MM-dd');
    return format2.format(date);
  }

  selectedDateFilterData() {
    getDailySchedulesData();
    Get.back();
    update();
  }

  String formatDateWithTimeZone(DateTime date) {
    String formattedDate = DateFormat("yyyy-MM-dd 00:00:00").format(date);
    Duration timeZoneOffset = date.timeZoneOffset;
    String sign = timeZoneOffset.isNegative ? '-' : '+';
    String hours = timeZoneOffset.inHours.abs().toString().padLeft(2, '0');
    String minutes =
        (timeZoneOffset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    return '$formattedDate$sign$hours:$minutes';
  }
}

class DataSorting {
  final String date;
  final List<ScheduleInspection> scheduleDataList;
  final String prefix;

  DataSorting({
    required this.date,
    required this.scheduleDataList,
    required this.prefix,
  });
}
