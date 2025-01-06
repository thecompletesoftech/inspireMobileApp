import 'dart:convert';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/languages/language.dart';
import 'package:public_housing/screens/auth/model/inspector_model.dart';
import 'package:public_housing/screens/properties_list_screen/screen/properties_list_screen.dart';
import '../../../../api_authentication/get_token_account.dart';
import '../../../../api_authentication/login_account_direct_request.dart';
import '../../repository/login_repository.dart';

class SigningController extends BaseController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController clientController = TextEditingController();
  LoginRepository loginRepository = LoginRepository();
  TokenAccount? tokenAccount;
  var islogin = false.obs;
  bool checked = false;
  bool isEmail = false;
  List clientList = [];
  bool isPass = false;
  var hide = true;

  @override
  void onInit() {
    // https://dcha.live.gccs.gilsonsoftware.com/auth/login/

    clientList = [
      {"title": 'Dev', "baseURL": "inspections.dev.gccs.gilsonsoftware.com"},
      {"title": 'Newport', "baseURL": "hacn.live.gccs.gilsonsoftware.com"},
      {
        "title": 'Chattanooga',
        "baseURL": "chattanooga.live.gccs.gilsonsoftware.com"
      },
      {"title": 'Marin', "baseURL": "marin.live.gccs.gilsonsoftware.com"},
      {"title": 'DCHA', "baseURL": "dcha.live.gccs.gilsonsoftware.com"},
      {"title": 'HACLA', "baseURL": "hacla.live.gccs.gilsonsoftware.com"},
      // {"title": 'HACLA DEV', "baseURL": "hacla.staging.gccs.gilsonsoftware.com"},
      {"title": 'KWHA', "baseURL": "kwha.live.gccs.gilsonsoftware.com"},
    ];
    update();
    super.onInit();
  }

  void clientSelectedValue(value) {
    clientController.text = value['title'];
    getStorageData.saveString(getStorageData.baseURL, value['baseURL']);
    getStorageData.saveString(getStorageData.clientName, value['title']);
  }

  loginApiCallCareCart() async {
    String user = emailController.text;
    String password = passController.text;
    try {
      TokenAccount tokenAccount = await loginAccount(user, password);
      print("account token" + tokenAccount.toString());
      saveAccountCareCart(tokenAccount);
      getStorageData.saveString(getStorageData.isLogin, true);
      // Get.offAllNamed(BuildingInspectionScreen.routes);
      // Get.offAllNamed(SelectWorkScreen.routes);
      Get.offAllNamed(PropertiesListScreen.routes);

      return tokenAccount;
    } catch (e) {
      print(e.toString());
      String title = "Error";
      String errorMessage = "An error has occurred";
      if (e.toString().contains("LA1000")) {
        title = "Account not found";
        errorMessage = "Email or password incorrect";
      }
      if (e.toString().contains("LA1001")) {
        title = "Account not found";
        errorMessage = "User name or password incorrect";
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
    if (utils.isValidationEmpty(emailController.text.trim())) {
      utils.showSnackBar(
          context: Get.context!,
          message: Languages.of(Get.context!)!.pleaseEnterEmail);
    } else if (utils.isValidationEmpty(passController.text.trim())) {
      utils.showSnackBar(
          context: Get.context!,
          message: Languages.of(Get.context!)!.pleaseEnterPassword);
    } else {
      loginApiCallCareCart();
    }
  }

  saveAccountCareCart(TokenAccount tokenAc) async {
    getStorageData.saveString(getStorageData.token, tokenAc.token);
    getStorageData.saveString(
        getStorageData.account, jsonEncode(tokenAc.account.toJson()));
    await createInspector(name: tokenAc.account.userName);
  }

  // login() async {
  //   var map = {"username": email.text, "password": pass.text};
  //   var response = await loginrepo.login(map);
  //   response.fold((l) {
  //     utils.showSnackBar(context: Get.context!, message: l.errorMessage);
  //   }, (Loginmodel r) async {
  //     getStorageData.saveString(getStorageData.isLogin, true);
  //     saveAccount(r.token.toString(), r.username);
  //     Get.offAllNamed(BuildingInspectionScreen.routes);
  //   });
  //   update();
  // }

  createInspector({required String name}) async {
    var response = await loginRepository.createInspector(name: name);
    response.fold((l) {
      utils.showSnackBar(context: Get.context!, message: l.errorMessage);
    }, (InspectorModel r) {
      print("rname" + r.inspector.id.toString());
      getStorageData.saveString(getStorageData.inspectorId, r.inspector.id);
    });
    update();
  }
}
