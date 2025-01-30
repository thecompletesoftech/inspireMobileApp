import 'package:screenshot/screenshot.dart';
import 'package:public_housing/commons/all.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class SignatureController extends BaseController {
  GlobalKey<SfSignaturePadState> ownerSignPadKey = GlobalKey();
  GlobalKey<SfSignaturePadState> tenantSignPadKey = GlobalKey();
  ScreenshotController ownerSignController = ScreenshotController();
  TextEditingController commentController = TextEditingController();
  ScreenshotController tenantSignController = ScreenshotController();
  bool ownerSign = false;
  bool visibleBtn = false;
  bool tenantSign = false;
  bool isOwnerBlank = true;
  bool visibleBtn1 = false;
  bool isTenantBlank = true;
}
