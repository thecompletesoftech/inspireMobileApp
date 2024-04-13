import 'dart:async';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:public_housing/commons/all.dart';

import '../internet_services/internet_service.dart';
import '../screens/deficiencies_inside_screen/controller/deficiencies_inside_controller.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart, isForegroundMode: true, autoStart: true));
}

@pragma("vm:entry-point")
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma("vm:entry-point")
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    // check backgroud service running // abhishek
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  DeficienciesInsideController _controller =
      Get.put(DeficienciesInsideController());

  if (service is AndroidServiceInstance) {
    if (await service.isForegroundService()) {
      service.setForegroundNotificationInfo(
          title: "INSPIRE DATA SYNC SERVICE", content: "INSPIRE DATA SYNC");
    }
  }

  //abhishek code for checking bg service is working

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    if (await service.isForegroundService()) {
      Timer.periodic(const Duration(seconds: 1), (timer) async {
      await  InternetConnectivity().isInternetCheck();
      // print("isinternet "+ isInternet.toString());
    if(isInternet == IsInternet.connect){
      _controller.uploadlocalimagetoserver();
        flutterLocalNotificationsPlugin.show(
          1,
          'COOL SERVICE',
          'Awesome ${DateTime.now()}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              "1",
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );
    }
    // else{
    //     service.invoke("stopService");
    // }
      });
    }
  }
  print("background service is running...");

  service.invoke("update");
}
