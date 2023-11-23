import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/inspection_screen/inspection_controller.dart';

class DeficienciesCardWidget extends GetView<InspectionController> {
  final RxCommonModel item;

  const DeficienciesCardWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InspectionController>(
        init: InspectionController(),
        assignId: true,
        builder: (controller) {
          return ShadowContainer(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            radius: 8.px,
            child: SizedBox(
              width: 328.px,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: controller.appColors.divider,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 84.px,
                            padding: EdgeInsets.all(16.px),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 52.px,
                                  height: 52.px,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 52.px,
                                        height: 52.px,
                                        decoration: const ShapeDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage("https://via.placeholder.com/52x52"),
                                            fit: BoxFit.cover,
                                          ),
                                          shape: OvalBorder(),
                                        ),
                                        child: ClipOval(
                                            child: Image.asset(
                                          item.image!,
                                          fit: BoxFit.cover,
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16.px),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: MyTextView(
                                          'Kitchen',
                                          textStyleNew: MyTextStyle(
                                            textColor: controller.appColors.textBlack,
                                            textSize: 20.px,
                                            textFamily: fontFamilyRegular,
                                            textWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4.px),
                                      SizedBox(
                                        width: double.infinity,
                                        child: MyTextView(
                                          'Refrigerator',
                                          textStyleNew: MyTextStyle(
                                            textColor: controller.appColors.textBlack,
                                            textSize: 20.px,
                                            textFamily: fontFamilyRegular,
                                            textWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 80.px,
                              height: 84.px,
                              // decoration: const BoxDecoration(
                              //   image: DecorationImage(
                              //     image: NetworkImage(
                              //         "https://via.placeholder.com/80x84"),
                              //     fit: BoxFit.contain,
                              //   ),
                              // ),
                              child: Image.asset(
                                item.imgId!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.px),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: MyTextView(
                                  item.title,
                                  isMaxLineWrap: true,
                                  textStyleNew: MyTextStyle(
                                    textColor: controller.appColors.textBlack,
                                    textSize: 20.px,
                                    textFamily: fontFamilyRegular,
                                    textWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 24.px),
                              SizedBox(
                                width: double.infinity,
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Comments',
                                        style: MyTextStyle(
                                          textColor: Colors.black,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ': “Refrigerator is missing - PM”\n',
                                        style: MyTextStyle(
                                          textColor: controller.appColors.lightText,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Date',
                                        style: MyTextStyle(
                                          textColor: Colors.black,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ': 06/22/2023\n',
                                        style: MyTextStyle(
                                          textColor: controller.appColors.lightText,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Responsibility',
                                        style: MyTextStyle(
                                          textColor: Colors.black,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ': Tenant',
                                        style: MyTextStyle(
                                          textColor: controller.appColors.lightText,
                                          textSize: 16.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).paddingOnly(bottom: 16.px),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonButton(
                                title: 'See photos',
                                textColor: controller.appColors.appColor,
                                color: controller.appColors.transparent,
                                textSize: 16.px,
                                textFamily: fontFamilyRegular,
                                textWeight: FontWeight.w500,
                                padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                                // radius: 100.px,
                                onTap: () {
                                  // Get.back();
                                }),
                            SizedBox(width: 8.px),
                            CommonButton(
                                title: 'Edit',
                                textColor: controller.appColors.appColor,
                                color: controller.appColors.transparent,
                                textSize: 16.px,
                                textFamily: fontFamilyRegular,
                                textWeight: FontWeight.w500,
                                padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                                onTap: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
