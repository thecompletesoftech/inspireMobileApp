import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/commons/common_widgets/common_container.dart';

class CommonUnitListView extends StatelessWidget {
  final String title;
  final String Subtitle;
  final VoidCallback? onTap;

  const CommonUnitListView(
      {super.key, required this.title, required this.Subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextView(
                    title,
                    textStyleNew: MyTextStyle(
                        textSize: 24.px,
                        textColor: AppColors().black,
                        textWeight: FontWeight.w600),
                  ),
                  MyTextView(
                    Subtitle,
                    textStyleNew: MyTextStyle(
                        textSize: 20.px,
                        textColor: AppColors().textcolor,
                        textWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ).paddingAll(16.px),
          Container(height: 2.px, color: AppColors().divider),
          Row(
            children: [
              CommonRow(
                image: icCalenderColor,
                imageName: 'Date',
                imageNameColor: AppColors().black,
              ),
              Spacer(),
              CommonIconButton(
                title: Strings.inspectUnit,
                radius: 100.px,
                width: 185.px,
                height: 44.px,
                color: AppColors().transparent,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.px,
                ),
                textSize: 16.px,
                textWeight: FontWeight.w500,
                textFamily: fontFamilyRegular,
                onTap: onTap,
                iconColor: AppColors.primerColor,
                icon: icHome,
                iconheigth: 20.px,
                textColor: AppColors.primerColor,
                border: Border.all(color: AppColors().black),
              ),
            ],
          ).paddingAll(16.px)
        ],
      ),
    );
  }
}

class CommonRow extends StatelessWidget {
  final String image;
  final String imageName;
  final Color imageNameColor;
  final double? textSize;
  final Color? textColor;
  final FontWeight? textWeight;

  const CommonRow({
    super.key,
    required this.image,
    required this.imageName,
    required this.imageNameColor,
    this.textSize,
    this.textColor,
    this.textWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.string(
          image,
          color: AppColors.primerColor,
        ).paddingOnly(right: 8.px),
        MyTextView(
          imageName,
          textStyleNew: MyTextStyle(
            textSize: textSize ?? 20.px,
            textColor: textColor ?? imageNameColor,
            textWeight: textWeight ?? FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
