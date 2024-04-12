import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveMethodsProvider {
  late LazyBox<dynamic> getBuildingsData;
  late LazyBox<dynamic>? getPropertiesData;
  late LazyBox<dynamic> getHousingItemData;
  late LazyBox<dynamic> getInspectionTypeData;
  late LazyBox<dynamic> getBuildingTypeData;
  late LazyBox<dynamic> getCertificateData;
  late LazyBox<dynamic> getBuildingInfoData;

  String getBuildingsKey = 'BUILDINGS';
  String getPropertiesKey = 'PROPERTIES';
  String getHousingItemKey = 'HOUSINGITEM';
  String getInspectionTypeKey = 'INSPECTIONTYPE';
  String getBuildingTypeKey = 'BUILDINGTYPE';
  String getCertificateKey = 'CERTIFICATE';
  String getBuildingInfoKey = 'BUILDINGINFO';

  initialize() async {
    getBuildingsData = await Hive.openLazyBox('getBuildingsData');
    getPropertiesData = await Hive.openLazyBox('getPropertiesData');
    getHousingItemData = await Hive.openLazyBox('getHousingItemData');
    getInspectionTypeData = await Hive.openLazyBox('getInspectionTypeData');
    getBuildingTypeData = await Hive.openLazyBox('getBuildingTypeData');
    getCertificateData = await Hive.openLazyBox('getCertificateData');
    getBuildingInfoData = await Hive.openLazyBox('getBuildingInfoData');
  }

  createDataBase() async {
    String dataBaseName = 'demo';

    if (Hive.isBoxOpen(dataBaseName)) {
      var box = await Hive.box(dataBaseName);
      print("box--->${box.get('')}");
    } else {
      await Hive.openBox(dataBaseName);
    }
  }

  setDataBaseData(boxDataName, keyName, data) async {
    try {
      await boxDataName!.put(keyName, data.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getDataBaseData(boxDataName, keyName) async {
    try {
      await boxDataName!.get(keyName);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
