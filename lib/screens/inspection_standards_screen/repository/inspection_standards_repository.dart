import 'package:dartz/dartz.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';
import '../../../api/provider/status_objects.dart';
import 'package:public_housing/api/provider/api_provider.dart';

class InspectionStandardsRepository {
  final ApiProviders _provider = ApiProviders();

  InspectionStandardsRepository();

  Future<Either<Failure, DeficiencyAreasResponseModel>>
      getInspectionDeficiencyAreas() async {
    var response = await _provider.getInspectionDeficiencyAreasRequest();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
