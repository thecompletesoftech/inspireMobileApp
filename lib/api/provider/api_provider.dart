import 'package:dartz/dartz.dart';
import 'package:public_housing/api/api_helper/api_base_helper_implementation.dart';
import 'package:public_housing/api/api_helper/dio_exceptions.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/models/image_response_model.dart';

import '../../screens/auth/model/LoginModel.dart';

class ApiProviders {
  ApiBaseHelperImplementation apiBaseHelperImplementation =
      ApiBaseHelperImplementation();

  ApiProviders();

  Future<Either<Failure, DeficiencyAreasResponseModel>>
      getDeficiencyAreasRequest() async {
    try {
      Response response = await apiBaseHelperImplementation.get(
        endPoint: "inspection/api/deficiency_areas/",
        headers: {
          'Authorization': GetStorageData().readString('token'),
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
}
