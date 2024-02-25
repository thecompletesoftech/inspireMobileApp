import 'dart:convert';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/languages/language.dart';
import 'package:public_housing/screens/auth/model/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api_authentication/get_token_account.dart';
import '../../../api_authentication/login_account_direct_request.dart';
import '../../building_inspection_screen/building_inspection_screen.dart';
import '../repository/log_repo.dart';

class SigningController extends BaseController {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool checked = false;
  bool isEmail = false;
  bool isPass = false;
  TokenAccount? tokenAccount;
  var hide = true;
  LoginRepository loginrepo = LoginRepository();
  var islogin = false.obs;

  loginApiCallcarecart() async {
    String user = email.text;
    String password = pass.text;
    try {
      TokenAccount tokenAccount = await loginAccount(user, password);
      print("account token" + tokenAccount.toString());
      saveAccountcarecart(tokenAccount);
      getStorageData.saveString(getStorageData.isLogin, true);
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
    // FormData formData = FormData.fromMap({
    //   'email': email.text.toString().toLowerCase().trim(),
    //   'password': utils.generateMd5(pass.text.toString().trim()),
    // });
    // // final data = await APIFunction().apiCall(
    // //     apiName: Constants.addBankAccount,
    // //     context: Get.context!,
    // //     params: formData,
    // //     token: getStorageData.readObject(getStorageData.token));
    // //
    // // BankDModel model = BankDModel.fromJson(data);
    // // if (model.responseCode == 1) {
    // getStorageData.saveString(getStorageData.isLogin, true);
    // //   Get.back(result: "date");
    // // } else {
    // //   utils.showSnackBar(context: Get.context!, message: model.responseMsg!);
    // // }
    // Get.offAllNamed(PropertyScreen.routes);
  }

  validation() {
    if (utils.isValidationEmpty(email.text.trim())) {
      utils.showSnackBar(
          context: Get.context!,
          message: Languages.of(Get.context!)!.pleaseEnterEmail);
    }
    // else if (!utils.emailValidator(email.text.trim())) {
    //   utils.showSnackBar(
    //       context: Get.context!,
    //       message: Languages.of(Get.context!)!.pleaseEnterValidEmail);
    // }

    else if (utils.isValidationEmpty(pass.text.trim())) {
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
      loginApiCallcarecart();
    }
  }

  saveAccountcarecart(TokenAccount tokenac) async {
    getStorageData.saveString(getStorageData.token, tokenac.token);
    getStorageData.saveString(
        getStorageData.account, jsonEncode(tokenac.account.toJson()));
    // tokenAccount = tokenac;
  }

  //inspection api data

  saveAccount(token, name) async {
    getStorageData.saveString(getStorageData.token, token);
    getStorageData.saveString(getStorageData.inspectorname, name);
  }

  login() async {
    var map = {"username": email.text, "password": pass.text};
    var response = await loginrepo.login(map);
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (Loginmodel r) {
      getStorageData.saveString(getStorageData.isLogin, true);
      saveAccount(r.token.toString(), r.username);
      Get.offAllNamed(BuildingInspectionScreen.routes);
    });
    update();
  }
}
