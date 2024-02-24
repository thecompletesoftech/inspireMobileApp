import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/screens/auth/model/LoginModel.dart';

import '../../../api/provider/status_objects.dart';

class LoginRepository {
  final ApiProviders _provider = ApiProviders();

  LoginRepository();

  Future<Either<Failure, Loginmodel>> login(mapjson) async {
    var response = await _provider.login(mapjson);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
