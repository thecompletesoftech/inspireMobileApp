import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/screens/building_inspection_screen/models/certificate_model.dart';

import '../models/building_model.dart';
import '../models/property_model.dart';

class BuildingInspectionRepository {
  final ApiProviders _provider = ApiProviders();

  BuildingInspectionRepository();

  Future<Either<Failure, PropertyModel>> getPropertyInfoApi() async {
    var response = await _provider.getPropertyInfo();
    return response.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<Failure, CertificateModel>> getCertificates() async {
    var response = await _provider.getCertificates();
    return response.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<Failure, BuildingModel>> getBuilding(id) async {
    var response = await _provider.getBuildingInfo(id);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
