import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    iosConfiguration: IosConfiguration(
        autoStart: true, onForeground: onStart, onBackground: onIosBackground),
    androidConfiguration: AndroidConfiguration(
        autoStart: true, onStart: onStart, isForegroundMode: true),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance bgService) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  return true;
}

@pragma("vm:entry-point")
void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  if (service is AndroidServiceInstance) {
    if (await service.isForegroundService()) {
      service.setForegroundNotificationInfo(
          title: "INSPIRE DATA SYNC SERVICE", content: "INSPIRE DATA SYNC");
    }
  }

  service.invoke("update");
}

// listenForNotificationData() {
//   bgServiceInstance.on('update').listen((event) async {
//     print('listenForNotificationData:-----------> $event');
//   }, onError: (e, s) {
//     print('error listening for updates:-----------> $e, $s');
//   }, onDone: () {
//     print('background listen closed:----------->');
//   });
// }