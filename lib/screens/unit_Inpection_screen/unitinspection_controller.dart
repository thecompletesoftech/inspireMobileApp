import 'package:flutter_svg/svg.dart';
import 'package:public_housing/screens/unit_Inpection_screen/screen/unit_inspection_screen.dart';

import '../../commons/all.dart';
import '../building_inspection_screen/screen/building_inspection_screen.dart';

class UnitController extends BaseController {
  TextEditingController unitnumberoRname = TextEditingController();
  TextEditingController unitAddress = TextEditingController();
  TextEditingController bedrooms = TextEditingController();
  TextEditingController bathrooms = TextEditingController();
  TextEditingController commentController = TextEditingController();
  var switchbtn = false.obs;
  String propertyaddress = '';
  var unitjson = {}.obs;

  void onInit() {
    unitAddress.text = Get.arguments['propertyInfo']['address'].toString();
    super.onInit();
  }

  getunitinspection() {
    return unitnumberoRname.text.isNotEmpty && unitAddress.text.isNotEmpty;
  }

  getreasonunitinspection() {
    return commentController.text.isNotEmpty;
  }

  getunitjson() {
    unitjson.addAll({
      "id": "1",
      "name": unitnumberoRname.text,
      "address": unitAddress.text,
      "number_of_bedrooms": bedrooms.text,
      "number_of_bathrooms": bathrooms.text,
      "occupied": switchbtn.value
    });
    print(unitjson.toString());
  }

  unitCannotInspected(context) {
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
                elevation: 8,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: appColors.border),
                      borderRadius: BorderRadius.circular(20),
                      color: appColors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextView(
                          Strings.unitcannitbeinspected,
                          textStyleNew: MyTextStyle(
                            textColor: appColors.textBlack,
                            textSize: 24.px,
                            textFamily: fontFamilyRegular,
                            textWeight: FontWeight.w400,
                          ),
                        ).paddingOnly(top: 24.px, left: 24.px, right: 24.px),
                        CommonTextField(
                                isLable: true,
                                controller: commentController,
                                color: appColors.transparent,
                                prefixIcon: GestureDetector(
                                  onTap: () {
                                    //  listen();
                                  },
                                  child: SvgPicture.string(
                                    icsubtrack,
                                  ).paddingOnly(left: 10.px, right: 20.px),
                                ),
                                padding: EdgeInsets.zero,
                                contentPadding:
                                    EdgeInsets.only(left: 20.px, right: 20.px),
                                labelText: Strings.reasonUninspectable,
                                hintText: Strings.Nokeyavailble)
                            .paddingOnly(top: 24.px, left: 24.px, right: 24.px),
                        Divider().paddingOnly(bottom: 10.px, top: 10.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonButton(
                                title: Strings.cancel,
                                textColor: appColors.appColor,
                                color: appColors.transparent,
                                textSize: 16.px,
                                textFamily: fontFamilyRegular,
                                textWeight: FontWeight.w500,
                                radius: 100.px,
                                onTap: () {
                                  Get.back();
                                }),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (() {
                                    Get.back();
                                    Get.toNamed(UnitInspection.routes);
                                  }),
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 44.px,
                                      width: 181.px,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100.px),
                                          border: Border.all(
                                              color: appColors.appColor)),
                                      child: MyTextView(
                                        Strings.saveandunit,
                                        textStyleNew: MyTextStyle(
                                          textColor: appColors.appColor,
                                          textWeight: FontWeight.w500,
                                          textFamily: fontFamilyBold,
                                          textSize: 16.px,
                                        ),
                                      )).paddingOnly(right: 16.px),
                                ),
                                CommonButton(
                                  title: Strings.CompleteInspection,
                                  radius: 100.px,
                                  width: 198.px,
                                  height: 44.px,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15.px,
                                    horizontal: 24.px,
                                  ),
                                  textSize: 16.px,
                                  textWeight: FontWeight.w500,
                                  textFamily: fontFamilyRegular,
                                  textColor: getreasonunitinspection()
                                      ? appColors.black
                                      : appColors.border1,
                                  color: getreasonunitinspection()
                                      ? appColors.textPink
                                      : appColors.black
                                          .withOpacity(0.11999999731779099),
                                  onTap: () {
                                    if (getreasonunitinspection()) {
                                      Get.toNamed(
                                          BuildingInspectionScreen.routes);
                                    }
                                  },
                                )
                              ],
                            ).paddingOnly(bottom: 20.px),
                          ],
                        ).paddingOnly(left: 24.px, right: 24.px),
                      ],
                    )));
          });
        });
  }
}
