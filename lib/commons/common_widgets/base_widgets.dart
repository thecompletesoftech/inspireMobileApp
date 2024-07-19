import 'package:public_housing/commons/common_mixins/common_mixin.dart';

import '../../offline_database_services/offline_hive_database_service.dart';
import '../all.dart';

class BaseController extends GetxController with AppCommonMixin {
  AppColors appColors = AppColors();
  Utils utils = Utils();
  HiveMethodsProvider hiveMethodsProvider = Get.find<HiveMethodsProvider>();
}

//base screen==-=-=-==-=--

class BaseScreen extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  final bool? resizeToAvoidBottomInset;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const BaseScreen(
      {Key? key,
      required this.child,
      this.backgroundColor,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.resizeToAvoidBottomInset = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils().hideKeyboard();
      },
      child: Scaffold(
        backgroundColor: backgroundColor ?? AppColors().appBGColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: SafeArea(
          top: false,
          bottom: false,
          child: child,
        ),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
