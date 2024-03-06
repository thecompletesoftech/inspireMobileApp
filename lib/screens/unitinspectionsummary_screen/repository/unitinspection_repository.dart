import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import '../models/CreateInspectionmodel.dart';

class UnitsummaryRepository {
  final ApiProviders _provider = ApiProviders();

  UnitsummaryRepository();

  Future<Either<Failure, CreateinspectionModel>> createinspection(
      {required insepctionjsons,
      required propertyjsons,
      required buildingjsons,
      required unitjsons,
      required certificatelists,
      required deficiencylists}) async {
    var response = await _provider.createinspection(
        buildingjson: buildingjsons,
        certificatelist: certificatelists,
        deficiencylist: deficiencylists,
        insepctionjson: insepctionjsons,
        propertyjson: propertyjsons,
        unitjson: unitjsons);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
