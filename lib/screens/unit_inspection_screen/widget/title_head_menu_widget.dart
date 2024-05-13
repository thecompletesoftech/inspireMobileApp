import 'package:public_housing/commons/all.dart';
import '../controller/unit_inspection_controller.dart';

class TitleheadMenu extends GetView<UnitController> {
  final String title;
  final String value;
  const TitleheadMenu({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyTextView(
          title.toString() + ": ",
          textStyleNew: MyTextStyle(
            textColor: controller.appColors.black,
            textSize: 16.px,
            textWeight: FontWeight.w600,
            textFamily: fontFamilyBold,
          ),
        ),
        MyTextView(
          value.toString(),
          textStyleNew: MyTextStyle(
              textSize: 16.px,
              textFamily: fontFamilyRegular,
              textWeight: FontWeight.w400,
              textColor: controller.appColors.lightText),
        ),
      ],
    );
  }
}
