import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/commons/common_widgets/common_container.dart';

class CommonPropertiesListView extends StatelessWidget {
  final String date;
  final String title;
  final String title1;
  final String Subtitle;
  final String Subtitle1;
  final VoidCallback? onTap;

  const CommonPropertiesListView({
    super.key,
    this.onTap,
    required this.date,
    required this.title,
    required this.title1,
    required this.Subtitle,
    required this.Subtitle1,
  });

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      radius: 17.px,
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
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MyTextView(
                    title1,
                    textStyleNew: MyTextStyle(
                        textSize: 24.px,
                        textColor: AppColors().black,
                        textWeight: FontWeight.w600),
                  ),
                  MyTextView(
                    Subtitle1,
                    textStyleNew: MyTextStyle(
                        textSize: 20.px,
                        textColor: AppColors().textcolor,
                        textWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ).paddingAll(16.px),
          Container(
            height: 2.px,
            color: AppColors().divider,
          ),
          Row(
            children: [
              CommonRow(
                image: icCalenderColor,
                imageName: date,
                imageNameColor: AppColors().black,
              ),
              Spacer(),
              GestureDetector(
                onTap: onTap,
                child: CommonRow(
                  image: icBuildings,
                  imageName: Strings.seeBuildings,
                  imageNameColor: AppColors().black,
                  textSize: 16.px,
                  textColor: AppColors.primerColor,
                  textWeight: FontWeight.w500,
                ),
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
  final Color? textColor;
  final double? textSize;
  final VoidCallback? onTap;
  final Color imageNameColor;
  final FontWeight? textWeight;

  const CommonRow({
    super.key,
    this.onTap,
    this.textSize,
    this.textColor,
    this.textWeight,
    required this.image,
    required this.imageName,
    required this.imageNameColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
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
      ),
    );
  }
}
