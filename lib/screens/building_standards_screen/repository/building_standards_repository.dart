import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';

class BuildingStandardsRepository {
  final ApiProviders _provider = ApiProviders();

  BuildingStandardsRepository();

  Future<Either<Failure, DeficiencyAreasResponseModel>>
      getDeficiencyAreas() async {
    var response = await _provider.getDeficiencyAreasRequest();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
