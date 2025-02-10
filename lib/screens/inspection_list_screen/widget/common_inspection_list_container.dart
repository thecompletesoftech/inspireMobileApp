import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/commons/common_widgets/common_container.dart';

class CommonInspectionsListView extends StatelessWidget {
  final String date;
  final String title;
  final String title1;
  final String endTime;
  final String subtitle;
  final String subtitle1;
  final String startTime;
  final bool isCompleted;
  final VoidCallback? onTap;

  const CommonInspectionsListView({
    super.key,
    this.onTap,
    required this.date,
    required this.title,
    required this.title1,
    required this.endTime,
    required this.subtitle,
    required this.subtitle1,
    required this.startTime,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      radius: 17.px,
      child: Column(
        children: [
          Row(
            children: [
              title.isNotEmpty
                  ? MyTextView(
                      title,
                      textStyleNew: MyTextStyle(
                          textSize: 24.px,
                          textColor: AppColors().black,
                          textWeight: FontWeight.w600),
                    )
                  : SizedBox(),
              subtitle.isNotEmpty
                  ? MyTextView(
                      ' - ${subtitle}',
                      textStyleNew: MyTextStyle(
                          textSize: 20.px,
                          textColor: AppColors().textcolor,
                          textWeight: FontWeight.w400),
                    )
                  : SizedBox(),
              Spacer(),
              if (isCompleted) ClipOval(child: SvgPicture.string(icComplete))
            ],
          ).paddingOnly(top: 16.px, left: 16.px, right: 16.px, bottom: 8.px),
          Row(
            children: [
              title1.isNotEmpty
                  ? MyTextView(
                      title1,
                      textStyleNew: MyTextStyle(
                          textSize: 20.px,
                          textColor: AppColors().black,
                          textWeight: FontWeight.w400),
                    )
                  : SizedBox(),
              subtitle1.isNotEmpty
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.px, horizontal: 16.px),
                      decoration: BoxDecoration(
                          color: AppColors().appBGColor,
                          borderRadius: BorderRadius.circular(100)),
                      child: MyTextView(
                        subtitle1,
                        textStyleNew: MyTextStyle(
                            textSize: 14.px,
                            textColor: AppColors().black,
                            textWeight: FontWeight.w500),
                      ),
                    ).paddingOnly(left: 24.px)
                  : SizedBox(),
            ],
          ).paddingOnly(bottom: 16.px, left: 16.px),
          Container(height: 2.px, color: AppColors().divider),
          Row(
            children: [
              CommonRow(
                image: icCalenderColor,
                imageName: date,
                imageNameColor: AppColors().black,
              ),
              CommonRow(
                image:
                    endTime.isNotEmpty && startTime.isNotEmpty ? clockIcon : '',
                imageName: endTime.isNotEmpty && startTime.isNotEmpty
                    ? '${startTime} - ${endTime}'
                    : "",
                imageNameColor: AppColors().black,
              ).paddingOnly(left: 32.px),
              Spacer(),
              isCompleted == true
                  ? /*CommonIconButton(
                      title: Strings.editInspection,
                      textColor: AppColors().appColor,
                      textWeight: FontWeight.w500,
                      textSize: 16.px,
                      onTap: onTap,
                      width: 176.px,
                      height: 44.px,
                      color: AppColors().transparent,
                      border: Border.all(color: AppColors().black),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.px,
                      ),
                      icon: icEditNotes,
                      iconheigth: 20.px,
                    )*/
                  MyTextView(
                      Strings.noShow,
                      textStyleNew: MyTextStyle(
                          textSize: 16.px,
                          textColor: AppColors().border1,
                          textWeight: FontWeight.w500),
                    )
                  : CommonButton(
                      title: Strings.details,
                      textColor: AppColors().appColor,
                      textWeight: FontWeight.w500,
                      textSize: 16.px,
                      onTap: onTap,
                      width: 92.px,
                      height: 44.px,
                      color: AppColors().transparent,
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
