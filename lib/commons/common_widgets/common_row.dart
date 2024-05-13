import 'package:flutter_svg/svg.dart';
import 'package:public_housing/commons/all.dart';

class CommonTextRow extends StatelessWidget {
  final String imageString;
  final String title;
  final String subTitle;
  final bool? isImage;

  const CommonTextRow(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.imageString,
      this.isImage = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isImage == true
            ? SizedBox.shrink()
            : SvgPicture.string(
                imageString,
                color: AppColors().grey,
              ),
        MyTextView(
          title,
          textStyleNew: MyTextStyle(
            textColor: AppColors().black,
            textWeight: FontWeight.w600,
            textFamily: fontFamilyBold,
            textSize: 20.px,
          ),
        ),
        Flexible(
          child: MyTextView(
            subTitle,
            textStyleNew: MyTextStyle(
              textColor: AppColors().textcolor,
              textWeight: FontWeight.w600,
              textFamily: fontFamilyBold,
              textSize: 20.px,
            ),
          ),
        )
      ],
    );
  }
}
