import '../all.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({
    Key? key,
    this.height,
    this.width,
    this.radius = 2,
    required this.child,
    this.color,
    this.border,
    this.padding,
    this.image,
    this.boxShadow = true,
  }) : super(key: key);
  final double? height;
  final double? width;
  final double radius;

  final Widget child;
  final Color? color;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;
  final DecorationImage? image;
  final bool boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: color ?? AppColors().white,
        borderRadius: BorderRadius.circular(radius),
        border: border,
        boxShadow: boxShadow
            ? [
                BoxShadow(
                  color: AppColors().shadow.withOpacity(0.1),
                  offset: const Offset(
                    10.0,
                    10.0,
                  ),
                  blurRadius: 5.h,
                  spreadRadius: 2.0,
                ) //BoxShadow
              ]
            : null,
        image: image,
      ),
      child: Center(child: child),
    );
  }
}
