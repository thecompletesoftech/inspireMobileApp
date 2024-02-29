import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/api/provider/status_objects.dart';

import '../models/deficiency_areas_res_model.dart';

class BuildingStandardsRepository {
  final ApiProviders _provider = ApiProviders();

  BuildingStandardsRepository();

  Future<Either<Failure, UnitDeficiencyAreasResponseModel>>
      getDeficiencyAreas() async {
    var response = await _provider.getunitDeficiencyAreasRequest();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
