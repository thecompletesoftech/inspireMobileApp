import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:public_housing/Models/accountmodel/account_model.dart';
import 'package:public_housing/commons/general_enum.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/internet_services/internet_service.dart';
import 'package:public_housing/screens/auth/signing_screen/screen/signing_screen.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart';
import 'package:public_housing/screens/properties_list_screen/repository/properties_list_repository.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PropertiesListController extends BaseController {
  final GlobalKey<PopupMenuButtonState<int>> popupKey = GlobalKey();
  PropertyStatus status = PropertyStatus.scheduled;
  String todayDate = '';
  String startDate = '';
  String endDate = '';
  DateTime? startDateTime;
  DateTime? endDateTime;
  bool isDateSelected = false;
  Account? account;
  PickerDateRange? dateRange;
  PropertiesListRepository propertiesListRepository =
      PropertiesListRepository();
  List<ScheduleDatum> scheduleMainDataList = [];
  List<DataSorting> scheduleDataList = [];
  ApiResponseStatus apiResponseStatus = ApiResponseStatus.initial;
  List<BuildingsData> completedBuildings = [];
  List<UnitsData> completedUnits = [];

  @override
  void onInit() {
    dateRange = PickerDateRange(DateTime.now(), DateTime(2025));
    todayDate = todayDateGet(DateTime.now());
    getAccount();
    () async {
      if (isInternet == IsInternet.connect) {
        await localStorageDataset();
      }
      await getLocalDailySchedulesData();
    }();
    super.onInit();
  }

  localStorageDataset() async {
    await setDataLocalStorage();
    await getDailySchedulesData();
    await getCertificatesData();
    await getPropertyInfoData();
    await getBuildingTypeData();
  }

  setDataLocalStorage() async {
    apiResponseStatus = ApiResponseStatus.loading;
    var response = await propertiesListRepository.localDeficiencyAreaDataSet();

    response.fold((l) {
      apiResponseStatus = ApiResponseStatus.failure;
    }, (r) {
      apiResponseStatus = ApiResponseStatus.success;
    });
    update();
  }

  getDailySchedulesData() async {
    apiResponseStatus = ApiResponseStatus.loading;
    var response = await propertiesListRepository.localDailySchedulesDataSet();

    response.fold((l) {
      apiResponseStatus = ApiResponseStatus.failure;
    }, (r) {
      apiResponseStatus = ApiResponseStatus.success;
    });
    update();
  }

  getCertificatesData() async {
    apiResponseStatus = ApiResponseStatus.loading;
    var response = await propertiesListRepository.localCertificatesDataSet();

    response.fold((l) {
      apiResponseStatus = ApiResponseStatus.failure;
    }, (r) {
      apiResponseStatus = ApiResponseStatus.success;
    });
    update();
  }

  getPropertyInfoData() async {
    apiResponseStatus = ApiResponseStatus.loading;
    var response = await propertiesListRepository.localPropertyInfoDataSet();

    response.fold((l) {
      apiResponseStatus = ApiResponseStatus.failure;
    }, (r) {
      apiResponseStatus = ApiResponseStatus.success;
    });
    update();
  }

  getBuildingTypeData() async {
    apiResponseStatus = ApiResponseStatus.loading;
    var response = await propertiesListRepository.localBuildingTypeDataSet();

    response.fold((l) {
      apiResponseStatus = ApiResponseStatus.failure;
    }, (r) {
      apiResponseStatus = ApiResponseStatus.success;
    });
    update();
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

  getLocalDailySchedulesData() async {
    scheduleMainDataList = [];
    apiResponseStatus = ApiResponseStatus.loading;
    var response = await propertiesListRepository.getDailySchedules();

    response.fold((l) {
      apiResponseStatus = ApiResponseStatus.failure;
    }, (r) async {
      r.scheduleData?.forEach((e) {
        scheduleMainDataList.add(e);
      });
      await getTodayData();
      apiResponseStatus = ApiResponseStatus.success;
    });
    update();
  }

  getTodayData() {
    scheduleDataList = [];
    scheduleMainDataList.forEach((e) {
      if (getDateFormat(date: e.date!) ==
          DateFormat('yyyy-MM-dd').format(DateTime.now())) {
        if (scheduleDataList.isEmpty) {
          scheduleDataList.add(
            DataSorting(
                date: todayDateGet(DateTime.now()),
                scheduleDataList: [e],
                prefix: Strings.todayInspections,
                isToday: true),
          );
        } else {
          scheduleDataList
              .firstWhere(
                  (element) => element.date == todayDateGet(DateTime.now()))
              .scheduleDataList
              .add(e);
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
    scheduleDataList = [];
    List<String> days = [];

    for (int i = 0; i <= endDateTime!.difference(startDateTime!).inDays; i++) {
      days.add(getDateFormat(date: startDateTime!.add(Duration(days: i))));
    }

    days.forEach((e) {
      final sortingData = scheduleMainDataList.where((element) =>
          DateTime.parse(e) == DateTime.parse(element.date.toString()));

      if (sortingData.isNotEmpty) {
        scheduleDataList.add(DataSorting(
            date: todayDateGet(DateTime.parse(e)),
            scheduleDataList: sortingData.toList(),
            isToday:
                true /*DateTime.now().day == DateTime.parse(e).day ? true : false*/,
            prefix: DateTime.now().day == DateTime.parse(e).day
                ? Strings.todayInspections
                : ''));
      }
    });
    Get.back();
    update();
  }

  int unitsCount({List<BuildingsData>? buildings}) {
    int totalCount = 0;
    buildings?.forEach(
      (element) {
        totalCount += element.units?.length ?? 0;
      },
    );
    return totalCount;
  }

  isCompletedData() {
    if (status.toString() == PropertyStatus.completed.toString()) {
      completedBuildings = [];
      completedUnits = [];

      for (var scheduleMainDataListData in scheduleMainDataList) {
        for (var buildingsListData
            in scheduleMainDataListData.buildings ?? []) {
          if (buildingsListData.iscompleted == 'Completed') {
            BuildingsData buildingsData = buildingsListData;
            buildingsData.date = scheduleMainDataListData.date;
            completedBuildings.add(buildingsData);
          }

          for (var unitsListData in buildingsListData.units ?? []) {
            if (unitsListData.iscompleted == 'Completed') {
              UnitsData unitsData = unitsListData;
              unitsData.date = scheduleMainDataListData.date;
              completedUnits.add(unitsData);
            }
          }
        }
      }
    } else {
      getTodayData();
    }
    update();
  }
}

class DataSorting {
  final String date;
  final List<ScheduleDatum> scheduleDataList;
  final String prefix;
  final bool isToday;

  DataSorting({
    required this.date,
    required this.scheduleDataList,
    required this.isToday,
    required this.prefix,
  });
}
