import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/languages/language.dart';

class AddBankDetailController extends BaseController {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController identityNumber = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController externalCountry = TextEditingController();
  TextEditingController externalCurrency = TextEditingController();
  TextEditingController bankNumber = TextEditingController();
  TextEditingController routingNumber = TextEditingController();
  bool checked = false;
  bool front = false;
  RxString imageFile = "".obs;
  RxString imageFile1 = "".obs;

  var date;
  String apiDate = "";

  @override
  void onInit() {
    // TODO: implement onInit
    getUserData();
    super.onInit();
  }

  getUserData() {
    if (getStorageData.containKey(getStorageData.loginData)) {
      // LoginModel loginModel = LoginModel.fromJson(getStorageData.readObject(getStorageData.loginData));
      // if (loginModel.responseCode == 1) {
      //   firstName.text = loginModel.data!.fname!;
      //   lastName.text = loginModel.data!.lname!;
      //   email.text = loginModel.data!.email!;
      //   phone.text = loginModel.data!.phone!;
      //   // dob.text = loginModel.data!.dob!;
      //   identityNumber.text = loginModel.data!.idNumber!;
      //   // address.text = loginModel.data!.location!;
      //   update();
      // } else {
      //   utils.showSnackBar(context: Get.context!, message: loginModel.responseMsg!);
      // }
    }
  }

  profilePicker() {
    showModalBottomSheet(
      context: Get.context!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.px),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 18.px),
            Container(
              height: 5.px,
              width: 56.px,
              decoration: BoxDecoration(
                color: AppColors().bottomSheetBar,
                borderRadius: BorderRadius.circular(12.px),
              ),
            ),
            SizedBox(height: 30.px),
            MyTextView(
              Languages.of(context)!.upload,
              textStyleNew: MyTextStyle(
                textSize: 25.px,
                textFamily: fontFamilyBold,
                textColor: AppColors().introBlack,
              ),
            ),
            SizedBox(height: 20.px),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    getFromGallery();
                    Get.back();
                  },
                  child: Container(
                    height: 129.px,
                    width: 157.px,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.px),
                      border: Border.all(
                        color: AppColors().grey.withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.string(
                          icUpload ?? "",
                          width: 50.px,
                          height: 50.px,
                        ),
                        // Image.asset(
                        //   ImagePath.icGallery,
                        //   height: 50.px,
                        //   width: 50.px,
                        // ),
                        MyTextView(
                          Languages.of(context)!.fromGallery,
                          textStyleNew: MyTextStyle(
                            textSize: 15.px,
                            textFamily: fontFamilyBold,
                            textColor: AppColors().lightText,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    getFromCamera();
                    Get.back();
                  },
                  child: Container(
                    height: 129.px,
                    width: 157.px,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.px),
                      border: Border.all(
                        color: AppColors().grey.withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.string(
                          icCamera ?? "",
                          width: 50.px,
                          height: 50.px,
                        ),
                        // Image.asset(
                        //   ImagePath.icCamera,
                        //   height: 50.px,
                        //   width: 50.px,
                        // ),
                        MyTextView(
                          Languages.of(context)!.takePhoto,
                          textStyleNew: MyTextStyle(
                            textSize: 15.px,
                            textFamily: fontFamilyBold,
                            textColor: AppColors().lightText,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        );
      },
    );
  }

  getFromCamera({int? index}) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      front ? imageFile = (pickedFile.path.obs) : imageFile1 = (pickedFile.path.obs);
    }
    update();
  }

  getFromGallery({int? index}) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      front ? imageFile = (pickedFile.path.obs) : imageFile1 = (pickedFile.path.obs);
    }
    update();
  }

  addBankAccount() async {
    FormData formData = FormData.fromMap({
      'user_id': getStorageData.readString(getStorageData.userId),
      'fname': firstName.text.toString().trim(),
      'lname': lastName.text.toString().trim(),
      'email': email.text.toString().trim().toLowerCase(),
      'phone': phone.text.toString().trim(),
      'bdate': dob.text.toString().split("/")[0].toString(),
      'bmonth': dob.text.toString().split("/")[1].toString(),
      'byear': dob.text.toString().split("/")[2].toString(),
      'identity_number': identityNumber.text.toString().trim(),
      'city': city.text.toString().trim(),
      'address_line1': address.text.toString().trim(),
      'pincode': postalCode.text.toString().trim(),
      'state': state.text.toString().trim(),
      'acc_number': bankNumber.text.toString().trim(),
      'routing_number': routingNumber.text.toString().trim(),
    });

    if (imageFile.isNotEmpty) {
      formData.files.add(
        MapEntry(
          'front_image',
          await MultipartFile.fromFile(imageFile.value,
              contentType: MediaType('image', 'png'), filename: imageFile.value.split('/').last),
        ),
      );
    }
    if (imageFile1.isNotEmpty) {
      formData.files.add(
        MapEntry(
          'back_image',
          await MultipartFile.fromFile(imageFile1.value,
              contentType: MediaType('image', 'png'), filename: imageFile1.value.split('/').last),
        ),
      );
    }

    // final data = await APIFunction().apiCall(
    //     apiName: Constants.addBankAccount,
    //     context: Get.context!,
    //     params: formData,
    //     token: getStorageData.readObject(getStorageData.token));
    //
    // BankDModel model = BankDModel.fromJson(data);
    // if (model.responseCode == 1) {
    //   getStorageData.saveObject(getStorageData.bankData, model);
    //   Get.back(result: "date");
    // } else {
    //   utils.showSnackBar(context: Get.context!, message: model.responseMsg!);
    // }
  }

  validation() {
    if (utils.isValidationEmpty(firstName.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterFirstName);
    } else if (utils.isValidationEmpty(lastName.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterLastName);
    }
    // =-=-=-=-=-=-=-=-=- date of birth =-=-==-=-=->>>>>>
    else if (utils.isValidationEmpty(dob.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterDob);
    }
    if (utils.isValidationEmpty(email.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterEmail);
    } else if (!utils.emailValidator(email.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterValidEmail);
    }
    // =-=-=-=-=-=-=-=-=- phone =-=-==-=-=->>>>>>
    else if (!utils.phoneValidator(phone.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterPhoneNumber);
    } else if (utils.isValidationEmpty(identityNumber.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterIdentityNo);
    } else if (utils.isRoutingNoValid(identityNumber.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterValidIdentityNo);
    } else if (utils.isValidationEmpty(city.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterCity);
    } else if (utils.isValidationEmpty(country.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterCountry);
    } else if (utils.isValidationEmpty(address.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterLocation);
    } else if (utils.isValidationEmpty(postalCode.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterPostalCode);
    } else if (utils.isValidationEmpty(state.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterState);
    } else if (utils.isValidationEmpty(bankNumber.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterBankNo);
    } else if (utils.isValidationEmpty(routingNumber.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterRouting);
    } else if (utils.isRoutingNoValid(routingNumber.text.trim())) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseEnterRoutingNo);
    }
    // =-=-=-=-=-=-=-=-=- Profile =-=-==-=-=->>>>>>
    else if (imageFile.isEmpty) {
      utils.showSnackBar(context: Get.context!, message: Languages.of(Get.context!)!.pleaseSelectImage);
    } else {
      addBankAccount();
    }
  }
}
