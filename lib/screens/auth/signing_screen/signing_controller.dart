import 'dart:convert';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/languages/language.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api_authentication/get_token_account.dart';
import '../../../api_authentication/login_account_direct_request.dart';
import '../../building_inspection_screen/building_inspection_screen.dart';

class SigningController extends BaseController {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool checked = false;
  bool isEmail = false;
  bool isPass = false;
  TokenAccount? tokenAccount;
  var hide = true;

  loginApiCall() async {
    String user = email.text;
    String password = pass.text;
    try {
      TokenAccount tokenAccount = await loginAccount(user, password);
      print("account token" + tokenAccount.toString());
      saveAccount(tokenAccount);
      getStorageData.saveString(getStorageData.isLogin, true);
      // Get.offAllNamed(PropertyScreen.routes);
      Get.offAllNamed(BuildingInspectionScreen.routes);
      return tokenAccount;
    } catch (e) {
      print(e.toString());
      String title = "Error";
      String errorMessage = "An error has occurred";
      if (e.toString().contains("LA1000")) {
        title = "Account not found";
        errorMessage = "Email or password incorrect";
      }
      if (e.toString().contains("LA1002")) {
        // print(e);
        errorMessage =
            "We're sorry, but it seems that this account has been deleted. If you believe this is an error or need further assistance, please contact our support team";
        title = "Account deleted";
      }
      Get.snackbar("", "",
          titleText: Text(title,
              style: TextStyle(
                  color: Colors.red[900],
                  fontSize: 19,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          messageText: Text(errorMessage,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 17,
              )),
          duration: Duration(seconds: 10),
          boxShadows: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3))
          ],
          snackStyle: SnackStyle.FLOATING);
      return null;
    }
  }

  validation() {
    if (utils.isValidationEmpty(email.text.trim())) {
      utils.showSnackBar(
          context: Get.context!,
          message: Languages.of(Get.context!)!.pleaseEnterEmail);
    } else if (!utils.emailValidator(email.text.trim())) {
      utils.showSnackBar(
          context: Get.context!,
          message: Languages.of(Get.context!)!.pleaseEnterValidEmail);
    } else if (utils.isValidationEmpty(pass.text.trim())) {
      utils.showSnackBar(
          context: Get.context!,
          message: Languages.of(Get.context!)!.pleaseEnterPassword);
    }
    // else if (!utils.passwordValidator(pass.text.trim())) {
    //   utils.showSnackBar(
    //       context: Get.context!,
    //       message: Languages.of(Get.context!)!.pleaseEnterValidPassword);
    // }
    else {
      // checked = true;
      loginApiCall();
    }
  }

  saveAccount(TokenAccount tokenAccount) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', tokenAccount.token);
    await sharedPreferences.setString(
        'accountModel', jsonEncode(tokenAccount.account.toJson()));
    print(
        "shared pref" + sharedPreferences.getString('accountModel').toString());
    tokenAccount = tokenAccount;
  }
}
