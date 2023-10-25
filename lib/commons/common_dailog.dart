import 'all.dart';

void alertActionDialogApp({
  required BuildContext context,
  String? message,
  String? rightBtnName,
  String? leftBtnName,
  double? borderRadius,
  GestureTapCallback? onRightClick,
  GestureTapCallback? onLeftClick,
  GestureTapCallback? okButtonClick,
  bool isOk = false,
  Widget? widget,
}) async {
  Utils utils = Utils();
  AppColors appColors = AppColors();
  utils.hideKeyboard();
  showDialog(
      context: context,
      barrierColor: Colors.black26,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.symmetric(horizontal: 15.h),
              elevation: 8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius ?? 1.h),
                child: Container(
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    color: appColors.white,
                    borderRadius: BorderRadius.circular(borderRadius ?? 1.h),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Container(
                      //   height: 6.5.h,
                      //   width: double.infinity,
                      //   alignment: Alignment.center,
                      //   color: appColors.appColor,
                      //   child: MyTextView(
                      //     Strings.appName,
                      //     textStyleNew: MyTextStyle(
                      //       textColor: appColors.white,
                      //       textSize: 15.px,
                      //       textFamily: fontFamilyRegular,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 12.px),
                      Padding(
                        padding: widget != null ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 2.h),
                        child: widget ??
                            MyTextView(
                              message ?? "",
                              isMaxLineWrap: true,
                              textAlignNew: TextAlign.center,
                              textStyleNew: MyTextStyle(
                                textColor: appColors.black,
                                textSize: 12.px,
                                textWeight: FontWeight.w400,
                              ),
                            ),
                      ),
                      widget != null ? const SizedBox() : SizedBox(height: 20.px),
                      // isOk
                      //     ? GestureDetector(
                      //         behavior: HitTestBehavior.opaque,
                      //         onTap: okButtonClick ??
                      //             () {
                      //               Get.back();
                      //             },
                      //         child: Container(
                      //           color: appColors.white,
                      //           width: double.infinity,
                      //           height: 5.h,
                      //           alignment: Alignment.center,
                      //           child: MyTextView(
                      //             Languages.of(context)!.ok.toUpperCase(),
                      //             textStyleNew: MyTextStyle(
                      //               textColor: appColors.buttonColor,
                      //               textWeight: FontWeight.w500,
                      //               textSize: 13.sp,
                      //             ),
                      //           ),
                      //         ),
                      //       )
                      //     : Row(
                      //         children: [
                      //           Expanded(
                      //             child: CommonButton(
                      //               title: leftBtnName,
                      //               onTap: onLeftClick ?? () => Get.back(),
                      //             ),
                      //           ),
                      //           Expanded(
                      //             child: CommonButton(
                      //               title: rightBtnName,
                      //               onTap: onRightClick,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}
