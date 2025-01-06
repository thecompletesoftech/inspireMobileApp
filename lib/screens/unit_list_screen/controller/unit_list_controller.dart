import 'dart:convert';

import 'package:public_housing/Models/accountmodel/account_model.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart';

class UnitListController extends BaseController {
  bool isManually = false;
  bool isComplete = false;
  ScheduleInspectionBuilding externalBuilding = ScheduleInspectionBuilding();
  ScheduleInspection propertyData = ScheduleInspection();
  var propertyInfo = {}.obs;
  var buildingInfo = {}.obs;
  var certificatesInfo = [].obs;
  Account? account;
  String inspectorName = '';
  List<ScheduleInspectionUnit> completeUnits = [];
  List<ScheduleInspectionUnit> remainUnits = [];

  @override
  void onInit() {
    if (Get.arguments['isManually'] != null) {
      isManually = Get.arguments['isManually'];
    }
    if (Get.arguments['propertyData'] != null) {
      propertyData = Get.arguments['propertyData'];
      propertyInfo.addAll({
        "id": propertyData.property?.id,
        "name": propertyData.property?.name,
        "city": propertyData.property?.city,
        "state": propertyData.property?.state,
        "zip": propertyData.property?.zip,
        "address": propertyData.property?.address1
      });
    }
    if (Get.arguments['externalBuilding'] != null) {
      externalBuilding = Get.arguments['externalBuilding'];
      buildingInfo.addAll({
        "id": externalBuilding.id,
        "name": externalBuilding.building?.name,
        "constructed_year": externalBuilding.building?.constructedYear,
        "building_type_id": externalBuilding.building?.buildingType?.id
      });
    }
    if (Get.arguments['isComplete'] != null) {
      isComplete = Get.arguments['isComplete'];
    }
    getAccount();
    externalCompleteUnits();
    super.onInit();
  }

  externalCompleteUnits() {
    externalBuilding.scheduleInspectionUnits?.forEach(
      (element) {
        // if (element.unit ?? false) {
        //   completeUnits.add(element);
        // } else {
        //   remainUnitsUnits.add(element);
        // }
      },
    );
  }

  getAccount() async {
    var accountData = await getStorageData.readString(getStorageData.account);
    account = Account.fromJson(jsonDecode(accountData.toString()));
    inspectorName = await account!.userName;
    update();
  }
}
