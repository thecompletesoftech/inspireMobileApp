import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/pdf_screen/pdf_controller.dart';

class PdfScreen extends GetView<PdfController> {
  const PdfScreen({Key? key}) : super(key: key);
  static const routes = "/PdfScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PdfController>(
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          child: Column(
            children: [
              CommonAppBar(color: controller.appColors.transparent, radius: 0.px),
              Expanded(
                flex: 1,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 32.px),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 48.px,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          ImagePath.gilsonLogo,
                          height: 72.px,
                          width: 198.px,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32.px,
                    ),
                    MyTextView(
                      "Inspection Report for Grand Avenue",
                      textStyleNew: MyTextStyle(
                          textFamily: fontFamilyRegular,
                          textSize: 24.px,
                          textWeight: FontWeight.w600,
                          textColor: controller.appColors.appColor),
                    ),
                    SizedBox(
                      height: 32.px,
                    ),
                    ShadowContainer(
                        color: controller.appColors.white,
                        child: Column(
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                              Column(
                                children: [
                                  MyTextView(
                                    "Inspection ID",
                                    textStyleNew: MyTextStyle(
                                        textFamily: fontFamilyRegular,
                                        textSize: 12.px,
                                        textWeight: FontWeight.w600,
                                        textColor: controller.appColors.appColor),
                                  ),
                                  MyTextView(
                                    "INSP-02942",
                                    textStyleNew: MyTextStyle(
                                        textFamily: fontFamilyRegular,
                                        textSize: 14.px,
                                        textWeight: FontWeight.w600,
                                        textColor: controller.appColors.appColor),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyTextView(
                                    "Start Date",
                                    textStyleNew: MyTextStyle(
                                        textFamily: fontFamilyRegular,
                                        textSize: 12.px,
                                        textWeight: FontWeight.w600,
                                        textColor: controller.appColors.appColor),
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CommonIconButton(
                                        icon: icCalenderColor,
                                        color: controller.appColors.transparent,
                                        iconheigth: 20.px,
                                        title: "06/18/2023",
                                        textColor: controller.appColors.black,
                                        onTap: () {},
                                      ),
                                      CommonIconButton(
                                        icon: icTimeColor,
                                        color: controller.appColors.transparent,
                                        iconheigth: 20.px,
                                        title: "08:02",
                                        textColor: controller.appColors.black,
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyTextView(
                                    "Start Date",
                                    textStyleNew: MyTextStyle(
                                        textFamily: fontFamilyRegular,
                                        textSize: 12.px,
                                        textWeight: FontWeight.w600,
                                        textColor: controller.appColors.appColor),
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CommonIconButton(
                                        icon: icCalenderColor,
                                        color: controller.appColors.transparent,
                                        iconheigth: 20.px,
                                        title: "06/18/2023",
                                        textColor: controller.appColors.black,
                                        onTap: () {},
                                      ),
                                      CommonIconButton(
                                        icon: icTimeColor,
                                        color: controller.appColors.transparent,
                                        iconheigth: 20.px,
                                        title: "08:02",
                                        textColor: controller.appColors.black,
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ]),
                          ],
                        ))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
