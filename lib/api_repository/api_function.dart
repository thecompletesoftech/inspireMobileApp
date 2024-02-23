import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'api_class.dart';
import '../commons/all.dart';
import '../languages/language.dart';

class APIFunction {
  Future<dynamic> apiCall({
    required String apiName,
    required BuildContext context,
    FormData? params,
    String? token = "",
    bool isLoading = true,
  }) async {
    printAction("params -------->>> ${params!.fields}");
    var response = await HttpUtil(token ?? "", isLoading, context).post(
      apiName,
      data: params,
    );

    return response;
  }
}

class GetAPIFunction {
  Future<dynamic> apiCall({
    required String apiName,
    required BuildContext context,
    FormData? params,
    String? token = "",
    bool isLoading = true,
  }) async {
    var response = await HttpUtil(token!, isLoading, context).get(
      apiName,
    );
    if (GetStorageData().readString('is_guest') != null &&
        GetStorageData().readString('is_guest') == "true") {
      if (response['ResponseCode'] == 0) {
        if (GetStorageData().containKey(GetStorageData().loginData)) {
          return response;
        } else {
          Utils().showSnackBar(
              context: context, message: Languages.of(context)!.guestError);
        }
      } else {
        return response;
      }
    } else {
      return response;
    }
  }
}

class ApidunctionGet {
  getApi(apiname, params, [type = true]) async {
    final box = GetStorage();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var url = Uri.parse(Constants.baseUrl + apiname);
        print(url);
        // print("token="+box.read("token"));
        print(params.toString());
        try {
          var userHeader = {
            "Content-type":
                type == true ? "application/json" : "multipart/form-data",
            "Authorization":
                box.read("token") == null ? "" : "Bearer " + box.read("token"),
            // "Accept-Language": box.read("lang") == 1 ? "en-Fr" : "en-Us"
          };
          // print("api header data" + userHeader.toString());
          var response = await http.post(url,
              body: jsonEncode(params), headers: userHeader);

          log("url===>" + url.toString());
          print("statuscode===>" + response.statusCode.toString());

          return response;
        } catch (e) {
          // Get.snackbar('Error'.tr, 'Something Went Wrong Try Again');
          log("catch execute on Api -- Error " + e.toString());
          return false;
        }
      }
    } on SocketException catch (_) {
      Get.snackbar('Error'.tr, 'Check your Internet');
    }
  }
}
