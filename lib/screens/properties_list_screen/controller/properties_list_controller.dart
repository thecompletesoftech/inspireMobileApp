import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:public_housing/Models/accountmodel/account_model.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/auth/signing_screen/screen/signing_screen.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart';
import 'package:public_housing/screens/properties_list_screen/repository/properties_list_repository.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum PropertyStatus { completed, scheduled }

enum ApiResponseStatus { initial, loading, success, failure }

class PropertiesListController extends BaseController {
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
  PropertiesListRepository propertiesListRepository =
      PropertiesListRepository();
  List<ScheduleInspection> scheduleMainDataList = [];
  List<DataSorting> scheduleDataList = [];
  ApiResponseStatus apiResponseStatus = ApiResponseStatus.initial;
  int itemsPerPage = 5;
  int page = 1;
  bool hasMore = true;

  @override
  void onInit() {
    dateRange = PickerDateRange(DateTime.now(), DateTime(2025));
    todayDate = todayDateGet(DateTime.now());

    () async {
      await getAccount();
      await getDailySchedulesData();
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

      var response = await propertiesListRepository.getDailySchedules(
        page: page,
        endDate:
            '${DateFormat("yyyy-MM-dd 00:00:00").format(endDateTime!)}${endDateTime!.timeZoneOffset.isNegative ? '-' : '+'}${endDateTime!.timeZoneOffset.inHours.toString().padLeft(2, '0')}${(endDateTime!.timeZoneOffset.inMinutes % 60).toString().padLeft(2, '0')}',
        startDate:
            '${DateFormat("yyyy-MM-dd 00:00:00").format(startDateTime!)}${startDateTime!.timeZoneOffset.isNegative ? '-' : '+'}${startDateTime!.timeZoneOffset.inHours.toString().padLeft(2, '0')}${(startDateTime!.timeZoneOffset.inMinutes % 60).toString().padLeft(2, '0')}',
        itemsPerPage: itemsPerPage,
      );

      response.fold((l) {
        if (!isLoadMore && !isPrevious) {
          apiResponseStatus = ApiResponseStatus.failure;
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
          getTodayData();
          hasMore = r.scheduleInspections!.length == itemsPerPage;
        } else {
          hasMore = false;
        }

        apiResponseStatus = ApiResponseStatus.success;
      });
    } catch (e) {
      apiResponseStatus = ApiResponseStatus.failure;
      hasMore = false;
    } finally {
      update();
    }
  }

  getUnitCount(List<ScheduleInspectionBuilding>? externalBuildings) {
    int totalUnit = 0;
    for (ScheduleInspectionBuilding i in externalBuildings ?? []) {
      totalUnit += i.scheduleInspectionUnits!.length;
    }
    return totalUnit;
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
      message = 'You selected ${Strings.changeSection}';
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
