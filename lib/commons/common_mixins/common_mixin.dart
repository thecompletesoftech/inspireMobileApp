import 'dart:convert';
import 'package:public_housing/Models/accountmodel/account_model.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import '../../screens/properties_list_screen/model/daily_schedules_res_model.dart';

mixin AppCommonMixin {
  GetStorageData getStorageData = GetStorageData();

  Future<Account?> getAccount() async {
    var accountData = await getStorageData.readString(getStorageData.account);
    return Account.fromJson(jsonDecode(accountData.toString()));
  }

  List<DeficiencyArea> extractDeficiencyAreaData(
      {required List<DeficiencyArea> deficiencyAreaList}) {
    for (DeficiencyArea deficiencyArea in deficiencyAreaList) {
      if (deficiencyArea.deficiencyAreaItems?.isNotEmpty ?? false) {
        List<DeficiencyAreaItem> deficiencyAreaItemList = [];
        for (DeficiencyAreaItem deficiencyAreaItem
            in deficiencyArea.deficiencyAreaItems!) {
          if (deficiencyAreaItem.deficiencyItemHousingDeficiency?.isNotEmpty ??
              false) {
            for (DeficiencyItemHousingDeficiency deficiencyItemHousingDeficiency
                in deficiencyAreaItem.deficiencyItemHousingDeficiency!) {
              deficiencyAreaItem.deficiencyItemHousingDeficiencyData =
                  DeficiencyItemHousingDeficiency.fromJson(
                      deficiencyItemHousingDeficiency.toJson());
              deficiencyAreaItemList.add(
                  DeficiencyAreaItem.fromJson(deficiencyAreaItem.toJson()));
            }
          }
        }
        deficiencyArea.deficiencyAreaItems = deficiencyAreaItemList.toList();
        // .map((x) => DeficiencyAreaItem.fromJson(x.toJson()))
        // .toList();
      }
    }
    return deficiencyAreaList;
  }

  List<DeficiencyArea> extractAndSetLocalDeficiencyAreaData(
      {required List<BuildingInspectionDataModel>
          buildingInspectionDataModelList,
      required List<DeficiencyArea> deficiencyAreaListData}) {
    List<DeficiencyArea> deficiencyAreaList =
        extractDeficiencyAreaData(deficiencyAreaList: deficiencyAreaListData);

    if (buildingInspectionDataModelList.isNotEmpty) {
      for (int i = 0; i < deficiencyAreaList.length; i++) {
        DeficiencyArea deficiencyArea = deficiencyAreaList[i];
        BuildingInspectionDataModel? buildingInspectionDataModel =
            buildingInspectionDataModelList.firstWhereOrNull(
                (buildingInspectionDataModel) =>
                    buildingInspectionDataModel.standardId ==
                    deficiencyArea.id);
        bool isUpdate = false;
        if (buildingInspectionDataModel != null &&
            (deficiencyArea.deficiencyAreaItems?.isNotEmpty ?? false)) {
          for (int j = 0; j < deficiencyArea.deficiencyAreaItems!.length; j++) {
            DeficiencyAreaItem deficiencyAreaItem =
                deficiencyArea.deficiencyAreaItems![j];
            DeficiencyAreaUpdatedItem? deficiencyAreaUpdatedItem =
                buildingInspectionDataModel.deficiencyAreaUpdatedItemList
                    ?.firstWhereOrNull((element) =>
                        element.deficiencyAreaItemsId ==
                            deficiencyAreaItem.id &&
                        element.deficiencyItemHousingDeficiencyId ==
                            deficiencyAreaItem
                                .deficiencyItemHousingDeficiencyData?.id);

            if (deficiencyAreaUpdatedItem != null) {
              isUpdate = true;
              // Update the existing DeficiencyAreaItem object
              deficiencyArea.deficiencyAreaItems![j].comment =
                  deficiencyAreaUpdatedItem.comment;
              deficiencyArea.deficiencyAreaItems![j].date =
                  deficiencyAreaUpdatedItem.date.toString();
              deficiencyArea.deficiencyAreaItems![j].deficiencyProofPictures =
                  deficiencyAreaUpdatedItem.deficiencyProofPictures;
              deficiencyArea.deficiencyAreaItems![j].isDeficiencyCheck = true;
            }
          }
          if (isUpdate) {
            deficiencyArea.isArea = true;
          }
        }
      }
    }
    return deficiencyAreaList;
  }
}
