import 'package:screenshot/screenshot.dart';
import 'package:public_housing/commons/all.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/Repository/deficiencies_inside_repository.dart';

enum ImageUploadStatus { initial, uploading, success }

class SignatureController extends BaseController {
  bool ownerSign = false;
  bool visibleBtn = false;
  bool tenantSign = false;
  bool isOwnerBlank = true;
  bool visibleBtn1 = false;
  bool isTenantBlank = true;
  GlobalKey<SfSignaturePadState> ownerSignPadKey = GlobalKey();
  GlobalKey<SfSignaturePadState> tenantSignPadKey = GlobalKey();
  ScreenshotController ownerSignController = ScreenshotController();
  TextEditingController commentController = TextEditingController();
  ScreenshotController tenantSignController = ScreenshotController();
  ImageUploadStatus imageUploadStatus = ImageUploadStatus.initial;
  DeficienciesInsideRepository deficienciesInsideRepository =
      DeficienciesInsideRepository();
  String ownerSignature = '';
  String tenantSignature = '';

  imageUpload({required String imagePath, required String signType}) async {
    imageUploadStatus = ImageUploadStatus.uploading;
    update();
    var response =
        await deficienciesInsideRepository.getImageUpload(filePath: imagePath);
    response.fold((l) {
      imageUploadStatus = ImageUploadStatus.initial;
      return null;
    }, (r) {
      imageUploadStatus = ImageUploadStatus.success;
    });

    update();
  }
}
