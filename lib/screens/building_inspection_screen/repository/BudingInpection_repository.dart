import 'package:dartz/dartz.dart';
import 'package:public_housing/api/provider/api_provider.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/screens/building_inspection_screen/models/certificate_model.dart';

import '../models/building_model.dart';
import '../models/property_model.dart';

class BudingInpectionRepository {
  final ApiProviders _provider = ApiProviders();

  BudingInpectionRepository();

  Future<Either<Failure, PropertyModel>> getpropetyinfoapi() async {
    var response = await _provider.getpropetyinfo();
    return response.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<Failure, CertificateModel>> getcertificates() async {
    var response = await _provider.getCertificates();
    return response.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<Failure, BuildingModel>> getbuilding(id) async {
    var response = await _provider.getBuildinginfo(id);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
