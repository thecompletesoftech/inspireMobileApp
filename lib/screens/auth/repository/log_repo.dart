import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/screens/auth/model/LoginModel.dart';

import '../../../api/provider/status_objects.dart';
import '../model/Inspectormodel.dart';

class LoginRepository {
  final ApiProviders _provider = ApiProviders();

  LoginRepository();

  Future<Either<Failure, Loginmodel>> login(mapjson) async {
    var response = await _provider.login(mapjson);
    return response.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<Failure, InspectorModel>> createinspectorapi(name) async {
    var response = await _provider.createInspector(name);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
