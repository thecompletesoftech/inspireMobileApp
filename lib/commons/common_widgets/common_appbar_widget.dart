import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/auth/signing_screen/screen/signing_screen.dart';
import 'package:public_housing/screens/properties_list_screen/controller/properties_list_controller.dart';

class CommonAppBar extends StatelessWidget {
  final String? image;
  final Color? color;
  final double? radius;
  final bool home;
  final Widget? child;
  final VoidCallback? onClickBack;

  CommonAppBar({
    Key? key,
    this.image,
    this.home = false,
    this.color,
    this.radius,
    this.child,
    this.onClickBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PropertiesListController propertiesListController =
        Get.put(PropertiesListController());

    return ShadowContainer(
      radius: radius,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      elevation: 3.0,
      child: Container(
        color: AppColors().white,
        height: 116.px,
        child: Padding(
          padding: EdgeInsets.all(32.px),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonBackButton(
                color: color!,
                height: 20.px,
                onClickBack: onClickBack ??
                    () {
                      Get.back();
                    },
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Image.asset(
                    ImagePath.logo,
                    width: 182.px,
                    height: 40.63.px,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextView(
                    propertiesListController.account?.userName ?? "",
                    textStyleNew: MyTextStyle(
                      textColor: AppColors().lightText,
                      textWeight: FontWeight.w600,
                      textFamily: fontFamilyBold,
                      textSize: 16.px,
                    ),
                  ),
                  MyTextView(
                    "${GetStorageData().readString(GetStorageData().clientName)}",
                    isMaxLineWrap: true,
                    textStyleNew: MyTextStyle(
                      textColor: AppColors().lightText,
                      textWeight: FontWeight.w400,
                      textFamily: fontFamilyMedium,
                      textSize: 14.px,
                    ),
                  )
                ],
              ),
              // Utils.isTabletScreen(context)
              //     ? GestureDetector(
              //         onTap: () {
              //           _key.currentState?.showButtonMenu();
              //         },
              //         child: Row(
              //           children: [
              //             PopupMenuButton<int>(
              //               key: _key,
              //               icon: const Icon(
              //                 Icons.arrow_back,
              //                 color: Colors.transparent,
              //               ),
              //               onSelected: (int value) =>
              //                   actionPopUpItemSelected(value),
              //               itemBuilder: (context) {
              //                 return <PopupMenuEntry<int>>[
              //                   PopupMenuItem(
              //                       value: 0,
              //                       child: ListTile(
              //                           leading: SvgPicture.string(
              //                             icEdit ?? "",
              //                             // width: 30.px,
              //                             // height: 30.px,
              //                           ),
              //                           title: MyTextView(
              //                             Strings.editProfile,
              //                             textStyleNew: MyTextStyle(
              //                                 textSize: 16.px,
              //                                 textColor: AppColors().black,
              //                                 textWeight: FontWeight.w400),
              //                           ))),
              //                   PopupMenuItem(
              //                       value: 1,
              //                       child: ListTile(
              //                           leading: SvgPicture.string(
              //                             icCopy ?? "",
              //                             // width: 30.px,
              //                             // height: 30.px,
              //                           ),
              //                           title: MyTextView(
              //                             Strings.inspectionHistory,
              //                             textStyleNew: MyTextStyle(
              //                                 textSize: 16.px,
              //                                 textColor: AppColors().black,
              //                                 textWeight: FontWeight.w400),
              //                           ))),
              //                   PopupMenuItem(
              //                       value: 2,
              //                       child: ListTile(
              //                           leading: SvgPicture.string(
              //                             icBook ?? "",
              //                             // width: 30.px,
              //                             // height: 30.px,
              //                           ),
              //                           title: MyTextView(
              //                             Strings.nSPIREStandards,
              //                             textStyleNew: MyTextStyle(
              //                                 textSize: 16.px,
              //                                 textColor: AppColors().black,
              //                                 textWeight: FontWeight.w400),
              //                           ))),
              //                   PopupMenuItem(
              //                       value: 3,
              //                       child: ListTile(
              //                           leading: SvgPicture.string(
              //                             icLogout ?? "",
              //                             // width: 30.px,
              //                             // height: 30.px,
              //                           ),
              //                           title: MyTextView(
              //                             Strings.logOut,
              //                             textStyleNew: MyTextStyle(
              //                                 textSize: 16.px,
              //                                 textColor: AppColors().black,
              //                                 textWeight: FontWeight.w400),
              //                           ))),
              //                 ];
              //               },
              //             ),
              //             image != null
              //                 ? CachedNetworkImage(
              //                     imageUrl: image!,
              //                     placeholder: (context, url) => Container(
              //                         color: AppColors()
              //                             .bottomSheetBackground
              //                             .withOpacity(0.8)),
              //                     errorWidget: (context, url, error) =>
              //                         Image.asset(ImagePath.user),
              //                     fit: BoxFit.cover,
              //                     width: 48.px,
              //                     height: 48.px,
              //                   )
              //                 : Image.asset(
              //                     ImagePath.user,
              //                     width: 48.px,
              //                     height: 48.px,
              //                   ),
              //           ],
              //         ),
              //       )
              //     : Expanded(
              //         flex: 0,
              //         child: GestureDetector(
              //           onTap: () {
              //             _key.currentState?.showButtonMenu();
              //           },
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.end,
              //             crossAxisAlignment: CrossAxisAlignment.end,
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               image != null
              //                   ? CachedNetworkImage(
              //                       imageUrl: image!,
              //                       placeholder: (context, url) => Container(
              //                           color: AppColors()
              //                               .bottomSheetBackground
              //                               .withOpacity(0.8)),
              //                       errorWidget: (context, url, error) =>
              //                           Image.asset(ImagePath.user),
              //                       fit: BoxFit.cover,
              //                       width: 48.px,
              //                       height: 48.px,
              //                     )
              //                   : Image.asset(
              //                       ImagePath.user,
              //                       width: 48.px,
              //                       height: 48.px,
              //                     ),
              //               SizedBox(
              //                 width: 16.px,
              //               ),
              //               Flexible(
              //                 flex: 1,
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     Flexible(
              //                       flex: 1,
              //                       child: MyTextView(
              //                         Strings.userName,
              //                         textStyleNew: MyTextStyle(
              //                           textColor: AppColors().lightText,
              //                           textWeight: FontWeight.w400,
              //                           textFamily: fontFamilyMediumFututext,
              //                           textSize: 24.px,
              //                         ),
              //                       ),
              //                     ),
              //                     MyTextView(
              //                       Strings.userType,
              //                       textStyleNew: MyTextStyle(
              //                         textColor: AppColors().lightText,
              //                         textWeight: FontWeight.w400,
              //                         textSize: 20.px,
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //               Expanded(
              //                 flex: 0,
              //                 child: Column(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceEvenly,
              //                   children: [
              //                     PopupMenuButton<int>(
              //                       key: _key,
              //                       icon: SvgPicture.string(
              //                         icDownArrow ?? "",
              //                         // width: 16.px,
              //                         height: 24.px,
              //                       ),
              //                       onSelected: (int value) =>
              //                           actionPopUpItemSelected(value),
              //                       itemBuilder: (context) {
              //                         return <PopupMenuEntry<int>>[
              //                           PopupMenuItem(
              //                               value: 0,
              //                               child: ListTile(
              //                                   leading: SvgPicture.string(
              //                                     icEdit ?? "",
              //                                     // width: 30.px,
              //                                     // height: 30.px,
              //                                   ),
              //                                   title: MyTextView(
              //                                     Strings.editProfile,
              //                                     textStyleNew: MyTextStyle(
              //                                         textSize: 16.px,
              //                                         textColor:
              //                                             AppColors().black,
              //                                         textWeight:
              //                                             FontWeight.w400),
              //                                   ))),
              //                           PopupMenuItem(
              //                               value: 1,
              //                               child: ListTile(
              //                                   leading: SvgPicture.string(
              //                                     icCopy ?? "",
              //                                     // width: 30.px,
              //                                     // height: 30.px,
              //                                   ),
              //                                   title: MyTextView(
              //                                     Strings.inspectionHistory,
              //                                     textStyleNew: MyTextStyle(
              //                                         textSize: 16.px,
              //                                         textColor:
              //                                             AppColors().black,
              //                                         textWeight:
              //                                             FontWeight.w400),
              //                                   ))),
              //                           PopupMenuItem(
              //                               value: 2,
              //                               child: ListTile(
              //                                   leading: SvgPicture.string(
              //                                     icBook ?? "",
              //                                     // width: 30.px,
              //                                     // height: 30.px,
              //                                   ),
              //                                   title: MyTextView(
              //                                     Strings.nSPIREStandards,
              //                                     textStyleNew: MyTextStyle(
              //                                         textSize: 16.px,
              //                                         textColor:
              //                                             AppColors().black,
              //                                         textWeight:
              //                                             FontWeight.w400),
              //                                   ))),
              //                           PopupMenuItem(
              //                               value: 3,
              //                               child: ListTile(
              //                                   leading: SvgPicture.string(
              //                                     icLogout ?? "",
              //                                     // width: 30.px,
              //                                     // height: 30.px,
              //                                   ),
              //                                   title: MyTextView(
              //                                     Strings.logOut,
              //                                     textStyleNew: MyTextStyle(
              //                                         textSize: 16.px,
              //                                         textColor:
              //                                             AppColors().black,
              //                                         textWeight:
              //                                             FontWeight.w400),
              //                                   ))),
              //                         ];
              //                       },
              //                     ),
              //                     const SizedBox()
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       )
            ],
          ),
        ),
      ),
    ).paddingOnly(bottom: 4);
  }

  static void actionPopUpItemSelected(int value) {
    // _scaffoldkey.currentState.hideCurrentSnackBar();
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar;
    String message;
    if (value == 0) {
      message = 'You selected ${Strings.editProfile}';
    } else if (value == 1) {
      message = 'You selected ${Strings.inspectionHistory}';
    } else if (value == 2) {
      message = 'You selected ${Strings.nSPIREStandards}';
    } else if (value == 3) {
      message = 'You selected ${Strings.logOut}';
      Get.offAllNamed(SigningScreen.routes);
    } else {
      message = 'Not implemented';
    }
    final snackBar = SnackBar(content: Text(message));
    // _scaffoldkey.currentState.showSnackBar(snackBar);
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }
}
