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
