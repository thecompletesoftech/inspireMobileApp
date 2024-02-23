import 'package:public_housing/commons/all.dart';

class CommonText extends StatelessWidget {
  final String title;
  final String description;

  const CommonText({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextView(
          title,
          isMaxLineWrap: true,
          textStyleNew: MyTextStyle(
            textColor: AppColors().black,
            textWeight: FontWeight.w400,
            textFamily: fontFamilyBold,
            textSize: 24.px,
          ),
        ),
        MyTextView(
          description,
          isMaxLineWrap: true,
          textStyleNew: MyTextStyle(
            textColor: AppColors().black,
            textWeight: FontWeight.w400,
            textFamily: fontFamilyBold,
            textSize: 16.px,
          ),
        ).paddingOnly(top: 8.px),
      ],
    );
  }
}
