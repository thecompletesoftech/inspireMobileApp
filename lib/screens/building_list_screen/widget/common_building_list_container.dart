import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/commons/common_widgets/common_container.dart';

class CommonBuildingListView extends StatelessWidget {
  final String date;
  final String title;
  final bool isToday;
  final String title1;
  final String Subtitle;
  final String Subtitle1;
  final String isCompleted;
  final VoidCallback? onTap;
  final VoidCallback? onTap1;

  const CommonBuildingListView({
    super.key,
    this.onTap,
    this.onTap1,
    required this.date,
    required this.title,
    required this.title1,
    required this.isToday,
    required this.Subtitle,
    required this.Subtitle1,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      radius: 17.px,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Row(
                    children: [
                      MyTextView(
                        '${Subtitle} - ',
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
              ),
              Spacer(),
              isCompleted == 'Completed'
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
              CommonRow(
                image: icHome,
                onTap: onTap,
                imageName: Strings.seeUnits,
                imageNameColor: AppColors().black,
                textSize: 16.px,
                textColor: AppColors.primerColor,
                textWeight: FontWeight.w500,
              ).paddingOnly(right: 24.px),
              CommonIconButton(
                title: isCompleted == 'Completed'
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
                iconColor: isToday == true || isCompleted == 'Completed'
                    ? AppColors.primerColor
                    : AppColors().border1,
                icon: isCompleted == 'Completed' ? icPencil : icBuildings,
                iconheigth: 20.px,
                textColor: isToday == true || isCompleted == 'Completed'
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
