import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/screens/auth/model/login_model.dart';

import '../../../api/provider/status_objects.dart';
import '../model/inspector_model.dart';

class LoginRepository {
  final ApiProviders _provider = ApiProviders();

  LoginRepository();

  Future<Either<Failure, Loginmodel>> login(mapJson) async {
    var response = await _provider.loginRequest(mapJson);
    return response.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<Failure, InspectorModel>> createInspector(
      {required String name}) async {
    var response = await _provider.createInspectorRequest(name: name);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
