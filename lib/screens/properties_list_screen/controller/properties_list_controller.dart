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

  getDailySchedulesData() async {
    scheduleMainDataList = [];
    apiResponseStatus = ApiResponseStatus.loading;
    var response = await propertiesListRepository.getDailySchedules(
        startDate: startDateTime!, endDate: endDateTime!);

    response.fold((l) {
      apiResponseStatus = ApiResponseStatus.failure;
    }, (r) async {
      r.scheduleInspections?.forEach((e) {
        scheduleMainDataList.add(e);
      });
      await getTodayData();
      apiResponseStatus = ApiResponseStatus.success;
    });
    update();
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
      // if (getDateFormat(date: e.scheduleDate!) ==
      //     DateFormat('yyyy-MM-dd').format(DateTime.now())) {
      // DateFormat('yyyy-MM-dd')
      //     .format(DateTime.parse('2025-01-16T00:00:00-05:00'))) {
      // if (scheduleDataList.isEmpty) {
      scheduleDataList.add(DataSorting(
          date: todayDateGet(e.scheduleDate!),
          scheduleDataList: [e],
          prefix: DateFormat('yyyy-MM-dd').format(e.scheduleDate!) ==
                  DateFormat('yyyy-MM-dd').format(DateTime.now())
              ? Strings.todayInspections
              : ''));
      // } else {
      //   scheduleDataList
      //       .firstWhere(
      //           (element) => element.date == todayDateGet(e.scheduleDate!))
      //       .scheduleDataList
      //       .add(e);
      // }
      // }
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
    // scheduleDataList = [];
    // List<String> days = [];
    //
    // for (int i = 0; i <= endDateTime!.difference(startDateTime!).inDays; i++) {
    //   days.add(getDateFormat(date: startDateTime!.add(Duration(days: i))));
    // }
    //
    // days.forEach((e) {
    //   final sortingData = scheduleMainDataList.where((element) =>
    //       DateTime.parse(e) == DateTime.parse(element.scheduleDate.toString()));
    //
    //   if (sortingData.isNotEmpty) {
    //     scheduleDataList.add(DataSorting(
    //         date: todayDateGet(DateTime.parse(e)),
    //         scheduleDataList: sortingData.toList(),
    //         prefix: DateTime.now().day == DateTime.parse(e).day
    //             ? Strings.todayInspections
    //             : ''));
    //   }
    // });
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
