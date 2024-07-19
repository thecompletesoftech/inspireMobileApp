import 'package:public_housing/Models/accountmodel/account_model.dart';
import 'package:public_housing/commons/all.dart';

class SelectWorkController extends BaseController {
  Account? account;

  @override
  void onInit() {
    () async {
      account = await getAccount();
    }();
    super.onInit();
  }
}
