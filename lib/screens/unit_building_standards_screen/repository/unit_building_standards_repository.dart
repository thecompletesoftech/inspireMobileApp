import 'package:dartz/dartz.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import '../../../api/provider/status_objects.dart';
import 'package:public_housing/api/provider/api_provider.dart';

class UnitBuildingStandardsRepository {
  final ApiProviders _provider = ApiProviders();

  UnitBuildingStandardsRepository();

  Future<Either<Failure, DeficiencyAreasResponseModel>>
      getDeficiencyAreas() async {
    var response = await _provider.getUnitDeficiencyAreasRequest();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
