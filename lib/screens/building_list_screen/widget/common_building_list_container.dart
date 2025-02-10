import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/commons/common_widgets/common_container.dart';

class CommonBuildingListView extends StatelessWidget {
  final String title;
  final String title1;
  final String subTitle;
  final String subTitle1;
  final DateTime dateTime;
  final VoidCallback? onTap;
  final VoidCallback? onTap1;
  final bool isComplete;

  const CommonBuildingListView({
    super.key,
    required this.title,
    required this.title1,
    required this.subTitle,
    required this.subTitle1,
    this.onTap,
    this.onTap1,
    required this.dateTime,
    required this.isComplete,
  });

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      radius: 17.px,
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
                        Row(
                          children: [
                            MyTextView(
                              '${title} - ',
                              textStyleNew: MyTextStyle(
                                  textSize: 24.px,
                                  textColor: AppColors().black,
                                  textWeight: FontWeight.w600),
                            ),
                            MyTextView(
                              title1,
                              textStyleNew: MyTextStyle(
                                  textSize: 20.px,
                                  textColor: AppColors().textcolor,
                                  textWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        if (isComplete)
                          ClipOval(
                            child: SvgPicture.string(
                              icComplete,
                            ),
                          )
                      ],
                    ),
                    Row(
                      children: [
                        MyTextView(
                          '${subTitle} - ',
                          textStyleNew: MyTextStyle(
                              textSize: 24.px,
                              textColor: AppColors().black,
                              textWeight: FontWeight.w600),
                        ),
                        MyTextView(
                          subTitle1,
                          textStyleNew: MyTextStyle(
                              textSize: 20.px,
                              textColor: AppColors().textcolor,
                              textWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
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
                imageName: '${DateFormat('yyyy-MM-dd').format(dateTime)}',
                imageNameColor: AppColors().black,
              ),
              Spacer(),
              CommonRow(
                image: icHome,
                onTap: onTap,
                imageName: 'See Units',
                imageNameColor: AppColors().black,
                textSize: 16.px,
                textColor: AppColors.primerColor,
                textWeight: FontWeight.w500,
              ).paddingOnly(right: 24.px),
              CommonIconButton(
                title: isComplete
                    ? Strings.editInspection
                    : Strings.inspectBuilding,
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
                onTap: onTap1,
                iconColor: '${DateFormat('yyyy-MM-dd').format(dateTime)}' ==
                            '${DateFormat('yyyy-MM-dd').format(DateTime.now())}' &&
                        isComplete == false
                    // '${DateFormat('yyyy-MM-dd').format(DateTime.parse('2025-01-16T00:00:00-05:00'))}'
                    ? AppColors.primerColor
                    : AppColors().border1,
                icon: isComplete ? icEditNotes : icBuildings,
                iconheigth: 20.px,
                textColor: '${DateFormat('yyyy-MM-dd').format(dateTime)}' ==
                            '${DateFormat('yyyy-MM-dd').format(DateTime.now())}' &&
                        isComplete == false
                    ? AppColors.primerColor
                    : AppColors().border1,
                border: '${DateFormat('yyyy-MM-dd').format(dateTime)}' ==
                            '${DateFormat('yyyy-MM-dd').format(DateTime.now())}' &&
                        isComplete == false
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
  final VoidCallback? onTap;
  final double? textSize;
  final Color? textColor;
  final FontWeight? textWeight;

  const CommonRow({
    super.key,
    required this.image,
    required this.imageName,
    required this.imageNameColor,
    this.onTap,
    this.textSize,
    this.textColor,
    this.textWeight,
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
