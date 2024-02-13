import 'dart:convert';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/languages/language.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api_authentication/get_token_account.dart';
import '../../../api_authentication/login_account_direct_request.dart';
import '../../../screens/property_screen/property_screen.dart';

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
      Get.offAllNamed(PropertyScreen.routes);
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
// create account demo--------->
  // createNewAccount() async {
  //   try {
  //     tokenAccount = await createAccount(
  //       name: "rishi",
  //       password: "Rishu@123",
  //       surname: "singh",
  //       email: "singh123@gmail.com",
  //       phoneNumber: "7845129601",
  //       address: "althan",
  //       zipcode: "394221",
  //       unitno: "1245",
  //       city: "Surat",
  //     );

  //     if (tokenAccount != null) {
  //       saveAccount(tokenAccount!);
  //     }
  //     return tokenAccount;
  //   } catch (e, st) {
  //     log("----- >>>  ${st}");
  //     String title = "Error";
  //     String message = "Something went wrong, please check your internet";
  //     if (e.toString().contains("CA104")) {
  //       title = "Error with the Email";
  //       message =
  //           "Oops! It seems like that email is already registered. Please try another email or log in if you already have an account";
  //     }
  //     if (e.toString().contains("CP101")) {
  //       title = "Error with the Phone";
  //       message =
  //           "Oops! It seems like that phone is already registered. Please try another phone or log in if you already have an account";
  //     }
  //     print(e);
  //     _dialogException(title: title, message: message);
  //     return null;
  //   }
  // }
//---------------->

  // _dialogException({required String title, required String message}) {
  //   Get.snackbar("", "",
  //       titleText: Text(title,
  //           style: TextStyle(
  //               color: Colors.red[900],
  //               fontSize: 19,
  //               fontWeight: FontWeight.bold)),
  //       backgroundColor: Colors.white,
  //       messageText: Text(message,
  //           style: TextStyle(
  //             color: Colors.black87,
  //             fontSize: 17,
  //           )),
  //       duration: Duration(seconds: 3),
  //       boxShadows: [
  //         BoxShadow(
  //             color: Colors.grey.withOpacity(0.5),
  //             spreadRadius: 5,
  //             blurRadius: 7,
  //             offset: const Offset(0, 3))
  //       ],
  //       snackStyle: SnackStyle.FLOATING);
  // }

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
