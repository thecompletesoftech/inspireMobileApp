import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/models/image_response_model.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_req_model.dart';

class DeficienciesInsideRepository {
  final ApiProviders _provider = ApiProviders();

  DeficienciesInsideRepository();

  Future<Either<Failure, ImageResponseModel>> getImageUpload(
      {required String filePath}) async {
    var response = await _provider.getImageUploadRequest(filePath: filePath);
    return response.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<Failure, dynamic>> createInspection(
      {required InspectionReqModel inspectionModel}) async {
    var response = await _provider.createInspectionRequest(
        inspectionModel: inspectionModel);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
