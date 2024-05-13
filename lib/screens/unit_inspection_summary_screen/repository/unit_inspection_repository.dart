import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/screens/unit_inspection_summary_screen/models/create_inspection_model.dart';

class UnitSummaryRepository {
  final ApiProviders _provider = ApiProviders();

  UnitSummaryRepository();

  Future<Either<Failure, CreateInspectionModel>> createInspections(
      {required inspectionJson,
      required propertyJson,
      required buildingJson,
      required unitJson,
      required certificateList,
      required deficiencyList}) async {
    var response = await _provider.createUnitInspectionRequest(
        buildingJson: buildingJson,
        certificateList: certificateList,
        deficiencyList: deficiencyList,
        inspectionJson: inspectionJson,
        propertyJson: propertyJson,
        unitJson: unitJson);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
