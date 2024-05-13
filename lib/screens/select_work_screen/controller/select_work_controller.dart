import 'dart:convert';

import 'package:public_housing/Models/accountmodel/account_model.dart';
import 'package:public_housing/commons/all.dart';

class SelectWorkController extends BaseController {
  Account? account;

  @override
  void onInit() {
    getAccount();
    super.onInit();
  }

  getAccount() async {
    var accountData = await getStorageData.readString(getStorageData.account);
    account = Account.fromJson(jsonDecode(accountData.toString()));
    update();
  }
}
