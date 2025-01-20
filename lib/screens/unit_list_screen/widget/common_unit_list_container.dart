import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/commons/common_widgets/common_container.dart';

class CommonUnitListView extends StatelessWidget {
  final String title;
  final String Subtitle;
  final VoidCallback? onTap;
  final DateTime dateTime;
  final bool isComplete;

  const CommonUnitListView({
    super.key,
    required this.title,
    required this.Subtitle,
    this.onTap,
    required this.dateTime,
    required this.isComplete,
  });

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyTextView(
                          title,
                          textStyleNew: MyTextStyle(
                              textSize: 24.px,
                              textColor: AppColors().black,
                              textWeight: FontWeight.w600),
                        ),
                        if (isComplete)
                          ClipOval(
                            child: SvgPicture.string(
                              icComplete,
                            ),
                          )
                      ],
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
              ),
            ],
          ).paddingAll(16.px),
          Container(height: 2.px, color: AppColors().divider),
          Row(
            children: [
              CommonRow(
                image: icCalenderColor,
                imageName: '${DateFormat('yyyy-MM-dd').format(dateTime)}',
                imageNameColor: AppColors().black,
              ),
              Spacer(),
              CommonIconButton(
                title:
                    isComplete ? Strings.editInspection : Strings.inspectUnit,
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
                iconColor: '${DateFormat('yyyy-MM-dd').format(dateTime)}' ==
                            '${DateFormat('yyyy-MM-dd').format(DateTime.now())}' &&
                        isComplete ==false
                    // '${DateFormat('yyyy-MM-dd').format(DateTime.parse('2025-01-16T00:00:00-05:00'))}'
                    ? AppColors.primerColor
                    : AppColors().border1,
                icon: isComplete ? icEditNotes : icHome,
                iconheigth: 20.px,
                textColor: '${DateFormat('yyyy-MM-dd').format(dateTime)}' ==
                            '${DateFormat('yyyy-MM-dd').format(DateTime.now())}' &&
                    isComplete ==false
                    ? AppColors.primerColor
                    : AppColors().border1,
                border: '${DateFormat('yyyy-MM-dd').format(dateTime)}' ==
                            '${DateFormat('yyyy-MM-dd').format(DateTime.now())}' &&
                    isComplete ==false
                    ? Border.all(color: AppColors().black)
                    : Border.all(color: AppColors().border1),
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
