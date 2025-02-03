import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/screens/inspection_list_screen/model/daily_schedules_res_model.dart';

class InspectionListRepository {
  final ApiProviders _provider = ApiProviders();

  InspectionListRepository();

  Future<Either<Failure, InspectionResponseModel>> getInspectionSchedules({
    required int page,
    required int itemsPerPage,
    required int type,
    required String endDate,
    required String startDate,
  }) async {
    var response = await _provider.getInspectionSchedulesRequest(
      page: page,
      type: type,
      itemsPerPage: itemsPerPage,
      endDate: endDate,
      startDate: startDate,
    );
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
