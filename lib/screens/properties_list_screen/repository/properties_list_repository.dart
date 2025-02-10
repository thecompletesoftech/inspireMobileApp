import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/screens/properties_list_screen/model/daily_schedules_res_model.dart';

class PropertiesListRepository {
  final ApiProviders _provider = ApiProviders();

  PropertiesListRepository();

  Future<Either<Failure, DailySchedulesResponseModel>> getDailySchedules({
    required int page,
    required int type,
    required String endDate,
    required String startDate,
    required int itemsPerPage,
  }) async {
    var response = await _provider.getDailySchedulesRequest(
      type: type,
      page: page,
      endDate: endDate,
      startDate: startDate,
      itemsPerPage: itemsPerPage,
    );
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
