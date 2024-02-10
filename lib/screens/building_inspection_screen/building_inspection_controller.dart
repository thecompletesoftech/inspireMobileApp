import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/auth/signing_screen/signing_screen.dart';

class BuildingInspectionController extends BaseController {
  final GlobalKey<PopupMenuButtonState<int>> popupKey = GlobalKey();
  TextEditingController inspectorController = TextEditingController();
  TextEditingController inspectionDateController = TextEditingController();


  void actionPopUpItemSelected(int value) {
    // _scaffoldkey.currentState.hideCurrentSnackBar();
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar;
    String message;
    if (value == 0) {
      message = 'You selected ${Strings.editProfile}';
    } else if (value == 1) {
      message = 'You selected ${Strings.inspectionHistory}';
    } else if (value == 2) {
      message = 'You selected ${Strings.nSPIREStandards}';
    } else if (value == 3) {
      message = 'You selected ${Strings.logOut}';
      Get.offAllNamed(SigningScreen.routes);
    } else {
      message = 'Not implemented';
    }
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }
}
