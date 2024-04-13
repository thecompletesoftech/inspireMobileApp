import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:public_housing/background_services/background_service.dart';

StreamSubscription<List<ConnectivityResult>>? subscription;
enum IsInternet { initial, connect, failed }
IsInternet isInternet = IsInternet.initial;

class InternetConnectivity {
  isInternetCheck() {
    // print("checking internet");
    // isInternet = IsInternet.initial;
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {

      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.ethernet)) {
        isInternet = IsInternet.connect;
        if(isInternet == IsInternet.connect){
        //  await initializeService();
        }
      print("net is conneted.......");
      } else if (result.contains(ConnectivityResult.none)) {
        isInternet = IsInternet.failed;
         print("net is not conneted.......");
      }
    });
    // print("isinternet"+ isInternet.toString());
  }
}
