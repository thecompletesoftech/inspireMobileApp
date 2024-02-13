import 'package:public_housing/commons/all.dart';

import '../../../languages/language.dart';
import 'signing_controller.dart';

class SigningScreen extends GetView<SigningController> {
  const SigningScreen({Key? key}) : super(key: key);

  static const routes = "/SigningScreen";

  @override
  Widget build(BuildContext context) {
    Utils.screenPortrait(context);
    return GetBuilder<SigningController>(
      builder: (_) {
        return BaseScreen(
          backgroundColor: controller.appColors.white,
          // bottomNavigationBar: Image.asset(
          //   ImagePath.loginScreen,
          //   height: 20.h,
          // ),
          child: SafeArea(
            child: Utils.isLandScapeMode(context)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Spacer(),
                            Image.asset(
                              ImagePath.gilsonLogo,
                              height: 10.h,
                            ).paddingOnly(bottom: 24.px),
                            Center(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Trust us',
                                      style: MyTextStyle(
                                        textColor:
                                            controller.appColors.appColor,
                                        textSize: 24.px,
                                        textFamily: fontFamilyFutuHvtext,
                                        textWeight: FontWeight.w600,
                                        // height: 0.08,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ', ',
                                      style: MyTextStyle(
                                        textColor:
                                            controller.appColors.appColor,
                                        textSize: 24.px,
                                        textFamily: fontFamilyMediumFututext,
                                        textWeight: FontWeight.w400,
                                        // height: 0.08,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'we can handle it',
                                      style: MyTextStyle(
                                        textColor:
                                            controller.appColors.appColor,
                                        textSize: 24.px,
                                        textFamily: fontFamilyMediumFututext,
                                        textWeight: FontWeight.w400,
                                        // height: 0.08,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            Image.asset(
                              ImagePath.loginScreen,
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 500.px,
                              child: ShadowContainer(
                                  elevation: 2,
                                  radius: 16.px,
                                  padding: EdgeInsets.all(48.px),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(ImagePath.appLogo,
                                                  height: 30.px)
                                              .paddingOnly(right: 24.px),
                                          Image.asset(ImagePath.logo,
                                              height: 30.px),
                                        ],
                                      ),
                                      MyTextView(
                                        Strings.signIn,
                                        textStyleNew: MyTextStyle(
                                            textSize: 32.px,
                                            textFamily: fontFamilyFutuHvtext,
                                            textColor:
                                                controller.appColors.black,
                                            textWeight: FontWeight.w500),
                                      ).paddingSymmetric(vertical: 48.px),
                                      CommonTextField(
                                        controller: controller.email,
                                        labelText: Languages.of(context)!.email,
                                        hintText: Languages.of(context)!
                                            .enterYourEmail,
                                        isLable: true,
                                        padding: EdgeInsets.zero,
                                        contentPadding: EdgeInsets.only(
                                            left: 16.px,
                                            top: 16.px,
                                            bottom: 16.px),
                                        onChange: (value) {
                                          if (controller.utils
                                              .isValidationEmpty(controller
                                                  .email.text
                                                  .trim())) {
                                            controller.isEmail = false;
                                            controller.checked = false;
                                            controller.update();
                                          } else if (!controller.utils
                                              .emailValidator(controller
                                                  .email.text
                                                  .trim())) {
                                            controller.isEmail = false;
                                            controller.checked = false;
                                            controller.update();
                                          } else {
                                            controller.isEmail = true;

                                            if (controller.isPass) {
                                              controller.checked = true;
                                            } else {
                                              controller.checked = false;
                                            }
                                            controller.update();
                                          }
                                        },
                                      ),
                                      SizedBox(height: 24.px),
                                      CommonTextField(
                                        controller: controller.pass,
                                        labelText:
                                            Languages.of(context)!.password,
                                        isLable: true,
                                        hintText: Languages.of(context)!
                                            .enterYourPassword,
                                        padding: EdgeInsets.zero,
                                        obscureText: controller.hide,
                                        contentPadding: EdgeInsets.only(
                                            left: 16.px,
                                            top: 16.px,
                                            bottom: 16.px),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            controller.hide = !controller.hide;
                                            controller.update();
                                          },
                                          icon: Icon(controller.hide
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined),
                                        ),
                                        onChange: (value) {
                                          if (controller.utils
                                              .isValidationEmpty(controller
                                                  .pass.text
                                                  .trim())) {
                                            controller.isPass = false;
                                            controller.checked = false;
                                            controller.update();
                                          }
                                          // else if (!controller.utils
                                          //     .passwordValidator(controller
                                          //         .pass.text
                                          //         .trim())) {
                                          //   controller.checked = false;
                                          //   controller.update();
                                          // }
                                           else {
                                            controller.isPass = true;
                                            if (controller.isEmail) {
                                              controller.checked = true;
                                            } else {
                                              controller.checked = false;
                                            }
                                            controller.update();
                                          }
                                        },
                                      ),
                                      CommonButton(
                                          title: Languages.of(context)!.login,
                                          radius: 100.px,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 15.px,
                                            horizontal: 24.px,
                                          ),
                                          textSize: 16.px,
                                          textWeight: FontWeight.w500,
                                          textFamily: fontFamilyRegular,
                                          textColor: controller.checked
                                              ? controller.appColors.black
                                              : controller.appColors.border1,
                                          color: controller.checked
                                              ? controller.appColors.textPink
                                              : controller.appColors.black
                                                  .withOpacity(
                                                      0.11999999731779099),
                                          onTap: () {
                                            // if (controller.checked)
                                            controller.validation();
                                          }).paddingSymmetric(vertical: 24.px),
                                      MyTextView(
                                        Strings.forgotPassword,
                                        textStyleNew: MyTextStyle(
                                            textSize: 16.px,
                                            textWeight: FontWeight.w500,
                                            textColor:
                                                controller.appColors.appColor,
                                            textFamily: fontFamilyRegular),
                                      )
                                    ],
                                  )).marginSymmetric(horizontal: 32.px),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Center(
                              child: Image.asset(
                                ImagePath.gilsonLogo,
                                height: Utils.isLandScapeMode(context)
                                    ? 70.px
                                    : 10.h,
                              ),
                            ).paddingOnly(top: 24.px),
                            ShadowContainer(
                                    elevation: 2,
                                    radius: 16.px,
                                    padding: EdgeInsets.all(38.px),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(ImagePath.appLogo,
                                                height: 54.px),
                                            Image.asset(ImagePath.logo,
                                                height: 54.px),
                                          ],
                                        ),
                                        MyTextView(
                                          Strings.signIn,
                                          isMaxLineWrap: true,
                                          textStyleNew: MyTextStyle(
                                              textSize: 32.px,
                                              textFamily: fontFamilyFutuHvtext,
                                              textColor:
                                                  controller.appColors.black,
                                              textWeight: FontWeight.w500),
                                        ).paddingSymmetric(vertical: 48.px),
                                        CommonTextField(
                                          controller: controller.email,
                                          labelText:
                                              Languages.of(context)!.email,
                                          hintText: Languages.of(context)!
                                              .enterYourEmail,
                                          isLable: true,
                                          padding: EdgeInsets.zero,
                                          contentPadding: EdgeInsets.only(
                                              left: 16.px,
                                              top: 16.px,
                                              bottom: 16.px),
                                          onChange: (value) {
                                            if (controller.utils
                                                .isValidationEmpty(controller
                                                    .email.text
                                                    .trim())) {
                                              controller.isEmail = false;
                                              controller.checked = false;
                                              controller.update();
                                            } else if (!controller.utils
                                                .emailValidator(controller
                                                    .email.text
                                                    .trim())) {
                                              controller.isEmail = false;
                                              controller.checked = false;
                                              controller.update();
                                            } else {
                                              controller.isEmail = true;
                                              if (controller.isPass) {
                                                controller.checked = true;
                                              } else {
                                                controller.checked = false;
                                              }
                                              controller.update();
                                            }
                                          },
                                        ),
                                        SizedBox(height: 24.px),
                                        CommonTextField(
                                          controller: controller.pass,
                                          labelText:
                                              Languages.of(context)!.password,
                                          isLable: true,
                                          hintText: Languages.of(context)!
                                              .enterYourPassword,
                                          padding: EdgeInsets.zero,
                                          obscureText: controller.hide,
                                          contentPadding: EdgeInsets.only(
                                              left: 16.px,
                                              top: 16.px,
                                              bottom: 16.px),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              controller.hide =
                                                  !controller.hide;
                                              controller.update();
                                            },
                                            icon: Icon(controller.hide
                                                ? Icons.visibility_outlined
                                                : Icons
                                                    .visibility_off_outlined),
                                          ),
                                          onChange: (value) {
                                            if (controller.utils
                                                .isValidationEmpty(controller
                                                    .pass.text
                                                    .trim())) {
                                              controller.isPass = false;
                                              controller.checked = false;
                                              controller.update();
                                            } 
                                            // else if (!controller.utils
                                            //     .passwordValidator(controller
                                            //         .pass.text
                                            //         .trim())) {
                                            //   controller.checked = false;
                                            //   controller.update();
                                            // } 
                                            else {
                                              controller.isPass = true;
                                              if (controller.isEmail) {
                                                controller.checked = true;
                                              } else {
                                                controller.checked = false;
                                              }
                                              controller.update();
                                            }
                                          },
                                        ),
                                        CommonButton(
                                            title: Languages.of(context)!.login,
                                            radius: 100.px,
                                            padding: EdgeInsets.symmetric(
                                              vertical: 15.px,
                                              horizontal: 24.px,
                                            ),
                                            textSize: 16.px,
                                            textWeight: FontWeight.w500,
                                            textFamily: fontFamilyRegular,
                                            textColor: controller.checked
                                                ? controller.appColors.black
                                                : controller.appColors.border1,
                                            color: controller.checked
                                                ? controller.appColors.textPink
                                                : controller.appColors.black
                                                    .withOpacity(
                                                        0.11999999731779099),
                                            onTap: () {
                                              if (controller.checked)
                                                controller.validation();
                                            }).paddingSymmetric(vertical: 24.px),
                                        GestureDetector(
                                          onTap: (() {
                                            // controller.createNewAccount();
                                          }),
                                          child: MyTextView(
                                            Strings.forgotPassword,
                                            textStyleNew: MyTextStyle(
                                                textSize: 16.px,
                                                textWeight: FontWeight.w500,
                                                textColor: controller
                                                    .appColors.appColor,
                                                textFamily: fontFamilyRegular),
                                          ),
                                        )
                                      ],
                                    ))
                                .marginSymmetric(
                                    horizontal: Utils.isMediumScreen(context)
                                        ? 16.h
                                        : 13.h,
                                    vertical: 10.h),
                            Image.asset(
                              ImagePath.loginScreen,
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
