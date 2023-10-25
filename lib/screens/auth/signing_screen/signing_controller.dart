import 'package:public_housing/commons/all.dart';
import 'package:public_housing/languages/language.dart';
import 'package:public_housing/screens/main_screen/main_screen.dart';

class SigningController extends BaseController {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool checked = false;
  bool isEmail = false;
  bool isPass = false;

  var hide = true;

  loginApiCall() async {
    FormData formData = FormData.fromMap({
      'email': email.text.toString().toLowerCase().trim(),
      'password': utils.generateMd5(pass.text.toString().trim()),
    });

    // final data = await APIFunction().apiCall(
    //     apiName: Constants.addBankAccount,
    //     context: Get.context!,
    //     params: formData,
    //     token: getStorageData.readObject(getStorageData.token));
    //
    // BankDModel model = BankDModel.fromJson(data);
    // if (model.responseCode == 1) {
    getStorageData.saveString(getStorageData.isLogin, true);
    //   Get.back(result: "date");
    // } else {
    //   utils.showSnackBar(context: Get.context!, message: model.responseMsg!);
    // }
    Get.offAllNamed(MainScreen.routes);
  }

  validation() {
    if (utils.isValidationEmpty(email.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterEmail);
    } else if (!utils.emailValidator(email.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterValidEmail);
    } else if (utils.isValidationEmpty(pass.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterPassword);
    } else if (!utils.passwordValidator(pass.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterValidPassword);
    } else {
      loginApiCall();
    }
  }
}
