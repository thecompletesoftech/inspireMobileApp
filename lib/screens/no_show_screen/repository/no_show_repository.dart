import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/screens/no_show_screen/model/no_show_req_model.dart';

class NoShowRepository {
  final ApiProviders _provider = ApiProviders();

  NoShowRepository();

  Future<Either<Failure, dynamic>> noShowCreateInspection(
      {required NoShowReqModel dataReq}) async {
    var response =
        await _provider.noShowCreateInspectionRequest(dataReq: dataReq);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
