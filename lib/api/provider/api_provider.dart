import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:public_housing/api/api_helper/api_base_helper_implementation.dart';
import 'package:public_housing/api/api_helper/dio_exceptions.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/internet_services/internet_service.dart';
import 'package:public_housing/offline_database_services/offline_hive_database_service.dart';
import 'package:public_housing/screens/building_inspection_screen/models/create_building_request_model.dart';
import 'package:public_housing/screens/building_inspection_screen/models/create_building_response_model.dart';
import 'package:public_housing/screens/building_inspection_screen/models/get_buildingtype_response_model.dart';
import 'package:public_housing/screens/building_inspection_screen/models/property_model.dart';
import 'package:public_housing/screens/building_inspection_summary/model/create_inspection_request_model.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/models/image_response_model.dart';
import '../../screens/Unit_building_standards_screen/models/deficiency_areas_res_model.dart';
import '../../screens/auth/model/Inspectormodel.dart';
import '../../screens/auth/model/LoginModel.dart';
import '../../screens/building_inspection_screen/models/building_model.dart';
import '../../screens/building_inspection_screen/models/certificate_model.dart';
import '../../screens/unitinspectionsummary_screen/models/CreateInspectionmodel.dart';

class ApiProviders extends BaseController {
  ApiBaseHelperImplementation apiBaseHelperImplementation =
      ApiBaseHelperImplementation();
  HiveMethodsProvider hiveMethodsProvider = HiveMethodsProvider();

  ApiProviders();

  Future<Either<Failure, DeficiencyAreasResponseModel>>
      getDeficiencyAreasRequest() async {
    if (isInternet == IsInternet.connect) {
      try {
        Response response = await apiBaseHelperImplementation.get(
          endPoint:
              '/inspection/api/deficiency_areas?housing_item_id=1&housing_item_id=2',
          headers: {
            'Authorization':
                '${getStorageData.readString(getStorageData.token)}',
          },
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(DeficiencyAreasResponseModel.fromJson(response.data));
        } else {
          return Left(Failure(errorMessage: response.statusMessage.toString()));
        }
      } on DioException catch (e) {
        return Left(createFailure(e));
      }
    } else {
      var data = hiveMethodsProvider.getDataBaseData(
          hiveMethodsProvider.getHousingItemData,
          hiveMethodsProvider.getHousingItemKey);

      if (data != null) {
        return Right(DeficiencyAreasResponseModel.fromJson(_parser(data)));
      } else {
        return Left(Failure(errorMessage: ''));
      }
    }
  }

  Future<Either<Failure, UnitDeficiencyAreasResponseModel>>
      getUnitDeficiencyAreasRequest() async {
    if (isInternet == IsInternet.connect) {
      try {
        Response response = await apiBaseHelperImplementation.get(
          endPoint: Constants.getDeficiency + "/?housing_item_id=3",
          headers: {
            'Authorization':
                '${getStorageData.readString(getStorageData.token)}',
          },
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(
              UnitDeficiencyAreasResponseModel.fromJson(response.data));
        } else {
          return Left(Failure(errorMessage: response.statusMessage.toString()));
        }
      } on DioException catch (e) {
        return Left(createFailure(e));
      }
    } else {
      var data = hiveMethodsProvider.getDataBaseData(
          hiveMethodsProvider.getHousingItemData,
          hiveMethodsProvider.getHousingItemKey);

      if (data != null) {
        return Right(UnitDeficiencyAreasResponseModel.fromJson(_parser(data)));
      } else {
        return Left(Failure(errorMessage: ''));
      }
    }
  }

