// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:public_housing/screens/add_bank_detail/signing_controller.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
//
// import '../../commons/appcolors.dart';
// import '../../commons/commmon_screen.dart';
// import '../../commons/common_widgets/button_widget.dart';
// import '../../commons/common_widgets/common_container.dart';
// import '../../commons/common_widgets/my_text_widgets.dart';
// import '../../commons/common_widgets/text_field_widgets.dart';
// import '../../commons/constants.dart';
// import '../../commons/imagepath.dart';
// import '../../commons/utils.dart';
// import '../../languages/language.dart';
//
// class AddBankDetailScreen extends GetView<AddBankDetailController> {
//   const AddBankDetailScreen({Key? key}) : super(key: key);
//
//   static const routes = "/AddBankDetailScreen";
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AddBankDetailController>(
//       builder: (_) {
//         return CommonScreen(
//           onTap: () {
//             Get.back();
//           },
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 3.h),
//                 child: MyTextView(
//                   Languages.of(context)!.addBankDetail,
//                   textAlignNew: TextAlign.start,
//                   textStyleNew: MyTextStyle(
//                     textSize: 25.px,
//                     textFamily: fontFamilyBold,
//                     textStyle: FontStyle.normal,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: ListView(
//                   shrinkWrap: true,
//                   physics: const BouncingScrollPhysics(),
//                   padding: EdgeInsets.symmetric(horizontal: 3.h),
//                   children: [
//                     SizedBox(height: 2.h),
//                     CommonTextField(
//                       controller: controller.firstName,
//                       hintText: Languages.of(context)!.firstName,
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 11.px),
//                         child: Image.asset(
//                           ImagePath.icProfile,
//                           height: 25.px,
//                           color: controller.firstName.text.isNotEmpty
//                               ? AppColors().buttonColor
//                               : AppColors().buttonColor.withOpacity(0.5),
//                         ),
//                       ),
//                       onChange: (value) {
//                         controller.update();
//                       },
//                     ),
//                     SizedBox(height: 2.h),
//                     CommonTextField(
//                       controller: controller.lastName,
//                       hintText: Languages.of(context)!.lastName,
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 11.px),
//                         child: Image.asset(
//                           ImagePath.icProfile,
//                           height: 25.px,
//                           color: controller.lastName.text.isNotEmpty
//                               ? AppColors().buttonColor
//                               : AppColors().buttonColor.withOpacity(0.5),
//                         ),
//                       ),
//                       onChange: (value) {
//                         controller.update();
//                       },
//                     ),
//                     SizedBox(height: 2.h),
//                     CommonTextField(
//                       controller: controller.email,
//                       hintText: Languages.of(context)!.email,
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 11.px),
//                         child: Image.asset(
//                           ImagePath.emailPrefix,
//                           height: 25.px,
//                           color: controller.email.text.isNotEmpty
//                               ? AppColors().buttonColor
//                               : AppColors().buttonColor.withOpacity(0.5),
//                         ),
//                       ),
//                       onChange: (value) {
//                         controller.update();
//                       },
//                     ),
//                     SizedBox(height: 2.h),
//                     CommonTextField(
//                       controller: controller.phone,
//                       hintText: Languages.of(context)!.phone,
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 11.px),
//                         child: Image.asset(
//                           ImagePath.icPhone,
//                           height: 25.px,
//                           color: controller.phone.text.isNotEmpty
//                               ? AppColors().buttonColor
//                               : AppColors().buttonColor.withOpacity(0.5),
//                         ),
//                       ),
//                       onChange: (value) {
//                         controller.update();
//                       },
//                     ),
//                     SizedBox(height: 2.h),
//                     CommonTextField(
//                       onTap: () async {
//                         DateTime? datePick =
//                             await controller.utils.selectDate(context);
//                         controller.date = datePick.toString().split(" ");
//                         var year;
//                         var month;
//                         var day;
//                         day = controller.date[0].toString().split("-").last;
//                         month = controller.date[0].toString().split("-")[1];
//                         year = controller.date[0].toString().split("-").first;
//
//                         controller.dob.text = "${day}/${month}/${year}";
//                         controller.apiDate = "${year}/${month}/${day}";
//
//                         printWhite("--> -dob-> --> ${controller.dob.text}");
//                         controller.update();
//                       },
//                       controller: controller.dob,
//                       hintText: Languages.of(context)!.dateOfBirth,
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 11.px),
//                         child: Image.asset(
//                           ImagePath.icCalender,
//                           height: 25.px,
//                           color: controller.dob.text.isNotEmpty
//                               ? AppColors().buttonColor
//                               : AppColors().buttonColor.withOpacity(0.5),
//                         ),
//                       ),
//                       onChange: (value) {
//                         controller.update();
//                       },
//                     ),
//                     SizedBox(height: 2.h),
//                     CommonTextField(
//                       controller: controller.identityNumber,
//                       inputType: TextInputType.number,
//                       hintText: Languages.of(context)!.identifyNumber,
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 11.px),
//                         child: Image.asset(
//                           ImagePath.creditCard,
//                           height: 25.px,
//                           color: controller.identityNumber.text.isNotEmpty
//                               ? AppColors().buttonColor
//                               : AppColors().buttonColor.withOpacity(0.5),
//                         ),
//                       ),
//                       onChange: (value) {
//                         controller.update();
//                       },
//                     ),
//                     SizedBox(height: 2.h),
//                     CommonTextField(
//                       controller: controller.city,
//                       hintText: Languages.of(context)!.city,
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 11.px),
//                         child: Image.asset(
//                           ImagePath.icBuildings,
//                           height: 25.px,
//                           color: controller.city.text.isNotEmpty
//                               ? AppColors().buttonColor
//                               : AppColors().buttonColor.withOpacity(0.5),
//                         ),
//                       ),
//                       onChange: (value) {
//                         controller.update();
//                       },
//                     ),
//                     SizedBox(height: 2.h),
//                     CommonTextField(
//                       onTap: () {
//                         // Get.toNamed(CountryScreen.routes)!.then((value) {
//                         //   controller.country.text = value;
//                         //   controller.update();
//                         // });
//                       },
//                       readOnly: true,
//                       suffixIcon: Icon(Icons.arrow_forward_ios,
//                           color: AppColors().lightText.withOpacity(0.5)),
//                       controller: controller.country,
//                       hintText: Languages.of(context)!.country,
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 11.px),
//                         child: Image.asset(
//                           ImagePath.icWeb,
//                           height: 25.px,
//                           color: controller.country.text.isNotEmpty
//                               ? AppColors().buttonColor
//                               : AppColors().buttonColor.withOpacity(0.5),
//                         ),
//                       ),
//                       onChange: (value) {
//                         controller.update();
//                       },
//                     ),
//                     SizedBox(height: 2.h),
//                     CommonTextField(
//                       controller: controller.address,
//                       hintText: Languages.of(context)!.addresStr,
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 11.px),
//                         child: Image.asset(
//                           ImagePath.icBuildings,
//                           height: 25.px,
//                           color: controller.address.text.isNotEmpty
//                               ? AppColors().buttonColor
//                               : AppColors().buttonColor.withOpacity(0.5),
//                         ),
//                       ),
//                       onChange: (value) {
//                         controller.update();
//                       },
//                     ),
//                     SizedBox(height: 2.h),
//                     CommonTextField(
//                       controller: controller.postalCode,
//                       inputType: TextInputType.number,
//                       hintText: Languages.of(context)!.postalCode,
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 11.px),
//                         child: Image.asset(
//                           ImagePath.icHomeAddress,
//                           height: 25.px,
//                           color: controller.postalCode.text.isNotEmpty
//                               ? AppColors().buttonColor
//                               : AppColors().buttonColor.withOpacity(0.5),
//                         ),
//                       ),
//                       onChange: (value) {
//                         controller.update();
//                       },
//                     ),
//                     SizedBox(height: 2.h),
//                     CommonTextField(
//                       controller: controller.state,
//                       hintText: Languages.of(context)!.state,
//                       textInputAction: TextInputAction.done,
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 11.px),
//                         child: Image.asset(
//                           ImagePath.icStreet,
//                           height: 25.px,
//                           color: controller.state.text.isNotEmpty
//                               ? AppColors().buttonColor
//                               : AppColors().buttonColor.withOpacity(0.5),
//                         ),
//                       ),
//                       onChange: (value) {
//                         controller.update();
//                       },
//                     ),
//                     /*           SizedBox(height: 2.h),
//                     CommonTextField(
//                       onTap: () {
//                         Get.toNamed(CountryScreen.routes)?.then((value) {
//                           if (value != null) {
//                             controller.externalCountry.text = value;
//                             controller.update();
//                           }
//                         });
//                       },
//                       readOnly: true,
//                       suffixIcon: Icon(Icons.arrow_forward_ios,
//                           color: AppColors().lightText.withOpacity(0.5)),
//                       controller: controller.externalCountry,
//                       hintText: Languages.of(context)!.externalAccount,
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 11.px),
//                         child: Image.asset(
//                           ImagePath.icWeb,
//                           height: 25.px,
//                           color: controller.externalCountry.text.isNotEmpty
//                               ? AppColors().buttonColor
//                               : AppColors().buttonColor.withOpacity(0.5),
//                         ),
//                       ),
//                       onChange: (value) {
//                         controller.update();
//                       },
//                     ),
//                     SizedBox(height: 2.h),
//                     CommonTextField(
//                       readOnly: true,
//                       onTap: () {
//                         showCurrencyPicker(
//                           context: context,
//                           showFlag: true,
//                           showCurrencyName: true,
//                           showCurrencyCode: true,
//                           onSelect: (Currency currency) {
//                             print('Select currency: ${currency.code}');
//                             controller.externalCurrency.text = currency.code;
//                           },
//                         );
//                       },
//                       controller: controller.externalCurrency,
//                       hintText: Languages.of(context)!.externalCurrency,
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 11.px),
//                         child: Image.asset(
//                           ImagePath.icCurrency,
//                           height: 25.px,
//                           color: controller.externalCurrency.text.isNotEmpty
//                               ? AppColors().buttonColor
//                               : AppColors().buttonColor.withOpacity(0.5),
//                         ),
//                       ),
//                       onChange: (value) {
//                         controller.update();
//                       },
//                     ),*/
//                     SizedBox(height: 2.h),
//                     CommonTextField(
//                       controller: controller.bankNumber,
//                       inputType: TextInputType.number,
//                       hintText: Languages.of(context)!.bankAccount,
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 11.px),
//                         child: Image.asset(
//                           ImagePath.bank,
//                           height: 25.px,
//                           color: controller.bankNumber.text.isNotEmpty
//                               ? AppColors().buttonColor
//                               : AppColors().buttonColor.withOpacity(0.5),
//                         ),
//                       ),
//                       onChange: (value) {
//                         controller.update();
//                       },
//                     ),
//                     SizedBox(height: 2.h),
//                     CommonTextField(
//                       controller: controller.routingNumber,
//                       inputType: TextInputType.number,
//                       hintText: Languages.of(context)!.routingNumber,
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 12.px),
//                         child: Image.asset(
//                           ImagePath.icRouting,
//                           height: 25.px,
//                           color: controller.routingNumber.text.isNotEmpty
//                               ? AppColors().buttonColor
//                               : AppColors().buttonColor.withOpacity(0.5),
//                         ),
//                       ),
//                       onChange: (value) {
//                         controller.update();
//                       },
//                     ),
//                     SizedBox(height: 2.h),
//                     CommonContainer(
//                       radius: 15.px,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 35.px),
//                         child: Center(
//                           child: GestureDetector(
//                             onTap: () {
//                               controller.front = true;
//                               controller.profilePicker();
//                             },
//                             child: controller.imageFile.isNotEmpty
//                                 ? Image.file(
//                                     File(controller.imageFile.toString()),
//                                     fit: BoxFit.cover,
//                                     height: 14.h,
//                                     width: 14.h,
//                                   )
//                                 : Column(
//                                     children: [
//                                       Image.asset(
//                                         ImagePath.icAdd,
//                                         height: 50.px,
//                                       ),
//                                       SizedBox(height: 12.px),
//                                       MyTextView(
//                                         Languages.of(context)!.frontImage,
//                                         textStyleNew: MyTextStyle(
//                                           textSize: 16.px,
//                                           textFamily: fontFamilyBook,
//                                           textColor: AppColors().lightText,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 2.h),
//                     CommonContainer(
//                       radius: 15.px,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 35.px),
//                         child: Center(
//                           child: GestureDetector(
//                             onTap: () {
//                               controller.front = false;
//                               controller.profilePicker();
//                             },
//                             child: controller.imageFile1.isNotEmpty
//                                 ? Image.file(
//                                     File(controller.imageFile1.toString()),
//                                     fit: BoxFit.cover,
//                                     height: 14.h,
//                                     width: 14.h,
//                                   )
//                                 : Column(
//                                     children: [
//                                       Image.asset(
//                                         ImagePath.icAdd,
//                                         height: 50.px,
//                                       ),
//                                       SizedBox(height: 12.px),
//                                       MyTextView(
//                                         Languages.of(context)!.backImage,
//                                         textStyleNew: MyTextStyle(
//                                           textSize: 16.px,
//                                           textFamily: fontFamilyBook,
//                                           textColor: AppColors().lightText,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // SizedBox(height: 3.h),
//                     // Row(
//                     //   crossAxisAlignment: CrossAxisAlignment.start,
//                     //   children: [
//                     //     GestureDetector(
//                     //       onTap: () {
//                     //         if (controller.checked) {
//                     //           controller.checked = false;
//                     //         } else {
//                     //           controller.checked = true;
//                     //         }
//                     //         controller.update();
//                     //       },
//                     //       child: CommonContainer(
//                     //         color: controller.checked ? AppColors().buttonColor : AppColors().white,
//                     //         border: Border.all(color: AppColors().buttonColor),
//                     //         height: 25.px,
//                     //         width: 25.px,
//                     //         radius: 100,
//                     //         child: Icon(Icons.check, color: AppColors().white),
//                     //       ),
//                     //     ),
//                     //     SizedBox(
//                     //       width: 10.px,
//                     //     ),
//                     //     Column(
//                     //       crossAxisAlignment: CrossAxisAlignment.start,
//                     //       children: [
//                     //         MyTextView(Languages.of(context)!.agreeMsg, textStyleNew: MyTextStyle(textFamily: fontFamilyRegular)),
//                     //         SizedBox(
//                     //           height: 1.h,
//                     //         ),
//                     //         GestureDetector(
//                     //           onTap: () {},
//                     //           child: MyTextView(
//                     //             Languages.of(context)!.rolesAndRegulation,
//                     //             textStyleNew: MyTextStyle(textDecorations: TextDecoration.underline, textFamily: fontFamilyMedium),
//                     //           ),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //   ],
//                     // ),
//                     SizedBox(
//                       height: 3.h,
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: CommonButton(
//                         title: Languages.of(context)!.submit,
//                         onTap: () {
//                           controller.validation();
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       height: 3.h,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
