import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/screens/inspection_unit_summary_screen/model/finding_type_res_model.dart';
import 'package:public_housing/screens/inspection_unit_summary_screen/model/result_res_model.dart';

class InspectionUnitSummaryRepository {
  final ApiProviders _provider = ApiProviders();

  InspectionUnitSummaryRepository();

  Future<Either<Failure, GetFindingTypeResponseModel>> getFindingType() async {
    var response = await _provider.getFindingTypeRequest();
    return response.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<Failure, ResultResponseModel>> getResults() async {
    var response = await _provider.getResultsRequest();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
