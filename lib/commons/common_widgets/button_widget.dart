import '../../responsive/scaling_query.dart';
import '../all.dart';

class CommonButton extends StatelessWidget {
  final String? title;
  final bool? isSmall;
  final bool? isBig;
  final double? width;
  final Color? color;
  final BoxBorder? border;
  final GestureTapCallback? onTap;
  final double? height;
  final double? radius;
  final Color? textColor;
  final String? textFamily;
  final double? textSize;
  final int? maxLinesNew;
  final FontWeight? textWeight;
  final EdgeInsetsGeometry? padding;

  const CommonButton({
    Key? key,
    required this.title,
    this.isSmall = true,
    this.isBig = false,
    this.width,
    this.height,
    required this.onTap,
    this.color,
    this.border,
    this.radius,
    this.textColor,
    this.textFamily,
    this.maxLinesNew,
    this.textWeight,
    this.textSize,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 16.px,
              vertical: 8.px,
            ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? appColors.appBGColor,
          borderRadius: BorderRadius.circular(
              // ScalingQuery(context).fontSize((radius ?? 15.px) / 20)
              (radius ?? 100.px)),
          border: border,
        ),
        child: Center(
          child: MyTextView(
            title,
            maxLinesNew: maxLinesNew ?? 1,
            textStyleNew: MyTextStyle(
              // textLetterSpacing: 1,
              textSize: Utils.isSmallScreen(context)
                  ? ScalingQuery(context).fontSize((textSize ?? 16.px) / 10)
                  : Utils.isTabletScreen1(context)
                      ? ScalingQuery(context).fontSize((textSize ?? 16.px) / 18)
                      : ScalingQuery(context)
                          .fontSize((textSize ?? 16.px) / 20),
              textWeight: textWeight ?? FontWeight.normal,
              textFamily: textFamily ?? fontFamilyRegular,
              textColor: textColor ?? appColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
