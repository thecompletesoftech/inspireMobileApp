import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:public_housing/background_services/background_service.dart';

StreamSubscription<List<ConnectivityResult>>? subscription;

enum IsInternet { initial, connect, failed }

IsInternet isInternet = IsInternet.initial;

class InternetConnectivity {
  isInternetCheck() {
    isInternet = IsInternet.initial;
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.ethernet)) {
        await initializeService();
        // await listenForNotificationData();
        isInternet = IsInternet.connect;
      } else if (result.contains(ConnectivityResult.none)) {
        FlutterBackgroundService().invoke("stopService");
        isInternet = IsInternet.failed;
      }
    });
  }
}
