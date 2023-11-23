import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/authority_signatures_screen/authority_signature_controller.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../pdf_screen/pdf_screen.dart';

class AuthoritySignatureScreen extends GetView<AuthoritySignatureController> {
  const AuthoritySignatureScreen({Key? key}) : super(key: key);
  static const routes = "/AuthoritySignatureScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthoritySignatureController>(
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
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: MyTextView(
                            controller.item == null ? "" : "${controller.item!.title}, ${controller.item!.subtitle}",
                            textStyleNew: MyTextStyle(
                              textSize: Utils.isMediumScreen(context) ? 24.px : 20.px,
                              textWeight: FontWeight.w600,
                              textColor: controller.appColors.appColor,
                              textFamily: fontFamilyBold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.px,
                        ),
                        controller.item != null
                            ? CommonButton(
                                title: controller.item!.check == false ? Strings.annualInspection : Strings.tenant,
                                textSize: 14.px,
                                isSmall: false,
                                isBig: true,
                                radius: 20.px,
                                textWeight: FontWeight.w500,
                                color: controller.appColors.white,
                                textColor: controller.item!.check == false
                                    ? controller.appColors.textGreen
                                    : controller.appColors.textPink,
                                onTap: () {})
                            : const SizedBox(),
                      ],
                    ).paddingOnly(top: 32.px),
                    Column(
                      children: [
                        Column(
                          children: [
                            MyTextView(
                              Strings.signatures,
                              maxLinesNew: 4,
                              textStyleNew: MyTextStyle(
                                textSize: 32.px,
                                textWeight: FontWeight.w600,
                                textColor: controller.appColors.appColor,
                                textFamily: fontFamilyBold,
                              ),
                            ),
                          ],
                        ).paddingSymmetric(vertical: 56.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyTextView(
                              Strings.pointOfContactSignatures,
                              textStyleNew: MyTextStyle(
                                textSize: 24.px,
                                textWeight: FontWeight.w400,
                                textColor: controller.appColors.black,
                                textFamily: fontFamilyRegular,
                              ),
                            ).paddingOnly(right: 16.px),
                            Expanded(
                              child: Container(
                                height: 2.px,
                                color: AppColors().divider,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 184.px,
                          child: ShadowContainer(
                            color: controller.appColors.white,
                            radius: 8.px,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.px),
                              child: controller.isTenantBlank
                                  ? GestureDetector(
                                      onTap: () {
                                        controller.isTenantBlank = false;
                                        controller.update();
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: SvgPicture.string(
                                              icSignEdit,
                                              width: 80.px,
                                              height: 80.px,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.px,
                                          ),
                                          Flexible(
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: Strings.tapToSign,
                                                    style: MyTextStyle(
                                                      textSize: 16.px,
                                                      textWeight: FontWeight.w600,
                                                      textColor: controller.appColors.appColor,
                                                      textFamily: fontFamilyBold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.px,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Screenshot(
                                      controller: controller.tenantSignController,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        width: MediaQuery.of(context).size.width,
                                        height: 150,
                                        child: Container(
                                          constraints: const BoxConstraints.expand(),
                                          color: Colors.white,
                                          child: SfSignaturePad(
                                            key: controller.tenantSignPadKey,
                                            minimumStrokeWidth: 3,
                                            maximumStrokeWidth: 6,
                                            strokeColor: Colors.black,
                                            backgroundColor: Colors.white,
                                            onDrawEnd: () async {
                                              controller.tenantSign = true;
                                              controller.update();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ).paddingOnly(top: 32.px, bottom: 22.px),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CommonButton(
                                title: "Clear",
                                textColor:
                                    controller.tenantSign ? controller.appColors.delete : controller.appColors.border1,
                                color: controller.appColors.transparent,
                                radius: 35.px,
                                textWeight: FontWeight.w600,
                                padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                                textSize: 16.px,
                                border: Border.all(
                                    color: controller.tenantSign
                                        ? controller.appColors.border
                                        : controller.appColors.lightText.withOpacity(0.2),
                                    width: 2),
                                onTap: () {
                                  controller.tenantSignPadKey.currentState!.clear();
                                  controller.tenantSign = false;
                                  controller.isTenantBlank = true;
                                  controller.update();
                                }),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CommonButton(
                                title: Strings.completeInspection,
                                textColor:
                                    controller.tenantSign ? controller.appColors.black : controller.appColors.border1,
                                color: controller.tenantSign
                                    ? controller.appColors.textPink
                                    : controller.appColors.black.withOpacity(0.11999999731779099),
                                radius: 35.px,
                                textWeight: FontWeight.w600,
                                textSize: 16.px,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.px,
                                  vertical: 12.px,
                                ),
                                onTap: () async {
                                  try {
                                    if (controller.tenantSign) {
                                      var tenantSign = await controller.tenantSignController.capture();
                                      if (tenantSign != null) {
                                        final tenantSignFile = await controller.utils.createFileFromString(tenantSign);
                                        if (tenantSignFile.toString().isNotEmpty) {
                                          controller.tenantSignPadKey.currentState!.clear();
                                          controller.tenantSign = false;
                                          controller.isTenantBlank = true;
                                          controller.isOwnerBlank = true;
                                          controller.update();

                                          // Get.offNamed(
                                          //   PropertyScreen.routes,
                                          // );
                                          Get.toNamed(PdfScreen.routes, arguments: controller.item);
                                        }
                                      }
                                    } else {
                                      printError("file=> error sign not found");
                                    }
                                  } catch (e) {
                                    printError(e.toString());
                                  }
                                }),
                          ],
                        ).paddingSymmetric(vertical: 56.px),
                      ],
                    ).paddingSymmetric(horizontal: 32.px),
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
