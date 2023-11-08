import 'package:flutter_svg/flutter_svg.dart';

import '../../responsive/scaling_query.dart';
import '../all.dart';

class CommonIconButton extends StatelessWidget {
  final String? icon;
  final double? iconheigth;
  final Color? iconColor;
  final double? space;
  final String? title;
  final int? maxLinesNew;
  final bool? isSmall;
  final bool? isBig;
  final double? width;
  final Color? color;
  final BoxBorder? border;
  final GestureTapCallback? onTap;
  final double? height;
  final bool isMaxLineWrap;
  final double? radius;
  final Color? textColor;
  final String? textFamily;
  final double? textSize;
  final FontWeight? textWeight;
  final EdgeInsetsGeometry? padding;

  const CommonIconButton({
    Key? key,
    required this.icon,
    required this.iconheigth,
    this.iconColor,
    this.space,
    required this.title,
    this.isSmall = true,
    this.isBig = false,
    this.isMaxLineWrap = false,
    this.width,
    required this.onTap,
    this.maxLinesNew,
    this.color,
    this.border,
    this.height,
    this.radius,
    this.textColor,
    this.textFamily,
    this.textWeight,
    this.textSize,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: padding ?? EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.h),
            height: height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color ?? appColors.buttonColor,
              borderRadius: BorderRadius.circular(ScalingQuery(context).fontSize((radius ?? 100.px) / 20)),
              border: border,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconColor != null
                    ? SvgPicture.string(
                        icon!,
                        height: iconheigth,
                        color: iconColor!,
                      )
                    : SvgPicture.string(
                        icon!,
                        height: iconheigth,
                      ),
                SizedBox(
                  width: space ?? 8.px,
                ),
                CommonButton(
                    title: title,
                    maxLinesNew: 1,
                    radius: 100.px,
                    onTap: onTap,
                    padding: EdgeInsets.zero,
                    textSize: 16.px,
                    color: appColors.transparent,
                    textWeight: textWeight ?? FontWeight.normal,
                    textFamily: textFamily ?? fontFamilyRegular,
                    textColor: textColor ?? appColors.white),
                // MyTextView(
                //   title,
                //   maxLinesNew: maxLinesNew ?? 1,
                //   isMaxLineWrap: isMaxLineWrap,
                //   textStyleNew: MyTextStyle(
                //     // textLetterSpacing: 1,
                //     textSize: ScalingQuery(context).fontSize((textSize ?? 16.px) / 18),
                //     textWeight: textWeight ?? FontWeight.normal,
                //     textFamily: textFamily ?? fontFamilyRegular,
                //     textColor: textColor ?? appColors.white,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
