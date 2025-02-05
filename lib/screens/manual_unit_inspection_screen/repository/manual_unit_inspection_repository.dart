import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/screens/manual_unit_inspection_screen/model/inspection_type_res_model.dart';

class ManualUnitInspectionRepository {
  final ApiProviders _provider = ApiProviders();

  ManualUnitInspectionRepository();

  Future<Either<Failure, InspectionTypeResModel>> getInspectionType() async {
    var response = await _provider.getInspectionTypeRequest();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
