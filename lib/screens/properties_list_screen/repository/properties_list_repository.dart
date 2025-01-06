import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart';

class PropertiesListRepository {
  final ApiProviders _provider = ApiProviders();

  PropertiesListRepository();

  Future<Either<Failure, DailySchedulesResponseModel>> getDailySchedules(
      {DateTime? startDate, DateTime? endDate}) async {
    var response = await _provider.getDailySchedulesRequest(
        startDate: startDate, endDate: endDate);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