  Future<Either<Failure, Loginmodel>> loginRequest(mapJson) async {
    try {
      Response response = await apiBaseHelperImplementation.post(
          endPoint: Constants.login, body: mapJson);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(Loginmodel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  Future<Either<Failure, InspectorModel>> createInspectorRequest(
      {required String name}) async {
    try {
      var mapJson = {"name": name};

      Response response = await ApiBaseHelperImplementation().post(
        endPoint: Constants.createInspector,
        body: mapJson,
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(InspectorModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  Future<Either<Failure, ImageResponseModel>> getImageUploadRequest(
      {required String filePath}) async {
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(filePath),
      });

      Response response = await apiBaseHelperImplementation.post(
        endPoint: "/inspection/api/images/upload/",
        body: formData,
        headers: {
          'Authorization': GetStorageData().readString('token'),
          'Origin':
              'https://${getStorageData.readString(getStorageData.baseURL)}/',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(ImageResponseModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  Future<Either<Failure, PropertyModel>> getPropertyInfo() async {
    if (isInternet == IsInternet.connect) {
      try {
        Response response = await apiBaseHelperImplementation
            .get(endPoint: Constants.propertyInfo, headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
        });
        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(PropertyModel.fromJson(response.data));
        } else {
          return Left(Failure(errorMessage: response.statusMessage.toString()));
        }
      } on DioException catch (e) {
        return Left(createFailure(e));
      }
    } else {
      var data = hiveMethodsProvider.getDataBaseData(
          hiveMethodsProvider.getPropertiesData,
          hiveMethodsProvider.getPropertiesKey);

      if (data != null) {
        return Right(PropertyModel.fromJson(_parser(data)));
      } else {
        return Left(Failure(errorMessage: ''));
      }
    }
  }

  Future<Either<Failure, CertificateModel>> getCertificatesRequest() async {
    if (isInternet == IsInternet.connect) {
      try {
        Response response = await apiBaseHelperImplementation.get(
          endPoint: Constants.certificates,
          headers: {
            'Authorization':
                '${getStorageData.readString(getStorageData.token)}',
          },
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(CertificateModel.fromJson(response.data));
        } else {
          return Left(Failure(errorMessage: response.statusMessage.toString()));
        }
      } on DioException catch (e) {
        return Left(createFailure(e));
      }
    } else {
      var data = hiveMethodsProvider.getDataBaseData(
          hiveMethodsProvider.getCertificateData,
          hiveMethodsProvider.getCertificateKey);

      if (data != null) {
        return Right(CertificateModel.fromJson(_parser(data)));
      } else {
        return Left(Failure(errorMessage: ''));
      }
    }
  }

  Future<Either<Failure, GetBuildingTypeResponseModel>>
      getBuildingTypeRequest() async {
    if (isInternet == IsInternet.connect) {
      try {
        Response response = await apiBaseHelperImplementation.get(
          endPoint: Constants.getBuildingType,
          headers: {
            'Authorization':
                '${getStorageData.readString(getStorageData.token)}',
          },
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(GetBuildingTypeResponseModel.fromJson(response.data));
        } else {
          return Left(Failure(errorMessage: response.statusMessage.toString()));
        }
      } on DioException catch (e) {
        return Left(createFailure(e));
      }
    } else {
      var data = hiveMethodsProvider.getDataBaseData(
          hiveMethodsProvider.getBuildingTypeData,
          hiveMethodsProvider.getBuildingTypeKey);

      if (data != null) {
        return Right(GetBuildingTypeResponseModel.fromJson(_parser(data)));
      } else {
        return Left(Failure(errorMessage: ''));
      }
    }
  }

  Future<Either<Failure, CreateBuildingResponseModel>> createBuildingsRequest(
      {required CreateBuildingRequestModel createBuildingRequestModel}) async {
    try {
      Response response = await apiBaseHelperImplementation.post(
        endPoint: Constants.createBuildings,
        body: createBuildingRequestModel.toJson(),
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(CreateBuildingResponseModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  Future<Either<Failure, BuildingModel>> getBuildingInfo(id) async {
    try {
      Response response = await apiBaseHelperImplementation.get(
        endPoint: Constants.buildings,
        queryParameter: {"property_id": id},
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(BuildingModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  Future<Either<Failure, CreateInspectionModel>> createUnitInspectionRequest(
      {required inspectionJson,
      required propertyJson,
      required buildingJson,
      required unitJson,
      required certificateList,
      required deficiencyList}) async {
    try {
      var formData = {
        "inspection": inspectionJson,
        "property": propertyJson,
        "building": buildingJson,
        "unit": unitJson,
        "certificates": certificateList,
        "deficiency_inspections": deficiencyList
      };
      Response response = await apiBaseHelperImplementation.post(
        endPoint: Constants.createInspection,
        body: formData,
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}'
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(CreateInspectionModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  Future<Either<Failure, dynamic>> createInspection(
      {required CreateInspectionRequestModel
          createInspectionRequestModel}) async {
    try {
      Response response = await apiBaseHelperImplementation.post(
        endPoint: Constants.createInspection,
        body: createInspectionRequestModel.toJson(),
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}'
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(true);
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  Map<String, dynamic> _parser(dynamic hiveMap) {
    final jsonString = jsonEncode(hiveMap);
    return jsonDecode(jsonString);
  }
}
