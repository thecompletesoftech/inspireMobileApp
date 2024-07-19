import 'package:get/get.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/offline_database_services/offline_hive_database_service.dart';
import 'package:public_housing/screens/splashscreen/controller/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() async {
    await Get.putAsync<HiveMethodsProvider>(() async {
      final HiveMethodsProvider service = HiveMethodsProvider();
      await service.setUpHive();
      return service;
    });
    Get.put<SplashController>(SplashController());
  }
}
