import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:public_housing/api/api_helper/api_base_helper_implementation.dart';
import 'package:public_housing/api/api_helper/dio_exceptions.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/auth/model/inspector_model.dart';
import 'package:public_housing/screens/auth/model/login_model.dart';
import 'package:public_housing/screens/building_inspection_screen/models/certificate_model.dart';
import 'package:public_housing/screens/building_inspection_screen/models/create_building_request_model.dart';
import 'package:public_housing/screens/building_inspection_screen/models/create_building_response_model.dart';
import 'package:public_housing/screens/building_inspection_screen/models/get_building_type_response_model.dart';
import 'package:public_housing/screens/building_inspection_screen/models/property_model.dart';
import 'package:public_housing/screens/building_inspection_summary/model/create_inspection_request_model.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/models/image_response_model.dart';
import 'package:public_housing/screens/inspection_list_screen/model/complete_inspection_res_model.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_req_model.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_res_model.dart';
import 'package:public_housing/screens/inspection_unit_summary_screen/model/finding_type_res_model.dart';
import 'package:public_housing/screens/inspection_unit_summary_screen/model/result_res_model.dart';
import 'package:public_housing/screens/manual_unit_inspection_screen/model/inspection_type_res_model.dart';
import 'package:public_housing/screens/no_show_screen/model/no_show_req_model.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart';
import 'package:public_housing/screens/special_amenities_screen/model/special_amenities_req_model.dart';
import 'package:public_housing/screens/unit_inspection_summary_screen/models/create_inspection_model.dart';
import 'package:public_housing/screens/building_inspection_screen/models/building_model.dart';

class ApiProviders extends BaseController {
  ApiBaseHelperImplementation apiBaseHelperImplementation =
      ApiBaseHelperImplementation();

  ApiProviders();

  Future<Either<Failure, DeficiencyAreasResponseModel>>
      getDeficiencyAreasRequest() async {
    try {
      Response response = await apiBaseHelperImplementation.get(
        endPoint:
            '/inspection/api/deficiency_areas?housing_item_id=1&housing_item_id=2',
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
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
  }

  Future<Either<Failure, DeficiencyAreasResponseModel>>
      getUnitDeficiencyAreasRequest() async {
    try {
      Response response = await apiBaseHelperImplementation.get(
        endPoint: Constants.getDeficiency + "/?housing_item_id=3",
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
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
  }

  Future<Either<Failure, DeficiencyAreasResponseModel>>
      getInspectionDeficiencyAreasRequest() async {
    try {
      Response response = await apiBaseHelperImplementation.get(
        endPoint: Constants.getDeficiency,
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
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
  }

  Future<Either<Failure, CertificateModel>> getCertificatesRequest() async {
    try {
      Response response = await apiBaseHelperImplementation.get(
        endPoint: Constants.certificates,
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
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
  }

  Future<Either<Failure, GetBuildingTypeResponseModel>>
      getBuildingTypeRequest() async {
    try {
      Response response = await apiBaseHelperImplementation.get(
        endPoint: Constants.getBuildingType,
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
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
    createInspectionRequestModel.inspection?.date =
        formatDateWithTimeZone(createInspectionRequestModel.inspection?.date);

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

  Future<Either<Failure, DailySchedulesResponseModel>>
      getDailySchedulesRequest({
    required int page,
    required int type,
    required String endDate,
    required String startDate,
    required int itemsPerPage,
  }) async {
    try {
      Map<String, dynamic> queryParameter = {};
      queryParameter = {
        "items_per_page": itemsPerPage,
        "start_date": startDate,
        "end_date": endDate,
        "page": page,
        "type": type,
      };

      Response response = await apiBaseHelperImplementation.get(
        endPoint: Constants.dailySchedules,
        // isTrue: true,
        queryParameter: queryParameter,
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(DailySchedulesResponseModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  Future<Either<Failure, dynamic>> createInspectionRequest(
      {required InspectionReqModel inspectionModel}) async {
    Map<String, dynamic> data =
        inspectionModel.inspection?.specialAmenities?.toJson() ?? {};
    data.removeWhere((key, value) {
      return value == null;
    });
    var filterData = inspectionModel.toJson();
    filterData['inspection']['special_amenities'] = data;
    try {
      Response response = await apiBaseHelperImplementation.post(
        endPoint: Constants.section8Create,
        body: filterData,
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

  Future<Either<Failure, dynamic>> noShowCreateInspectionRequest(
      {required NoShowReqModel dataReq}) async {
    try {
      Response response = await apiBaseHelperImplementation.post(
        endPoint: Constants.section8Create,
        body: dataReq.toJson(),
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

  Future<Either<Failure, InspectionResponseModel>>
      getInspectionSchedulesRequest({
    required int page,
    required int itemsPerPage,
    required int type,
    required String endDate,
    required String startDate,
  }) async {
    try {
      Map<String, dynamic> queryParameter = {};
      queryParameter = {
        "items_per_page": itemsPerPage,
        "page": page,
        "type": type,
        "start_date": startDate,
        "end_date": endDate,
      };

      Response response = await apiBaseHelperImplementation.get(
        endPoint: Constants.dailySchedules,
        queryParameter: queryParameter,
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(InspectionResponseModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  Future<Either<Failure, GetFindingTypeResponseModel>>
      getFindingTypeRequest() async {
    try {
      Response response = await apiBaseHelperImplementation.get(
        endPoint: Constants.findingType,
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(GetFindingTypeResponseModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  Future<Either<Failure, CompleteInspectionResModel>>
      getCompleteInspectionSchedulesRequest({
    required int type,
    required int page,
    required int itemsPerPage,
  }) async {
    try {
      Map<String, dynamic> queryParameter = {};
      queryParameter = {
        "type": type,
        "page": page,
        "items_per_page": itemsPerPage,
      };

      Response response = await apiBaseHelperImplementation.get(
        endPoint: Constants.completeInspection,
        queryParameter: queryParameter,
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(CompleteInspectionResModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  Future<Either<Failure, InspectionTypeResModel>>
      getInspectionTypeRequest() async {
    try {
      Response response = await apiBaseHelperImplementation.get(
        endPoint: Constants.inspectionType,
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(InspectionTypeResModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  Future<Either<Failure, ResultResponseModel>> getResultsRequest() async {
    try {
      Response response = await apiBaseHelperImplementation.get(
        endPoint: Constants.results,
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(ResultResponseModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  String formatDateWithTimeZone(DateTime date) {
    String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(date);
    Duration timeZoneOffset = date.timeZoneOffset;
    String sign = timeZoneOffset.isNegative ? '-' : '+';
    String hours = timeZoneOffset.inHours.abs().toString().padLeft(2, '0');
    String minutes =
        (timeZoneOffset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    return '$formattedDate$sign$hours:$minutes';
  }
}
