import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/screens/building_inspection_summary/model/create_inspection_request_model.dart';

class BuildingInspectionSummaryRepository {
  final ApiProviders _provider = ApiProviders();

  BuildingInspectionSummaryRepository();

  Future<Either<Failure, dynamic>> getDeficiencyAreas(
      {required CreateInspectionRequestModel
          createInspectionRequestModel}) async {
    var response = await _provider.createInspection(
        createInspectionRequestModel: createInspectionRequestModel);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
