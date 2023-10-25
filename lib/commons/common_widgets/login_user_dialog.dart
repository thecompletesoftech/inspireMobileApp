import '../../languages/language.dart';
import '../all.dart';

loginUsDialog() {
  Get.defaultDialog(
      backgroundColor: AppColors().white,
      title: "",
      middleText: "",
      content: Container(
        padding: EdgeInsets.only(left: 20),
        height: 180,
        width: Get.size.width,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyTextView(
                  "Oops",
                  maxLinesNew: 1,
                  textStyleNew: MyTextStyle(
                    textColor: AppColors().black,
                    textSize: 20.px,
                    textFamily: fontFamilyBold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.size.height / 30,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                MyTextView(
                  "Please create your account to access this",
                  isMaxLineWrap: true,
                  textStyleNew: MyTextStyle(
                    textColor: AppColors().black,
                    textSize: 16.px,
                    textFamily: fontFamilyMedium,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.size.height / 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CommonButton(
                      title: Languages.of(Get.context!)!.login,
                      onTap: () {
                        Get.back(closeOverlays: true);
                        // Get.toNamed(LoginScreen.routes);
                      }),
                ),
              ],
            ),
          ],
        ),
      ));
}

loginUserDialog() {
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
              color: AppColors().bottomSheetBar.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12.px),
            ),
          ),
          SizedBox(height: 30.px),
          // Image.asset(
          //   ImagePath.loginError,
          //   height: 120.px,
          //   width: 120.px,
          // ),
          SizedBox(
            height: 2.h,
          ),
          MyTextView(
            "Oops",
            isMaxLineWrap: true,
            textAlignNew: TextAlign.center,
            textStyleNew: MyTextStyle(
              textSize: 25.px,
              textFamily: fontFamilyBold,
            ),
          ),
          SizedBox(height: 2.h),
          MyTextView(
            Languages.of(context)!.loginFirst,
            isMaxLineWrap: true,
            textAlignNew: TextAlign.center,
            textStyleNew: MyTextStyle(
              textSize: 18.px,
              textFamily: fontFamilyMedium,
            ),
          ),
          SizedBox(height: 3.h),
          CommonButton(
            isSmall: false,
            isBig: true,
            title: Languages.of(Get.context!)!.login,
            onTap: () {
              GetStorageData().removeData(GetStorageData().token);
              Get.back(closeOverlays: true);
              // Get.toNamed(LoginScreen.routes);
            },
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 20.px)
        ],
      );
    },
  );
}
