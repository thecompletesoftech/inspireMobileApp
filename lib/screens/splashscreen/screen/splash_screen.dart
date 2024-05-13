import '../../../commons/all.dart';
import 'package:public_housing/screens/splashscreen/controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  static const routes = "/";

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Stack(
        alignment: const Alignment(0, 0),
        children: [
          // Container(
          //   alignment: Alignment.centerLeft,
          //   child: Image.asset(
          //     ImagePath.splashBack,
          //     fit: BoxFit.cover,
          //     scale: 0.5,
          //     // height: 100.h,
          //   ),
          // ),
          Align(
            alignment: const Alignment(0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImagePath.splashIcon,
                  width: 487.68.px,
                  // height: 87.68.px,
                ),
                // MyTextView(
                //   Strings.appName,
                //   textStyleNew: MyTextStyle(
                //     textColor: appColors.textBlack,
                //     textWeight: FontWeight.w900,
                //     textSize: 50.px,
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
