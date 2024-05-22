import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/api/provider/status_objects.dart';

class PropertiesListRepository {
  final ApiProviders _provider = ApiProviders();

  PropertiesListRepository();

  Future<Either<Failure, String>> localStorageDataSet() async {
    var response = await _provider.localStorageDataSetRequest();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
