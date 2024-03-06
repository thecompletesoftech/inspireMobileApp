import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:public_housing/api/api_helper/api_base_helper_implementation.dart';
import 'package:public_housing/api/api_helper/dio_exceptions.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/commons/all.dart';
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

  ApiProviders();

  Future<Either<Failure, DeficiencyAreasResponseModel>>
      getDeficiencyAreasRequest({required bool isType}) async {
    try {
      String endPoint;

      if (isType) {
        endPoint =
            'inspection/api/deficiency_areas?housing_item_id=1&housing_item_id=2';
      } else {
        endPoint = 'inspection/api/deficiency_areas?housing_item_id=3';
      }

      Response response = await apiBaseHelperImplementation.get(
        endPoint: endPoint,
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

  Future<Either<Failure, UnitDeficiencyAreasResponseModel>>
      getunitDeficiencyAreasRequest() async {
    try {
      Response response = await apiBaseHelperImplementation.get(
        endPoint: Constants.getdeficieny + "/?housing_item_id=3",
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(UnitDeficiencyAreasResponseModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  Future<Either<Failure, Loginmodel>> login(mapjson) async {
    try {
      Response response = await apiBaseHelperImplementation.post(
          endPoint: Constants.login, body: mapjson);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(Loginmodel.fromJson(response.data));
      } else {
        print("asdsadas" + response.statusCode.toString());
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  Future<Either<Failure, InspectorModel>> createInspector(name) async {
    try {
      var mapjson = {"name": name};

      Response response = await apiBaseHelperImplementation.post(
        endPoint: Constants.createinspector,
        body: mapjson,
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(InspectorModel.fromJson(response.data));
      } else {
        print("asdsadas" + response.statusCode.toString());
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
        endPoint: "inspection/api/images/upload/",
        body: formData,
        headers: {
          'Authorization': GetStorageData().readString('token'),
          'Origin': 'https://inspections.dev.gccs.gilsonsoftware.com',
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
          .get(endPoint: Constants.propertyinfo, headers: {
        'Authorization': '${getStorageData.readString(getStorageData.token)}',
      });
      print("asdsad" + response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(PropertyModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  Future<Either<Failure, CertificateModel>> getCertificates() async {
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

  Future<Either<Failure, BuildingModel>> getBuildingInfo(id) async {
    try {
      Response response = await apiBaseHelperImplementation.get(
        endPoint: Constants.buildings,
        queryParameter: {"property_id": id},
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
        },
      );
      print("asdxsdsa" + id.toString());
      print("asddsd" + response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(BuildingModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(createFailure(e));
    }
  }

  Future<Either<Failure, CreateinspectionModel>> createinspection(
      {required insepctionjson,
      required propertyjson,
      required buildingjson,
      required unitjson,
      required certificatelist,
      required deficiencylist}) async {
    try {
      var formData = {
        "inspection": insepctionjson,
        "property": propertyjson,
        "building": buildingjson,
        "unit": unitjson,
        "certificates": certificatelist,
        "deficiency_inspections": deficiencylist
      };
      print("formdata" + jsonEncode(formData).toString());
      Response response = await apiBaseHelperImplementation.post(
        endPoint: Constants.createinspection,
        body: formData,
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}'
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(CreateinspectionModel.fromJson(response.data));
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
        endPoint: Constants.createinspection,
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
}
