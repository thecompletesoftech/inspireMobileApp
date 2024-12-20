import 'package:dartz/dartz.dart';
import '../../../api/provider/status_objects.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/screens/unit_building_standards_screen/models/unit_deficiency_areas_res_model.dart';

class UnitBuildingStandardsRepository {
  final ApiProviders _provider = ApiProviders();

  UnitBuildingStandardsRepository();

  Future<Either<Failure, UnitDeficiencyAreasResponseModel>>
      getDeficiencyAreas() async {
    var response = await _provider.getUnitDeficiencyAreasRequest();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
