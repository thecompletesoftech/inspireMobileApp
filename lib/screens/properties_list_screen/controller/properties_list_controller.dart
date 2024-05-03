import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:public_housing/Models/accountmodel/account_model.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/auth/signing_screen/screen/signing_screen.dart';

enum PropertyStatus { completed, scheduled }

class PropertiesListController extends BaseController {
  final GlobalKey<PopupMenuButtonState<int>> popupKey = GlobalKey();
  PropertyStatus status = PropertyStatus.scheduled;
  String date = '';
  String todayDate = '';
  DateTime? startDate;
  DateTime? endDate;
  String toDate = '';
  bool isDateSelected = false;
  Account? account;

  @override
  void onInit() {
    getAccount();
    startDate = DateTime.now();
    endDate = DateTime.now();
    todayDate = todayDateGet(DateTime.now());
    super.onInit();
  }

  void navigateToDateTime() {
    showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28.px),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          color: appColors.white,
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
                          textColor: appColors.black,
                          textWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    CommonButton(
                      title: Strings.today,
                      textColor: AppColors.primerColor,
                      textWeight: FontWeight.w500,
                      textSize: 16.px,
                      onTap: () {
                        date = todayDateGet(DateTime.now());
                        Get.back();
                        update();
                      },
                      width: 92.px,
                      height: 44.px,
                      color: appColors.transparent,
                      border: Border.all(color: appColors.black),
                    ),
                  ],
                ).paddingAll(24.px),
                Flexible(
                  child: DateRangePickerDialog(
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 100)),
                    initialDateRange: DateTimeRange(
                      start: DateTime.now(),
                      end: DateTime.now(),
                    ),
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                  ),
                ),
                Container(
                  height: 2.px,
                  color: AppColors().divider,
                ),
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
                              textColor: appColors.textcolor,
                              textWeight: FontWeight.w400),
                        ),
                        MyTextView(
                          todayDate,
                          textStyleNew: MyTextStyle(
                              textSize: 24.px,
                              textColor: appColors.black,
                              textWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextView(
                          toDate == '' ? Strings.selectDate : Strings.to,
                          textStyleNew: MyTextStyle(
                              textSize: 20.px,
                              textColor: appColors.textcolor,
                              textWeight: FontWeight.w400),
                        ),
                        MyTextView(
                          '',
                          textStyleNew: MyTextStyle(
                              textSize: 24.px,
                              textColor: appColors.black,
                              textWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    CommonButton(
                      title: Strings.confirmDates,
                      textColor:
                          confirmDates() ? appColors.white : appColors.border1,
                      textWeight: FontWeight.w500,
                      textSize: 16.px,
                      onTap: () {},
                      width: 152.px,
                      height: 44.px,
                      color: confirmDates()
                          ? AppColors.primerColor
                          : appColors.black.withOpacity(.12),
                    ),
                  ],
                ).paddingAll(24.px)
              ],
            ),
          ),
        );
      },
    );
  }

  getAccount() async {
    var accountData = await getStorageData.readString(getStorageData.account);
    account = Account.fromJson(jsonDecode(accountData.toString()));
    update();
  }

  bool confirmDates() {
    if (todayDate != '' && toDate != '') {
      isDateSelected = true;
    }
    return isDateSelected;
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
}
