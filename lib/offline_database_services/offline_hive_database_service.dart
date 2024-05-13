import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import '../../screens/building_inspection_screen/models/building_model.dart';
import 'package:public_housing/screens/building_inspection_screen/models/certificate_model.dart';
import 'package:public_housing/screens/building_inspection_screen/models/get_building_type_response_model.dart';
import 'package:public_housing/screens/building_inspection_screen/models/property_model.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';

class HiveMethodsProvider {
  late Box<dynamic> _getPropertiesData;
  late Box<dynamic> _getHousingItemData;
  late Box<dynamic> _getInspectionTypeData;
  late Box<dynamic> _getBuildingTypeData;
  late Box<dynamic> _getCertificateData;
  late Box<dynamic> _getBuildingInfoData;
  late Box<dynamic> _getPropertyInfoData;

  String getPropertiesKey = 'PROPERTIES';
  String getHousingItemKey = 'HOUSINGITEM';
  String getInspectionTypeKey = 'INSPECTIONTYPE';
  String getBuildingTypeKey = 'BUILDINGTYPE';
  String getCertificateKey = 'CERTIFICATE';
  String getBuildingInfoKey = 'BUILDINGINFO';
  String getPropertyInfoKey = 'PROPERTYINFO';

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
    _getPropertiesData = await Hive.openBox('getPropertiesData');
    _getHousingItemData = await Hive.openBox('getHousingItemData');
    _getInspectionTypeData = await Hive.openBox('getInspectionTypeData');
    _getBuildingTypeData = await Hive.openBox('getBuildingTypeData');
    _getCertificateData = await Hive.openBox('getCertificateData');
    _getBuildingInfoData = await Hive.openBox('getBuildingInfoData');
    _getPropertyInfoData = await Hive.openBox('getPropertyInfoData');
  }

  Future<void> setHousingItemData(
      Map<String, dynamic> deficiencyAreasResponseModel) async {
    Map<String, dynamic> setData = <String, dynamic>{};
    for (var p in deficiencyAreasResponseModel.entries) {
      setData[p.key] = p.value;
    }
    await _getHousingItemData.put(getHousingItemKey, setData);
  }

  Future<Either<Failure, DeficiencyAreasResponseModel>> getHousingItemData(
      {required String type}) async {
    var deficiencyAreasResponseModel =
        await _getHousingItemData.get(getHousingItemKey);

    if (type == 'Building') {
      if (deficiencyAreasResponseModel != null) {
        var data = DeficiencyAreasResponseModel.fromJson(
            _parser(deficiencyAreasResponseModel));

        data.deficiencyAreas?.forEach((element) {
          element.deficiencyAreaItems?.forEach((e) {
            List<DeficiencyItemHousingDeficiency> dataList = [];

            e.deficiencyItemHousingDeficiency?.forEach((d) {
              if (d.housingItem?.id == 1 || d.housingItem?.id == 2) {
                dataList.add(d);
              }
            });
            e.deficiencyItemHousingDeficiency = dataList;
          });
        });

        return Right(data);
      } else {
        return Left(Failure(errorMessage: ''));
      }
    } else {
      if (deficiencyAreasResponseModel != null) {
        var data = DeficiencyAreasResponseModel.fromJson(
            _parser(deficiencyAreasResponseModel));

        data.deficiencyAreas?.forEach((element) {
          element.deficiencyAreaItems?.forEach((e) {
            List<DeficiencyItemHousingDeficiency> dataList = [];

            e.deficiencyItemHousingDeficiency?.forEach((d) {
              if (d.housingItem?.id == 3) {
                dataList.add(d);
              }
            });
            e.deficiencyItemHousingDeficiency = dataList;
          });
        });

        return Right(data);
      } else {
        return Left(Failure(errorMessage: ''));
      }
    }
  }

  Future<void> setCertificateData(Map<String, dynamic> certificateModel) async {
    Map<String, dynamic> setData = <String, dynamic>{};
    for (var p in certificateModel.entries) {
      setData[p.key] = p.value;
    }
    await _getCertificateData.put(getCertificateKey, setData);
  }

  Future<Either<Failure, CertificateModel>> getCertificateData() async {
    var certificateModel = await _getCertificateData.get(getCertificateKey);

    if (certificateModel != null) {
      return Right(CertificateModel.fromJson(_parser(certificateModel)));
    } else {
      return Left(Failure(errorMessage: ''));
    }
  }

  Future<void> setPropertyInfoData(Map<String, dynamic> propertyModel) async {
    Map<String, dynamic> setData = <String, dynamic>{};
    for (var p in propertyModel.entries) {
      setData[p.key] = p.value;
    }
    await _getPropertyInfoData.put(getPropertyInfoKey, setData);
  }

  Future<Either<Failure, PropertyModel>> getPropertyInfoData() async {
    var propertyModel = await _getPropertyInfoData.get(getPropertyInfoKey);

    if (propertyModel != null) {
      return Right(PropertyModel.fromJson(_parser(propertyModel)));
    } else {
      return Left(Failure(errorMessage: ''));
    }
  }

  Future<void> setBuildingTypeData(
      Map<String, dynamic> getBuildingTypeResponseModel) async {
    Map<String, dynamic> setData = <String, dynamic>{};
    for (var p in getBuildingTypeResponseModel.entries) {
      setData[p.key] = p.value;
    }
    await _getBuildingTypeData.put(getBuildingTypeKey, setData);
  }

  Future<Either<Failure, GetBuildingTypeResponseModel>>
      getBuildingTypeData() async {
    var getBuildingTypeResponseModel =
        await _getBuildingTypeData.get(getBuildingTypeKey);

    if (getBuildingTypeResponseModel != null) {
      return Right(GetBuildingTypeResponseModel.fromJson(
          _parser(getBuildingTypeResponseModel)));
    } else {
      return Left(Failure(errorMessage: ''));
    }
  }

  Future<void> setBuildingInfoData(Map<String, dynamic> buildingModel) async {
    Map<String, dynamic> setData = <String, dynamic>{};
    for (var p in buildingModel.entries) {
      setData[p.key] = p.value;
    }
    await _getBuildingInfoData.put(getBuildingInfoKey, setData);
  }

  Future<Either<Failure, BuildingModel>> getBuildingInfoData() async {
    var buildingModel = await _getBuildingInfoData.get(getBuildingInfoKey);

    if (buildingModel != null) {
      return Right(BuildingModel.fromJson(_parser(buildingModel)));
    } else {
      return Left(Failure(errorMessage: ''));
    }
  }

  Map<String, dynamic> _parser(dynamic hiveMap) {
    final jsonString = jsonEncode(hiveMap);
    return jsonDecode(jsonString);
  }
}
