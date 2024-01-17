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
      elevation: elevation ?? 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 15.px),
      ),
      color: color ?? AppColors().white,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        height: height ?? null,
        width: width,
        alignment: Alignment.center,
        margin: margin ?? EdgeInsets.zero,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 1.5.h),
        child: child,
      ),
    );
  }
}

class ShadowContainer1 extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final double? elevation;
  final bool? isBorder;
  final Color? color;
  final Color? divider;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const ShadowContainer1({
    Key? key,
    this.height,
    required this.child,
    this.width,
    this.color,
    this.divider,
    this.margin,
    this.radius,
    this.elevation,
    this.isBorder = true,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 1.5.h),
      decoration: BoxDecoration(
          color: color ?? AppColors().white,
          borderRadius: BorderRadius.circular(radius ?? 15.px),
          border: Border.all(width: elevation ?? 2.0, color: divider ?? AppColors().divider)),
      child: child,
    );
  }
}

class ShadowContainer2 extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final double? elevation;
  final bool? isBorder;
  final Color? color;
  final Color? divider;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const ShadowContainer2({
    Key? key,
    this.height,
    required this.child,
    this.width,
    this.color,
    this.divider,
    this.margin,
    this.radius,
    this.elevation,
    this.isBorder = true,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 1.5.h),
      decoration: ShapeDecoration(
        color: color ?? AppColors().white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: elevation ?? 2.0,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: divider ?? AppColors().divider,
          ),
          borderRadius: BorderRadius.circular(radius ?? 15.px),
        ),
      ),
      child: child,
    );
  }
}
