import '../all.dart';

class ShadowContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final double? elevation;
  final bool? isBorder;
  final Color? color;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const ShadowContainer({
    Key? key,
    this.height,
    required this.child,
    this.width,
    this.color,
    this.margin,
    this.radius,
    this.elevation,
    this.isBorder = true,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 15.px),
        //set border radius more than 50% of height and width to make circle
      ),
      color: color ?? AppColors().white,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        // height: height ?? 147.px,
        width: width,
        alignment: Alignment.center,
        margin: margin ?? EdgeInsets.zero,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 1.5.h),
        child: child,
      ),
    );
  }
}
