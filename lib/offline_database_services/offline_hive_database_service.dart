import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveMethodsProvider {
  late Box<dynamic> getBuildingsData;
  late Box<dynamic> getPropertiesData;
  late Box<dynamic> getHousingItemData;
  late Box<dynamic> getInspectionTypeData;
  late Box<dynamic> getBuildingTypeData;
  late Box<dynamic> getCertificateData;
  late Box<dynamic> getBuildingInfoData;

  String getBuildingsKey = 'BUILDINGS';
  String getPropertiesKey = 'PROPERTIES';
  String getHousingItemKey = 'HOUSINGITEM';
  String getInspectionTypeKey = 'INSPECTIONTYPE';
  String getBuildingTypeKey = 'BUILDINGTYPE';
  String getCertificateKey = 'CERTIFICATE';
  String getBuildingInfoKey = 'BUILDINGINFO';

  Future<void> setUpHive() async {
    try {
      await Hive.initFlutter('INSPIRE_DATABASE');
      if (!Hive.isBoxOpen("getBuildingsData")) {
        await initialize();
      }
    } catch (error) {
      print(error.toString());
    }
  }

  initialize() async {
    getBuildingsData = await Hive.openBox('getBuildingsData');
    getPropertiesData = await Hive.openBox('getPropertiesData');
    getHousingItemData = await Hive.openBox('getHousingItemData');
    getInspectionTypeData = await Hive.openBox('getInspectionTypeData');
    getBuildingTypeData = await Hive.openBox('getBuildingTypeData');
    getCertificateData = await Hive.openBox('getCertificateData');
    getBuildingInfoData = await Hive.openBox('getBuildingInfoData');
  }

  setDataBaseData(boxDataName, keyName, data) async {
    try {
      await boxDataName!.put(keyName, data);
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
