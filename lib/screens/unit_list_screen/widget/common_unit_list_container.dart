import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/commons/common_widgets/common_container.dart';

class CommonUnitListView extends StatelessWidget {
  final String date;
  final String title;
  final bool isToday;
  final String Subtitle;
  final String isComplete;
  final VoidCallback? onTap;

  const CommonUnitListView({
    super.key,
    this.onTap,
    required this.date,
    required this.title,
    required this.isToday,
    required this.Subtitle,
    required this.isComplete,
  });

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              isComplete == 'Completed'
                  ? Padding(
                      padding: EdgeInsets.only(top: 5.px),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.string(icComplete),
                        ],
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ).paddingAll(16.px),
          Container(height: 2.px, color: AppColors().divider),
          Row(
            children: [
              CommonRow(
                image: icCalenderColor,
                imageName: date,
                imageNameColor: AppColors().black,
              ),
              Spacer(),
              CommonIconButton(
                title: isComplete == true
                    ? Strings.editInspection
                    : Strings.inspectUnit,
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
                iconColor: isToday == true
                    ? AppColors.primerColor
                    : AppColors().border1,
                icon: isComplete == true ? icPencil : icHome,
                iconheigth: 20.px,
                textColor: isToday == true
                    ? AppColors.primerColor
                    : AppColors().border1,
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
  final double? textSize;
  final Color? textColor;
  final Color imageNameColor;
  final FontWeight? textWeight;

  const CommonRow({
    super.key,
    this.textSize,
    this.textColor,
    this.textWeight,
    required this.image,
    required this.imageName,
    required this.imageNameColor,
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
