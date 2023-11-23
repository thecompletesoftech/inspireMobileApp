import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/inspection_screen/inspection_controller.dart';

class GeneralNotesCardWidget extends GetView<InspectionController> {
  final RxCommonModel item;

  const GeneralNotesCardWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InspectionController>(
        init: InspectionController(),
        assignId: true,
        builder: (controller) {
          return ShadowContainer(
            radius: 4.px,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.px),
                      child: MyTextView(
                        item.subtitle,
                        isMaxLineWrap: true,
                        textStyleNew: MyTextStyle(
                          textSize: 14.px,
                          textWeight: FontWeight.w600,
                          textColor: controller.appColors.border,
                          textFamily: fontFamilyRegular,
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(bottom: 8.px),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.px),
                        child: MyTextView(
                          item.title,
                          isMaxLineWrap: true,
                          textStyleNew: MyTextStyle(
                            textSize: 16.px,
                            textWeight: FontWeight.w400,
                            textColor: controller.appColors.lightText,
                            textFamily: fontFamilyRegular,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(vertical: 16.px),
          );
        });
  }
}
