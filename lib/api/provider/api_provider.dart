import 'package:dartz/dartz.dart';

import 'package:public_housing/api/api_helper/api_base_helper_implementation.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_inspection_screen/models/property_model.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';

import '../../screens/auth/model/LoginModel.dart';
import '../../screens/building_inspection_screen/models/building_model.dart';
import '../../screens/building_inspection_screen/models/certificate_model.dart';

class ApiProviders extends BaseController {
  ApiBaseHelperImplementation apiBaseHelperImplementation =
      ApiBaseHelperImplementation();

  ApiProviders();

  Future<Either<Failure, DeficiencyAreasResponseModel>>
      getDeficiencyAreasRequest() async {
    try {
      Response response = await apiBaseHelperImplementation.get(
        endPoint: "deficiency_areas/",
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
      return Left(Failure(errorMessage: e.response?.data['message']));
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
      return Left(Failure(errorMessage: e.response?.data['detail']));
    }
  }

  Future<Either<Failure, PropertyModel>> getpropetyinfo() async {
    try {
      print("gettoken" +
          getStorageData.readString(getStorageData.token).toString());
      Response response = await apiBaseHelperImplementation.get(
        endPoint: Constants.propertyinfo,
        headers: {
          'Authorization': '${getStorageData.readString(getStorageData.token)}',
        },
      );
      print("asddas" + response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(PropertyModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(errorMessage: e.response?.data['message']));
    }
  }

  Future<Either<Failure, CertificateModel>> getCertificates() async {
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
      return Left(Failure(errorMessage: e.response?.data['message']));
    }
  }

  Future<Either<Failure, BuildingModel>> getBuildinginfo() async {
    try {
      Response response = await apiBaseHelperImplementation.get(
        endPoint: Constants.buildings,
        headers: {
          'Authorization':
              '${getStorageData.readString(getStorageData.token)}',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(BuildingModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(errorMessage: e.response?.data['message']));
    }
  }
}
