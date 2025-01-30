import '../all.dart';

class BaseController extends GetxController {
  AppColors appColors = AppColors();
  Utils utils = Utils();
  GetStorageData getStorageData = GetStorageData();
}

class BaseScreen extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  final bool? resizeToAvoidBottomInset;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const BaseScreen({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils().hideKeyboard();
      },
      child: Scaffold(
        backgroundColor: backgroundColor ?? AppColors().appBGColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: SafeArea(top: false, bottom: false, child: child),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
