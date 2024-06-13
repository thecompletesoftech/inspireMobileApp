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
              ],
            ),
          )
        ],
      ),
    );
  }
}
